// ===== CORE FUNCTIONS =====
function parseQueryString(url) {
    const objURL = {};
    url.replace(/([^?=&]+)(=([^&]*))?/g, (_, key, __, value) => {
        objURL[key] = value ? decodeURIComponent(value) : value;
    });
    return objURL;
}

function showError($field, message) {
    $field.addClass('field-error');
    let $errorMsg = $field.next('.field-message');
    if ($errorMsg.length === 0) {
        $field.after(`<div class="field-message" style="color: red; font-size: 12px; margin-top: 5px;">${message}</div>`);
    } else {
        $errorMsg.text(message);
    }
}

function clearError($field) {
    $field.removeClass('field-error');
    $field.next('.field-message').remove();
}

function validateForm() {
    let isValid = true;

    // Validate full name
    const $fullName = $('#billing_address_full_name');
    const fullName = $fullName.val().trim();
    if (!fullName) {
        showError($fullName, 'Vui lòng nhập họ và tên');
        isValid = false;
    } else {
        clearError($fullName);
    }

    // Validate phone number
    const $phone = $('#billing_address_phone');
    const phone = $phone.val().trim();
    if (!phone) {
        showError($phone, 'Vui lòng nhập số điện thoại');
        isValid = false;
    } else if (!/^(0|\+84)[1-9][0-9]{8}$/.test(phone)) {
        showError($phone, 'Số điện thoại không hợp lệ');
        isValid = false;
    } else {
        clearError($phone);
    }

    // Validate province
    const $province = $('#customer_shipping_province');
    if (!$province.val()) {
        showError($province, 'Vui lòng chọn tỉnh / thành');
        isValid = false;
    } else {
        clearError($province);
    }

    // Validate district
    const $district = $('#customer_shipping_district');
    if (!$district.val()) {
        showError($district, 'Vui lòng chọn quận / huyện');
        isValid = false;
    } else {
        clearError($district);
    }

    // Validate ward
    const $ward = $('#customer_shipping_ward');
    if (!$ward.val()) {
        showError($ward, 'Vui lòng chọn phường / xã');
        isValid = false;
    } else {
        clearError($ward);
    }

    // Validate address detail (ghi chú)
    const $addressDetail = $('#billing_address_address1');
    if (!$addressDetail.val().trim()) {
        showError($addressDetail, 'Vui lòng nhập ghi chú (địa chỉ chi tiết)');
        isValid = false;
    } else {
        clearError($addressDetail);
    }

    return isValid;
}

// ===== FORM HANDLING =====
function handleFormSubmit(formElement) {
    if (!validateForm()) {
        return false;
    }

    const $form = $(formElement);
    $form.find('button:submit').addClass('btn-loading');
    // Thực tế ở đây form sẽ submit về server. Nếu muốn AJAX, có thể tuỳ chỉnh.
}

// ===== EVENT HANDLERS =====
function setupEventHandlers() {
    // Form submission
    $('body').on('submit', 'form', function (e) {
        e.preventDefault();
        handleFormSubmit(this);
    });

    // Field interactions for validation
    $('#billing_address_phone').on('input', function () {
        const phone = $(this).val().trim();
        if (phone && !/^(0|\+84)[1-9][0-9]{8}$/.test(phone)) {
            showError($(this), 'Số điện thoại không hợp lệ');
        } else {
            clearError($(this));
        }
    });

    $('#billing_address_full_name').on('input', function () {
        if ($(this).val().trim()) {
            clearError($(this));
        }
    });

    $('#customer_shipping_province').on('change', function () {
        if ($(this).val()) {
            clearError($(this));
        }
    });
    $('#customer_shipping_district').on('change', function () {
        if ($(this).val()) {
            clearError($(this));
        }
    });
    $('#customer_shipping_ward').on('change', function () {
        if ($(this).val()) {
            clearError($(this));
        }
    });
}

$(document).ready(function () {
    setupEventHandlers();

    // ===== LOAD PROVINCES / DISTRICTS / WARDS (provinces.open‐api.vn) =====
    const provinceSelect = document.getElementById("customer_shipping_province");
    const districtSelect = document.getElementById("customer_shipping_district");
    const wardSelect = document.getElementById("customer_shipping_ward");

    // Load provinces
    fetch("https://provinces.open-api.vn/api/p/")
        .then(res => res.json())
        .then(provinces => {
            provinces.forEach(province => {
                let option = document.createElement("option");
                option.value = province.code;
                option.textContent = province.name;
                provinceSelect.appendChild(option);
            });
        })
        .catch(err => console.error("Lỗi khi load provinces:", err));

    // Province -> Districts
    provinceSelect.addEventListener("change", function () {
        const provinceCode = this.value;
        districtSelect.innerHTML = `<option value="">Chọn quận / huyện</option>`;
        wardSelect.innerHTML = `<option value="">Chọn phường / xã</option>`;
        $('#shipping_fee_display').text('—');
        $('#total_price').text('—');

        if (!provinceCode) return;

        fetch(`https://provinces.open-api.vn/api/p/${provinceCode}?depth=2`)
            .then(res => res.json())
            .then(data => {
                (data.districts || []).forEach(district => {
                    let option = document.createElement("option");
                    option.value = district.code;
                    option.textContent = district.name;
                    districtSelect.appendChild(option);
                });
            })
            .catch(err => console.error("Lỗi khi load districts:", err));
    });

    // District -> Wards
    districtSelect.addEventListener("change", function () {
        const districtCode = this.value;
        wardSelect.innerHTML = `<option value="">Chọn phường / xã</option>`;
        $('#shipping_fee_display').text('—');
        $('#total_price').text('—');

        if (!districtCode) return;

        fetch(`https://provinces.open-api.vn/api/d/${districtCode}?depth=2`)
            .then(res => res.json())
            .then(data => {
                (data.wards || []).forEach(ward => {
                    let option = document.createElement("option");
                    option.value = ward.code;
                    option.textContent = ward.name;
                    wardSelect.appendChild(option);
                });
            })
            .catch(err => console.error("Lỗi khi load wards:", err));
    });

    // ===== GHN SHIPPING COST =====
    // ID cố định của quận (district) cửa hàng bạn (ví dụ: Quận 1 = 1450)
    const fromDistrictId = 1450;
    // Thay bằng token GHN thực của bạn
    const shopToken = '0e4a6ccc-409c-11f0-befe-e619a81f0f8e';
    // Thay bằng shop_id (số nguyên) thực của bạn
    const shopId = 4785156;

    // Khi thay đổi quận hoặc phường → tính phí
    $('#customer_shipping_district, #customer_shipping_ward').change(function () {
        const toDistrictId = $('#customer_shipping_district').val();
        const toWardCode = $('#customer_shipping_ward').val();
        const addressDetail = $('#billing_address_address1').val().trim();

        // Đặt trước thông báo đang tính phí
        $('#shipping_fee_display').text('Đang tính...');
        $('#total_price').text('—');

        // Chỉ gọi API GHN khi cả quận, phường và ghi chú (địa chỉ chi tiết) đều đã có giá trị
        if (toDistrictId && toWardCode && addressDetail) {
            getAvailableServices(fromDistrictId, toDistrictId)
                .then(serviceId => {
                    calculateShippingFee(fromDistrictId, toDistrictId, toWardCode, serviceId);
                })
                .catch(() => {
                    $('#shipping_fee_display').text('Không có dịch vụ');
                    $('#total_price').text('—');
                });
        } else {
            // Nếu thiếu thông tin, reset hiển thị
            $('#shipping_fee_display').text('—');
            $('#total_price').text('—');
        }
    });

    // Hàm lấy service_id từ GHN
    function getAvailableServices(fromDistrictId, toDistrictId) {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: "https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/available-services",
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "Token": shopToken
                },
                data: JSON.stringify({
                    shop_id: shopId,
                    from_district: fromDistrictId,
                    to_district: parseInt(toDistrictId, 10)
                }),
                success: function (response) {
                    if (response.data && response.data.length > 0) {
                        resolve(response.data[0].service_id);
                    } else {
                        reject();
                    }
                },
                error: function () {
                    reject();
                }
            });
        });
    }

    // Hàm tính phí ship GHN và cập nhật lên giao diện
    function calculateShippingFee(fromDistrictId, toDistrictId, toWardCode, serviceId) {
        $.ajax({
            url: "https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee",
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Token": shopToken,         // token GHN
                "ShopId": shopId            // bắt buộc phải có
            },
            data: JSON.stringify({
                from_district_id: fromDistrictId,
                service_id: serviceId,
                to_district_id: parseInt(toDistrictId, 10),
                to_ward_code: toWardCode,
                weight: 500,
                length: 15,
                width: 15,
                height: 10,
                insurance_value: 249000,
                coupon: null
            }),
            success: function (response) {
                if (response.data && response.data.total !== undefined) {
                    const fee = response.data.total;
                    // Hiển thị phí ship
                    $('#shipping_fee_display').text(fee.toLocaleString('vi-VN') + '₫');

                    // Tính tổng: giá sản phẩm + phí ship
                    const priceText = $('.order-summary-emphasis').first().text().replace(/[^0-9]/g, '');
                    const productPrice = parseInt(priceText, 10) || 0;
                    const total = productPrice + fee;
                    $('#total_price').text(total.toLocaleString('vi-VN') + '₫');
                } else {
                    $('#shipping_fee_display').text('Không thể tính');
                    $('#total_price').text('—');
                }
            },
            error: function () {
                $('#shipping_fee_display').text('Không thể tính');
                $('#total_price').text('—');
            }
        });
    }

    // ===== PAGE RELOAD PREVENTION =====
    window.onpageshow = function (event) {
        if (event.persisted) {
            window.location.reload();
        }
    };

    // ===== ORDER SUMMARY TOGGLE =====
    $('.order-summary-toggle').on('click', function () {
        $('.sidebar .order-summary').toggleClass('order-summary-is-collapsed order-summary-is-expanded');
        $(this).toggleClass('order-summary-toggle-hide order-summary-toggle-show');
    });
});

// ===== CORE FUNCTIONS =====
function parseQueryString(url) {
    const objURL = {};
    url.replace(/([^?=&]+)(=([^&]*))?/g, (_, key, __, value) => {
        objURL[key] = value ? decodeURIComponent(value) : value;
    });
    return objURL;
}

function checkRequiredFields() {
    $('.field-required').each(function() {
        const $field = $(this);
        const $input = $field.find('input');
        const $select = $field.find('select');

        if ($input.val() !== '') {
            $input.parent().next('.field-message').remove();
            $field.removeClass('field-error');
        }

        if ($select.val() !== null) {
            $select.parent().next('.field-message').remove();
            $field.removeClass('field-error');
        }
    });
}

// ===== FORM HANDLING =====
function handleFormSubmit(formElement) {
    const $form = $(formElement);
    $form.find('button:submit').addClass('btn-loading');

    const formData = new FormData(formElement);
    const urlParams = new URLSearchParams([...formData]);

    // Add additional parameters
    ['selected_customer_shipping_country',
        'selected_customer_shipping_province',
        'selected_customer_shipping_district',
        'selected_customer_shipping_ward'].forEach(param => {
        const value = $(`input[name="${param}"]`).val();
        if (value) urlParams.set(param.replace('selected_', ''), value);
    });

    // Submit form data
    $.ajax({
        type: 'GET',
        url: `${window.location.pathname}?${urlParams.toString()}`,
        success: function(html) {
            // Update relevant sections
            $('.step-sections').attr('step', $(html).find('.step-sections').attr('step'));
            $('.order-summary-sections').html($(html).find('.order-summary-sections').html());

            $form.find('button:submit').removeClass('btn-loading');
        },
        error: function() {
            $form.find('button:submit').removeClass('btn-loading');
        }
    });
}

// ===== EVENT HANDLERS =====
function setupEventHandlers() {
    // Form submission
    $('body').on('submit', 'form', function(e) {
        e.preventDefault();
        handleFormSubmit(this);
    });

    // Address selection
    $('body').on('change', '#customer_shipping_province, #customer_shipping_district, #customer_shipping_ward', function() {
        $('#form_update_shipping_method').submit();
    });

    // Payment method selection
    $('body').on('change', 'input[name="payment_method_id"]', function() {
        $('#section-payment-method').submit();
    });

    // Shipping method selection
    $('body').on('change', 'input[name="shipping_rate_id"]', function() {
        $('#section-shipping-rate').submit();
    });

    // Field interactions
    $('body')
        .on('focus', '.field input, .field select', function() {
            $(this).closest('.field').addClass('field-active');
        })
        .on('blur', '.field input, .field select', function() {
            $(this).closest('.field').removeClass('field-active');
        });
}

// ===== INITIALIZATION =====
$(document).ready(function() {
    setupEventHandlers();

    // Set initial step
    const stepCheckout = parseInt($('.step-sections').attr('step'));
    if (stepCheckout === 1) {
        $('body').on('change', '#stored_addresses', checkRequiredFields);
    }

    // Reload prevention
    window.onpageshow = function(event) {
        if (event.persisted) {
            window.location.reload();
        }
    };

    // Order summary toggle
    $('.order-summary-toggle').on('click', function() {
        $('.sidebar .order-summary').toggleClass('order-summary-is-collapsed order-summary-is-expanded');
        $(this).toggleClass('order-summary-toggle-hide order-summary-toggle-show');
    });
});
document.addEventListener("DOMContentLoaded", function () {
    const provinceSelect = document.getElementById("customer_shipping_province");
    const districtSelect = document.getElementById("customer_shipping_district");
    const wardSelect = document.getElementById("customer_shipping_ward");

    //  danh sách tỉnh
    fetch("https://provinces.open-api.vn/api/p/")
        .then(res => res.json())
        .then(provinces => {
            provinces.forEach(province => {
                let option = document.createElement("option");
                option.value = province.code;
                option.textContent = province.name;
                provinceSelect.appendChild(option);
            });
        });

    //  tỉnh > quận/huyện
    provinceSelect.addEventListener("change", function () {
        let provinceCode = this.value;
        districtSelect.innerHTML = `<option selected>Chọn quận / huyện</option>`;
        wardSelect.innerHTML = `<option selected>Chọn phường / xã</option>`;

        if (!provinceCode) return;

        fetch(`https://provinces.open-api.vn/api/p/${provinceCode}?depth=2`)
            .then(res => res.json())
            .then(data => {
                data.districts.forEach(district => {
                    let option = document.createElement("option");
                    option.value = district.code;
                    option.textContent = district.name;
                    districtSelect.appendChild(option);
                });
            });
    });

    //  quận > load phường/xã
    districtSelect.addEventListener("change", function () {
        let districtCode = this.value;
        wardSelect.innerHTML = `<option selected>Chọn phường / xã</option>`;

        if (!districtCode) return;

        fetch(`https://provinces.open-api.vn/api/d/${districtCode}?depth=2`)
            .then(res => res.json())
            .then(data => {
                data.wards.forEach(ward => {
                    let option = document.createElement("option");
                    option.value = ward.code;
                    option.textContent = ward.name;
                    wardSelect.appendChild(option);
                });
            });
    });
});
function validateForm() {
    let isValid = true;
    // Validate full name
    const fullName = $('#billing_address_full_name').val().trim();
    if (!fullName) {
        showError($('#billing_address_full_name'), 'Vui lòng nhập họ và tên');
        isValid = false;
    } else {
        clearError($('#billing_address_full_name'));
    }

    // Validate phone number
    const phone = $('#billing_address_phone').val().trim();
    if (!phone) {
        showError($('#billing_address_phone'), 'Vui lòng nhập số điện thoại');
        isValid = false;
    } else if (!/^(0|\+84)[1-9][0-9]{9}$/.test(phone)) {
        showError($('#billing_address_phone'), 'Số điện thoại không hợp lệ');
        isValid = false;
    } else {
        clearError($('#billing_address_phone'));
    }

    return isValid;
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

// ===== FORM HANDLING =====
function handleFormSubmit(formElement) {
    if (!validateForm()) {
        return false;
    }

    const $form = $(formElement);
    $form.find('button:submit').addClass('btn-loading');

}

// ===== EVENT HANDLERS =====
function setupEventHandlers() {
    $('body').on('submit', 'form', function(e) {
        e.preventDefault();
        handleFormSubmit(this);
    });
    $('#billing_address_phone').on('input', function() {
        const phone = $(this).val().trim();
        if (phone && !/^(0|\+84)[1-9][0-9]{8}$/.test(phone)) {
            showError($(this), 'Số điện thoại không hợp lệ');
        } else {
            clearError($(this));
        }
    });

    $('#billing_address_full_name').on('input', function() {
        if ($(this).val().trim()) {
            clearError($(this));
        }
    });
}
$(document).ready(function () {
    // ID cố định của quận cửa hàng bạn (ví dụ: Quận 1 - 1450)
    const fromDistrictId = 1450;
    const shopToken = 'YOUR_GHN_TOKEN'; // thay bằng token GHN
    const shopId = YOUR_SHOP_ID; // thay bằng shop_id số nguyên

    // Sự kiện thay đổi quận hoặc phường
    $('#customer_shipping_district, #customer_shipping_ward').change(function () {
        let toDistrictId = $('#customer_shipping_district').val();
        let toWardCode = $('#customer_shipping_ward').val();

        if (toDistrictId && toWardCode && toDistrictId !== 'null' && toWardCode !== 'null') {
            getAvailableServices(fromDistrictId, toDistrictId).then(serviceId => {
                calculateShippingFee(fromDistrictId, toDistrictId, toWardCode, serviceId);
            });
        }
    });

    // Lấy Service ID trước khi tính phí
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
                    to_district: parseInt(toDistrictId)
                }),
                success: function (response) {
                    if (response.data && response.data.length > 0) {
                        resolve(response.data[0].service_id);
                    } else {
                        alert('Không có dịch vụ giao hàng phù hợp');
                        reject();
                    }
                },
                error: function () {
                    alert('Lỗi lấy danh sách dịch vụ GHN');
                    reject();
                }
            });
        });
    }

    // Hàm tính phí giao hàng
    function calculateShippingFee(fromDistrictId, toDistrictId, toWardCode, serviceId) {
        $.ajax({
            url: "https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee",
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Token": shopToken
            },
            data: JSON.stringify({
                from_district_id: fromDistrictId,
                service_id: serviceId,
                to_district_id: parseInt(toDistrictId),
                to_ward_code: toWardCode,
                weight: 500, // gram
                length: 15,
                width: 15,
                height: 10,
                insurance_value: 249000,
                coupon: null
            }),
            success: function (response) {
                const fee = response.data.total;
                $('#shipping_fee').text(fee.toLocaleString('vi-VN') + '₫');

                // Tính tổng
                const productPrice = 249000; // thay bằng lấy từ DOM nếu cần
                const total = productPrice + fee;
                $('#total_price').text(total.toLocaleString('vi-VN') + '₫');
            },
            error: function () {
                $('#shipping_fee').text('Không thể tính');
            }
        });
    }
});

$(document).ready(function () {
    const fromDistrictId = 1450;
    const shopToken = '0e4a6ccc-409c-11f0-befe-e619a81f0f8e'; // thay bằng token GHN
    const shopId = 4785156; // thay bằng shop_id số nguyên

    // Sự kiện thay đổi quận hoặc phường
    $('#customer_shipping_district, #customer_shipping_ward').change(function () {
        let toDistrictId = $('#customer_shipping_district').val();
        let toWardCode = $('#customer_shipping_ward').val();

        if (toDistrictId && toWardCode && toDistrictId !== 'null' && toWardCode !== 'null') {
            getAvailableServices(fromDistrictId, toDistrictId).then(serviceId => {
                calculateShippingFee(fromDistrictId, toDistrictId, toWardCode, serviceId);
            });
        }
    });

    // Lấy Service ID trước khi tính phí
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
                    to_district: parseInt(toDistrictId)
                }),
                success: function (response) {
                    if (response.data && response.data.length > 0) {
                        resolve(response.data[0].service_id);
                    } else {
                        alert('Không có dịch vụ giao hàng phù hợp');
                        reject();
                    }
                },
                error: function () {
                    alert('Lỗi lấy danh sách dịch vụ GHN');
                    reject();
                }
            });
        });
    }

    // Hàm tính phí giao hàng
    function calculateShippingFee(fromDistrictId, toDistrictId, toWardCode, serviceId) {
        $.ajax({
            url: "https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee",
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Token": shopToken
            },
            data: JSON.stringify({
                from_district_id: fromDistrictId,
                service_id: serviceId,
                to_district_id: parseInt(toDistrictId),
                to_ward_code: toWardCode,
                weight: 500, // gram
                length: 15,
                width: 15,
                height: 10,
                insurance_value: 249000,
                coupon: null
            }),
            success: function (response) {
                const fee = response.data.total;
                $('#shipping_fee').text(fee.toLocaleString('vi-VN') + '₫');

                // Tính tổng
                const productPrice = 249000; // thay bằng lấy từ DOM nếu cần
                const total = productPrice + fee;
                $('#total_price').text(total.toLocaleString('vi-VN') + '₫');
            },
            error: function () {
                $('#shipping_fee').text('Không thể tính');
            }
        });
    }
});



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

    // Load danh sách tỉnh
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

    // Khi chọn tỉnh → load quận/huyện
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

    // Khi chọn quận → load phường/xã
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

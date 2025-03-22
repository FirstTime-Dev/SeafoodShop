var parseQueryString = function (url) {
    var str = url;
    var objURL = {};
    str.replace(
        new RegExp("([^?=&]+)(=([^&]*))?", "g"),
        function ($0, $1, $2, $3) {
            if ($3 != undefined && $3 != null)
                objURL[$1] = decodeURIComponent($3);
            else
                objURL[$1] = $3;
        });
    return objURL;
};
$(document).ready(function () {
    setTimeout(function () {
        var stepCheckout = parseInt($('.step-sections').attr('step'));
        if (stepCheckout === 1) {
            var flagVal = 0;
            $('body').on('change', '#stored_addresses', function () {
                flagVal = $(this).val();
            });
            $('body').on('click', '.step-footer-continue-btn', function () {
                $(document).ajaxComplete(function (event, xhr, settings) {

                    if (settings.url.indexOf("form_next_step") > -1) {
                        $('#stored_addresses').val(flagVal);
                    }
                });
            })

            function check_required() {
                $('.field-required').each(function () {
                    var self = $(this).find('input');
                    var selfSelect = $(this).find('select');
                    if (self.val() !== '') {
                        self.parent().next().remove();
                        self.parents('.field-error').removeClass('field-error')
                    }
                    if (selfSelect !== null || selfSelect !== 0) {
                        selfSelect.parent().next().remove();
                        selfSelect.parents('.field-error').removeClass('field-error')
                    }
                });
            }

            $('body').on('change', '#stored_addresses', function () {
                check_required();
            });
        }
    }, 0)
})
window.onpageshow = function (event) {
    if (event.persisted) {
        var currentUrl = '';
        currentUrl = '/checkouts/b0f5454f852d4a8a9bfdb60baf1fb2d7?step=1';
        if (currentUrl)
            window.location = currentUrl;
    }
};


var isInit = false;

const paylayterLoadingTrigger = (isLoading = true) => {
    if (isLoading) {
        $('.payment-later-table').addClass('hidden');
        $('.paylater--ul').addClass('hidden');
        $('.payment-later-table--loading').addClass('show');
        $('.checkout-payment__loading--box').addClass('show');
    } else {
        $('.checkout-payment__loading--box').removeClass('show');
        $('.payment-later-table--loading').removeClass('show');
        $('.payment-later-table').removeClass('hidden');
        $('.paylater--ul').removeClass('hidden');
    }
}

function funcFormOnSubmit(e) {

    if (!isInit) {
        isInit = true;

        $.fn.tagName = function () {
            return this.prop("tagName").toLowerCase();
        };
    }

    // update new version
    let oldVer = $('.checkout_version')
    $(oldVer).attr('data_checkout_version', oldVer++);
    //----------

    if (typeof (e) == 'string') {
        var element = $(e);
        var formData = e;
    } else {
        var element = this;
        var formData = this;
        //e.preventDefault();
        let formIdCheck = $(element).attr('id'), replaceElement = [], funcCallback;
        e.preventDefault();
    }

    $(element).find('button:submit').addClass('btn-loading');
    let formId = $(element).attr('id'), replaceElement = [], funcCallback;

    if (formId == undefined || formId == null || formId == '')
        return;

    const findPaymentMethodId = $('body').find('input:radio[name$="payment_method_id"]:checked').attr('type-id');

    const isReePay = findPaymentMethodId == 41 || findPaymentMethodId == 43 || findPaymentMethodId == 46 || findPaymentMethodId == 12;
    const findCardHistoryId = $('body').find('input:radio[name$="payment_card_id"]:checked').attr('card-id');

    if (['section-payment-method', 'form_discount_add', 'section-shipping-rate'].includes(formId) && isReePay) {
        if (findPaymentMethodId == 41) {
            $('#section-pay-later-method').removeClass('hidden');
        }
        if (findPaymentMethodId == 43) {
            $('#section-pay-later-method-kredivo').removeClass('hidden');
        }
        if (findPaymentMethodId == 46) {
            $('#section-pay-later-method-aftee').removeClass('hidden');
        }
        if (findPaymentMethodId == 12) {
            $('#section-pay-card-history-method-payoo').removeClass('hidden');
        }
        paylayterLoadingTrigger()
    }

    if (formId == 'form_update_location_customer_shipping' || formId == 'form_update_shipping_method' || formId == 'section-shipping-rate' || formId == 'section-payment-method') {
        if ($('.order-checkout__loading--box').length > 0) {
            $('#' + formId).find('.order-checkout__loading--box').addClass('show');
            $('body').find('button:submit').addClass('btn-loading');
        }
    }


    if (formId == 'form_next_step' || formId == "checkout_complete") {
        formData = '.step-sections';
        replaceElement = [...replaceElement,
            '.step-sections', '.order-summary-sections',
            '#checkout_order_information_changed_error_message']
    } else if (
        formId == 'form_redeem_add'
        || formId == 'form_redeem_remove'
        || formId == 'form_discount_add'
        || formId == 'form_discount_remove'
        || formId == 'section-payment-method'
        || formId == 'form_update_shipping_method'
        || formId == "checkout_complete"


        || formId == 'section-shipping-rate'

    ) {
        replaceElement = [...replaceElement, '#checkout_order_information_changed_error_message', '#form_update_shipping_method'
            , '#change_pick_location_or_shipping',
            '.inventory_location_data',
            '.order-summary-toggle-inner .order-summary-toggle-total-recap',
            '.order-summary-sections',
            '.order-summary-section.order-summary-section-total-lines.total-line-table.total-line-table-footer',
            '.order-summary-section.order-summary-section-total-lines.total-line-table.total-line.total-line-redeem',
            '.order-summary-section.order-summary-section-redeem.redeem-login-section',
            '.step-footer'
        ]

        replaceElement.push('#section-shipping-rate');

    }


    replaceElement.push('#section-pay-later-method');
    replaceElement.push('#section-pay-later-method-kredivo')
    replaceElement.push('#section-pay-later-method-aftee')
    replaceElement.push('#section-pay-card-history-method-payoo')
    if (!$(formData) || $(formData).length == 0) {
        window.location.reload();
        return false;
    }

    var inputurl = '';

    if (($(formData).tagName() != 'form' && $(formData).tagName() != 'input' && $(formData).tagName() != 'div')
        || ($(formData).tagName() == 'input' || $(formData).tagName() == 'div')) {

        formData += ' :input';
    }
    try {

        var listparameters = new URLSearchParams($(formData).serialize());

        var countrytmp = $('body').find('input[name$="selected_customer_shipping_country"]').val();
        if (countrytmp && countrytmp != '') {
            listparameters.set('customer_shipping_country', countrytmp);
        }

        if ($('body').find('#customer_pick_at_location_true').length != 0 && $('body').find('#customer_pick_at_location_true').is(':checked')) {
            let location_id_checked = $('.inventory_location input[name="inventory_location_id"]:checked').val();
            listparameters.set('inventory_location_id', location_id_checked);
        }

        if ($('body').find('#section-shipping-rate').length != 0) {
            let shipping_rate_id_checked = $('#section-shipping-rate input[name="shipping_rate_id"]:checked').val();
            listparameters.set('shipping_rate_id', shipping_rate_id_checked);
        }


        var provincetmp = $('body').find('input[name$="selected_customer_shipping_province"]').val();
        if (provincetmp && provincetmp != '' && provincetmp != "null") {
            listparameters.set('customer_shipping_province', provincetmp);
            var districttmp = $('body').find('input[name$="selected_customer_shipping_district"]').val();
            if (districttmp && districttmp != '' && districttmp != "null") {
                listparameters.set('customer_shipping_district', districttmp);
                var wardtmp = $('body').find('input[name$="selected_customer_shipping_ward"]').val();
                if (wardtmp && wardtmp != '') listparameters.set('customer_shipping_ward', wardtmp);
            } else {
                var districtid = listparameters.get('customer_shipping_district');
                if (districtid == null || districtid == '' || districtid == "null" || districtid == 'null') {
                    listparameters.set('customer_shipping_district', '');
                    listparameters.set('customer_shipping_ward', '');
                }
            }
        } else {
            var provinceid = listparameters.get('customer_shipping_province');
            if (provinceid == null || provinceid == '' || provinceid == "null" || provinceid == 'null') {
                var district = listparameters.get('customer_shipping_district')
                if (district && district != '') {
                    listparameters.set('customer_shipping_district', '');
                }

                var ward = listparameters.get('customer_shipping_ward')
                if (ward && ward != '') {
                    listparameters.set('customer_shipping_ward', '');
                }
            }
        }


        var address1tmp = $('body').find('input[name$="billing_address[address1]"]').val();
        if (address1tmp != '' && address1tmp != undefined) listparameters.set('billing_address[address1]', address1tmp);

        var phonetmp = $('body').find('input[name$="billing_address[phone]"]').val();
        if (phonetmp != '' && phonetmp != undefined) listparameters.set('billing_address[phone]', phonetmp);

        var emailtmp = $('body').find('input[name$="checkout_user[email]"]').val();
        if (emailtmp != '' && emailtmp != undefined) listparameters.set('checkout_user[email]', emailtmp);

        var fullnametmp = $('body').find('input[name$="billing_address[full_name]"]').val();
        if (fullnametmp != '' && fullnametmp != undefined) listparameters.set('billing_address[full_name]', fullnametmp);


        listparameters.delete('selected_customer_shipping_country');
        listparameters.delete('selected_customer_shipping_province');
        listparameters.delete('selected_customer_shipping_district');
        listparameters.delete('selected_customer_shipping_ward');

        if ($('body').find('input[name$="customer_pick_at_location"]')) {
            var optionShippingtmp = $('body').find('input[name$="customer_pick_at_location"]:checked').val();
            if (optionShippingtmp != '' && optionShippingtmp != undefined) listparameters.set('customer_pick_at_location', optionShippingtmp);

        } else {
            listparameters.append("customer_pick_at_location", false);
        }


        if (formId == 'form_next_step' || formId == 'form_update_shipping_method' || formId == 'section-payment-method' || formId == 'section-shipping-rate') {
            var version = Number($('body').find('.checkout_version').attr("data_checkout_version"));
            if (version)
                listparameters.append("version", version);
        }


        if (findCardHistoryId != null && findCardHistoryId != 'undefined')
            listparameters.set('card_payment_token', findCardHistoryId);
        inputurl = listparameters.toString();

    } catch (err) {

        // Older Browser URLSearchParams not support
        var listparameters = parseQueryString($(formData).serialize());
        if (formId == 'form_next_step') {
            var version = Number($('body').find('.checkout_version').attr("data_checkout_version"));
            listparameters.version = version;
        }
        var countrytmp = $('body').find('input[name$="selected_customer_shipping_country"]').val();
        if (countrytmp != '') {
            listparameters.customer_shipping_country = countrytmp;
        }

        var provincetmp = $('body').find('input[name$="selected_customer_shipping_province"]').val();
        if (provincetmp != '' && listparameters.customer_shipping_province) listparameters.customer_shipping_province = provincetmp;

        var districttmp = $('body').find('input[name$="selected_customer_shipping_district"]').val();
        if (districttmp != '' && listparameters.customer_shipping_district) listparameters.customer_shipping_district = districttmp;

        var wardtmp = $('body').find('input[name$="selected_customer_shipping_ward"]').val();
        if (wardtmp != '' && listparameters.customer_shipping_ward) listparameters.customer_shipping_ward = wardtmp;


        var address1tmp = $('body').find('input[name$="billing_address[address1]"]').val();
        if (address1tmp != '' && listparameters.billing_address[address1] && address1tmp != undefined) listparameters.set('billing_address[address1]', address1tmp);

        var phonetmp = $('body').find('input[name$="billing_address[phone]"]').val();
        if (phonetmp != '' && listparameters.billing_address[phone] && phonetmp != undefined) listparameters.set('billing_address[phone]', phonetmp);

        var emailtmp = $('body').find('input[name$="checkout_user[email]"]').val();
        if (emailtmp != '' && listparameters.checkout_user[email] && emailtmp != undefined) listparameters.set('checkout_user[email]', emailtmp);


        var fullnametmp = $('body').find('input[name$="billing_address[full_name]"]').val();
        if (fullnametmp != '' && listparameters.billing_address[full_name] && fullnametmp != undefined) listparameters.set('billing_address[full_name]', fullnametmp);


        delete listparameters.selected_customer_shipping_country;
        delete listparameters.selected_customer_shipping_province;
        delete listparameters.selected_customer_shipping_district;
        delete listparameters.selected_customer_shipping_ward;

        if ($('body').find('input[name$="customer_pick_at_location"]')) {
            var optionShippingtmp = $('body').find('input[name$="customer_pick_at_location"]:checked').val();
            if (optionShippingtmp != '' && optionShippingtmp != undefined) listparameters.set('customer_pick_at_location', optionShippingtmp);
        } else {
            listparameters.append("customer_pick_at_location", false);
        }

        if (formId == 'form_next_step' || formId == 'form_update_shipping_method' || formId == 'section-payment-method' || formId == 'section-shipping-rate') {
            var fiversion = $('body').find('.checkout_version').attr("data_checkout_version");
            if (fiversion && fiversion != '') {
                listparameters['version'] = Number(fiversion);
            }

        }


        var listObject = '';
        for (var key in listparameters) {
            listObject += '&' + key + '=' + encodeURIComponent(listparameters[key]);
        }
        ;
        inputurl = listObject.substring(1);

    }


    let url = window.location.origin + window.location.pathname + '?' + inputurl + encodeURI('&form_name=' + formId)
    let data = '';
    var method = "get";
    if (formId == "checkout_complete") {
        url = '/checkouts/complete';
        method = "post";
        data = $('#' + formId).serialize()
    }


    $.ajax({
        type: method,
        url: url,
        data: data,
        success: function (html) {
            if ($(html).attr('id') == 'redirect-url') {
                window.location = $(html).val();
            } else {
                if (replaceElement.length > 0) {
                    for (var i = 0; i < replaceElement.length; i++) {
                        var tempElement = replaceElement[i];
                        var newElement = $(html).find(tempElement);

                        if (newElement.length > 0) {
                            if (tempElement == '.step-sections')
                                $(tempElement).attr('step', $(newElement).attr('step'));

                            var listTempElement = $(tempElement);

                            for (var j = 0; j < newElement.length; j++)
                                if (j < listTempElement.length) {

                                    if ($(newElement[j]).attr('id') == 'checkout_order_information_changed_error_message') {
                                        if ($(newElement[j]).find('span').html().trim() != '') {
                                            $(listTempElement[j]).removeClass('hidden');
                                            $("html, body").animate({scrollTop: 0}, "slow");
                                            if ($(window).width() <= 999) {
                                                $('.banner').addClass('error');
                                            }
                                        } else {
                                            $(listTempElement[j]).addClass('hidden');
                                            if ($(window).width() <= 999) {
                                                $('.banner').removeClass('error');
                                            }
                                        }
                                    }
                                    if ($(newElement[j]).attr('class') == 'order-summary-sections' && formId == 'section-payment-method') {
                                        const oldVersion = $('.checkout_version')
                                        const newVersion = $(html).find('.checkout_version').attr('data_checkout_version')
                                        $(oldVersion).attr('data_checkout_version', newVersion);
                                        $(listTempElement[j]).html($(newElement[j]).html());
                                    } else {
                                        $(listTempElement[j]).html($(newElement[j]).html());
                                    }

                                }
                        }
                    }
                }


                var is_vietnam = $("#is_vietnam").val();
                if (is_vietnam && is_vietnam == "true") {
                    //$("#div_location_country_not_vietnam").hide();
                } else {
                    $("#div_location_country_not_vietnam").show();
                }


                $('body').attr('src', $(html).attr('src'));
                $(element).find('button:submit').removeClass('btn-loading');
                $('body').find('button:submit').removeClass('btn-loading');
                if (($('body').find('.field-error') && $('body').find('.field-error').length > 0)
                    || ($('body').find('.has-error') && $('body').find('.has-error').length > 0)) {
                    $("html, body").animate({scrollTop: 0}, "slow");
                }
                if (['section-payment-method', 'form_discount_add', 'section-shipping-rate', 'form_discount_remove'].includes(formId) && isReePay) {
                    if (formId != 'section-payment-method') {
                        paylayterLoadingTrigger()
                        funcFormOnSubmit('#section-payment-method')
                    } else {
                        if (findPaymentMethodId == 41) {
                            $('#section-pay-later-method').removeClass('hidden')
                        }
                        if (findPaymentMethodId == 43) {
                            $('#section-pay-later-method-kredivo').removeClass('hidden')
                        }
                        if (findPaymentMethodId == 46) {
                            $('#section-pay-later-method-aftee').removeClass('hidden')
                        }
                        if (findPaymentMethodId == 12) {
                            $('#section-pay-card-history-method-payoo').removeClass('hidden')
                        }
                        paylayterLoadingTrigger(false)
                    }
                } else {
                    paylayterLoadingTrigger()
                }

                if (formId == 'form_update_location_customer_shipping' || formId == 'form_update_shipping_method' || formId == 'section-shipping-rate' || formId == 'section-payment-method') {
                    if ($('.order-checkout__loading--box').length > 0) {
                        $('.order-checkout__loading--box').removeClass('show');
                    }
                }
                if (funcCallback)
                    funcCallback();
            }
        }
    }).fail(function () {
        $(element).find('button:submit').removeClass('btn-loading');
        if (formId == 'section-payment-method') {
            $('#section-pay-later-method').addClass('hidden');
            paylayterLoadingTrigger(false)
        }
        if (formId == 'form_update_location_customer_shipping' || formId == 'form_update_shipping_method' || formId == 'section-shipping-rate' || formId == 'section-payment-method') {
            if ($('.order-checkout__loading--box').length > 0) {
                $('.order-checkout__loading--box').removeClass('show');

            }
        }
    });

    return false;
};

function getRepayment(e) {
    let element, formData;
    if (typeof (e) == 'string') {
        element = $(e);
    } else {
        element = this;
        e.preventDefault();
    }
    const findPaymentMethodId = $('body').find('input:radio[name$="payment_method_id"]:checked').attr('type-id');

    const isReePay = findPaymentMethodId == 41 || findPaymentMethodId == 43 || findPaymentMethodId == 46 || findPaymentMethodId == 12;

    var formId = $(element).attr('id'), replaceElement = [], funcCallback;
    if (formId == undefined || formId == null || formId == '') return;
    if (isReePay) {
        if (findPaymentMethodId == 41) {
            $('#section-pay-later-method-kredivo').addClass('hidden');
            $('#section-pay-later-method-aftee').addClass('hidden');
            $('#section-pay-later-method').removeClass('hidden');
            $('#section-pay-card-history-method-payoo').addClass('hidden');
        }
        if (findPaymentMethodId == 43) {
            $('#section-pay-later-method').addClass('hidden');
            $('#section-pay-later-method-aftee').addClass('hidden');
            $('#section-pay-later-method-kredivo').removeClass('hidden');
            $('#section-pay-card-history-method-payoo').addClass('hidden');
        }
        if (findPaymentMethodId == 46) {
            $('#section-pay-later-method').addClass('hidden');
            $('#section-pay-later-method-kredivo').addClass('hidden');
            $('#section-pay-later-method-aftee').removeClass('hidden');
            $('#section-pay-card-history-method-payoo').addClass('hidden');
        }
        if (findPaymentMethodId == 12) {
            $('#section-pay-card-history-method-payoo').removeClass('hidden');
            $('#section-pay-later-method').addClass('hidden');
            $('#section-pay-later-method-kredivo').addClass('hidden');
            $('#section-pay-later-method-aftee').addClass('hidden');
        }
        paylayterLoadingTrigger()
    }
    replaceElement.push('.content-box');
    replaceElement.push('#section-pay-later-method');
    replaceElement.push('#section-pay-later-method-kredivo')
    replaceElement.push('#section-pay-later-method-aftee')
    replaceElement.push('#section-pay-card-history-method-payoo')
    let paymentMethodId = $('body').find('input:radio[name$="payment_method_id"]:checked').val()
    if (formId == 'section-payment-method') {
        $.ajax({
            type: 'GET',
            url: window.location.origin + window.location.pathname + '?' + 'payment_method_id=' + paymentMethodId + '&preview=true',
            success: function (html) {
                for (var i = 0; i < replaceElement.length; i++) {
                    let tempElement = replaceElement[i];
                    let newElement = $(html).find(tempElement);
                    if (newElement.length > 0) {

                        let listTempElement = $(tempElement);
                        for (var j = 0; j < newElement.length; j++)
                            if (j < listTempElement.length) {
                                $(listTempElement[j]).html($(newElement[j]).html());
                            }
                    }
                }
                if (isReePay) {
                    if (findPaymentMethodId == 41) {
                        $('#section-pay-later-method').removeClass('hidden');
                    }
                    if (findPaymentMethodId == 43) {
                        $('#section-pay-later-method-kredivo').removeClass('hidden');
                    }
                    if (findPaymentMethodId == 46) {
                        $('#section-pay-later-method-aftee').removeClass('hidden');
                    }
                    if (findPaymentMethodId == 12) {
                        $('#section-pay-card-history-method-payoo').removeClass('hidden');
                    }
                }
                ;
                paylayterLoadingTrigger(false)
            }
        }).fail(function () {
            $('#section-pay-later-method').addClass('hidden');
            $('#section-pay-later-method-kredivo').addClass('hidden');
            $('#section-pay-later-method-aftee').addClass('hidden');
            $('#section-pay-card-history-method-payoo').addClass('hidden');
            $('.checkout-payment__loading--box').removeClass('show');
            $('.payment-later-table--loading').removeClass('show');
        })
    }
    return false;
}

function funcSetEvent() {

    var effectControlFieldClass = '.field input, .field select, .field textarea';
    $('body')
        .on('focus', effectControlFieldClass, function () {
            funcFieldFocus($(this), true);
        })
        .on('blur', effectControlFieldClass, function () {
            funcFieldFocus($(this), false);
            funcFieldHasValue($(this), true);
            var idDOM = $(this).attr('id');

            if (idDOM == 'checkout_user_email' || idDOM == 'billing_address_phone' || idDOM == 'billing_address_full_name' || idDOM == 'billing_address_address1') {
                var elementForm = $('body').find('input#' + idDOM);
                if (elementForm && elementForm.val() != '' && elementForm.val().length > 0) {
                    $('#form_update_shipping_method').submit();
                }
            }


        })
        .on('keyup input paste', effectControlFieldClass, function () {
            funcFieldHasValue($(this), false);
        })
        .on('submit', 'form', funcFormOnSubmit);


    //$("#div_location_country_not_vietnam").hide();
    $("#is_vietnam").val("true");
    $("#div_location_country_not_vietnam").hide();


    $('body')
        .on('change', '#form_update_location_customer_shipping', function (e) {
            if (e.target.id === 'billing_address_address1') return;
            $(this).submit();
        })
    ;


    $('body')

        .on('change', '#form_update_location_customer_shipping select[name=customer_shipping_country]', function () {

            var currentCountry = $(this).val();
            if (currentCountry && currentCountry != "null" && currentCountry != 241) {
                $("#is_vietnam").val("false");
                $("#div_location_country_not_vietnam").show();
            } else {
                $("#is_vietnam").val("true");
                $("#div_location_country_not_vietnam").hide();
            }
        })

        .on('change', '#form_update_location_customer_shipping select[name=customer_shipping_country]', function () {

            var country_selected = $('body').find('input[name=selected_customer_shipping_country]');
            if (country_selected && country_selected.length > 0) {
                $(country_selected).val($(this).val());

                var province_selected = $('body').find('#form_update_location_customer_shipping select[name=customer_shipping_province]');
                if (province_selected && province_selected.length > 0) {
                    province_selected.val("null");
                }
                var district_selected = $('body').find('#form_update_location_customer_shipping select[name=customer_shipping_district]');
                if (district_selected && district_selected.length > 0) {
                    district_selected.val("null");
                }

                var ward_selected = $('body').find('#form_update_location_customer_shipping select[name=customer_shipping_ward]');
                if (ward_selected && ward_selected.length > 0) {
                    ward_selected.val("null");
                }

                var province = $('.section-customer-information input:hidden[name=customer_shipping_province]');
                if (province) {
                    province.val("null");
                }

                var district = $('.section-customer-information input:hidden[name=customer_shipping_district]');
                if (district) {
                    district.val("null");
                }
                var ward = $('.section-customer-information input:hidden[name=customer_shipping_ward]');
                if (ward) {
                    ward.val("null");
                }
            }

            $('.section-customer-information input:hidden[name=customer_shipping_coutry]').val($(this).val());
        })
        .on('change', '#form_update_location_customer_shipping select[name=customer_shipping_province]', function () {

            var province_selected = $('body').find('input[name=selected_customer_shipping_province]');
            if (province_selected && province_selected.length > 0) {
                $(province_selected).val($(this).val());
                var district_selected = $('body').find('#form_update_location_customer_shipping select[name=customer_shipping_district]');
                if (district_selected && district_selected.length > 0) {
                    district_selected.val("null");
                }

                var ward_selected = $('body').find('#form_update_location_customer_shipping select[name=customer_shipping_ward]');
                if (ward_selected && ward_selected.length > 0) {
                    ward_selected.val("null");
                }

                var district = $('.section-customer-information input:hidden[name=customer_shipping_district]');
                if (district) {
                    district.val("null");
                }
                var ward = $('.section-customer-information input:hidden[name=customer_shipping_ward]');
                if (ward) {
                    ward.val("null");
                }
            }
            $('.section-customer-information input:hidden[name=customer_shipping_province]').val($(this).val());
        })
        .on('change', '#form_update_location_customer_shipping select[name=customer_shipping_district]', function () {

            var district_selected = $('body').find('input[name=selected_customer_shipping_district]');
            if (district_selected && district_selected.length > 0) {
                $(district_selected).val($(this).val());

                var ward_selected = $('body').find('#form_update_location_customer_shipping select[name=customer_shipping_ward]');
                if (ward_selected && ward_selected.length > 0) {
                    ward_selected.val("null");
                }
                var ward = $('.section-customer-information input:hidden[name=customer_shipping_ward]');
                if (ward) {
                    ward.val("null");
                }
            }
            $('.section-customer-information input:hidden[name=customer_shipping_district]').val($(this).val());
        })
        .on('change', '#form_update_location_customer_shipping select[name=customer_shipping_ward]', function () {


            var ward_selected = $('body').find('input[name=selected_customer_shipping_ward]');
            if (ward_selected && ward_selected.length > 0) {
                $(ward_selected).val($(this).val());
            }

            $('.section-customer-information input:hidden[name=customer_shipping_ward]').val($(this).val());
        });


    $('body')
        .on('change', '#form_update_shipping_method input:radio', function (e) {
            $('#form_update_shipping_method .content-box-row.content-box-row-secondary').addClass('hidden');

            var id = $(this).attr('id');

            if (id) {
                var sub = $('body').find('.content-box-row.content-box-row-secondary[for=' + id + ']')

                if (sub && sub.length > 0) {
                    $(sub).removeClass('hidden');
                }
            }
        });


    $('body')
        .on('change', '#section-payment-method input:radio', function () {
            $('#section-payment-method .content-box-row.content-box-row-secondary').addClass('hidden');
            funcFormOnSubmit('#section-payment-method');
            var id = $(this).attr('id');

            if (id) {
                var sub = $('body').find('.content-box-row.content-box-row-secondary[for=' + id + ']')

                if (sub && sub.length > 0) {
                    $(sub).removeClass('hidden');
                }
            }
        });


    $('body')
        .on('change', '#section-shipping-rate input:radio[name=shipping_rate_id]', function () {
            funcFormOnSubmit('#section-shipping-rate');
        });


};

function funcFieldFocus(fieldInputElement, isFocus) {

    if (fieldInputElement == undefined)
        return;

    var fieldElement = $(fieldInputElement).closest('.field');

    if (fieldElement == undefined)
        return;

    if (isFocus)
        $(fieldElement).addClass('field-active');
    else
        $(fieldElement).removeClass('field-active');
};

function funcFieldHasValue(fieldInputElement, isCheckRemove) {

    if (fieldInputElement == undefined)
        return;

    var fieldElement = $(fieldInputElement).closest('.field');

    if (fieldElement == undefined)
        return;

    if ($(fieldElement).find('.field-input-wrapper-select').length > 0) {
        var value = $(fieldInputElement).find(':selected').val();

        if (value == 'null')
            value = undefined;

        if ($(fieldInputElement)[0].id == 'customer_shipping_country') {
            var country_selected = $('body').find('input[name=selected_customer_shipping_country]');
            if (country_selected && country_selected.length > 0) {
                $(country_selected).val(value);
            }
        }

        if ($(fieldInputElement)[0].id == 'customer_shipping_province') {
            var province_selected = $('body').find('input[name=selected_customer_shipping_province]');
            if (province_selected && province_selected.length > 0) {
                $(province_selected).val(value);
            }
        }

        if ($(fieldInputElement)[0].id == 'customer_shipping_district') {
            var district_selected = $('body').find('input[name=selected_customer_shipping_district]');
            if (district_selected && district_selected.length > 0) {
                $(district_selected).val(value);
            }
        }
        if ($(fieldInputElement)[0].id == 'customer_shipping_ward') {
            var ward_selected = $('body').find('input[name=selected_customer_shipping_ward]');
            if (ward_selected && ward_selected.length > 0) {
                $(ward_selected).val(value);
            }
        }

    } else {
        var value = $(fieldInputElement).val();
    }

    if (!isCheckRemove) {
        if (value != $(fieldInputElement).attr('value'))
            $(fieldElement).removeClass('field-error');
    }

    var fieldInputBtnWrapperElement = $(fieldInputElement).closest('.field-input-btn-wrapper');

    if (value && value.trim() != '') {
        $(fieldElement).addClass('field-show-floating-label');
        $(fieldInputBtnWrapperElement).find('button:submit').removeClass('btn-disabled');
    } else if (isCheckRemove) {
        $(fieldElement).removeClass('field-show-floating-label');
        $(fieldInputBtnWrapperElement).find('button:submit').addClass('btn-disabled');
    } else {
        $(fieldInputBtnWrapperElement).find('button:submit').addClass('btn-disabled');
    }
};

function funcInit() {

    funcSetEvent();


}

function funcReplaceMembershipInfo(html, replaceElement) {

    var tempElement = $(replaceElement);
    var newElement = $(html).find(replaceElement);
    tempElement.html(newElement.html());
}

function funcMembershipInfo() {

}

function funcGetBrowserInfo() {

    $.ajax({
        type: 'POST',
        url: '/browser-info?w=' + $(window).width() + '&h=' + $(window).height(),
        success: function () {
        }
    });


}

$(document).ready(function () {
    funcInit();
    funcMembershipInfo();
    funcGetBrowserInfo();
});
var toggleShowOrderSummary = false;
$(document).ready(function () {
    var currentUrl = '';
    const findPaymentMethodId = $('body').find('input:radio[name$="payment_method_id"]:checked').attr('type-id');
    const isReePay = findPaymentMethodId == 41 || findPaymentMethodId == 43 || findPaymentMethodId == 46 || findPaymentMethodId == 12;


    if (isReePay) {

        funcFormOnSubmit('#section-payment-method')

    }

    currentUrl = '/checkouts/b0f5454f852d4a8a9bfdb60baf1fb2d7?step=1';


    if ($('#reloadValue').val().length == 0) {
        $('#reloadValue').val(currentUrl);
        $('body').show();
    } else {
        window.location = $('#reloadValue').val();
        $('#reloadValue').val('');
    }

    $('body')
        .on('click', '.order-summary-toggle', function () {
            toggleShowOrderSummary = !toggleShowOrderSummary;

            if (toggleShowOrderSummary) {
                $('.order-summary-toggle')
                    .removeClass('order-summary-toggle-hide')
                    .addClass('order-summary-toggle-show');

                $('.sidebar:not(.sidebar-second) .sidebar-content .order-summary')
                    .removeClass('order-summary-is-collapsed')
                    .addClass('order-summary-is-expanded');

                $('.sidebar.sidebar-second .sidebar-content .order-summary')
                    .removeClass('order-summary-is-expanded')
                    .addClass('order-summary-is-collapsed');
            } else {
                $('.order-summary-toggle')
                    .removeClass('order-summary-toggle-show')
                    .addClass('order-summary-toggle-hide');

                $('.sidebar:not(.sidebar-second) .sidebar-content .order-summary')
                    .removeClass('order-summary-is-expanded')
                    .addClass('order-summary-is-collapsed');

                $('.sidebar.sidebar-second .sidebar-content .order-summary')
                    .removeClass('order-summary-is-collapsed')
                    .addClass('order-summary-is-expanded');
            }
        });
});
if ((typeof Haravan) === 'undefined') {
    Haravan = {};
}
Haravan.culture = 'vi-VN';
Haravan.shop = 'haisanhoanggia.myharavan.com';
Haravan.theme = {"name": "CUS 2022 ko xóa news+Mai 655304+31/07/2023 759053", "id": 1000966139, "role": "main"};
Haravan.domain = 'haisanhoanggia.com';

(function () {
    function asyncLoad() {
        var urls = ["https://app.haraloyalty.com/api/assets/checkout.js?scope=checkout&v=1643126796"];
        for (var i = 0; i < urls.length; i++) {
            var s = document.createElement('script');
            s.type = 'text/javascript';
            s.async = true;
            s.src = urls[i];
            var x = document.getElementsByTagName('script')[0];
            x.parentNode.insertBefore(s, x);
        }
    }

    window.attachEvent ? window.attachEvent('onload', asyncLoad) : window.addEventListener('load', asyncLoad, false);
})();
window.HaravanAnalytics.ga = "UA-196895417-1";
window.HaravanAnalytics.enhancedEcommerce = true;
(function (i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r;
    i[r] = i[r] || function () {
        (i[r].q = i[r].q || []).push(arguments)
    }, i[r].l = 1 * new Date();
    a = s.createElement(o),
        m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
ga('create', window.HaravanAnalytics.ga, {
    cookieDomain: 'auto',
    siteSpeedSampleRate: '10',
    sampleRate: 100,
    allowLinker: true
});
ga('send', 'pageview');
ga('require', 'linker');
ga('require', 'linker');
try {
    if (window.location.href.indexOf('checkouts') > -1) {
        var themeid = Haravan.theme.id;
        !function (e, t, n) {
            var a = t.getElementsByTagName(n)[0], c = t.createElement(n);
            c.async = false, c.src = "https://theme.hstatic.net/1000182631/" + themeid + "/14/tracking.js?v=" + (new Date).getTime(), a.parentNode.insertBefore(c, a)
        }(window, document, "script");
    }
} catch (e) {
}
;
window.HaravanAnalytics.ga4 = "G-EZGSYKJLNG";
window.HaravanAnalytics.enhancedEcommercev4 = false;
window.dataLayer = window.dataLayer || [];

function gtag() {
    dataLayer.push(arguments);
}

gtag('js', new Date());
gtag('config', 'G-EZGSYKJLNG');
window.HaravanAnalytics.fb = "1641919716262815";
!function (f, b, e, v, n, t, s) {
    if (f.fbq) return;
    n = f.fbq = function () {
        n.callMethod ?
            n.callMethod.apply(n, arguments) : n.queue.push(arguments)
    };
    if (!f._fbq) f._fbq = n;
    n.push = n;
    n.loaded = !0;
    n.version = '2.0';
    n.queue = [];
    t = b.createElement(e);
    t.async = !0;
    t.src = v;
    s = b.getElementsByTagName(e)[0];
    s.parentNode.insertBefore(t, s)
}(window,
    document, 'script', '//connect.facebook.net/en_US/fbevents.js');
// Insert Your Facebook Pixel ID below.
fbq('init', "1641919716262815", {}, {'agent': 'plharavan'});
fbq('track', 'PageView');
$("html, body").animate({scrollTop: 0}, "slow");
$(document).ready(function () {
    var dataDiscount = {
        "data": []
    };
    dataDiscount.data.forEach(function (item) {
        var it = item.discount;
        if (it) {
            it.description = getDiscountDescription(it);
            it.highlight_note = getDiscountHighlightNote(it);
            it.enddate = getDiscountExpireDate(it);
        }
    });

    function getDiscountExpireDate(item) {
        var strDate = "HSD: ";
        if (item.enddate && item.enddate.trim() !== "") {
            var date = new Date(item.enddate);
            if (!isNaN(date.getTime())) { // Kiểm tra xem có phải là ngày hợp lệ không
                return strDate.concat(date.toLocaleDateString(Haravan?.culture || "vi-VN"));
            }
        }
        return "";
    }

    function getDiscountHighlightNote(item) {
        var description = "";
        var applyForObject = "";
        var strDiscountType = "";
        if (item.discount_type == 3) {
            //shipping
            if (item.take_type == 1)//amount
            {
                var amount = Haravan.formatMoney(item.savings, "{{amount}}₫");
                description = "<li>Giảm " + amount + " phí vận chuyển " + "</li>";
            } else if (item.take_type == 2) //percent
            {
                var amount = item.savings / 100;
                description = "<li>Giảm " + amount + "% phí vận chuyển " + "</li>";
            }

        } else if (item.discount_type == 4) {
            //sameprice
            var amount = Haravan.formatMoney(item.savings, "{{amount}}₫");
            description = "<li>Đồng giá " + amount + "</li>";
        } else if (item.discount_type == 5) {
            //order amount
            if (item.take_type == 1) {
                var amount = Haravan.formatMoney(item.savings, "{{amount}}₫");
                strDiscountType = " <li>Giảm " + amount + "</li>";
                description += strDiscountType;
            } else if (item.take_type == 2) {
                var amount = item.savings / 100;
                strDiscountType = "<li>Giảm " + amount + "% giá trị đơn hàng</li>";
                description += strDiscountType;
            }

        } else if (item.discount_type == 6) {
            //product amount
            if (item.take_type == 1) {
                var amount = Haravan.formatMoney(item.savings, "{{amount}}₫");
                strDiscountType = " <li>Giảm " + amount + "</li>";
                description += strDiscountType;
            } else if (item.take_type == 2) {
                var amount = item.savings / 100;
                strDiscountType = "<li>Giảm " + amount + "% giá trị sản phẩm</li>";
                description += strDiscountType;
            }
        }

        return "<ul>" + description + "</ul>";
    }
    
    function getDiscountDescription(item) {
        var description = "";
        var resultDiscount = "";
        var str_max_amount_apply = "";
        var applyQuantityOrderValue = "";
        var str_LimitUsedCustomer = "";

        var applyForCustomers = "";
        var applyForProducts = "";
        var applyForProvinces = "";

        if (item.max_amount_apply > 0) {
            var max_amount_apply = Haravan.formatMoney(item.max_amount_apply, "{{amount}}₫");
            str_max_amount_apply = "<li>Tối đa " + max_amount_apply + "</li>";

        }

        if (item.customer_limit_used > 0) {
            str_LimitUsedCustomer = "<li>Mỗi khách hàng chỉ được áp dụng " + item.customer_limit_used + " lần</li>";

        }

        if (item.product_quantity > 0) {
            var strQuantity = "<li>Mua tối thiểu " + item.product_quantity + " sản phẩm </li>";
            applyQuantityOrderValue += strQuantity;
        }

        if (item.order_over > 0) {
            var strAmount = "<li>Mua tối thiểu " + Haravan.formatMoney(item.order_over, "{{amount}}₫") + "</li>";
            applyQuantityOrderValue += strAmount;
        }

        if (item.province_apply_type == 2) {
            //product_prerequisite
            applyForProvinces += "<li>Tỉnh thành áp dụng ";

            var lstProvinces = "";
            item.entitled_provinces.data.forEach(function (objData) {
                var obj = objData.province;
                var str = obj.province_name + ", ";
                lstProvinces += str;
            })
            if (lstProvinces.length > 2)
                lstProvinces = lstProvinces.substring(0, lstProvinces.length - 2);
            applyForProvinces += lstProvinces + " </li>";
        }

        if (item.product_apply_type == 2) {
            //product_prerequisite
            applyForProducts += "<li>Sản phẩm ";

            var lstProducts = "";
            item.entitled_products.data.forEach(function (objData) {
                var obj = objData.product;
                var str = "<a target='blank' href='" + obj.product_url + "'>" + obj.product_title + "</a> <br/>";
                lstProducts += str;
            })

            applyForProducts += lstProducts + " </li>";
        } else if (item.product_apply_type == 3) {
            //collection_prerequisite
            applyForProducts += "<li>Nhóm sản phẩm ";

            var lstCollections = "";
            item.entitled_collections.data.forEach(function (objData) {
                var obj = objData.collection;
                var str = "<a target='blank' href='" + obj.collection_url + "'>" + obj.collection_title + "</a> <br/>";
                lstCollections += str;
            })

            applyForProducts += lstCollections + " </li>";
        } else if (item.product_apply_type == 4) {
            //variant_prerequisite
            applyForProducts += "<li>Biến thể của sản phẩm";

            var lstVariants = "";
            item.entitled_variants.data.forEach(function (objData) {

                var obj = objData.variant;
                var str = "<a target='blank' href='" + obj.product_url + "'>" + obj.product_title + " (" + obj.variant_title + ")" + "</a> <br/>";
                lstVariants += str;
            })

            applyForProducts += lstVariants + " </li>";
        }

        if (item.customer_apply_type == 2) {
            //customer_prerequisite
            applyForCustomers = "<li>Khách hàng được chỉ định</li>";
        } else if (item.customer_apply_type == 3) {
            //customersegment_prerequisite
            applyForCustomers = "<li>Nhóm khách hàng được chỉ định</li>";
        }


        if (item.discount_type == 4) {
            //sameprice
            var amount = Haravan.formatMoney(item.savings, "{{amount}}₫");
            resultDiscount = "<li>Đồng giá " + amount + "</li>";

        } else if (item.discount_type == 3) {
            //shipping
            if (item.take_type == 1) {
                //amount
                var amount = Haravan.formatMoney(item.savings, "{{amount}}₫");
                resultDiscount = "<li>Giảm " + amount + " phí vận chuyển" + "</li>";
                if (item.max_shipping_fee_apply > 0) {
                    var max_shipping_fee_apply = Haravan.formatMoney(item.max_shipping_fee_apply, "{{amount}}₫");
                    var subItem = "<li>Không áp dụng nếu phí vận chuyển vượt quá " + max_shipping_fee_apply + "</li>";
                    resultDiscount = resultDiscount + subItem;
                }
            } else {
                //percentage
                var amount = item.savings / 100;
                resultDiscount = "<li>Giảm " + amount + "% phí vận chuyển" + "</li>";
                if (item.max_shipping_fee_apply > 0) {
                    var max_shipping_fee_apply = Haravan.formatMoney(item.max_shipping_fee_apply, "{{amount}}₫");
                    var subItem = "<li>Không áp dụng nếu phí vận chuyển vượt quá " + max_shipping_fee_apply + "</li>";
                    resultDiscount = resultDiscount + subItem;
                }

            }
        } else if (item.discount_type == 5) {
            //order amount
            if (item.take_type == 1) {
                //amount
                var amount = Haravan.formatMoney(item.savings, "{{amount}}₫");
                resultDiscount = "<li>Giảm " + amount + " giá trị đơn hàng" + "</li>";

            } else {
                var amount = item.savings / 100;
                resultDiscount = "<li>Giảm " + amount + "% giá trị đơn hàng" + "</li>";
            }
        } else if (item.discount_type == 6) {

            //product amount
            if (item.take_type == 1) {
                //amount
                var amount = Haravan.formatMoney(item.savings, "{{amount}}₫");
                resultDiscount = "<li>Giảm " + amount + " sản phẩm" + "</li>";
                var str_on_every_item = "";
                if (item.on_every_item == 'true') {
                    str_on_every_item = "<li>Áp dụng cho từng sản phẩm trong giỏ hàng</li>";
                } else {
                    str_on_every_item = "<li>Áp dụng 1 lần cho toàn bộ đơn hàng</li>";
                }
                resultDiscount += str_on_every_item;
            } else {
                var amount = item.savings / 100;
                resultDiscount = "<li>Giảm " + amount + "% sản phẩm" + "</li>";
            }


        }
        description += resultDiscount;
        description += str_max_amount_apply;
        description += applyQuantityOrderValue;
        description += str_LimitUsedCustomer;
        description += applyForCustomers;
        description += applyForProducts;
        description += applyForProvinces;
        return "<ul>" + description + "</ul>";
    }


    function togglePopupCoupons() {
        if ($('.hrv-coupons-popup').hasClass('active-popup') && $('.hrv-coupons-popup-site-overlay').hasClass('active-popup')) {
            $('.hrv-coupons-popup').removeClass('active-popup');
            $('.hrv-coupons-popup-site-overlay').removeClass('active-popup');
            $('[class*="hrv-discount-code-"]').removeClass('open-more');
            if ($(window).width() < 768) {
                $('body').css('overflow', '');
            }
        } else {
            $('.hrv-coupons-popup').addClass('active-popup');
            $('.hrv-coupons-popup-site-overlay').addClass('active-popup');

            if ($(window).width() < 768) {
                $('body').css('overflow', 'hidden');
            }
        }
    }

    function renderCoupons() {
        var htmlItemCoupons = "";
        var hiddenClass = "";
        $.each(dataDiscount.data, function (i, v) {
            var couponItem = v.discount;
            if (i >= 2) hiddenClass = 'hidden';
            /*
        var htmlItemCoupon = `<div class="coupon_item




            ${hiddenClass}">
                            <div class="coupon_icon pos-relative">
                                <div class="icon-svg">
                                    <svg xmlns="http://www.w3.org/2000/svg" id="Layer_1" data-name="Layer 1" viewBox="0 0 56 56"><defs><style>.cls-1{fill:#10a9f7;}.cls-2{fill:#1c70f7;}.cls-3{fill:#1f26f7;}</style></defs><path class="cls-1" d="M32.67,4.67A7,7,0,0,0,28,6.49a7,7,0,1,0-4.67,12.18h9.34a7,7,0,0,0,0-14ZM21,11.67a2.34,2.34,0,1,1,4.67,0V14H23.33A2.34,2.34,0,0,1,21,11.67ZM32.67,14H30.33V11.67A2.34,2.34,0,1,1,32.67,14Z"/><path class="cls-2" d="M44.54,25.67H11.87A2.33,2.33,0,0,0,9.54,28V49a2.36,2.36,0,0,0,2.36,2.36H44.52A2.35,2.35,0,0,0,46.87,49V28A2.33,2.33,0,0,0,44.54,25.67Z"/><path class="cls-3" d="M42,14H14a7,7,0,0,0-7,7v8.49a.84.84,0,0,0,.84.84H48.16a.84.84,0,0,0,.84-.84V21A7,7,0,0,0,42,14Z"/><path class="cls-1" d="M25.67,14h4.66V51.33H25.67Z"/></svg>
                                </div>
                                <div class="coupon_body">
                                    <div class="coupon_head">

                                        <h3 class="coupon_title"> <span>




            ${couponItem.name}</span></h3>
                                        <div class="coupon_desc_short">




            ${couponItem.highlight_note}</div>
                                        <div class="coupon_desc">




            ${couponItem.description}</div>`;
        if(couponItem.description != '') htmlItemCoupon += `<div class="coupon_more">Xem chi tiết</div>`;
        htmlItemCoupon +=				`<div class="coupon_exp">




            ${couponItem.enddate}</div>
                                    </div>
                                    <button class="btn btn_apply_line_coupon" data-code="




            ${couponItem.name}">Áp dụng</button>
                                </div>
                            </div>
                          </div>`;
        */

            var htmlItemCoupon = `<div class="coupon_item ${hiddenClass}">
		                        <div class="coupon_icon pos-relative">
									<div class="coupon_body">

										 <div class="coupon_head">
											<div class="icon-svg">
												<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M28.4325 45.5026C27.418 45.5026 26.5115 44.7611 25.631 44.0411C25.093 43.6006 24.3555 42.9976 23.9995 42.9976C23.644 42.9976 22.9065 43.6006 22.3685 44.0411C21.404 44.8296 20.31 45.7261 19.1055 45.4501C17.8625 45.1676 17.254 43.8606 16.717 42.7081C16.449 42.1316 16.043 41.2601 15.7545 41.1206C15.4485 40.9711 14.4985 41.2016 13.87 41.3526C12.6465 41.6471 11.2605 41.9791 10.2805 41.1976C9.297 40.4121 9.3145 38.9816 9.331 37.7201C9.339 37.0766 9.351 36.1046 9.144 35.8446C8.9395 35.5886 7.993 35.3861 7.3665 35.2521C6.1275 34.9871 4.7245 34.6866 4.1745 33.5466C3.6325 32.4241 4.265 31.1511 4.822 30.0281C5.1115 29.4461 5.5485 28.5656 5.472 28.2281C5.403 27.9256 4.65 27.3411 4.152 26.9541C3.1435 26.1721 2 25.2841 2 24.0001C2 22.7161 3.1435 21.8286 4.1525 21.0456C4.6505 20.6591 5.4035 20.0746 5.4725 19.7716C5.549 19.4341 5.112 18.5536 4.823 17.9711C4.2655 16.8481 3.6335 15.5756 4.176 14.4521C4.726 13.3126 6.129 13.0121 7.3675 12.7471C7.994 12.6131 8.9405 12.4106 9.1445 12.1551C9.3525 11.8946 9.3405 10.9221 9.3325 10.2786C9.3165 9.01706 9.299 7.58706 10.282 6.80156C11.2615 6.01956 12.6485 6.35256 13.8715 6.64656C14.501 6.79756 15.45 7.02606 15.7555 6.87906C16.0445 6.73956 16.45 5.86856 16.7185 5.29156C17.255 4.13856 17.863 2.83206 19.106 2.54956C20.309 2.27656 21.405 3.16956 22.369 3.95856C22.9075 4.39906 23.645 5.00206 24.0005 5.00206C24.356 5.00206 25.0935 4.39906 25.6315 3.95906C26.5965 3.16956 27.69 2.27456 28.895 2.54956C30.1375 2.83206 30.746 4.13906 31.283 5.29206C31.5515 5.86856 31.957 6.74006 32.246 6.87956C32.5525 7.02706 33.501 6.79806 34.1295 6.64706C35.353 6.35306 36.7395 6.02006 37.7195 6.80206C38.703 7.58756 38.6855 9.01756 38.669 10.2796C38.661 10.9231 38.649 11.8956 38.856 12.1551C39.0605 12.4106 40.007 12.6136 40.6335 12.7476C41.8725 13.0126 43.2755 13.3126 43.8255 14.4526C44.3675 15.5756 43.735 16.8486 43.178 17.9716C42.8885 18.5541 42.4515 19.4341 42.528 19.7716C42.597 20.0746 43.35 20.6591 43.848 21.0456C44.8565 21.8286 46 22.7161 46 24.0001C46 25.2841 44.8565 26.1716 43.8475 26.9546C43.3495 27.3411 42.5965 27.9251 42.5275 28.2291C42.451 28.5666 42.888 29.4466 43.177 30.0291C43.7345 31.1521 44.3665 32.4246 43.824 33.5481C43.274 34.6876 41.871 34.9881 40.6325 35.2526C40.006 35.3871 39.0595 35.5896 38.855 35.8451C38.6475 36.1056 38.6595 37.0781 38.6675 37.7216C38.6835 38.9826 38.701 40.4126 37.718 41.1981C36.7385 41.9801 35.3515 41.6466 34.1285 41.3531C33.499 41.2021 32.55 40.9726 32.2445 41.1211C31.9555 41.2601 31.55 42.1316 31.2815 42.7081C30.745 43.8616 30.137 45.1681 28.894 45.4506C28.738 45.4861 28.584 45.5026 28.4325 45.5026ZM15.445 39.0751C15.8595 39.0751 16.257 39.1421 16.6235 39.3186C17.555 39.7676 18.051 40.8331 18.5305 41.8636C18.768 42.3736 19.262 43.4346 19.5485 43.4996C19.815 43.5466 20.685 42.8331 21.102 42.4921C22.001 41.7571 22.93 40.9971 23.9995 40.9971C25.069 40.9971 25.9985 41.7576 26.897 42.4921C27.314 42.8331 28.158 43.5326 28.4515 43.4996C28.737 43.4341 29.2315 42.3736 29.4685 41.8636C29.9475 40.8331 30.4435 39.7686 31.3755 39.3186C32.3235 38.8611 33.4775 39.1396 34.595 39.4081C35.1325 39.5371 36.253 39.8066 36.469 39.6346C36.6885 39.4596 36.674 38.3021 36.667 37.7461C36.6525 36.6001 36.6375 35.4156 37.2915 34.5966C37.9415 33.7826 39.096 33.5356 40.213 33.2966C40.76 33.1796 41.8975 32.9361 42.022 32.6786C42.138 32.4371 41.629 31.4111 41.3845 30.9181C40.872 29.8856 40.3415 28.8176 40.5765 27.7856C40.804 26.7846 41.7275 26.0676 42.62 25.3746C43.103 25.0006 44 24.3046 44 24.0001C44 23.6956 43.103 22.9996 42.621 22.6251C41.728 21.9321 40.8045 21.2156 40.577 20.2141C40.3425 19.1821 40.873 18.1141 41.3855 17.0816C41.63 16.5886 42.1395 15.5631 42.023 15.3211C41.8985 15.0631 40.761 14.8201 40.2145 14.7031C39.0975 14.4641 37.9425 14.2171 37.2925 13.4036C36.639 12.5851 36.654 11.4001 36.6685 10.2546C36.6755 9.69856 36.69 8.54056 36.4705 8.36556C36.2555 8.19356 35.1345 8.46306 34.596 8.59206C33.479 8.86056 32.325 9.13856 31.3765 8.68106C30.445 8.23156 29.949 7.16656 29.4695 6.13656C29.232 5.62656 28.7385 4.56556 28.4515 4.50056C28.1765 4.45306 27.3145 5.16706 26.8975 5.50756C25.999 6.24306 25.07 7.00306 24.0005 7.00306C22.931 7.00306 22.002 6.24256 21.103 5.50756C20.686 5.16656 19.816 4.45606 19.5485 4.50006C19.2625 4.56506 18.768 5.62606 18.531 6.13606C18.0515 7.16606 17.556 8.23106 16.6245 8.68056C15.6765 9.13756 14.5225 8.86056 13.4045 8.59156C12.867 8.46206 11.7455 8.19306 11.5305 8.36456C11.311 8.54006 11.3255 9.69756 11.3325 10.2536C11.347 11.3996 11.362 12.5846 10.708 13.4026C10.058 14.2166 8.9035 14.4636 7.7865 14.7026C7.2395 14.8196 6.102 15.0631 5.9775 15.3206C5.8615 15.5621 6.3705 16.5881 6.615 17.0811C7.1275 18.1136 7.658 19.1816 7.423 20.2136C7.1955 21.2146 6.272 21.9316 5.3795 22.6246C4.897 22.9996 4 23.6956 4 24.0001C4 24.3046 4.897 25.0011 5.379 25.3751C6.272 26.0681 7.1955 26.7841 7.423 27.7856C7.6575 28.8176 7.127 29.8851 6.6145 30.9181C6.37 31.4111 5.8605 32.4366 5.977 32.6786C6.1015 32.9371 7.239 33.1801 7.786 33.2971C8.9025 33.5361 10.0575 33.7831 10.7075 34.5971C11.361 35.4156 11.346 36.6001 11.3315 37.7461C11.3245 38.3021 11.31 39.4601 11.5295 39.6351C11.7445 39.8046 12.8655 39.5376 13.404 39.4081C14.0885 39.2431 14.788 39.0751 15.445 39.0751Z" fill="#F47560"/>
<path d="M18.207 32.207L32.207 18.207C32.5975 17.8165 32.5975 17.1835 32.207 16.793C31.8165 16.4025 31.1835 16.4025 30.793 16.793L16.793 30.793C16.4025 31.1835 16.4025 31.8165 16.793 32.207C16.9885 32.4025 17.244 32.5 17.5 32.5C17.756 32.5 18.0115 32.4025 18.207 32.207ZM19.5 23C17.5705 23 16 21.43 16 19.5C16 17.57 17.5705 16 19.5 16C21.4295 16 23 17.57 23 19.5C23 21.43 21.4295 23 19.5 23ZM19.5 18C18.673 18 18 18.673 18 19.5C18 20.327 18.673 21 19.5 21C20.327 21 21 20.327 21 19.5C21 18.673 20.327 18 19.5 18ZM29.5 33C27.5705 33 26 31.4295 26 29.5C26 27.5705 27.5705 26 29.5 26C31.4295 26 33 27.5705 33 29.5C33 31.4295 31.4295 33 29.5 33ZM29.5 28C28.673 28 28 28.673 28 29.5C28 30.327 28.673 31 29.5 31C30.327 31 31 30.327 31 29.5C31 28.673 30.327 28 29.5 28Z" fill="#F47560"/>
</svg>
											</div>
											<h3 class="coupon_title">
												<span>${couponItem.name}</span>
												<div class="coupon_exp">${couponItem.enddate}</b></div>
											</h3>
										 </div>`;
            if (couponItem.highlight_note != '') htmlItemCoupon += `<div class="coupon_desc_short">${couponItem.highlight_note}</div>`;
            if (couponItem.description != '') htmlItemCoupon += `<div class="coupon_desc">${couponItem.description}</div>`;
            htmlItemCoupon += `			 <div class="coupon_actions">
										    <div class="coupon_more">Xem chi tiết<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Layer_1" x="0px" y="0px" viewBox="0 0 330 330" style="enable-background:new 0 0 330 330;" xml:space="preserve"><path id="XMLID_225_" d="M325.607,79.393c-5.857-5.857-15.355-5.858-21.213,0.001l-139.39,139.393L25.607,79.393 c-5.857-5.857-15.355-5.858-21.213,0.001c-5.858,5.858-5.858,15.355,0,21.213l150.004,150c2.813,2.813,6.628,4.393,10.606,4.393 s7.794-1.581,10.606-4.394l149.996-150C331.465,94.749,331.465,85.251,325.607,79.393z"></path><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g></svg></div>
										    <button class="btn btn_apply_line_coupon" data-code="${couponItem.name}">Áp dụng</button>
										 </div>
									</div>
								 </div>
							  </div>`;

            htmlItemCoupons = htmlItemCoupons + htmlItemCoupon;
        });

        if (hiddenClass != '') {
            var htmlMoreCoupon = `<div class="text-center">
								<button id="show_all_coupon">
									<span>Xem thêm</span>
									<span id="show_all_icon">
									<svg width="12" height="12" viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg">
<path d="M11.3337 5.99984L10.3937 5.05984L6.66699 8.77984V0.666504H5.33366V8.77984L1.61366 5.05317L0.666992 5.99984L6.00033 11.3332L11.3337 5.99984Z"/>
</svg>
                                    </span>
								</button>
							  </div>`;
            htmlItemCoupons += htmlMoreCoupon;
        }
        $('.hrv-discount-code-web').html(htmlItemCoupons);
    }

    $(document).on('click', '#show_all_coupon', function () {
        var coupons = $('.coupon_item').length;
        var parentDOM = $(this).parents('div[class*="hrv-discount-code-"]');
        if (!parentDOM.hasClass('open-more')) {
            parentDOM.find('.coupon_item').removeClass('hidden');
            parentDOM.addClass('open-more');
            $(this).find('span:first-child').html('Thu gọn');
        } else {
            parentDOM.find('.coupon_item:nth-child(n+3):nth-child(-n+' + coupons + ')').addClass('hidden');
            parentDOM.removeClass('open-more');
            $(this).find('span:first-child').html('Xem thêm');
        }
    });

    $('body').on('click', '.order-summary-section-display-discount .hrv-discount-choose-coupons', function () {
        togglePopupCoupons();
        renderCoupons();
    })

    $('body').on('click', '.hrv-coupons-close-popup svg', function () {
        togglePopupCoupons();
    })

    $('body').on('click', '.hrv-discount-code-web .btn_apply_line_coupon', function () {
        var codeCoupons = $(this).data('code');
        togglePopupCoupons();
        $('input[id="discount.code"]').val(codeCoupons).trigger("change");
        $('form#form_discount_add button.field-input-btn.btn.btn-default').removeClass('btn-disabled');
        $('form#form_discount_add button.field-input-btn.btn.btn-default').trigger('click');
    })

    $('body').on('click', '.coupon_layer', function () {
        $(this).siblings('.btn_apply_line_coupon').trigger('click');
    });

    $(document).on('click', '.coupon_more', function () {
        $(this).parent().siblings('.coupon_desc_short').toggleClass('close');
        $(this).toggleClass('open');
    });
    $(document).on('click', '.hrv-coupons-popup-site-overlay', function () {
        togglePopupCoupons();
    });
})
var isFirstLoadTime = true;
var siteKey = "6LchSLkqAAAAABVHBpeFgg8N-WgkYsr5fO6GUF_s";
var isUseCaptchaCheckout = false

if (isUseCaptchaCheckout == true) {

}
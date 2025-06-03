<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Thanh toán - Seafood Shop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/payment.css">
    <script src="<%=request.getContextPath()%>/JS/payment.js"></script>
    <script src='//hstatic.net/0/0/global/jquery.min.js'></script>
</head>
<body>
<div class="banner">
    <div class="wrap">
        <a href="/" class="logo">
            <div class="logo-cus"></div>
        </a>
    </div>
</div>

<div class="content">
    <div class="wrap">
        <div class="sidebar">
            <div class="sidebar-content">
                <div class="order-summary">
                    <div class="order-summary-sections">
                        <div class="order-summary-section order-summary-section-product-list">
                            <table class="product-table">
                                <tbody>
                                <tr class="product">
                                    <td class="product-image">
                                        <div class="product-thumbnail">
                                            <div class="product-thumbnail-wrapper">
                                                <img class="product-thumbnail-image" alt="Nghêu Sần - Sống"
                                                     src="//product.hstatic.net/1000182631/product/308366365_3369717133294639_935367907393673668_n_289d590ea0e74fa1869f433d6cafb5d4_small.jpeg"/>
                                            </div>
                                            <span class="product-thumbnail-quantity" aria-hidden="true">1</span>
                                        </div>
                                    </td>
                                    <td class="product-description">
                                        <span class="product-description-name order-summary-emphasis">Nghêu Sần - Sống</span>
                                        <span class="product-description-variant order-summary-small-text">1 kg</span>
                                    </td>
                                    <td class="product-price">
                                        <span class="order-summary-emphasis">249,000₫</span>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="order-summary-section order-summary-section-total-lines payment-lines">
                            <table class="total-line-table">
                                <tbody>
                                <tr class="total-line total-line-subtotal">
                                    <td class="total-line-name">Tạm tính</td>
                                    <td class="total-line-price">249,000₫</td>
                                </tr>
                                <tr class="total-line total-line-shipping">
                                    <td class="total-line-name">Phí ship sẽ được xác nhận qua điện thoại</td>
                                    <td class="total-line-price">—</td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr class="total-line">
                                    <td class="total-line-name payment-due-label">
                                        <span class="payment-due-label-total">Tổng cộng</span>
                                    </td>
                                    <td class="total-line-name payment-due">
                                        <span class="payment-due-price">249,000₫</span>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="main">
            <div class="main-content">
                <div class="step">
                    <div class="step-sections steps-onepage" step="1">
                        <div class="section">
                            <div class="section-header">
                                <h2 class="section-title">Thông tin giao hàng</h2>
                            </div>

                            <div class="section-content section-customer-information no-mb">
                                <div class="fieldset">
                                    <div class="field field-required">
                                        <div class="field-input-wrapper">
                                            <label class="field-label" for="billing_address_full_name">Họ và tên</label>
                                            <input placeholder="Họ và tên" class="field-input" type="text"
                                                   id="billing_address_full_name" name="billing_address[full_name]">
                                        </div>
                                    </div>

                                    <div class="field field-required field-two-thirds">
                                        <div class="field-input-wrapper">
                                            <label class="field-label" for="checkout_user_email">Email</label>
                                            <input placeholder="Email" class="field-input" type="email"
                                                   id="checkout_user_email" name="checkout_user[email]">
                                        </div>
                                    </div>

                                    <div class="field field-required field-third">
                                        <div class="field-input-wrapper">
                                            <label class="field-label" for="billing_address_phone">Số điện thoại</label>
                                            <input placeholder="Số điện thoại" class="field-input" type="tel"
                                                   id="billing_address_phone" name="billing_address[phone]">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="section-content">
                                <div class="fieldset">


                                    <div class="field field-required field-third">
                                        <div class="field-input-wrapper field-input-wrapper-select">
                                            <label class="field-label" for="customer_shipping_province">Tỉnh /
                                                thành</label>
                                            <select class="field-input" id="customer_shipping_province">
                                                <option value="null" selected>Chọn tỉnh / thành</option>
                                                <option value="50">Hồ Chí Minh</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="field field-required field-third">
                                        <div class="field-input-wrapper field-input-wrapper-select">
                                            <label class="field-label" for="customer_shipping_district">Quận /
                                                huyện</label>
                                            <select class="field-input" id="customer_shipping_district">
                                                <option value="null" selected>Chọn quận / huyện</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="field field-required field-third">
                                        <div class="field-input-wrapper field-input-wrapper-select">
                                            <label class="field-label" for="customer_shipping_ward">Phường / xã</label>
                                            <select class="field-input" id="customer_shipping_ward">

                                                <option value="null" selected>Chọn phường / xã</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="field field-required">
                                        <div class="field-input-wrapper">
                                            <label class="field-label" for="billing_address_address1">ghi chú</label>
                                            <input placeholder="ghi chú" class="field-input" type="text"
                                                   id="billing_address_address1" name="billing_address[address1]">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="section-payment-method" class="section">
                                <div class="section-header">
                                    <h2 class="section-title">Phương thức thanh toán</h2>
                                </div>
                                <div class="section-content">
                                    <div class="content-box">
                                        <div class="radio-wrapper content-box-row">
                                            <label class="radio-label" for="payment_method_id_502444">
                                                <div class="radio-input payment-method-checkbox">
                                                    <input id="payment_method_id_502444" class="input-radio"
                                                           name="payment_method_id" type="radio" value="502444" checked>
                                                </div>
                                                <div class='radio-content-input'>
                                                    <div>
                                                        <span class="radio-label-primary">COD - Thanh toán khi nhận hàng</span>
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                        <div class="radio-wrapper content-box-row">
                                            <label class="radio-label" for="payment_method_id_1002918822">
                                                <div class="radio-input payment-method-checkbox">
                                                    <input id="payment_method_id_1002918822" class="input-radio"
                                                           name="payment_method_id" type="radio" value="1002918822">
                                                </div>
                                                <div class='radio-content-input'>
                                                    <div>
                                                        <span class="radio-label-primary">Chuyển khoản ngân hàng</span>
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="step-footer">
                        <form id="form_next_step">
                            <button type="submit" class="step-footer-continue-btn btn">
                                <span class="btn-content">Hoàn tất đơn hàng</span>
                            </button>
                        </form>
                        <a class="step-footer-previous-link" href="<%= request.getContextPath()%>/JSP/cart.jsp">
                            Giỏ hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
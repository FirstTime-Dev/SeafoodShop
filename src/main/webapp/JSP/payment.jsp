<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Thanh toán - Seafood Shop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/payment.css">
    <script src="//hstatic.net/0/0/global/jquery.min.js"></script>
    <script src="<%= request.getContextPath() %>/JS/payment.js"></script>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="banner">
    <div class="wrap">
        <a href="/SeafoodShop_war_exploded/homeController" class="logo">
            <div class="logo-cus"></div>
        </a>
    </div>
</div>

<div class="content">
    <div class="wrap">
        <%
            SeafoodShop.model.Product product = (SeafoodShop.model.Product) request.getAttribute("product");
            if (product == null) {
        %>
        <div class="sidebar">
            <div class="sidebar-content">
                <p>Không tìm thấy sản phẩm để hiển thị.</p>
            </div>
        </div>
        <%
        } else {
            String imgUrl = product.getImgUrl();
            String thumbnailSrc = (imgUrl == null || imgUrl.trim().isEmpty())
                    ? (request.getContextPath() + "/IMG/default-product.png")
                    : (request.getContextPath() + "/" + imgUrl);
            String formattedPrice = String.format("%,d", product.getPrice().longValue()) + "₫";
        %>
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
                                                <img class="product-thumbnail-image"
                                                     alt="<%= product.getName() %>"
                                                     src="<%= thumbnailSrc %>"/>
                                            </div>
                                            <span class="product-thumbnail-quantity" aria-hidden="true">1</span>
                                        </div>
                                    </td>
                                    <td class="product-description">
                                        <span class="product-description-name order-summary-emphasis"><%= product.getName() %></span>
                                        <span class="product-description-variant order-summary-small-text">1 kg</span>
                                    </td>
                                    <td class="product-price">
                                        <span class="order-summary-emphasis"><%= formattedPrice %></span>
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
                                    <td class="total-line-price"><%= formattedPrice %>
                                    </td>
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
                                        <span class="payment-due-price"><%= formattedPrice %></span>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>

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
                                                   id="checkout_user_email" name="billing_address[email]">
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
                                            <select class="field-input" id="customer_shipping_province"
                                                    name="billing_address[province]">
                                                <option value="">Chọn tỉnh / thành</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="field field-required field-third">
                                        <div class="field-input-wrapper field-input-wrapper-select">
                                            <label class="field-label" for="customer_shipping_district">Quận /
                                                huyện</label>
                                            <select class="field-input" id="customer_shipping_district"
                                                    name="billing_address[district]">
                                                <option value="">Chọn quận / huyện</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="field field-required field-third">
                                        <div class="field-input-wrapper field-input-wrapper-select">
                                            <label class="field-label" for="customer_shipping_ward">Phường / xã</label>
                                            <select class="field-input" id="customer_shipping_ward"
                                                    name="billing_address[ward]">
                                                <option value="">Chọn phường / xã</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="field field-required">
                                        <div class="field-input-wrapper">
                                            <label class="field-label" for="billing_address_address1">Ghi chú</label>
                                            <input placeholder="Ghi chú" class="field-input" type="text"
                                                   id="billing_address_address1" name="billing_address[address1]">
                                        </div>
                                    </div>

                                    <div class="field field-required">
                                        <div class="field-input-wrapper">
                                            <label class="field-label">Phí ship</label>
                                            <span id="shipping_fee_display">—</span>
                                        </div>
                                    </div>

                                    <div class="field">
                                        <div class="field-input-wrapper">
                                            <label class="field-label">Tổng thanh toán</label>
                                            <span id="total_price">—</span>
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
                                                           name="payment_method_id" type="radio" value="COD" checked>
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
                                                           name="payment_method_id" type="radio" value="Bank">
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
                        <form id="form_next_step" action="<%= request.getContextPath() %>/Payment" method="post">
                            <input type="hidden" name="productId" value="<%= product.getProductID() %>">
                            <input type="hidden" name="quantity" value="1">
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

<jsp:include page="footer.jsp"/>

</body>
</html>

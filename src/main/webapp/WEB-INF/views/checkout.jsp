<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Checkout | THOUHA MART</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f7f7f7;
            color: #222;
        }

        .header {
            background: #ffffff;
            border-bottom: 1px solid #e5e5e5;
            padding: 18px 6%;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font-size: 25px;
            font-weight: 800;
            color: #7b2cbf;
        }

        .nav {
            display: flex;
            gap: 25px;
        }

        .nav a {
            text-decoration: none;
            color: #333;
            font-weight: 600;
        }

        .nav a:hover {
            color: #7b2cbf;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 40px auto;
        }

        .page-title {
            margin-bottom: 25px;
        }

        .page-title h1 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .page-title p {
            color: #777;
        }

        .checkout-grid {
            display: grid;
            grid-template-columns: 1fr 380px;
            gap: 25px;
        }

        .card {
            background: #ffffff;
            border-radius: 14px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }

        .card h2 {
            margin-bottom: 20px;
            font-size: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 700;
        }

        textarea {
            width: 100%;
            min-height: 140px;
            resize: vertical;
            border: 1px solid #d8d8d8;
            border-radius: 10px;
            padding: 14px;
            font-size: 15px;
            outline: none;
        }

        textarea:focus {
            border-color: #7b2cbf;
        }

        .payment-option {
            border: 2px solid #7b2cbf;
            border-radius: 10px;
            padding: 16px;
            display: flex;
            align-items: center;
            gap: 12px;
            background: #faf5ff;
        }

        .payment-option input {
            width: 18px;
            height: 18px;
        }

        .payment-info strong {
            display: block;
            margin-bottom: 4px;
        }

        .payment-info span {
            color: #777;
            font-size: 13px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            color: #555;
        }

        .summary-total {
            border-top: 1px solid #eee;
            margin-top: 18px;
            padding-top: 18px;
            display: flex;
            justify-content: space-between;
            font-size: 21px;
            font-weight: 800;
        }

        .place-order {
            width: 100%;
            margin-top: 25px;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: #7b2cbf;
            color: white;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
        }

        .place-order:hover {
            background: #6420a3;
        }

        .back-cart {
            display: inline-block;
            margin-top: 18px;
            color: #7b2cbf;
            text-decoration: none;
            font-weight: 600;
        }

        .error {
            background: #ffe8e8;
            color: #b00020;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        @media (max-width: 800px) {

            .checkout-grid {
                grid-template-columns: 1fr;
            }

            .header {
                flex-direction: column;
                gap: 15px;
            }

            .nav {
                flex-wrap: wrap;
                justify-content: center;
            }
        }

    </style>
</head>

<body>

<header class="header">

    <div class="logo">
        THOUHA MART
    </div>

    <nav class="nav">

        <a href="${pageContext.request.contextPath}/buyer/home">
            Home
        </a>

        <a href="${pageContext.request.contextPath}/products">
            Products
        </a>

        <a href="${pageContext.request.contextPath}/cart">
            Cart
        </a>

        <a href="${pageContext.request.contextPath}/orders">
            Orders
        </a>

    </nav>

</header>


<main class="container">

    <div class="page-title">

        <h1>Checkout</h1>

        <p>
            Enter your delivery details and place your order.
        </p>

    </div>


    <c:if test="${not empty error}">

        <div class="error">
            ${error}
        </div>

    </c:if>


    <div class="checkout-grid">


        <!-- SHIPPING DETAILS -->

        <div class="card">

            <h2>Delivery Address</h2>

            <form action="${pageContext.request.contextPath}/checkout"
                  method="post">

                <div class="form-group">

                    <label for="shippingAddress">
                        Shipping Address
                    </label>

                    <textarea
                            id="shippingAddress"
                            name="shippingAddress"
                            placeholder="Enter your complete delivery address"
                            required></textarea>

                </div>


                <h2>Payment Method</h2>

                <label class="payment-option">

                    <input
                            type="radio"
                            name="paymentMethod"
                            value="COD"
                            checked>

                    <div class="payment-info">

                        <strong>
                            Cash on Delivery
                        </strong>

                        <span>
                            Pay when your order is delivered.
                        </span>

                    </div>

                </label>


                <button type="submit"
                        class="place-order">

                    Place Order

                </button>

            </form>

            <a class="back-cart"
               href="${pageContext.request.contextPath}/cart">

                ← Back to Cart

            </a>

        </div>


        <!-- ORDER SUMMARY -->

        <div class="card">

            <h2>Order Summary</h2>

            <div class="summary-row">

                <span>Items</span>

                <strong>${cartItems.size()}</strong>

            </div>


            <c:set var="total" value="0" />

            <c:forEach var="item" items="${cartItems}">

                <c:set var="total"
                       value="${total + item.subtotal}" />

            </c:forEach>


            <div class="summary-row">

                <span>Subtotal</span>

                <strong>
                    ₹ ${total}
                </strong>

            </div>


            <div class="summary-row">

                <span>Delivery</span>

                <strong>
                    FREE
                </strong>

            </div>


            <div class="summary-total">

                <span>Total</span>

                <span>
                    ₹ ${total}
                </span>

            </div>

        </div>

    </div>

</main>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Orders | THOUHA MART</title>

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

        .order-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding-bottom: 18px;
            margin-bottom: 18px;
        }

        .order-number {
            font-size: 18px;
            font-weight: 800;
        }

        .order-date {
            color: #777;
            font-size: 14px;
            margin-top: 6px;
        }

        .status {
            background: #e9f8ef;
            color: #18864b;
            padding: 7px 13px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
        }

        .order-details {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .detail-box {
            background: #fafafa;
            border-radius: 10px;
            padding: 15px;
        }

        .detail-box span {
            display: block;
            color: #777;
            font-size: 13px;
            margin-bottom: 7px;
        }

        .detail-box strong {
            font-size: 16px;
        }

        .address {
            margin-top: 18px;
            padding-top: 18px;
            border-top: 1px solid #eee;
        }

        .address-title {
            font-weight: 700;
            margin-bottom: 7px;
        }

        .address-text {
            color: #666;
            line-height: 1.5;
        }

        .empty {
            background: #ffffff;
            text-align: center;
            padding: 60px 20px;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }

        .empty-icon {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .empty h2 {
            margin-bottom: 10px;
        }

        .empty p {
            color: #777;
            margin-bottom: 25px;
        }

        .shop-button {
            display: inline-block;
            background: #7b2cbf;
            color: white;
            text-decoration: none;
            padding: 12px 22px;
            border-radius: 9px;
            font-weight: 700;
        }

        .shop-button:hover {
            background: #6420a3;
        }

        @media (max-width: 700px) {

            .header {
                flex-direction: column;
                gap: 15px;
            }

            .nav {
                flex-wrap: wrap;
                justify-content: center;
            }

            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }

            .order-details {
                grid-template-columns: 1fr;
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

        <h1>My Orders</h1>

        <p>
            Track and review your orders from THOUHA MART.
        </p>

    </div>


    <c:choose>

        <c:when test="${empty orders}">

            <div class="empty">

                <div class="empty-icon">
                    📦
                </div>

                <h2>No Orders Yet</h2>

                <p>
                    You haven't placed any orders yet.
                </p>

                <a class="shop-button"
                   href="${pageContext.request.contextPath}/products">

                    Start Shopping

                </a>

            </div>

        </c:when>


        <c:otherwise>

            <c:forEach var="order"
                       items="${orders}">

                <div class="order-card">

                    <div class="order-header">

                        <div>

                            <div class="order-number">

                                Order #${order.id}

                            </div>

                            <div class="order-date">

                                ${order.createdAt}

                            </div>

                        </div>


                        <div class="status">

                            ${order.status}

                        </div>

                    </div>


                    <div class="order-details">

                        <div class="detail-box">

                            <span>
                                Total Amount
                            </span>

                            <strong>
                                ₹ ${order.totalAmount}
                            </strong>

                        </div>


                        <div class="detail-box">

                            <span>
                                Payment Method
                            </span>

                            <strong>
                                ${order.paymentMethod}
                            </strong>

                        </div>


                        <div class="detail-box">

                            <span>
                                Order Status
                            </span>

                            <strong>
                                ${order.status}
                            </strong>

                        </div>

                    </div>


                    <div class="address">

                        <div class="address-title">
                            Delivery Address
                        </div>

                        <div class="address-text">
                            ${order.shippingAddress}
                        </div>

                    </div>

                </div>

            </c:forEach>

        </c:otherwise>

    </c:choose>

</main>

</body>

</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

    <title>My Cart - THOUHA MART</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            color: #333;
        }

        .header {
            background: #ffffff;
            border-bottom: 1px solid #eeeeee;
            padding: 18px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .logo {
            font-size: 24px;
            font-weight: 800;
            color: #8e2de2;
            text-decoration: none;
        }

        .nav {
            display: flex;
            gap: 25px;
        }

        .nav a {
            text-decoration: none;
            color: #444;
            font-weight: 600;
        }

        .nav a:hover {
            color: #8e2de2;
        }

        .container {
            width: 86%;
            max-width: 1200px;
            margin: 40px auto;
        }

        .page-title {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #777;
            margin-bottom: 30px;
        }

        .empty-cart {
            background: #ffffff;
            padding: 60px 20px;
            border-radius: 14px;
            text-align: center;
            box-shadow: 0 4px 18px rgba(0,0,0,0.06);
        }

        .empty-icon {
            font-size: 55px;
            margin-bottom: 20px;
        }

        .empty-cart h2 {
            margin-bottom: 10px;
        }

        .empty-cart p {
            color: #777;
            margin-bottom: 25px;
        }

        .shop-btn {
            display: inline-block;
            background: #8e2de2;
            color: white;
            padding: 13px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
        }

        .cart-layout {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 25px;
            align-items: start;
        }

        .cart-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .cart-item {
            background: #ffffff;
            border-radius: 14px;
            padding: 20px;
            display: flex;
            gap: 20px;
            align-items: center;
            box-shadow: 0 4px 18px rgba(0,0,0,0.05);
        }

        .product-image {
            width: 110px;
            height: 110px;
            border-radius: 10px;
            background: #f2f2f2;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .no-image {
            font-size: 38px;
        }

        .item-details {
            flex: 1;
        }

        .item-details h3 {
            font-size: 19px;
            margin-bottom: 8px;
        }

        .price {
            font-size: 18px;
            font-weight: 700;
            color: #8e2de2;
            margin-bottom: 15px;
        }

        .quantity-form {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quantity-form label {
            font-size: 14px;
            color: #666;
        }

        .quantity-input {
            width: 65px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 6px;
            text-align: center;
        }

        .update-btn {
            border: none;
            background: #f1e7ff;
            color: #7a20c9;
            padding: 8px 13px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
        }

        .update-btn:hover {
            background: #e5d3ff;
        }

        .remove-btn {
            border: none;
            background: transparent;
            color: #e53935;
            cursor: pointer;
            font-weight: 600;
            margin-top: 10px;
        }

        .subtotal {
            font-size: 20px;
            font-weight: 800;
            text-align: right;
            min-width: 120px;
        }

        .summary {
            background: #ffffff;
            border-radius: 14px;
            padding: 25px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.05);
            position: sticky;
            top: 20px;
        }

        .summary h2 {
            margin-bottom: 22px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            color: #555;
        }

        .summary-total {
            border-top: 1px solid #eeeeee;
            padding-top: 18px;
            margin-top: 10px;
            font-size: 21px;
            font-weight: 800;
            color: #222;
        }

        .checkout-btn {
            display: block;
            width: 100%;
            text-align: center;
            background: #8e2de2;
            color: #ffffff;
            text-decoration: none;
            padding: 14px;
            border-radius: 8px;
            margin-top: 22px;
            font-weight: 700;
        }

        @media (max-width: 850px) {

            .cart-layout {
                grid-template-columns: 1fr;
            }

            .summary {
                position: static;
            }
        }

        @media (max-width: 600px) {

            .header {
                flex-direction: column;
            }

            .nav {
                gap: 15px;
            }

            .container {
                width: 92%;
            }

            .cart-item {
                flex-wrap: wrap;
            }

            .subtotal {
                width: 100%;
                text-align: left;
            }
        }

    </style>

</head>

<body>

<header class="header">

    <a class="logo"
       href="${pageContext.request.contextPath}/buyer/home">
        THOUHA MART
    </a>

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

        <a href="#">
            Orders
        </a>

    </nav>

</header>


<div class="container">

    <h1 class="page-title">
        My Cart 🛒
    </h1>

    <p class="subtitle">
        Review your selected products before checkout.
    </p>


    <c:choose>

        <c:when test="${empty cartItems}">

            <div class="empty-cart">

                <div class="empty-icon">
                    🛒
                </div>

                <h2>
                    Your cart is empty
                </h2>

                <p>
                    Looks like you haven't added anything yet.
                </p>

                <a class="shop-btn"
                   href="${pageContext.request.contextPath}/products">
                    Continue Shopping
                </a>

            </div>

        </c:when>


        <c:otherwise>

            <div class="cart-layout">

                <div class="cart-list">

                    <c:forEach var="item"
                               items="${cartItems}">

                        <div class="cart-item">

                            <div class="product-image">

                                <c:choose>

                                    <c:when test="${not empty item.imageUrl}">

                                        <img src="${item.imageUrl}"
                                             alt="${item.productName}">

                                    </c:when>

                                    <c:otherwise>

                                        <span class="no-image">
                                            📦
                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </div>


                            <div class="item-details">

                                <h3>
                                    ${item.productName}
                                </h3>

                                <div class="price">
                                    ₹ ${item.price}
                                </div>


                                <form class="quantity-form"
                                      action="${pageContext.request.contextPath}/cart/update"
                                      method="post">

                                    <input type="hidden"
                                           name="productId"
                                           value="${item.productId}">

                                    <label>
                                        Quantity
                                    </label>

                                    <input class="quantity-input"
                                           type="number"
                                           name="quantity"
                                           value="${item.quantity}"
                                           min="1">

                                    <button class="update-btn"
                                            type="submit">
                                        Update
                                    </button>

                                </form>


                                <form action="${pageContext.request.contextPath}/cart/remove"
                                      method="post">

                                    <input type="hidden"
                                           name="productId"
                                           value="${item.productId}">

                                    <button class="remove-btn"
                                            type="submit">
                                        Remove
                                    </button>

                                </form>

                            </div>


                            <div class="subtotal">

                                ₹ ${item.subtotal}

                            </div>

                        </div>

                    </c:forEach>

                </div>


                <div class="summary">

                    <h2>
                        Order Summary
                    </h2>

                    <div class="summary-row">

                        <span>
                            Items
                        </span>

                        <span>
                            ${cartItems.size()}
                        </span>

                    </div>

                    <div class="summary-row summary-total">

                        <span>
                            Total
                        </span>

                        <span>
                            ₹
                            <c:set var="total" value="0"/>

                            <c:forEach var="item"
                                       items="${cartItems}">

                                <c:set var="total"
                                       value="${total + item.subtotal}"/>

                            </c:forEach>

                            ${total}

                        </span>

                    </div>

                    <a href="${pageContext.request.contextPath}/checkout">
    Proceed to Checkout
</a>

                </div>

            </div>

        </c:otherwise>

    </c:choose>

</div>

</body>
</html>
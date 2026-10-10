<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>All Products | THOUHA MART</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f7f8fc;
            color: #202124;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .navbar {
            background: #ffffff;
            padding: 18px 6%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            flex-wrap: wrap;
            border-bottom: 1px solid #eeeeee;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.04);
        }

        .logo {
            color: #6c35de;
            font-size: 25px;
            font-weight: 800;
            letter-spacing: -0.7px;
            white-space: nowrap;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 25px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: #555;
            font-size: 14px;
            font-weight: 600;
            transition: color 0.2s;
        }

        .nav-links a:hover,
        .nav-links a.active {
            color: #6c35de;
        }

        .page-container {
            width: 88%;
            max-width: 1250px;
            margin: 38px auto;
        }

        .page-heading {
            margin-bottom: 25px;
        }

        .page-heading h1 {
            font-size: 30px;
            margin-bottom: 10px;
            color: #202124;
        }

        .page-heading p {
            color: #777;
            font-size: 15px;
            line-height: 1.6;
        }

        .search-panel {
            background: #ffffff;
            padding: 20px;
            border-radius: 14px;
            margin-bottom: 25px;
            box-shadow: 0 4px 18px rgba(30, 20, 60, 0.04);
        }

        .search-form {
            display: flex;
            gap: 12px;
        }

        .search-form input {
            flex: 1;
            min-width: 0;
            padding: 14px 16px;
            border: 1px solid #dedee8;
            border-radius: 9px;
            font-size: 15px;
            outline: none;
        }

        .search-form input:focus {
            border-color: #6c35de;
            box-shadow: 0 0 0 3px rgba(108, 53, 222, 0.10);
        }

        .search-button {
            border: none;
            border-radius: 9px;
            background: #6c35de;
            color: white;
            padding: 0 25px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
        }

        .search-button:hover {
            background: #5525bd;
        }

        .clear-link {
            display: inline-block;
            margin-top: 12px;
            color: #6c35de;
            font-size: 13px;
            font-weight: 600;
        }

        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin: 28px 0 20px;
        }

        .results-header h2 {
            font-size: 20px;
        }

        .results-count {
            color: #777;
            font-size: 14px;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 22px;
        }

        .product-card {
            background: #ffffff;
            border-radius: 14px;
            overflow: hidden;
            border: 1px solid #eeeeF4;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(40, 25, 80, 0.09);
        }

        .product-image {
            height: 210px;
            background: #f0ebff;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-placeholder {
            font-size: 58px;
        }

        .product-details {
            padding: 18px;
        }

        .product-name {
            font-size: 16px;
            font-weight: 700;
            line-height: 1.5;
            margin-bottom: 8px;
            overflow-wrap: anywhere;
        }

        .product-description {
            font-size: 13px;
            line-height: 1.6;
            color: #777;
            margin-bottom: 14px;
            overflow-wrap: anywhere;
        }

        .product-price {
            color: #6c35de;
            font-size: 22px;
            font-weight: 800;
            margin-bottom: 12px;
        }

        .stock-status {
            color: #16834a;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 17px;
        }

        .out-of-stock {
            color: #d93025;
        }

        .cart-button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background: #6c35de;
            color: white;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
        }

        .cart-button:hover {
            background: #5525bd;
        }

        .cart-button:disabled {
            background: #c7c7d0;
            cursor: not-allowed;
        }

        .empty-state {
            background: #ffffff;
            border-radius: 14px;
            padding: 60px 20px;
            text-align: center;
            grid-column: 1 / -1;
        }

        .empty-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .empty-state h3 {
            margin-bottom: 10px;
            font-size: 21px;
        }

        .empty-state p {
            color: #777;
            line-height: 1.6;
        }

        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            background: #6c35de;
            color: white;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
        }

        footer {
            text-align: center;
            padding: 25px 15px;
            color: #888;
            font-size: 13px;
            margin-top: 50px;
            border-top: 1px solid #eeeeee;
            background: #ffffff;
        }

        @media (max-width: 1000px) {
            .product-grid {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }
        }

        @media (max-width: 700px) {
            .navbar {
                padding: 16px 5%;
            }

            .nav-links {
                gap: 16px;
            }

            .page-container {
                width: 92%;
                margin: 28px auto;
            }

            .page-heading h1 {
                font-size: 25px;
            }

            .product-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 13px;
            }

            .product-image {
                height: 155px;
            }

            .product-details {
                padding: 12px;
            }

            .product-price {
                font-size: 19px;
            }

            .search-form {
                flex-direction: column;
            }

            .search-button {
                padding: 14px;
            }
        }

        @media (max-width: 380px) {
            .product-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<header class="navbar">

    <a class="logo"
       href="${pageContext.request.contextPath}/buyer/home">
        THOUHA MART
    </a>

    <nav class="nav-links">
        <a href="${pageContext.request.contextPath}/buyer/home">
            Home
        </a>

        <a class="active"
           href="${pageContext.request.contextPath}/products">
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

<main class="page-container">

    <section class="page-heading">
        <h1>Discover Products</h1>
        <p>
            Explore products from sellers across THOUHA MART.
            Find what you need at great prices.
        </p>
    </section>

    <section class="search-panel">

        <form class="search-form"
              action="${pageContext.request.contextPath}/products"
              method="get">

            <input
                type="search"
                name="search"
                placeholder="Search products by name or description..."
                value="<c:out value='${search}'/>"
                maxlength="100"
                aria-label="Search products">

            <button class="search-button" type="submit">
                Search Products
            </button>

        </form>

        <c:if test="${not empty search}">
            <a class="clear-link"
               href="${pageContext.request.contextPath}/products">
                Clear search and view all products
            </a>
        </c:if>

    </section>

    <section>

        <div class="results-header">

            <h2>
                <c:choose>
                    <c:when test="${not empty search}">
                        Search Results
                    </c:when>
                    <c:otherwise>
                        All Products
                    </c:otherwise>
                </c:choose>
            </h2>

            <span class="results-count">
                <c:choose>
                    <c:when test="${empty products}">
                        No products found
                    </c:when>
                    <c:otherwise>
                        <c:out value="${products.size()}"/> products available
                    </c:otherwise>
                </c:choose>
            </span>

        </div>

        <div class="product-grid">

            <c:choose>

                <c:when test="${not empty products}">

                    <c:forEach var="product" items="${products}">


<div class="product-image">
    <c:choose>
        <c:when test="${not empty product.imageUrl}">
            <img
                src="${pageContext.request.contextPath}/${product.imageUrl}"
                alt="<c:out value='${product.name}'/>"
                loading="lazy"
                onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">

            <span class="product-placeholder" style="display:none;">
                📦
            </span>
        </c:when>

        <c:otherwise>
            <span class="product-placeholder">
                📦
            </span>
        </c:otherwise>
    </c:choose>
</div>

<div class="product-details">

                            <div class="product-details">

                                <h3 class="product-name">
                                    <c:out value="${product.name}"/>
                                </h3>

                                <p class="product-description">
                                    <c:out value="${product.description}"/>
                                </p>

                                <div class="product-price">
                                    ₹ <fmt:formatNumber
                                            value="${product.price}"
                                            minFractionDigits="2"
                                            maxFractionDigits="2"/>
                                </div>

                                <c:choose>

                                    <c:when test="${product.stock > 0}">
                                        <p class="stock-status">
                                            ✓ In Stock
                                        </p>
                                    </c:when>

                                    <c:otherwise>
                                        <p class="stock-status out-of-stock">
                                            Out of Stock
                                        </p>
                                    </c:otherwise>

                                </c:choose>

                                <c:choose>

                                    <c:when test="${product.stock > 0}">
                                        <form
                                            action="${pageContext.request.contextPath}/cart"
                                            method="post">

                                            <input type="hidden"
                                                   name="productId"
                                                   value="<c:out value='${product.id}'/>">

                                            <input type="hidden"
                                                   name="quantity"
                                                   value="1">

                                            <button class="cart-button"
                                                    type="submit">
                                                Add to Cart
                                            </button>

                                        </form>
                                    </c:when>

                                    <c:otherwise>
                                        <button class="cart-button"
                                                type="button"
                                                disabled>
                                            Out of Stock
                                        </button>
                                    </c:otherwise>

                                </c:choose>

                            </div>

                        </article>

                    </c:forEach>

                </c:when>

                <c:otherwise>

                    <div class="empty-state">

                        <div class="empty-icon">🔎</div>

                        <h3>
                            <c:choose>
                                <c:when test="${not empty search}">
                                    No matching products found
                                </c:when>
                                <c:otherwise>
                                    No products available yet
                                </c:otherwise>
                            </c:choose>
                        </h3>

                        <p>
                            Try another search term or browse all available products.
                        </p>

                        <a class="back-button"
                           href="${pageContext.request.contextPath}/products">
                            View All Products
                        </a>

                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </section>

</main>

<footer>
    &copy; 2026 THOUHA MART. All rights reserved.
</footer>

</body>
</html>
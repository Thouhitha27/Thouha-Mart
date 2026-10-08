<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Products | THOUHA MART</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f8f8fb;
            color: #222;
        }

        /* HEADER */

        .header {
            background: #ffffff;
            border-bottom: 1px solid #eeeeee;
            padding: 15px 6%;
            display: flex;
            align-items: center;
            gap: 30px;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 25px;
            font-weight: 800;
            color: #7b2cbf;
            white-space: nowrap;
        }

        .search-box {
            flex: 1;
            max-width: 600px;
            position: relative;
        }

        .search-box input {
            width: 100%;
            padding: 13px 18px;
            border: 1px solid #dddddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            background: #f8f8f8;
        }

        .search-box input:focus {
            border-color: #7b2cbf;
            background: #ffffff;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 22px;
            margin-left: auto;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
            font-size: 14px;
            font-weight: 600;
        }

        .nav-links a:hover {
            color: #7b2cbf;
        }

        /* PAGE */

        .container {
            width: 88%;
            max-width: 1300px;
            margin: 35px auto;
        }

        .page-heading {
            margin-bottom: 25px;
        }

        .page-heading h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .page-heading p {
            color: #777;
            font-size: 14px;
        }

        /* FILTER BAR */

        .filter-bar {
            background: white;
            border: 1px solid #eeeeee;
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .filter-title {
            font-weight: 600;
            font-size: 14px;
        }

        .sort-select {
            padding: 9px 13px;
            border: 1px solid #dddddd;
            border-radius: 6px;
            background: white;
        }

        /* PRODUCT GRID */

        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 22px;
        }

        .product-card {
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #eeeeee;
            transition: 0.2s ease;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        .product-image {
            width: 100%;
            height: 230px;
            background: #f4f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .no-image {
            font-size: 55px;
            color: #cccccc;
        }

        .product-info {
            padding: 17px;
        }

        .product-name {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
            line-height: 1.4;
        }

        .product-description {
            font-size: 13px;
            color: #777;
            min-height: 38px;
            margin-bottom: 12px;
        }

        .price {
            font-size: 20px;
            font-weight: 800;
            color: #222;
            margin-bottom: 8px;
        }

        .stock {
            font-size: 12px;
            color: #238636;
            margin-bottom: 15px;
        }

        .out-stock {
            color: #d93025;
        }

        .add-cart {
            width: 100%;
            border: none;
            padding: 11px;
            border-radius: 7px;
            background: #7b2cbf;
            color: white;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
        }

        .add-cart:hover {
            background: #6923a5;
        }

        /* EMPTY */

        .empty-products {
            background: white;
            border-radius: 12px;
            padding: 70px 20px;
            text-align: center;
            border: 1px solid #eeeeee;
        }

        .empty-products h2 {
            margin-bottom: 10px;
        }

        .empty-products p {
            color: #777;
        }

        /* RESPONSIVE */

        @media (max-width: 1000px) {

            .product-grid {
                grid-template-columns: repeat(3, 1fr);
            }

            .nav-links {
                gap: 12px;
            }
        }

        @media (max-width: 750px) {

            .header {
                flex-wrap: wrap;
                gap: 15px;
            }

            .search-box {
                order: 3;
                flex-basis: 100%;
            }

            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .container {
                width: 94%;
            }
        }

        @media (max-width: 480px) {

            .product-grid {
                grid-template-columns: 1fr;
            }

            .nav-links {
                margin-left: 0;
            }
        }

    </style>
</head>

<body>

<header class="header">

    <div class="logo">
        THOUHA MART
    </div>

    <div class="search-box">
        <input
                type="text"
                placeholder="Search products..."
                id="searchInput">
    </div>

    <nav class="nav-links">
        <a href="${pageContext.request.contextPath}/buyer/home">
            Home
        </a>

        <a href="${pageContext.request.contextPath}/products">
            Products
        </a>

        <a href="#">
            Cart
        </a>

        <a href="#">
            Orders
        </a>
    </nav>

</header>


<main class="container">

    <div class="page-heading">

        <h1>All Products</h1>

        <p>
            Discover products from sellers on THOUHA MART
        </p>

    </div>


    <div class="filter-bar">

        <div class="filter-title">
            <c:out value="${products.size()}" />
            products available
        </div>

        <select class="sort-select">
            <option>Sort: Latest</option>
            <option>Price: Low to High</option>
            <option>Price: High to Low</option>
        </select>

    </div>


    <c:choose>

        <c:when test="${not empty products}">

            <div class="product-grid">

                <c:forEach var="product" items="${products}">

                    <div class="product-card">

                        <div class="product-image">

                            <c:choose>

                                <c:when test="${not empty product.imageUrl}">

                                    <img
                                            src="${product.imageUrl}"
                                            alt="<c:out value='${product.name}' />">

                                </c:when>

                                <c:otherwise>

                                    <div class="no-image">
                                        &#128230;
                                    </div>

                                </c:otherwise>

                            </c:choose>

                        </div>


                        <div class="product-info">

                            <div class="product-name">
                                <c:out value="${product.name}" />
                            </div>


                            <div class="product-description">

                                <c:choose>

                                    <c:when test="${not empty product.description}">
                                        <c:out value="${product.description}" />
                                    </c:when>

                                    <c:otherwise>
                                        Quality product from THOUHA MART
                                    </c:otherwise>

                                </c:choose>

                            </div>


                            <div class="price">
                                ₹ <c:out value="${product.price}" />
                            </div>


                            <c:choose>

                                <c:when test="${product.stock > 0}">

                                    <div class="stock">
                                        In Stock
                                   <form action="${pageContext.request.contextPath}/cart/add" method="post">
    <input type="hidden" name="productId" value="${product.id}">
    <input type="hidden" name="quantity" value="1">

    <button type="submit" class="add-cart">
        Add to Cart
    </button>
</form>

                                </c:when>

                                <c:otherwise>

                                    <div class="stock out-stock">
                                        Out of Stock
                                    </div>

                                    <button
                                            class="add-cart"
                                            disabled>
                                        Out of Stock
                                    </button>

                                </c:otherwise>

                            </c:choose>

                        </div>

                    </div>

                </c:forEach>

            </div>

        </c:when>


        <c:otherwise>

            <div class="empty-products">

                <h2>No products available</h2>

                <p>
                    Products will appear here when sellers add them.
                </p>

            </div>

        </c:otherwise>

    </c:choose>

</main>

</body>
</html>
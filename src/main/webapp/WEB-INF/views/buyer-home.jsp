<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>THOUHA MART - Home</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f8f8fc;
            color: #222;
        }

        .header {
            background: white;
            padding: 18px 7%;
            display: flex;
            align-items: center;
            gap: 25px;
            border-bottom: 1px solid #eee;
            flex-wrap: wrap;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
            color: #9b2c9b;
            white-space: nowrap;
        }

        .search {
            flex: 1;
            min-width: 180px;
            padding: 13px 18px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
        }

        .search:focus {
            border-color: #9b2c9b;
        }

        .nav {
            display: flex;
            gap: 20px;
            align-items: center;
            flex-wrap: wrap;
        }

        .nav a {
            text-decoration: none;
            color: #333;
            font-weight: 600;
        }

        .nav a:hover {
            color: #9b2c9b;
        }

        .hero {
            margin: 30px 7%;
            padding: 45px;
            border-radius: 15px;
            background: linear-gradient(135deg, #f2ddf5, #ffffff);
        }

        .hero h1 {
            font-size: 38px;
            margin-bottom: 12px;
        }

        .hero p {
            color: #666;
            font-size: 17px;
            line-height: 1.6;
            margin-bottom: 22px;
        }

        .shop-btn {
            display: inline-block;
            padding: 13px 25px;
            background: #9b2c9b;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .shop-btn:hover,
        .add-btn:hover {
            background: #792079;
        }

        .section {
            margin: 35px 7%;
        }

        .section h2 {
            margin-bottom: 20px;
            font-size: 25px;
        }

        .categories {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .category {
            background: white;
            padding: 18px 25px;
            border-radius: 10px;
            border: 1px solid #eee;
            font-weight: 600;
        }

        .products {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 22px;
        }

        .product {
            background: white;
            border-radius: 12px;
            padding: 18px;
            border: 1px solid #eee;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .product:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 22px rgba(0, 0, 0, 0.07);
        }

        .product-image {
            height: 180px;
            background: #f3f0f5;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 15px;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .placeholder {
            font-size: 55px;
        }

        .product h3 {
            margin-bottom: 8px;
            font-size: 18px;
        }

        .description {
            color: #777;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 12px;
        }

        .price {
            font-size: 21px;
            font-weight: bold;
            color: #9b2c9b;
            margin-bottom: 12px;
        }

        .stock {
            font-size: 13px;
            color: #39834a;
            margin-bottom: 12px;
        }

        .out-of-stock {
            color: #c0392b;
        }

        .add-btn {
            width: 100%;
            padding: 12px;
            border: none;
            background: #9b2c9b;
            color: white;
            border-radius: 7px;
            font-weight: bold;
            cursor: pointer;
            font-size: 14px;
        }

        .add-btn:disabled {
            background: #aaa;
            cursor: not-allowed;
        }

        .empty-state {
            background: white;
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 35px 20px;
            text-align: center;
            color: #666;
            grid-column: 1 / -1;
        }

        .footer {
            text-align: center;
            padding: 25px;
            margin-top: 40px;
            background: white;
            color: #777;
            border-top: 1px solid #eee;
        }

        @media (max-width: 700px) {
            .header {
                padding: 16px 5%;
            }

            .search {
                order: 3;
                flex-basis: 100%;
            }

            .hero {
                margin: 20px 5%;
                padding: 28px;
            }

            .hero h1 {
                font-size: 28px;
            }

            .section {
                margin: 28px 5%;
            }

            .nav {
                gap: 13px;
            }
        }
    </style>
</head>

<body>

<header class="header">
    <div class="logo">🛍️ THOUHA MART</div>

    <input
        class="search"
        type="search"
        id="productSearch"
        placeholder="Search products, brands and more..."
        aria-label="Search products"
    >

    <nav class="nav">
        <a href="${pageContext.request.contextPath}/products">🛍️ Shop</a>
        <a href="${pageContext.request.contextPath}/cart">🛒 Cart</a>
        <a href="${pageContext.request.contextPath}/orders">Orders</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<section class="hero">
    <h1>Welcome to THOUHA MART 👋</h1>
    <p>
        Discover amazing products from trusted sellers.
        Shop smarter, faster and easier.
    </p>
    <a href="${pageContext.request.contextPath}/products" class="shop-btn">
        Shop Now
    </a>
</section>

<section class="section">
    <h2>Shop by Category</h2>

    <div class="categories">
        <div class="category">📱 Electronics</div>
        <div class="category">👗 Fashion</div>
        <div class="category">🏠 Home &amp; Living</div>
        <div class="category">💄 Beauty</div>
        <div class="category">🎧 Accessories</div>
    </div>
</section>

<section class="section">
    <h2>Popular Products</h2>

    <div class="products" id="productList">

        <c:forEach var="product" items="${products}">
            <article class="product">

                <div class="product-image">
                    <c:choose>
                        <c:when test="${not empty product.imageUrl}">
                            <img
                                src="<c:out value='${product.imageUrl}'/>"
                                alt="<c:out value='${product.name}'/>"
                                loading="lazy"
                                onerror="this.style.display='none'; this.nextElementSibling.style.display='block';"
                            >
                            <span class="placeholder" style="display:none;">🛍️</span>
                        </c:when>
                        <c:otherwise>
                            <span class="placeholder">🛍️</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <h3><c:out value="${product.name}"/></h3>

                <c:if test="${not empty product.description}">
                    <p class="description">
                        <c:out value="${product.description}"/>
                    </p>
                </c:if>

                <div class="price">
                    ₹<fmt:formatNumber value="${product.price}" minFractionDigits="2" maxFractionDigits="2"/>
                </div>

                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <p class="stock">
                            In stock: <c:out value="${product.stock}"/>
                        </p>

                        <form action="${pageContext.request.contextPath}/cart/add" method="post">
                            <input type="hidden" name="productId" value="${product.id}">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="add-btn">Add to Cart</button>
                        </form>
                    </c:when>

                    <c:otherwise>
                        <p class="stock out-of-stock">Out of stock</p>
                        <button type="button" class="add-btn" disabled>
                            Out of Stock
                        </button>
                    </c:otherwise>
                </c:choose>

            </article>
        </c:forEach>

        <c:if test="${empty products}">
            <div class="empty-state">
                <h3>No products available yet</h3>
                <p>Products added by our sellers will appear here.</p>
            </div>
        </c:if>

    </div>
</section>

<footer class="footer">
    &copy; 2026 THOUHA MART. Shop with confidence.
</footer>

<script>
    const searchInput = document.getElementById("productSearch");
    const productCards = document.querySelectorAll(".product");

    searchInput.addEventListener("input", function () {
        const searchText = this.value.toLowerCase().trim();

        productCards.forEach(function (card) {
            const productName = card.querySelector("h3").textContent.toLowerCase();
            const description = card.querySelector(".description");
            const descriptionText = description
                ? description.textContent.toLowerCase()
                : "";

            card.style.display =
                productName.includes(searchText) ||
                descriptionText.includes(searchText)
                    ? ""
                    : "none";
        });
    });
</script>

</body>
</html>
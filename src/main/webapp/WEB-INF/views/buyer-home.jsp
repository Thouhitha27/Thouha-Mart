<%@ page contentType="text/html;charset=UTF-8" %>

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
            background: #f8f8f8;
            color: #222;
        }

        .header {
            background: white;
            padding: 18px 7%;
            display: flex;
            align-items: center;
            gap: 30px;
            border-bottom: 1px solid #eee;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
            color: #9b2c9b;
            white-space: nowrap;
        }

        .search {
            flex: 1;
            padding: 13px 18px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
        }

        .nav {
            display: flex;
            gap: 22px;
            align-items: center;
        }

        .nav a {
            text-decoration: none;
            color: #333;
            font-weight: 600;
        }

        .hero {
            margin: 30px 7%;
            padding: 45px;
            border-radius: 15px;
            background: linear-gradient(135deg, #f6e8f7, #ffffff);
        }

        .hero h1 {
            font-size: 38px;
            margin-bottom: 12px;
        }

        .hero p {
            color: #666;
            font-size: 17px;
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

        .section {
            margin: 35px 7%;
        }

        .section h2 {
            margin-bottom: 20px;
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
            cursor: pointer;
            font-weight: 600;
        }

        .products {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .product {
            background: white;
            border-radius: 12px;
            padding: 18px;
            border: 1px solid #eee;
        }

        .product-image {
            height: 180px;
            background: #f3f3f3;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 55px;
            margin-bottom: 15px;
        }

        .product h3 {
            margin-bottom: 8px;
        }

        .price {
            font-size: 20px;
            font-weight: bold;
            color: #9b2c9b;
            margin-bottom: 12px;
        }

        .add-btn {
            width: 100%;
            padding: 11px;
            border: none;
            background: #9b2c9b;
            color: white;
            border-radius: 7px;
            font-weight: bold;
            cursor: pointer;
        }

        @media (max-width: 700px) {
            .header {
                flex-wrap: wrap;
            }

            .search {
                order: 3;
                flex-basis: 100%;
            }

            .hero {
                padding: 30px;
            }

            .hero h1 {
                font-size: 28px;
            }
        }
    </style>
</head>

<body>

<header class="header">

    <div class="logo">
        🛍️ THOUHA MART
    </div>

    <input
        class="search"
        type="text"
        placeholder="Search products, brands and more..."
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

    <a href="#" class="shop-btn">
        Shop Now
    </a>

</section>


<section class="section">

    <h2>Shop by Category</h2>

    <div class="categories">

        <div class="category">📱 Electronics</div>

        <div class="category">👗 Fashion</div>

        <div class="category">🏠 Home & Living</div>

        <div class="category">💄 Beauty</div>

        <div class="category">🎧 Accessories</div>

    </div>

</section>


<section class="section">

    <h2>Popular Products</h2>

    <div class="products">

        <div class="product">

            <div class="product-image">
                💻
            </div>

            <h3>Premium Laptop</h3>

            <div class="price">
                ₹50,000
            </div>

            <button class="add-btn">
                Add to Cart
            </button>

        </div>


        <div class="product">

            <div class="product-image">
                📱
            </div>

            <h3>Smartphone</h3>

            <div class="price">
                ₹20,000
            </div>

            <button class="add-btn">
                Add to Cart
            </button>

        </div>


        <div class="product">

            <div class="product-image">
                🎧
            </div>

            <h3>Wireless Headphones</h3>

            <div class="price">
                ₹2,000
            </div>

            <button class="add-btn">
                Add to Cart
            </button>

        </div>

    </div>

</section>

</body>
</html>
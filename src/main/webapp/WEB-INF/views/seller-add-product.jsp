<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Add Product | THOUHA MART</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            background: #f7f7fb;
            color: #222;
        }

        .layout {
            display: flex;
            min-height: 100vh;
        }

        /* SIDEBAR */
        .sidebar {
            width: 250px;
            background: #ffffff;
            border-right: 1px solid #eeeeee;
            padding: 28px 18px;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
        }

        .brand {
            font-size: 25px;
            font-weight: 800;
            color: #6c3df4;
            margin-bottom: 8px;
            padding-left: 12px;
        }

        .seller-label {
            color: #888;
            font-size: 13px;
            padding-left: 12px;
            margin-bottom: 30px;
        }

        .menu {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .menu a {
            text-decoration: none;
            color: #555;
            padding: 14px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            transition: 0.2s;
        }

        .menu a:hover {
            background: #f1edff;
            color: #6c3df4;
        }

        .menu a.active {
            background: #eee8ff;
            color: #6c3df4;
        }

        .logout {
            margin-top: 20px;
            color: #dc2626 !important;
        }

        .logout:hover {
            background: #fef2f2 !important;
        }

        /* MAIN */
        .main {
            margin-left: 250px;
            width: calc(100% - 250px);
            padding: 30px 40px;
        }

        /* TOP BAR */
        .topbar {
            background: white;
            border-radius: 16px;
            padding: 20px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.04);
        }

        .topbar h1 {
            font-size: 25px;
        }

        .topbar p {
            color: #888;
            margin-top: 5px;
            font-size: 14px;
        }

        .seller-badge {
            background: #f1edff;
            color: #6c3df4;
            padding: 10px 16px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: bold;
            white-space: nowrap;
        }

        /* FORM CARD */
        .form-card {
            background: white;
            border-radius: 18px;
            padding: 32px;
            max-width: 900px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.05);
        }

        .form-card h2 {
            font-size: 21px;
            margin-bottom: 7px;
        }

        .form-description {
            color: #888;
            font-size: 14px;
            margin-bottom: 28px;
            line-height: 1.6;
        }

        /* ERROR */
        .error-box {
            background: #fff0f0;
            border: 1px solid #ffcaca;
            color: #c62828;
            padding: 14px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        /* FORM */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        label {
            font-size: 14px;
            font-weight: 700;
            margin-bottom: 8px;
            color: #333;
        }

        input,
        textarea,
        select {
            width: 100%;
            border: 1px solid #dddddd;
            border-radius: 10px;
            padding: 13px 14px;
            font-size: 14px;
            outline: none;
            background: #fff;
            transition: 0.2s;
        }

        input:focus,
        textarea:focus,
        select:focus {
            border-color: #6c3df4;
            box-shadow: 0 0 0 3px rgba(108, 61, 244, 0.10);
        }

        textarea {
            min-height: 130px;
            resize: vertical;
        }

        .hint {
            color: #999;
            font-size: 12px;
            margin-top: 6px;
            line-height: 1.5;
        }

        /* BUTTONS */
        .actions {
            margin-top: 30px;
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .btn {
            display: inline-block;
            border: none;
            border-radius: 10px;
            padding: 13px 22px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: 0.2s;
        }

        .btn-primary {
            background: #6c3df4;
            color: white;
        }

        .btn-primary:hover {
            background: #5930d5;
        }

        .btn-secondary {
            background: #f2f2f5;
            color: #555;
        }

        .btn-secondary:hover {
            background: #e8e8ec;
        }

        /* INFO */
        .info-box {
            max-width: 900px;
            margin-top: 20px;
            background: #f1edff;
            border: 1px solid #ddd4ff;
            border-radius: 14px;
            padding: 18px 20px;
            color: #51418a;
            font-size: 13px;
            line-height: 1.7;
        }

        /* MOBILE */
        @media (max-width: 800px) {
            .sidebar {
                width: 210px;
            }

            .main {
                margin-left: 210px;
                width: calc(100% - 210px);
                padding: 20px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full {
                grid-column: auto;
            }
        }

        @media (max-width: 600px) {
            .layout {
                display: block;
            }

            .sidebar {
                position: static;
                width: 100%;
                border-right: none;
                border-bottom: 1px solid #eee;
            }

            .main {
                margin-left: 0;
                width: 100%;
                padding: 20px;
            }

            .topbar {
                align-items: flex-start;
                flex-direction: column;
            }

            .form-card {
                padding: 22px;
            }
        }
    </style>

</head>

<body>

<div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">

        <div class="brand">THOUHA MART</div>

        <div class="seller-label">Seller Panel</div>

        <nav class="menu">

            <a href="${pageContext.request.contextPath}/seller/dashboard">
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/seller/products/add"
               class="active">
                Add Product
            </a>

            <a href="${pageContext.request.contextPath}/seller/products">
                My Products
            </a>

            <a href="${pageContext.request.contextPath}/seller/orders">
                Orders
            </a>

            <a href="${pageContext.request.contextPath}/seller/sales">
                Sales
            </a>

            <a href="${pageContext.request.contextPath}/logout"
               class="logout">
                Logout
            </a>

        </nav>

    </aside>

    <!-- MAIN CONTENT -->
    <main class="main">

        <!-- TOP BAR -->
        <div class="topbar">

            <div>
                <h1>Add New Product</h1>
                <p>Add a product to your THOUHA MART store.</p>
            </div>

            <div class="seller-badge">
                Seller Account
            </div>

        </div>

        <!-- PRODUCT FORM -->
        <div class="form-card">

            <h2>Product Information</h2>

            <p class="form-description">
                Enter your product details carefully.
                Customers will see this information on the marketplace.
            </p>

            <!-- ERROR MESSAGE -->
            <c:if test="${not empty error}">
                <div class="error-box">
                    <c:out value="${error}"/>
                </div>
            </c:if>

            <!-- FORM -->
            <form
                action="${pageContext.request.contextPath}/seller/products/add"
                method="post">

                <div class="form-grid">

                    <!-- PRODUCT NAME -->
                    <div class="form-group full">

                        <label for="name">Product Name</label>

                        <input
                            type="text"
                            id="name"
                            name="name"
                            placeholder="Example: Wireless Bluetooth Headphones"
                            maxlength="150"
                            required>

                    </div>

                    <!-- CATEGORY -->
                    <div class="form-group">

                        <label for="categoryId">Category</label>

                        <select
                            id="categoryId"
                            name="categoryId"
                            required>

                            <option value="">Select a category</option>

                            <c:forEach var="category" items="${categories}">

                                <option value="${category.id}">
                                    <c:out value="${category.name}"/>
                                </option>

                            </c:forEach>

                        </select>

                        <c:if test="${empty categories}">
                            <span class="hint">
                                No categories are currently available.
                                Please contact the administrator.
                            </span>
                        </c:if>

                    </div>

                    <!-- PRICE -->
                    <div class="form-group">

                        <label for="price">Price (₹)</label>

                        <input
                            type="number"
                            id="price"
                            name="price"
                            placeholder="Example: 1999.00"
                            min="0.01"
                            step="0.01"
                            required>

                    </div>

                    <!-- STOCK -->
                    <div class="form-group">

                        <label for="stock">Available Stock</label>

                        <input
                            type="number"
                            id="stock"
                            name="stock"
                            placeholder="Example: 50"
                            min="0"
                            step="1"
                            required>

                    </div>

                    <!-- IMAGE URL -->
                    <div class="form-group">

                        <label for="imageUrl">Product Image URL</label>

                        <input
                            type="url"
                            id="imageUrl"
                            name="imageUrl"
                            placeholder="https://example.com/product.jpg"
                            maxlength="1000">

                        <span class="hint">
                            Enter a publicly accessible image URL.
                            File upload is not included in this form.
                        </span>

                    </div>

                    <!-- DESCRIPTION -->
                    <div class="form-group full">

                        <label for="description">
                            Product Description
                        </label>

                        <textarea
                            id="description"
                            name="description"
                            maxlength="5000"
                            placeholder="Describe the product features, size, specifications and other details."></textarea>

                    </div>

                </div>

                <!-- BUTTONS -->
                <div class="actions">

                    <button
                        type="submit"
                        class="btn btn-primary">
                        + Add Product
                    </button>

                    <a
                        href="${pageContext.request.contextPath}/seller/products"
                        class="btn btn-secondary">
                        Cancel
                    </a>

                </div>

            </form>

        </div>

        <!-- SELLER TIP -->
        <div class="info-box">

            <strong>Seller tip:</strong>

            Provide a clear product name, accurate price, available stock
            and useful description. Good product information helps customers
            understand what they are buying.

        </div>

    </main>

</div>

</body>
</html>
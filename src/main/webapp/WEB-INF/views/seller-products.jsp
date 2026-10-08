<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Products - THOUHA MART</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f5f7fb;
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
            border-right: 1px solid #e5e7eb;
            padding: 24px 18px;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
        }

        .brand {
            font-size: 25px;
            font-weight: 800;
            color: #6c3df4;
            margin-bottom: 35px;
            padding-left: 10px;
        }

        .menu-title {
            font-size: 12px;
            color: #9ca3af;
            font-weight: 700;
            margin: 20px 10px 10px;
            text-transform: uppercase;
        }

        .nav-link {
            display: block;
            text-decoration: none;
            color: #4b5563;
            padding: 13px 14px;
            margin-bottom: 6px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
        }

        .nav-link:hover {
            background: #f3efff;
            color: #6c3df4;
        }

        .nav-link.active {
            background: #eee8ff;
            color: #6c3df4;
        }

        .logout {
            position: absolute;
            bottom: 25px;
            left: 18px;
            right: 18px;
            color: #dc2626;
        }

        .logout:hover {
            background: #fef2f2;
            color: #dc2626;
        }

        /* MAIN */

        .main {
            margin-left: 250px;
            width: calc(100% - 250px);
            padding: 30px;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            gap: 15px;
        }

        .page-title h1 {
            font-size: 28px;
            margin-bottom: 6px;
        }

        .page-title p {
            color: #6b7280;
            font-size: 14px;
        }

        .add-btn {
            display: inline-block;
            text-decoration: none;
            background: #6c3df4;
            color: white;
            padding: 12px 20px;
            border-radius: 9px;
            font-size: 14px;
            font-weight: 700;
        }

        .add-btn:hover {
            background: #5730d0;
        }

        /* MESSAGE */

        .success {
            background: #ecfdf5;
            color: #047857;
            border: 1px solid #a7f3d0;
            padding: 13px 16px;
            border-radius: 9px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        /* PRODUCTS */

        .products-card {
            background: #ffffff;
            border-radius: 14px;
            border: 1px solid #e5e7eb;
            overflow: hidden;
        }

        .card-header {
            padding: 20px 22px;
            border-bottom: 1px solid #e5e7eb;
        }

        .card-header h2 {
            font-size: 18px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        th {
            text-align: left;
            background: #f9fafb;
            color: #6b7280;
            font-size: 12px;
            text-transform: uppercase;
            padding: 14px 18px;
            border-bottom: 1px solid #e5e7eb;
        }

        td {
            padding: 16px 18px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
            vertical-align: middle;
        }

        tr:hover td {
            background: #fafafa;
        }

        .product-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .product-image {
            width: 55px;
            height: 55px;
            border-radius: 9px;
            object-fit: cover;
            border: 1px solid #e5e7eb;
            background: #f3f4f6;
        }

        .no-image {
            width: 55px;
            height: 55px;
            border-radius: 9px;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #9ca3af;
            font-size: 11px;
            text-align: center;
        }

        .product-name {
            font-weight: 700;
            color: #111827;
        }

        .product-description {
            color: #9ca3af;
            font-size: 12px;
            margin-top: 4px;
        }

        .price {
            font-weight: 700;
            color: #111827;
        }

        .stock {
            font-weight: 600;
        }

        .stock-low {
            color: #d97706;
        }

        .stock-out {
            color: #dc2626;
        }

        .stock-good {
            color: #059669;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
        }

        .status-active {
            background: #dcfce7;
            color: #15803d;
        }

        .status-inactive {
            background: #fee2e2;
            color: #b91c1c;
        }

        /* EMPTY STATE */

        .empty {
            text-align: center;
            padding: 70px 20px;
        }

        .empty-icon {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .empty h3 {
            font-size: 20px;
            margin-bottom: 8px;
        }

        .empty p {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 20px;
        }

        /* RESPONSIVE */

        @media (max-width: 800px) {

            .sidebar {
                width: 210px;
            }

            .main {
                margin-left: 210px;
                width: calc(100% - 210px);
                padding: 20px;
            }

            .topbar {
                align-items: flex-start;
                flex-direction: column;
            }
        }

        @media (max-width: 600px) {

            .sidebar {
                position: static;
                width: 100%;
                min-height: auto;
            }

            .layout {
                display: block;
            }

            .logout {
                position: static;
                margin-top: 20px;
            }

            .main {
                margin-left: 0;
                width: 100%;
                padding: 18px;
            }

            .brand {
                margin-bottom: 20px;
            }
        }
    </style>
</head>

<body>

<div class="layout">

    <!-- SIDEBAR -->

    <aside class="sidebar">

        <div class="brand">
            THOUHA MART
        </div>

        <div class="menu-title">
            Seller Menu
        </div>

        <a class="nav-link"
           href="${pageContext.request.contextPath}/seller/dashboard">
            Dashboard
        </a>

        <a class="nav-link"
           href="${pageContext.request.contextPath}/seller/products/add">
            Add Product
        </a>

        <a class="nav-link active"
           href="${pageContext.request.contextPath}/seller/products">
            My Products
        </a>

        <a class="nav-link" href="#">
            Orders
        </a>

        <a class="nav-link" href="#">
            Sales
        </a>

        <a class="nav-link logout"
           href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </aside>


    <!-- MAIN CONTENT -->

    <main class="main">

        <div class="topbar">

            <div class="page-title">
                <h1>My Products</h1>
                <p>Manage the products you have added to THOUHA MART.</p>
            </div>

            <a class="add-btn"
               href="${pageContext.request.contextPath}/seller/products/add">
                + Add Product
            </a>

        </div>


        <!-- SUCCESS MESSAGE -->

        <c:if test="${param.added == 'true'}">
            <div class="success">
                Product added successfully.
            </div>
        </c:if>


        <!-- PRODUCTS -->

        <div class="products-card">

            <div class="card-header">
                <h2>Your Products</h2>
            </div>

            <c:choose>

                <c:when test="${not empty products}">

                    <div class="table-wrapper">

                        <table>

                            <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Status</th>
                                <th>Category</th>
                            </tr>
                            </thead>

                            <tbody>

                            <c:forEach var="product"
                                       items="${products}">

                                <tr>

                                    <td>

                                        <div class="product-info">

                                            <c:choose>

                                                <c:when test="${not empty product.imageUrl}">
                                                    <img
                                                            class="product-image"
                                                            src="${product.imageUrl}"
                                                            alt="${product.name}">
                                                </c:when>

                                                <c:otherwise>
                                                    <div class="no-image">
                                                        No Image
                                                    </div>
                                                </c:otherwise>

                                            </c:choose>

                                            <div>

                                                <div class="product-name">
                                                    ${product.name}
                                                </div>

                                                <c:if test="${not empty product.description}">
                                                    <div class="product-description">
                                                        ${product.description}
                                                    </div>
                                                </c:if>

                                            </div>

                                        </div>

                                    </td>


                                    <td>
                                        <span class="price">
                                            ₹${product.price}
                                        </span>
                                    </td>


                                    <td>

                                        <c:choose>

                                            <c:when test="${product.stock == 0}">
                                                <span class="stock stock-out">
                                                    Out of Stock
                                                </span>
                                            </c:when>

                                            <c:when test="${product.stock <= 5}">
                                                <span class="stock stock-low">
                                                    ${product.stock} left
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="stock stock-good">
                                                    ${product.stock}
                                                </span>
                                            </c:otherwise>

                                        </c:choose>

                                    </td>


                                    <td>

                                        <c:choose>

                                            <c:when test="${product.status == 'ACTIVE'}">
                                                <span class="status status-active">
                                                    ACTIVE
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="status status-inactive">
                                                    ${product.status}
                                                </span>
                                            </c:otherwise>

                                        </c:choose>

                                    </td>


                                    <td>
                                        ${product.categoryId}
                                    </td>

                                </tr>

                            </c:forEach>

                            </tbody>

                        </table>

                    </div>

                </c:when>


                <c:otherwise>

                    <div class="empty">

                        <div class="empty-icon">
                            📦
                        </div>

                        <h3>No Products Yet</h3>

                        <p>
                            You haven't added any products yet.
                            Start selling by adding your first product.
                        </p>

                        <a class="add-btn"
                           href="${pageContext.request.contextPath}/seller/products/add">
                            Add Your First Product
                        </a>

                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </main>

</div>

</body>
</html>
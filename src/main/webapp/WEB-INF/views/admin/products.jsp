<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products | THOUHA MART</title>

```
<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: Arial, Helvetica, sans-serif;
        background: #f5f6fa;
        color: #222;
    }

    .layout {
        display: flex;
        min-height: 100vh;
    }

    .sidebar {
        width: 245px;
        background: #172033;
        color: white;
        padding: 28px 18px;
        flex-shrink: 0;
    }

    .brand {
        font-size: 22px;
        font-weight: bold;
        color: #ffbd59;
        margin-bottom: 8px;
    }

    .subtitle {
        color: #aeb8ca;
        font-size: 12px;
        margin-bottom: 35px;
    }

    .nav-title {
        color: #8996ac;
        font-size: 11px;
        font-weight: bold;
        letter-spacing: 1.5px;
        margin: 20px 10px 12px;
    }

    .nav-link {
        display: block;
        text-decoration: none;
        color: #dce3ef;
        padding: 13px 12px;
        margin-bottom: 7px;
        border-radius: 8px;
        font-size: 14px;
    }

    .nav-link:hover,
    .nav-link.active {
        background: #34415b;
        color: #ffbd59;
    }

    .main {
        flex: 1;
        min-width: 0;
        padding: 30px;
    }

    .topbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 15px;
        margin-bottom: 28px;
    }

    .topbar h1 {
        font-size: 27px;
        margin-bottom: 7px;
    }

    .muted {
        color: #788195;
        font-size: 14px;
        line-height: 1.6;
    }

    .admin-badge {
        background: white;
        padding: 12px 16px;
        border-radius: 10px;
        box-shadow: 0 3px 12px #1720330d;
        font-size: 13px;
        font-weight: bold;
        white-space: nowrap;
    }

    .card {
        background: white;
        border-radius: 13px;
        padding: 24px;
        box-shadow: 0 4px 18px #17203308;
    }

    .card-heading {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 15px;
        margin-bottom: 22px;
    }

    .card-heading h2 {
        font-size: 19px;
        margin-bottom: 8px;
    }

    .count {
        color: #657089;
        font-size: 13px;
    }

    .search-box {
        width: 100%;
        max-width: 360px;
        padding: 12px 14px;
        border: 1px solid #dfe3eb;
        border-radius: 8px;
        font-size: 14px;
        outline: none;
    }

    .search-box:focus {
        border-color: #5268e8;
    }

    .table-wrap {
        width: 100%;
        overflow-x: auto;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        min-width: 850px;
    }

    th {
        background: #f7f8fb;
        color: #69748a;
        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: .5px;
        text-align: left;
        padding: 15px 12px;
    }

    td {
        padding: 16px 12px;
        border-bottom: 1px solid #edf0f5;
        font-size: 14px;
        vertical-align: middle;
    }

    tbody tr:hover {
        background: #fafbfe;
    }

    .product-image {
        width: 68px;
        height: 68px;
        object-fit: contain;
        border-radius: 9px;
        background: #f7f8fb;
        padding: 5px;
        display: block;
    }

    .image-placeholder {
        width: 68px;
        height: 68px;
        border-radius: 9px;
        background: #f0f2f7;
        color: #8993a6;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 11px;
        text-align: center;
    }

    .product-name {
        font-weight: bold;
        color: #202a3e;
    }

    .product-id {
        color: #8790a1;
        font-size: 12px;
        margin-top: 5px;
    }

    .price {
        font-weight: bold;
        white-space: nowrap;
    }

    .stock {
        display: inline-block;
        background: #e8f7ef;
        color: #17804a;
        padding: 6px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: bold;
        white-space: nowrap;
    }

    .out-of-stock {
        background: #fff0ee;
        color: #c43d32;
    }

    .status {
        display: inline-block;
        background: #e8f7ef;
        color: #17804a;
        padding: 6px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: bold;
    }

    .empty {
        padding: 45px 15px;
        text-align: center;
        color: #788195;
    }

    .back-link {
        display: inline-block;
        margin-top: 22px;
        color: #5268e8;
        text-decoration: none;
        font-size: 14px;
        font-weight: bold;
    }

    .back-link:hover {
        text-decoration: underline;
    }

    @media (max-width: 760px) {
        .layout {
            display: block;
        }

        .sidebar {
            width: 100%;
            padding: 20px;
        }

        .subtitle {
            margin-bottom: 15px;
        }

        .main {
            padding: 18px;
        }

        .topbar {
            align-items: flex-start;
            flex-direction: column;
        }

        .card {
            padding: 16px;
        }

        .card-heading {
            align-items: flex-start;
            flex-direction: column;
        }

        .search-box {
            max-width: none;
        }
    }
</style>
```

</head>

<body>
<div class="layout">

```
<aside class="sidebar">
    <div class="brand">THOUHA MART</div>
    <div class="subtitle">Marketplace Administration</div>

    <div class="nav-title">MAIN MENU</div>

    <a class="nav-link"
       href="${pageContext.request.contextPath}/admin/dashboard">
        Dashboard
    </a>

    <a class="nav-link active"
       href="${pageContext.request.contextPath}/admin/products">
        Products
    </a>

    <a class="nav-link"
       href="${pageContext.request.contextPath}/admin/users">
        Users
    </a>

    <a class="nav-link"
       href="${pageContext.request.contextPath}/admin/orders">
        Orders
    </a>

    <div class="nav-title">STORE</div>

    <a class="nav-link"
       href="${pageContext.request.contextPath}/products">
        View Store
    </a>

    <a class="nav-link"
       href="${pageContext.request.contextPath}/logout">
        Logout
    </a>
</aside>

<main class="main">

    <header class="topbar">
        <div>
            <h1>Product Management</h1>
            <p class="muted">
                Monitor products available in the THOUHA MART marketplace.
            </p>
        </div>

        <div class="admin-badge">Administrator</div>
    </header>

    <section class="card">

        <div class="card-heading">
            <div>
                <h2>All Products</h2>

                <p class="count">
                    Total products:
                    ${empty products ? 0 : products.size()}
                </p>
            </div>

            <input
                type="search"
                id="productSearch"
                class="search-box"
                placeholder="Search by product name or ID..."
                aria-label="Search products">
        </div>

        <div class="table-wrap">
            <table id="productsTable">

                <thead>
                <tr>
                    <th>Image</th>
                    <th>Product</th>
                    <th>Seller ID</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Status</th>
                </tr>
                </thead>

                <tbody>

                <c:forEach var="product" items="${products}">
                    <tr>

                        <td>
                            <c:choose>
                                <c:when test="${not empty product.image}">
                                    <img
                                        class="product-image"
                                        src="${pageContext.request.contextPath}/images/${product.image}"
                                        alt="${product.name}"
                                        onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">

                                    <div class="image-placeholder"
                                         style="display:none;">
                                        Image unavailable
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <div class="image-placeholder">
                                        No image
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <div class="product-name">
                                <c:out value="${product.name}"/>
                            </div>

                            <div class="product-id">
                                Product #<c:out value="${product.id}"/>
                            </div>
                        </td>

                        <td>
                            <c:out value="${product.sellerId}"/>
                        </td>

                        <td class="price">
                            ₹<fmt:formatNumber
                                value="${product.price}"
                                minFractionDigits="2"
                                maxFractionDigits="2"/>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${product.stock gt 0}">
                                    <span class="stock">
                                        <c:out value="${product.stock}"/> units
                                    </span>
                                </c:when>

                                <c:otherwise>
                                    <span class="stock out-of-stock">
                                        Out of stock
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <span class="status">Available</span>
                        </td>

                    </tr>
                </c:forEach>

                <c:if test="${empty products}">
                    <tr>
                        <td colspan="6" class="empty">
                            No active products found in the marketplace.
                        </td>
                    </tr>
                </c:if>

                </tbody>
            </table>
        </div>
    </section>

    <a class="back-link"
       href="${pageContext.request.contextPath}/admin/dashboard">
        ← Back to Admin Dashboard
    </a>

</main>
```

</div>

<script>
    const searchInput = document.getElementById("productSearch");
    const productRows = document.querySelectorAll("#productsTable tbody tr");

    searchInput.addEventListener("input", function () {
        const keyword = this.value.toLowerCase().trim();

        productRows.forEach(function (row) {
            row.style.display =
                row.textContent.toLowerCase().includes(keyword) ? "" : "none";
        });
    });
</script>

</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | THOUHA MART</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f6fb;
            color: #20263a;
        }

        .layout {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 245px;
            background: #172554;
            color: white;
            padding: 28px 18px;
            flex-shrink: 0;
        }

        .brand {
            font-size: 23px;
            font-weight: 800;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #bfdbfe;
            font-size: 12px;
            margin-bottom: 35px;
        }

        .nav-title {
            color: #93a4c8;
            font-size: 11px;
            text-transform: uppercase;
            margin: 25px 10px 12px;
            letter-spacing: 1.3px;
        }

        .sidebar a {
            display: block;
            padding: 13px 12px;
            margin: 5px 0;
            text-decoration: none;
            color: #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background: #2563eb;
            color: white;
        }

        .main {
            flex: 1;
            min-width: 0;
        }

        .topbar {
            background: white;
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            border-bottom: 1px solid #e8ebf2;
        }

        .topbar h2 {
            font-size: 21px;
        }

        .admin-badge {
            background: #dbeafe;
            color: #1d4ed8;
            border-radius: 25px;
            padding: 10px 15px;
            font-size: 13px;
            font-weight: bold;
        }

        .content {
            padding: 30px;
        }

        .welcome {
            margin-bottom: 25px;
        }

        .welcome h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .welcome p {
            color: #718096;
            font-size: 14px;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 18px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            border-radius: 13px;
            padding: 23px;
            border: 1px solid #e8ebf2;
            box-shadow: 0 4px 15px rgba(20, 35, 70, 0.04);
        }

        .card-label {
            color: #718096;
            font-size: 13px;
            margin-bottom: 14px;
        }

        .card-value {
            font-size: 28px;
            font-weight: 800;
            color: #172554;
        }

        .card-note {
            margin-top: 10px;
            font-size: 12px;
            color: #64748b;
        }

        .section {
            background: white;
            border-radius: 13px;
            padding: 24px;
            border: 1px solid #e8ebf2;
            margin-bottom: 24px;
        }

        .section h3 {
            margin-bottom: 8px;
            font-size: 18px;
        }

        .section p {
            color: #718096;
            font-size: 13px;
            line-height: 1.7;
        }

        .actions {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .action {
            display: block;
            padding: 18px;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            text-decoration: none;
            color: #1e293b;
            transition: 0.2s;
        }

        .action:hover {
            border-color: #2563eb;
            background: #eff6ff;
        }

        .action strong {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .action span {
            color: #718096;
            font-size: 12px;
            line-height: 1.5;
        }

        .notice {
            background: #eff6ff;
            color: #1e40af;
            padding: 14px 16px;
            border-radius: 9px;
            font-size: 13px;
            margin-top: 20px;
        }

        @media (max-width: 1000px) {
            .cards {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .actions {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 650px) {
            .layout {
                display: block;
            }

            .sidebar {
                width: 100%;
            }

            .topbar {
                padding: 18px;
                align-items: flex-start;
                flex-direction: column;
            }

            .content {
                padding: 18px;
            }

            .cards,
            .actions {
                grid-template-columns: 1fr;
            }

            .welcome h1 {
                font-size: 23px;
            }
        }
    </style>
</head>

<body>
<div class="layout">

    <aside class="sidebar">
        <div class="brand">THOUHA MART</div>
        <div class="subtitle">Administration Panel</div>

        <div class="nav-title">Main Menu</div>

        <a class="active"
           href="${pageContext.request.contextPath}/admin/dashboard">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/products">
            View Store
        </a>
<div class="nav-title">Management</div>

<a href="${pageContext.request.contextPath}/admin/products">
    Product Management
</a>

<a href="${pageContext.request.contextPath}/admin/users">
    User Management
</a>

<a href="${pageContext.request.contextPath}/admin/orders">
    Order Management
</a>

        <div class="nav-title">Account</div>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>
    </aside>

    <main class="main">

        <header class="topbar">
            <h2>Admin Dashboard</h2>

            <div class="admin-badge">
                Administrator
                <c:if test="${not empty adminName}">
                    · <c:out value="${adminName}"/>
                </c:if>
            </div>
        </header>

        <div class="content">

            <section class="welcome">
                <h1>Welcome back, Admin! 👋</h1>
                <p>Manage your THOUHA MART marketplace from one place.</p>
            </section>

            <section class="cards">

                <div class="card">
                    <div class="card-label">Marketplace</div>
                    <div class="card-value">Products</div>
                    <div class="card-note">Manage marketplace products</div>
                </div>

                <div class="card">
                    <div class="card-label">Customers & Sellers</div>
                    <div class="card-value">Users</div>
                    <div class="card-note">Manage registered accounts</div>
                </div>

                <div class="card">
                    <div class="card-label">Transactions</div>
                    <div class="card-value">Orders</div>
                    <div class="card-note">Monitor customer orders</div>
                </div>

                <div class="card">
                    <div class="card-label">Platform</div>
                    <div class="card-value">Active</div>
                    <div class="card-note">THOUHA MART administration</div>
                </div>

            </section>

            <section class="section">
                <h3>Quick Management</h3>
                <p>Choose a section to continue managing the marketplace.</p>

                <div class="actions">

                    <a class="action" id="products"
                       href="${pageContext.request.contextPath}/products">
                        <strong>🛍️ Product Management</strong>
                        <span>View products currently available in the store.</span>
                    </a>

                    <a class="action" id="users" href="#users">
                        <strong>👥 User Management</strong>
                        <span>Admin user-management module will be connected next.</span>
                    </a>

                    <a class="action" id="orders" href="#orders">
                        <strong>📦 Order Management</strong>
                        <span>Admin order-management module will be connected next.</span>
                    </a>

                </div>

                <div class="notice">
                    Dashboard connected. Product, user and order statistics
                    will be displayed after connecting their database services.
                </div>
            </section>

        </div>
    </main>
</div>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management | THOUHA MART</title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6fb;
            color: #20243a;
        }

        .layout {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 245px;
            background: #171b35;
            color: white;
            padding: 28px 18px;
            flex-shrink: 0;
        }

        .brand {
            font-size: 22px;
            font-weight: bold;
            margin: 0 0 38px;
        }

        .brand span { color: #a99bff; }

        .nav-label {
            color: #a8acc7;
            font-size: 11px;
            letter-spacing: 1.5px;
            margin: 25px 12px 12px;
        }

        .sidebar a {
            display: block;
            text-decoration: none;
            color: #d8daeb;
            padding: 13px 12px;
            border-radius: 9px;
            margin-bottom: 6px;
            font-size: 14px;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background: #6254d9;
            color: white;
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
            flex-wrap: wrap;
            margin-bottom: 28px;
        }

        .topbar h1 {
            margin: 0 0 8px;
            font-size: 27px;
        }

        .muted { color: #777e96; font-size: 14px; }

        .admin-badge {
            background: white;
            padding: 12px 16px;
            border-radius: 12px;
            box-shadow: 0 4px 18px #1720440a;
            font-size: 14px;
        }

        .summary {
            display: flex;
            align-items: center;
            gap: 16px;
            background: white;
            padding: 22px;
            border-radius: 15px;
            margin-bottom: 24px;
            box-shadow: 0 5px 22px #1720440a;
        }

        .summary-icon {
            width: 52px;
            height: 52px;
            display: grid;
            place-items: center;
            border-radius: 13px;
            background: #eeeaff;
            font-size: 25px;
        }

        .summary h2 { margin: 0 0 5px; font-size: 25px; }
        .summary p { margin: 0; color: #777e96; font-size: 13px; }

        .panel {
            background: white;
            border-radius: 15px;
            padding: 22px;
            box-shadow: 0 5px 22px #1720440a;
        }

        .panel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .panel-header h2 { margin: 0; font-size: 19px; }

        .table-wrap { overflow-x: auto; }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        th {
            text-align: left;
            padding: 14px 12px;
            background: #f7f8fc;
            color: #747b92;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: .5px;
        }

        td {
            padding: 16px 12px;
            border-bottom: 1px solid #eef0f6;
            font-size: 13px;
            vertical-align: top;
        }

        tbody tr:hover { background: #fafaff; }

        .order-id { font-weight: bold; color: #5546c7; }

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            background: #e7f8ee;
            color: #18834b;
            font-size: 11px;
            font-weight: bold;
        }

        .address {
            max-width: 220px;
            overflow-wrap: anywhere;
            line-height: 1.5;
        }

        .empty {
            text-align: center;
            padding: 45px 15px;
            color: #777e96;
        }

        .back-link {
            color: #5a4bd5;
            text-decoration: none;
            font-size: 13px;
        }

        @media (max-width: 760px) {
            .layout { display: block; }
            .sidebar { width: 100%; padding: 18px; }
            .brand { margin-bottom: 18px; }
            .nav-label { margin-top: 15px; }
            .main { padding: 18px; }
            .topbar h1 { font-size: 23px; }
        }
    </style>
</head>

<body>
<div class="layout">

    <aside class="sidebar">
        <div class="brand">THOUHA <span>MART</span></div>

        <div class="nav-label">MAIN MENU</div>

        <a href="${pageContext.request.contextPath}/admin/dashboard">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/admin/products">
            Product Management
        </a>

        <a href="${pageContext.request.contextPath}/admin/users">
            User Management
        </a>

        <a class="active"
           href="${pageContext.request.contextPath}/admin/orders">
            Order Management
        </a>

        <div class="nav-label">STORE</div>

        <a href="${pageContext.request.contextPath}/products">
            View Store
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>
    </aside>

    <main class="main">

        <header class="topbar">
            <div>
                <h1>Order Management</h1>
                <div class="muted">
                    Monitor customer orders across THOUHA MART.
                </div>
            </div>

            <div class="admin-badge">
                👤 <c:out value="${adminName}" default="Administrator"/>
            </div>
        </header>

        <section class="summary">
            <div class="summary-icon">📦</div>
            <div>
                <h2><c:out value="${orders.size()}" default="0"/></h2>
                <p>Total orders recorded</p>
            </div>
        </section>

        <section class="panel">
            <div class="panel-header">
                <h2>All Customer Orders</h2>
                <a class="back-link"
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    ← Back to Dashboard
                </a>
            </div>

            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Buyer ID</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Payment</th>
                        <th>Shipping Address</th>
                        <th>Order Date</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td class="order-id">
                                #<c:out value="${order.id}"/>
                            </td>

                            <td>
                                <c:out value="${order.buyerId}"/>
                            </td>

                            <td>
                                ₹<fmt:formatNumber
                                    value="${order.totalAmount}"
                                    minFractionDigits="2"
                                    maxFractionDigits="2"/>
                            </td>

                            <td>
                                <span class="status">
                                    <c:out value="${order.status}"/>
                                </span>
                            </td>

                            <td>
                                <c:out value="${order.paymentMethod}"
                                       default="Not specified"/>
                            </td>

                            <td class="address">
                                <c:out value="${order.shippingAddress}"
                                       default="No address"/>
                            </td>

                            <td>
                                <c:if test="${not empty order.createdAt}">
                                    <fmt:formatDate
                                        value="${order.createdAt}"
                                        pattern="dd MMM yyyy, hh:mm a"/>
                                </c:if>
                                <c:if test="${empty order.createdAt}">
                                    —
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="7" class="empty">
                                <div style="font-size:35px; margin-bottom:10px;">
                                    📭
                                </div>
                                <strong>No orders yet</strong>
                                <p>Customer orders will appear here after checkout.</p>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </section>

    </main>
</div>
</body>
</html>
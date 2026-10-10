<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>User Management | THOUHA MART</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f6fb;
            color: #1e293b;
        }

        .topbar {
            background: #172554;
            color: white;
            padding: 22px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .brand {
            font-size: 23px;
            font-weight: 800;
        }

        .topbar a {
            color: white;
            text-decoration: none;
            font-size: 14px;
        }

        .container {
            max-width: 1200px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
        }

        .heading h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .heading p {
            color: #64748b;
            font-size: 14px;
        }

        .back-btn {
            display: inline-block;
            background: #2563eb;
            color: white;
            text-decoration: none;
            padding: 12px 17px;
            border-radius: 8px;
            font-size: 13px;
        }

        .summary {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 22px;
            margin-bottom: 25px;
        }

        .summary-label {
            color: #64748b;
            font-size: 13px;
            margin-bottom: 10px;
        }

        .summary-number {
            font-size: 30px;
            font-weight: 800;
            color: #172554;
        }

        .table-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
        }

        .table-heading {
            padding: 22px;
            border-bottom: 1px solid #e2e8f0;
        }

        .table-heading h2 {
            font-size: 18px;
            margin-bottom: 7px;
        }

        .table-heading p {
            font-size: 13px;
            color: #64748b;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 650px;
        }

        th, td {
            padding: 17px 20px;
            text-align: left;
            border-bottom: 1px solid #edf0f5;
            font-size: 13px;
        }

        th {
            background: #f8fafc;
            color: #64748b;
            text-transform: uppercase;
            font-size: 11px;
            letter-spacing: 0.5px;
        }

        td {
            color: #334155;
        }

        .user-name {
            font-weight: 700;
            color: #172554;
        }

        .role {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
        }

        .role-admin {
            background: #ede9fe;
            color: #6d28d9;
        }

        .role-seller {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .role-buyer {
            background: #dcfce7;
            color: #166534;
        }

        .empty {
            text-align: center;
            padding: 45px 20px;
            color: #64748b;
        }

        .empty strong {
            display: block;
            margin-bottom: 8px;
            color: #334155;
            font-size: 16px;
        }

        .footer {
            text-align: center;
            color: #94a3b8;
            font-size: 12px;
            padding: 25px 10px;
        }

        @media (max-width: 600px) {
            .topbar {
                padding: 18px 20px;
                align-items: flex-start;
                flex-direction: column;
            }

            .heading h1 {
                font-size: 23px;
            }
        }
    </style>
</head>

<body>

<header class="topbar">
    <div class="brand">THOUHA MART</div>

    <a href="${pageContext.request.contextPath}/admin/dashboard">
        ← Admin Dashboard
    </a>
</header>

<main class="container">

    <section class="heading">
        <div>
            <h1>User Management</h1>
            <p>View registered buyers, sellers and administrators.</p>
        </div>

        <a class="back-btn"
           href="${pageContext.request.contextPath}/admin/dashboard">
            Back to Dashboard
        </a>
    </section>

    <section class="summary">
        <div class="summary-label">Total Registered Users</div>

        <div class="summary-number">
            <c:out value="${users.size()}"/>
        </div>
    </section>

    <section class="table-card">

        <div class="table-heading">
            <h2>Registered Users</h2>
            <p>User information retrieved from the THOUHA MART database.</p>
        </div>

        <c:choose>
            <c:when test="${not empty users}">

                <div class="table-wrapper">
                    <table>
                        <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Name</th>
                            <th>Email Address</th>
                            <th>Role</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>
                                    #<c:out value="${user.id}"/>
                                </td>

                                <td class="user-name">
                                    <c:out value="${user.name}"/>
                                </td>

                                <td>
                                    <c:out value="${user.email}"/>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${user.role == 'ADMIN'}">
                                            <span class="role role-admin">ADMIN</span>
                                        </c:when>

                                        <c:when test="${user.role == 'SELLER'}">
                                            <span class="role role-seller">SELLER</span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="role role-buyer">
                                                <c:out value="${user.role}"/>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

            </c:when>

            <c:otherwise>
                <div class="empty">
                    <strong>No users found</strong>
                    Registered users will appear here.
                </div>
            </c:otherwise>
        </c:choose>

    </section>

</main>

<footer class="footer">
    THOUHA MART Admin Panel
</footer>

</body>
</html>
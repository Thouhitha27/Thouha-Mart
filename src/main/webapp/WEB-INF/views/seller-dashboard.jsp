<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

```
<title>Seller Dashboard | THOUHA MART</title>

<style>

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: Arial, Helvetica, sans-serif;
        background: #f6f6f8;
        color: #222;
    }

    /* SIDEBAR */

    .sidebar {
        position: fixed;
        left: 0;
        top: 0;

        width: 245px;
        height: 100vh;

        background: #ffffff;
        border-right: 1px solid #eeeeee;

        padding: 25px 15px;
    }

    .brand {
        font-size: 23px;
        font-weight: 800;

        color: #7b2cbf;

        padding: 0 15px 30px;
    }

    .seller-label {
        padding: 0 15px 20px;

        color: #888;

        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .menu a {
        display: block;

        text-decoration: none;
        color: #444;

        padding: 13px 15px;
        margin-bottom: 5px;

        border-radius: 8px;

        font-size: 14px;
        font-weight: 600;

        transition: 0.2s;
    }

    .menu a:hover,
    .menu .active {
        background: #f1e8f8;
        color: #7b2cbf;
    }

    .logout {
        position: absolute;

        bottom: 25px;
        left: 15px;
        right: 15px;
    }

    .logout a {
        display: block;

        text-align: center;

        padding: 11px;

        border: 1px solid #dddddd;
        border-radius: 8px;

        color: #555;

        text-decoration: none;

        font-size: 14px;

        transition: 0.2s;
    }

    .logout a:hover {
        background: #f7f7f7;
        color: #7b2cbf;
    }

    /* MAIN */

    .main {
        margin-left: 245px;
        min-height: 100vh;
    }

    /* TOP BAR */

    .topbar {
        background: #ffffff;

        height: 75px;

        border-bottom: 1px solid #eeeeee;

        display: flex;
        align-items: center;
        justify-content: space-between;

        padding: 0 35px;
    }

    .topbar h2 {
        font-size: 20px;
    }

    .seller-profile {
        display: flex;
        align-items: center;

        gap: 12px;
    }

    .avatar {
        width: 40px;
        height: 40px;

        background: #7b2cbf;
        color: white;

        border-radius: 50%;

        display: flex;
        align-items: center;
        justify-content: center;

        font-weight: 700;
    }

    .seller-profile span {
        font-size: 14px;
        font-weight: 600;
    }

    /* CONTENT */

    .content {
        padding: 35px;
    }

    .welcome {
        margin-bottom: 30px;
    }

    .welcome h1 {
        font-size: 28px;
        margin-bottom: 8px;
    }

    .welcome p {
        color: #777;
    }

    /* STATISTICS */

    .stats {
        display: grid;

        grid-template-columns: repeat(4, 1fr);

        gap: 20px;

        margin-bottom: 30px;
    }

    .stat-card {
        background: white;

        border: 1px solid #eeeeee;
        border-radius: 12px;

        padding: 22px;
    }

    .stat-title {
        color: #888;

        font-size: 13px;

        margin-bottom: 12px;
    }

    .stat-value {
        font-size: 27px;
        font-weight: 800;
    }

    /* QUICK ACTIONS */

    .section-title {
        font-size: 19px;

        margin-bottom: 18px;
    }

    .actions {
        display: grid;

        grid-template-columns: repeat(3, 1fr);

        gap: 20px;

        margin-bottom: 35px;
    }

    .action-card {
        background: white;

        border: 1px solid #eeeeee;
        border-radius: 12px;

        padding: 25px;

        text-decoration: none;
        color: #222;

        transition: 0.2s;
    }

    .action-card:hover {
        transform: translateY(-3px);

        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.07);
    }

    .action-icon {
        width: 45px;
        height: 45px;

        border-radius: 10px;

        background: #f1e8f8;
        color: #7b2cbf;

        display: flex;
        align-items: center;
        justify-content: center;

        font-size: 20px;

        margin-bottom: 15px;
    }

    .action-card h3 {
        font-size: 16px;

        margin-bottom: 7px;
    }

    .action-card p {
        color: #888;

        font-size: 13px;
    }

    /* RECENT ORDERS */

    .orders-box {
        background: white;

        border: 1px solid #eeeeee;
        border-radius: 12px;

        overflow: hidden;
    }

    .orders-header {
        padding: 20px;

        border-bottom: 1px solid #eeeeee;

        font-weight: 700;
    }

    .empty-orders {
        padding: 45px 20px;

        text-align: center;

        color: #888;

        line-height: 1.6;
    }

    /* RESPONSIVE */

    @media (max-width: 1000px) {

        .stats {
            grid-template-columns: repeat(2, 1fr);
        }

        .actions {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 700px) {

        .sidebar {
            position: relative;

            width: 100%;
            height: auto;
        }

        .logout {
            position: static;

            margin-top: 15px;
        }

        .main {
            margin-left: 0;
        }

        .topbar {
            padding: 0 20px;
        }

        .content {
            padding: 20px;
        }

        .stats,
        .actions {
            grid-template-columns: 1fr;
        }
    }

</style>
```

</head>

<body>

```
<!-- SIDEBAR -->

<aside class="sidebar">

    <div class="brand">
        THOUHA MART
    </div>

    <div class="seller-label">
        Seller Panel
    </div>

    <nav class="menu">

        <a href="${pageContext.request.contextPath}/seller/dashboard"
           class="active">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/seller/products/add">
            Add Product
        </a>

        <a href="${pageContext.request.contextPath}/seller/products">
            My Products
        </a>

        <a href="#">
            Orders
        </a>

        <a href="#">
            Sales
        </a>

    </nav>

    <div class="logout">

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</aside>


<!-- MAIN -->

<main class="main">

    <!-- TOP BAR -->

    <header class="topbar">

        <h2>
            Seller Dashboard
        </h2>

        <div class="seller-profile">

            <div class="avatar">
                S
            </div>

            <span>
                Seller Account
            </span>

        </div>

    </header>


    <!-- CONTENT -->

    <section class="content">

        <!-- WELCOME -->

        <div class="welcome">

            <h1>
                Welcome back, Seller! 👋
            </h1>

            <p>
                Manage your products, orders and sales from one place.
            </p>

        </div>


        <!-- STATISTICS -->

        <div class="stats">

            <div class="stat-card">

                <div class="stat-title">
                    My Products
                </div>

                <div class="stat-value">
                    0
                </div>

            </div>


            <div class="stat-card">

                <div class="stat-title">
                    Orders
                </div>

                <div class="stat-value">
                    0
                </div>

            </div>


            <div class="stat-card">

                <div class="stat-title">
                    Total Sales
                </div>

                <div class="stat-value">
                    ₹0
                </div>

            </div>


            <div class="stat-card">

                <div class="stat-title">
                    Pending Orders
                </div>

                <div class="stat-value">
                    0
                </div>

            </div>

        </div>


        <!-- QUICK ACTIONS -->

        <h2 class="section-title">
            Quick Actions
        </h2>


        <div class="actions">

            <!-- ADD PRODUCT -->

            <a href="${pageContext.request.contextPath}/seller/products/add"
               class="action-card">

                <div class="action-icon">
                    +
                </div>

                <h3>
                    Add New Product
                </h3>

                <p>
                    List a new product for buyers.
                </p>

            </a>


            <!-- VIEW PRODUCTS -->

            <a href="${pageContext.request.contextPath}/seller/products"
               class="action-card">

                <div class="action-icon">
                    ◈
                </div>

                <h3>
                    View Products
                </h3>

                <p>
                    View your products on THOUHA MART.
                </p>

            </a>


            <!-- VIEW SALES -->

            <a href="#"
               class="action-card">

                <div class="action-icon">
                    ₹
                </div>

                <h3>
                    View Sales
                </h3>

                <p>
                    Track your sales and earnings.
                </p>

            </a>

        </div>


        <!-- RECENT ORDERS -->

        <h2 class="section-title">
            Recent Orders
        </h2>


        <div class="orders-box">

            <div class="orders-header">
                Latest Orders
            </div>

            <div class="empty-orders">

                No orders yet.

                <br>

                Orders will appear here when customers purchase your products.

            </div>

        </div>

    </section>

</main>
```

</body>

</html>

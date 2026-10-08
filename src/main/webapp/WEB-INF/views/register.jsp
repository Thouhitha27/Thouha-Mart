```jsp
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Register - THOUHA MART</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #fff4f8, #f5f0ff);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
        }

        .register-container {
            width: 950px;
            max-width: 95%;
            min-height: 600px;
            background: #ffffff;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 15px 45px rgba(0, 0, 0, 0.12);
            display: flex;
        }

        .brand-section {
            width: 45%;
            padding: 55px 45px;
            background: linear-gradient(145deg, #ff3f8e, #8b4dff);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .brand-icon {
            font-size: 60px;
            margin-bottom: 20px;
        }

        .brand-section h1 {
            font-size: 40px;
            margin-bottom: 18px;
        }

        .brand-section p {
            font-size: 17px;
            line-height: 1.7;
            opacity: 0.95;
        }

        .brand-points {
            margin-top: 30px;
            line-height: 2;
            font-size: 15px;
        }

        .form-section {
            width: 55%;
            padding: 45px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-section h2 {
            font-size: 30px;
            color: #222;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #777;
            margin-bottom: 25px;
        }

        .input-group {
            margin-bottom: 16px;
        }

        .input-group label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: #333;
        }

        .input-group input,
        .input-group select {
            width: 100%;
            padding: 13px 15px;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
            background: white;
        }

        .input-group input:focus,
        .input-group select:focus {
            border-color: #ff3f8e;
            box-shadow: 0 0 0 3px rgba(255, 63, 142, 0.1);
        }

        .register-btn {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(90deg, #ff3f8e, #8b4dff);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 5px;
        }

        .register-btn:hover {
            opacity: 0.9;
        }

        .login-text {
            text-align: center;
            margin-top: 20px;
            color: #777;
        }

        .login-text a {
            color: #ff3f8e;
            font-weight: bold;
            text-decoration: none;
        }

        .error-message {
            background: #fff0f0;
            color: #d63031;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14px;
        }

        @media (max-width: 700px) {
            .register-container {
                flex-direction: column;
            }

            .brand-section,
            .form-section {
                width: 100%;
            }

            .brand-section {
                padding: 35px;
            }

            .form-section {
                padding: 35px;
            }
        }
    </style>
</head>

<body>

<div class="register-container">

    <div class="brand-section">

        <div class="brand-icon">&#128717;</div>

        <h1>THOUHA MART</h1>

        <p>
            Join our marketplace and discover amazing
            products from trusted sellers.
        </p>

        <div class="brand-points">
            ✓ Shop from multiple sellers<br>
            ✓ Secure account<br>
            ✓ Easy order management<br>
            ✓ Seller marketplace
        </div>

    </div>


    <div class="form-section">

        <h2>Create Account</h2>

        <p class="subtitle">
            Register to start using THOUHA MART
        </p>


        <% if ("true".equals(request.getParameter("error"))) { %>

            <div class="error-message">
                Registration failed. Email may already exist or the details are invalid.
            </div>

        <% } %>


        <form action="${pageContext.request.contextPath}/auth" method="post">

            <input type="hidden" name="action" value="register">


            <div class="input-group">

                <label for="name">Full Name</label>

                <input
                    type="text"
                    id="name"
                    name="name"
                    placeholder="Enter your full name"
                    required>

            </div>


            <div class="input-group">

                <label for="email">Email</label>

                <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="Enter your email"
                    required>

            </div>


            <div class="input-group">

                <label for="password">Password</label>

                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Minimum 6 characters"
                    minlength="6"
                    required>

            </div>


            <div class="input-group">

                <label for="role">Account Type</label>

                <select id="role" name="role" required>

                    <option value="">Select account type</option>

                    <option value="BUYER">
                        Buyer
                    </option>

                    <option value="SELLER">
                        Seller
                    </option>

                </select>

            </div>


            <button type="submit" class="register-btn">
                CREATE ACCOUNT
            </button>

        </form>


        <p class="login-text">

            Already have an account?

            <a href="${pageContext.request.contextPath}/login">
                Login
            </a>

        </p>

    </div>

</div>

</body>
</html>
```

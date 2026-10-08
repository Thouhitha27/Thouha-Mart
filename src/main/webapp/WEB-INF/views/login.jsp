<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - THOUHA MART</title>

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
        }

        .login-container {
            width: 900px;
            max-width: 92%;
            min-height: 520px;
            background: white;
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

        .brand-section h1 {
            font-size: 42px;
            margin-bottom: 18px;
        }

        .brand-section p {
            font-size: 17px;
            line-height: 1.7;
            opacity: 0.95;
        }

        .brand-icon {
            font-size: 65px;
            margin-bottom: 20px;
        }

        .form-section {
            width: 55%;
            padding: 55px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-section h2 {
            font-size: 32px;
            color: #222;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #777;
            margin-bottom: 30px;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        .input-group input {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
        }

        .input-group input:focus {
            border-color: #ff3f8e;
            box-shadow: 0 0 0 3px rgba(255, 63, 142, 0.1);
        }

        .login-btn {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(90deg, #ff3f8e, #8b4dff);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 8px;
        }

        .login-btn:hover {
            opacity: 0.9;
        }

        .register-text {
            text-align: center;
            margin-top: 25px;
            color: #777;
        }

        .register-text a {
            color: #ff3f8e;
            font-weight: bold;
            text-decoration: none;
        }

        @media (max-width: 700px) {
            .login-container {
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

<div class="login-container">

    <div class="brand-section">
        <div class="brand-icon">&#128717;</div>
        <h1>THOUHA MART</h1>
        <p>
            Discover amazing products from trusted sellers.
            Shop smarter, faster and easier.
        </p>
    </div>

    <div class="form-section">

        <h2>Welcome Back!</h2>
        <p class="subtitle">Login to continue shopping</p>

        <form action="${pageContext.request.contextPath}/auth" method="post">

            <input type="hidden" name="action" value="login">

            <div class="input-group">
                <label>Email</label>
                <input
                    type="email"
                    name="email"
                    placeholder="Enter your email"
                    required>
            </div>

            <div class="input-group">
                <label>Password</label>
                <input
                    type="password"
                    name="password"
                    placeholder="Enter your password"
                    required>
            </div>

            <button type="submit" class="login-btn">
                LOGIN
            </button>

        </form>

        <p class="register-text">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register">
                Register
            </a>
        </p>

    </div>

</div>

</body>
</html>

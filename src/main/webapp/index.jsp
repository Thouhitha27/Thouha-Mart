<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | THOUHA MART</title>

```
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }

    body {
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(135deg, #f5f3ff, #e0e7ff);
        padding: 20px;
    }

    .container {
        width: 100%;
        max-width: 420px;
        background: white;
        padding: 40px 35px;
        border-radius: 18px;
        box-shadow: 0 15px 45px rgba(40, 30, 100, 0.12);
    }

    .logo {
        text-align: center;
        font-size: 29px;
        font-weight: bold;
        color: #5b21b6;
        margin-bottom: 10px;
    }

    .subtitle {
        text-align: center;
        color: #777;
        font-size: 14px;
        margin-bottom: 30px;
    }

    h2 {
        color: #222;
        font-size: 24px;
        margin-bottom: 8px;
    }

    .description {
        color: #777;
        font-size: 14px;
        margin-bottom: 25px;
    }

    label {
        display: block;
        font-size: 14px;
        font-weight: bold;
        color: #333;
        margin-bottom: 8px;
    }

    input {
        width: 100%;
        padding: 13px;
        border: 1px solid #ddd;
        border-radius: 8px;
        outline: none;
        margin-bottom: 20px;
        font-size: 14px;
    }

    input:focus {
        border-color: #6d28d9;
        box-shadow: 0 0 0 3px rgba(109, 40, 217, 0.1);
    }

    button {
        width: 100%;
        padding: 14px;
        border: none;
        border-radius: 8px;
        background: #6d28d9;
        color: white;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: 0.3s;
    }

    button:hover {
        background: #4c1d95;
    }

    .register {
        text-align: center;
        margin-top: 24px;
        font-size: 14px;
        color: #666;
    }

    .register a {
        color: #6d28d9;
        text-decoration: none;
        font-weight: bold;
    }

    .register a:hover {
        text-decoration: underline;
    }

    .footer {
        text-align: center;
        margin-top: 25px;
        color: #999;
        font-size: 12px;
    }

    @media (max-width: 480px) {
        .container {
            padding: 30px 22px;
        }
    }
</style>
```

</head>

<body>

```
<div class="container">

    <div class="logo">THOUHA MART</div>
    <p class="subtitle">Your trusted online marketplace</p>

    <h2>Welcome Back!</h2>
    <p class="description">Sign in to continue shopping with us.</p>

    <form action="login" method="post">

        <label for="email">Email Address</label>
        <input
            type="email"
            id="email"
            name="email"
            placeholder="Enter your email address"
            required>

        <label for="password">Password</label>
        <input
            type="password"
            id="password"
            name="password"
            placeholder="Enter your password"
            required>

        <button type="submit">Sign In</button>

    </form>

    <div class="register">
        Don't have an account?
        <a href="register">Create Account</a>
    </div>

    <div class="footer">
        &copy; 2026 THOUHA MART. All rights reserved.
    </div>

</div>
```

</body>
</html>

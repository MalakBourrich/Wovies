<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Wovies - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
            color: #e5e5e5;
            min-height: 100vh;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(229, 9, 20, 0.1) 0%, transparent 70%);
            animation: pulse 15s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .login-container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 450px;
            padding: 2rem;
        }

        .logo-section {
            text-align: center;
            margin-bottom: 3rem;
        }

        .logo {
            font-size: 3.5rem;
            font-weight: 900;
            background: linear-gradient(135deg, #e50914 0%, #ff2a2a 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: 2px;
            text-shadow: 0 0 30px rgba(229, 9, 20, 0.3);
            margin-bottom: 0.5rem;
        }

        .logo-tagline {
            color: #888;
            font-size: 0.9rem;
            letter-spacing: 3px;
            text-transform: uppercase;
        }

        .login-card {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.9) 0%, rgba(20, 20, 20, 0.95) 100%);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 3rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.6);
        }

        .login-title {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-align: center;
        }

        .login-subtitle {
            color: #888;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-size: 0.9rem;
            font-weight: 600;
            color: #b3b3b3;
            margin-bottom: 0.5rem;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 1.1rem;
        }

        .form-control-custom {
            width: 100%;
            padding: 0.875rem 1rem 0.875rem 3rem;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: #fff;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control-custom:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.08);
            border-color: #e50914;
            box-shadow: 0 0 0 3px rgba(229, 9, 20, 0.1);
        }

        .form-control-custom::placeholder {
            color: #666;
        }

        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #666;
            cursor: pointer;
            font-size: 1.1rem;
            transition: color 0.3s ease;
        }

        .password-toggle:hover {
            color: #e50914;
        }

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            font-size: 0.85rem;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .remember-me input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #e50914;
        }

        .remember-me label {
            color: #b3b3b3;
            cursor: pointer;
        }

        .forgot-link {
            color: #e50914;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .forgot-link:hover {
            color: #ff2a2a;
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #e50914 0%, #c20812 100%);
            border: none;
            border-radius: 8px;
            color: #fff;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(229, 9, 20, 0.3);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(229, 9, 20, 0.5);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 2rem 0;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: linear-gradient(90deg, transparent 0%, rgba(255, 255, 255, 0.1) 50%, transparent 100%);
        }

        .divider span {
            padding: 0 1rem;
            color: #666;
            font-size: 0.85rem;
        }

        .social-login {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .btn-social {
            padding: 0.75rem;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: #fff;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-social:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .btn-social i {
            font-size: 1.2rem;
        }

        .signup-link {
            text-align: center;
            color: #888;
            font-size: 0.9rem;
        }

        .signup-link a {
            color: #e50914;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .signup-link a:hover {
            color: #ff2a2a;
            text-decoration: underline;
        }

        .alert-custom {
            padding: 0.875rem 1rem;
            background: rgba(229, 9, 20, 0.1);
            border: 1px solid rgba(229, 9, 20, 0.3);
            border-radius: 8px;
            color: #ff6b6b;
            font-size: 0.85rem;
            margin-bottom: 1.5rem;
            display: none;
        }

        .alert-custom.show {
            display: block;
        }

        @media (max-width: 576px) {
            .login-container {
                padding: 1rem;
            }

            .login-card {
                padding: 2rem 1.5rem;
            }

            .logo {
                font-size: 2.5rem;
            }

            .social-login {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-section">
            <div class="logo">WOVIES</div>
            <div class="logo-tagline">Stream Unlimited</div>
        </div>

        <div class="login-card">
            <h1 class="login-title">Welcome Back</h1>
            <p class="login-subtitle">Sign in to continue watching</p>

            <div class="alert-custom" id="errorAlert">
                <i class="bi bi-exclamation-circle"></i> Invalid email or password
            </div>

            <form id="loginForm" onsubmit="return handleLogin(event)">
                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <div class="input-wrapper">
                        <i class="bi bi-envelope input-icon"></i>
                        <input type="email" class="form-control-custom" id="email" placeholder="Enter your email" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>
                    <div class="input-wrapper">
                        <i class="bi bi-lock input-icon"></i>
                        <input type="password" class="form-control-custom" id="password" placeholder="Enter your password" required>
                        <button type="button" class="password-toggle" onclick="togglePassword()">
                            <i class="bi bi-eye" id="toggleIcon"></i>
                        </button>
                    </div>
                </div>

                <div class="form-options">
                    <div class="remember-me">
                        <input type="checkbox" id="rememberMe">
                        <label for="rememberMe">Remember me</label>
                    </div>
                    <a href="forgot-password.jsp" class="forgot-link">Forgot password?</a>
                </div>

                <button type="submit" class="btn-login">Sign In</button>
            </form>

            <div class="divider">
                <span>or continue with</span>
            </div>

            <div class="social-login">
                <button class="btn-social" onclick="socialLogin('google')">
                    <i class="bi bi-google"></i>
                    <span>Google</span>
                </button>
                <button class="btn-social" onclick="socialLogin('facebook')">
                    <i class="bi bi-facebook"></i>
                    <span>Facebook</span>
                </button>
            </div>

            <div class="signup-link">
                Don't have an account? <a href="signup.jsp">Sign up now</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePassword() {
            var passwordInput = document.getElementById('password');
            var toggleIcon = document.getElementById('toggleIcon');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.className = 'bi bi-eye-slash';
            } else {
                passwordInput.type = 'password';
                toggleIcon.className = 'bi bi-eye';
            }
        }

        function handleLogin(event) {
            event.preventDefault();

            var email = document.getElementById('email').value;
            var password = document.getElementById('password').value;
            var rememberMe = document.getElementById('rememberMe').checked;

            // In a real application, you would send this to your backend
            // For demo purposes, we'll just redirect to the home page

            // Example validation
            if (email && password) {
                // Simulate successful login
                window.location.href = 'index.jsp';
            } else {
                // Show error
                document.getElementById('errorAlert').classList.add('show');
                setTimeout(function() {
                    document.getElementById('errorAlert').classList.remove('show');
                }, 3000);
            }

            return false;
        }

        function socialLogin(provider) {
            // In a real application, this would initiate OAuth flow
            console.log('Login with ' + provider);
            // For demo, redirect to home
            window.location.href = 'index.jsp';
        }
    </script>
</body>
</html>
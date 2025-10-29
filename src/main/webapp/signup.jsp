<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Wovies</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .signup-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 500px;
            width: 100%;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .signup-header {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }

        .signup-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .signup-header p {
            font-size: 1rem;
            opacity: 0.9;
        }

        .signup-body {
            padding: 40px 30px;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .form-control {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 12px 15px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #f093fb;
            box-shadow: 0 0 0 0.2rem rgba(240, 147, 251, 0.25);
        }

        .input-group-text {
            background: #f8f9fa;
            border: 2px solid #e0e0e0;
            border-right: none;
            border-radius: 10px 0 0 10px;
        }

        .input-group .form-control {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }

        .btn-signup {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            border: none;
            border-radius: 10px;
            color: white;
            font-weight: 600;
            padding: 14px;
            font-size: 1.1rem;
            width: 100%;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .btn-signup:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(240, 147, 251, 0.4);
            background: linear-gradient(135deg, #f5576c 0%, #f093fb 100%);
        }

        .btn-signup:active {
            transform: translateY(0);
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 25px 0;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #e0e0e0;
        }

        .divider span {
            padding: 0 15px;
            color: #999;
            font-size: 0.9rem;
        }

        .social-signup {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .btn-social {
            flex: 1;
            padding: 12px;
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            background: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-social:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .btn-google {
            color: #db4437;
        }

        .btn-google:hover {
            background: #db4437;
            color: white;
            border-color: #db4437;
        }

        .btn-facebook {
            color: #4267B2;
        }

        .btn-facebook:hover {
            background: #4267B2;
            color: white;
            border-color: #4267B2;
        }

        .form-check-input:checked {
            background-color: #f093fb;
            border-color: #f093fb;
        }

        .terms-link {
            color: #f093fb;
            text-decoration: none;
            font-weight: 600;
        }

        .terms-link:hover {
            color: #f5576c;
            text-decoration: underline;
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #e0e0e0;
        }

        .login-link a {
            color: #f093fb;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            color: #f5576c;
            text-decoration: underline;
        }

        .password-strength {
            height: 5px;
            background: #e0e0e0;
            border-radius: 5px;
            margin-top: 8px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            transition: all 0.3s ease;
            width: 0%;
        }

        .strength-weak {
            background: #f5576c;
            width: 33%;
        }

        .strength-medium {
            background: #ffa726;
            width: 66%;
        }

        .strength-strong {
            background: #66bb6a;
            width: 100%;
        }

        .alert {
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 20px;
        }

        .row {
            margin-left: -5px;
            margin-right: -5px;
        }

        .row > [class*='col-'] {
            padding-left: 5px;
            padding-right: 5px;
        }
    </style>
</head>
<body>
<div class="signup-container">
    <div class="signup-header">
        <h1><i class="fas fa-play-circle"></i> Wovies</h1>
        <p>Create your account and start streaming!</p>
    </div>

    <div class="signup-body">
        <%
            // Retrieve messages from request (or session if needed)
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
        %>

        <!-- Display error message -->
        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <!-- Display success message -->
        <% if (success != null && !success.isEmpty()) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> <%= success %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>


        <form action="${pageContext.request.contextPath}/signup" method="POST" id="signupForm">

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="firstName" class="form-label">First Name</label>
                    <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-user"></i>
                            </span>
                        <input type="text" class="form-control" id="firstName" name="firstName"
                               placeholder="John" value="${param.firstName}" required>
                    </div>
                </div>
                <div class="col-md-6">
                    <label for="lastName" class="form-label">Last Name</label>
                    <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-user"></i>
                            </span>
                        <input type="text" class="form-control" id="lastName" name="lastName"
                               placeholder="Doe" value="${param.lastName}" required>
                    </div>
                </div>
            </div>

            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-at"></i>
                        </span>
                    <input type="text" class="form-control" id="username" name="username"
                           placeholder="johndoe123" value="${param.username}" required>
                </div>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-envelope"></i>
                        </span>
                    <input type="email" class="form-control" id="email" name="email"
                           placeholder="john@example.com" value="${param.email}" required>
                </div>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-lock"></i>
                        </span>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Enter strong password" required>
                </div>
                <div class="password-strength">
                    <div class="password-strength-bar" id="strengthBar"></div>
                </div>
            </div>

            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-lock"></i>
                        </span>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                           placeholder="Re-enter password" required>
                </div>
            </div>

            <div class="mb-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="terms" name="terms" value="true" required>
                    <label class="form-check-label" for="terms">
                        I agree to the <a href="#" class="terms-link">Terms & Conditions</a>
                    </label>
                </div>
            </div>

            <button type="submit" class="btn btn-signup">
                <i class="fas fa-user-plus"></i> Create Account
            </button>
        </form>

        <div class="divider">
            <span>OR</span>
        </div>

        <div class="social-signup">
            <button class="btn btn-social btn-google" onclick="alert('Social signup coming soon!')">
                <i class="fab fa-google"></i> Google
            </button>
            <button class="btn btn-social btn-facebook" onclick="alert('Social signup coming soon!')">
                <i class="fab fa-facebook-f"></i> Facebook
            </button>
        </div>

        <div class="login-link">
            Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login Here</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Password strength checker
    const passwordInput = document.getElementById('password');
    const strengthBar = document.getElementById('strengthBar');

    passwordInput.addEventListener('input', function() {
        const password = this.value;
        let strength = 0;

        if (password.length >= 8) strength++;
        if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength++;
        if (password.match(/[0-9]/)) strength++;
        if (password.match(/[^a-zA-Z0-9]/)) strength++;

        strengthBar.className = 'password-strength-bar';

        if (strength === 0) {
            strengthBar.style.width = '0%';
        } else if (strength <= 2) {
            strengthBar.classList.add('strength-weak');
        } else if (strength === 3) {
            strengthBar.classList.add('strength-medium');
        } else {
            strengthBar.classList.add('strength-strong');
        }
    });

    // Form validation
    const form = document.getElementById('signupForm');
    const confirmPassword = document.getElementById('confirmPassword');

    form.addEventListener('submit', function(e) {
        const password = passwordInput.value;
        const confirm = confirmPassword.value;

        if (password !== confirm) {
            e.preventDefault();
            alert('Passwords do not match!');
            confirmPassword.focus();
            return false;
        }

        if (password.length < 8) {
            e.preventDefault();
            alert('Password must be at least 8 characters long!');
            passwordInput.focus();
            return false;
        }
    });
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("email");

    if (email != null) {
        response.sendRedirect("home");
        return;
    }
%>
<html>
<head>
    <title>Wovies - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="login-container">
        <div class="logo-section">
            <div class="logo">WOVIES</div>
            <div class="logo-tagline">Stream Unlimited</div>
        </div>

        <div class="login-card">
            <h1 class="login-title">Welcome Back</h1>
            <p class="login-subtitle">log in to continue watching</p>

            <% 
                // Display error message if redirected back
                String error = (String) request.getAttribute("error");
                if (error != null) { 
            %>
                <div class="alert-custom" id="errorAlert">
                    <i class="bi bi-exclamation-circle"> <%= error %></i>
                </div>
            <% } %> 

            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" >
                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <div class="input-wrapper">
                        <i class="bi bi-envelope input-icon"></i>
                        <input type="email" class="form-control-custom" id="email" placeholder="Enter your email" name="email" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>
                    <div class="input-wrapper">
                        <i class="bi bi-lock input-icon"></i>
                        <input type="password" class="form-control-custom" id="password" placeholder="Enter your password" name="password" required>
                        <button type="button" class="password-toggle" onclick="togglePassword()">
                            <i class="bi bi-eye" id="toggleIcon"></i>
                        </button>
                    </div>
                </div>

                <div class="form-options">
                    <div class="remember-me">
                        <input type="checkbox" id="rememberMe" name="remember-me">
                        <label for="rememberMe">Remember me</label>
                    </div>
                    <a href="forgot-password" class="forgot-link">Forgot password?</a>
                </div>

                <button type="submit" class="btn-login">Log in</button>
            </form>

            <div class="divider">
                <span>or continue with</span>
            </div>


            <div class="signup-link">
                Don't have an account? <a href="sign-up">Sign up now</a>
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
    </script>
</body>
</html>
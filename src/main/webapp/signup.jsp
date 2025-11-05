<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Wovies - Sign Up</title>
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
            position: relative;
            overflow-x: hidden;
            padding: 2rem 0;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0%;
            left: 0%;
            transform: translate(-50%, -50%);
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(229, 9, 20, 0.1) 0%, transparent 80%);
            animation: pulse 15s ease-in-out infinite;
            pointer-events: none;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .signup-container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 550px;
            padding: 0 2rem;
            margin: 0 auto;
        }

        .logo-section {
            text-align: center;
            margin-bottom: 2rem;
        }

        .logo {
            font-size: 2.5rem;
            font-weight: 900;
            background: linear-gradient(135deg, #e50914 0%, #ff2a2a 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: 2px;
            text-shadow: 0 0 30px rgba(229, 9, 20, 0.3);
            margin-bottom: 0.25rem;
        }

        .logo-tagline {
            color: #888;
            font-size: 0.9rem;
            letter-spacing: 3px;
            text-transform: uppercase;
        }

        .signup-card {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.9) 0%, rgba(20, 20, 20, 0.95) 100%);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.6);
        }

        .signup-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.35rem;
            text-align: center;
        }

        .signup-subtitle {
            color: #888;
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 0.85rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .form-group {
            margin-bottom: 1rem;
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
            font-size: 1rem;
        }

        .form-control-custom {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.75rem;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: #fff;
            font-size: 0.9rem;
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

        .form-control-custom.error {
            border-color: #ff6b6b;
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
            font-size: 1rem;
            transition: color 0.3s ease;
        }

        .password-toggle:hover {
            color: #e50914;
        }

        .password-strength {
            margin-top: 0.5rem;
            height: 4px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 2px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }

        .password-strength-bar.weak {
            width: 33%;
            background: #ff6b6b;
        }

        .password-strength-bar.medium {
            width: 66%;
            background: #ffa500;
        }

        .password-strength-bar.strong {
            width: 100%;
            background: #4caf50;
        }

        .password-hint {
            font-size: 0.75rem;
            color: #666;
            margin-top: 0.25rem;
        }

        .error-message {
            font-size: 0.8rem;
            color: #ff6b6b;
            margin-top: 0.25rem;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        .terms-checkbox {
            display: flex;
            align-items: start;
            gap: 0.75rem;
            margin-bottom: 1.25rem;
        }

        .terms-checkbox input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #e50914;
            margin-top: 0.15rem;
        }

        .terms-checkbox label {
            color: #b3b3b3;
            font-size: 0.85rem;
            line-height: 1.5;
        }

        .terms-checkbox a {
            color: #e50914;
            text-decoration: none;
        }

        .terms-checkbox a:hover {
            text-decoration: underline;
        }

        .btn-signup {
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

        .btn-signup:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(229, 9, 20, 0.5);
        }

        .btn-signup:active {
            transform: translateY(0);
        }

        .btn-signup:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
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

        .social-signup {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1.5rem;
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

        .login-link {
            text-align: center;
            color: #888;
            font-size: 0.9rem;
        }

        .login-link a {
            color: #e50914;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: #ff2a2a;
            text-decoration: underline;
        }

        @media (max-width: 576px) {
            .signup-container {
                padding: 1rem;
            }

            .signup-card {
                padding: 2rem 1.5rem;
            }

            .logo {
                font-size: 2.5rem;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .social-signup {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="logo-section">
            <div class="logo">WOVIES</div>
            <div class="logo-tagline">Start Streaming Today</div>
        </div>

        <div class="signup-card">
            <h1 class="signup-title">Create Account</h1>
            <p class="signup-subtitle">Join millions of viewers worldwide</p>

            <form id="signupForm" onsubmit="return handleSignup(event)">
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <div class="input-wrapper">
                            <i class="bi bi-person input-icon"></i>
                            <input type="text" class="form-control-custom" id="firstName" placeholder="John" required>
                        </div>
                        <div class="error-message" id="firstNameError">Please enter your first name</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Last Name</label>
                        <div class="input-wrapper">
                            <i class="bi bi-person input-icon"></i>
                            <input type="text" class="form-control-custom" id="lastName" placeholder="Doe" required>
                        </div>
                        <div class="error-message" id="lastNameError">Please enter your last name</div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <div class="input-wrapper">
                        <i class="bi bi-envelope input-icon"></i>
                        <input type="email" class="form-control-custom" id="email" placeholder="john.doe@example.com" required>
                    </div>
                    <div class="error-message" id="emailError">Please enter a valid email address</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>
                    <div class="input-wrapper">
                        <i class="bi bi-lock input-icon"></i>
                        <input type="password" class="form-control-custom" id="password" placeholder="Create a strong password" required oninput="checkPasswordStrength()">
                        <button type="button" class="password-toggle" onclick="togglePassword('password', 'toggleIcon1')">
                            <i class="bi bi-eye" id="toggleIcon1"></i>
                        </button>
                    </div>
                    <div class="password-strength">
                        <div class="password-strength-bar" id="passwordStrengthBar"></div>
                    </div>
                    <div class="password-hint">At least 8 characters with uppercase, lowercase and numbers</div>
                    <div class="error-message" id="passwordError">Password must be at least 8 characters</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Confirm Password</label>
                    <div class="input-wrapper">
                        <i class="bi bi-lock input-icon"></i>
                        <input type="password" class="form-control-custom" id="confirmPassword" placeholder="Re-enter your password" required>
                        <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword', 'toggleIcon2')">
                            <i class="bi bi-eye" id="toggleIcon2"></i>
                        </button>
                    </div>
                    <div class="error-message" id="confirmPasswordError">Passwords do not match</div>
                </div>

                <div class="terms-checkbox">
                    <input type="checkbox" id="terms" required>
                    <label for="terms">
                        I agree to the <a href="terms">Terms of Service</a> and <a href="privacy">Privacy Policy</a>
                    </label>
                </div>

                <button type="submit" class="btn-signup">Create Account</button>
            </form>

            <div class="divider">
                <span>or sign up with</span>
            </div>

            <div class="social-signup">
                <button class="btn-social" onclick="socialSignup('google')">
                    <i class="bi bi-google"></i>
                    <span>Google</span>
                </button>
                <button class="btn-social" onclick="socialSignup('facebook')">
                    <i class="bi bi-facebook"></i>
                    <span>Facebook</span>
                </button>
            </div>

            <div class="login-link">
                Already have an account? <a href="login">Sign in</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePassword(inputId, iconId) {
            var passwordInput = document.getElementById(inputId);
            var toggleIcon = document.getElementById(iconId);

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.className = 'bi bi-eye-slash';
            } else {
                passwordInput.type = 'password';
                toggleIcon.className = 'bi bi-eye';
            }
        }

        function checkPasswordStrength() {
            var password = document.getElementById('password').value;
            var strengthBar = document.getElementById('passwordStrengthBar');

            var strength = 0;
            if (password.length >= 8) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;

            strengthBar.className = 'password-strength-bar';
            if (strength <= 1) {
                strengthBar.classList.add('weak');
            } else if (strength <= 3) {
                strengthBar.classList.add('medium');
            } else {
                strengthBar.classList.add('strong');
            }
        }

        function validateForm() {
            var isValid = true;

            // Clear previous errors
            document.querySelectorAll('.error-message').forEach(function(el) {
                el.classList.remove('show');
            });
            document.querySelectorAll('.form-control-custom').forEach(function(el) {
                el.classList.remove('error');
            });

            // Validate first name
            var firstName = document.getElementById('firstName');
            if (!firstName.value.trim()) {
                firstName.classList.add('error');
                document.getElementById('firstNameError').classList.add('show');
                isValid = false;
            }

            // Validate last name
            var lastName = document.getElementById('lastName');
            if (!lastName.value.trim()) {
                lastName.classList.add('error');
                document.getElementById('lastNameError').classList.add('show');
                isValid = false;
            }

            // Validate email
            var email = document.getElementById('email');
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email.value)) {
                email.classList.add('error');
                document.getElementById('emailError').classList.add('show');
                isValid = false;
            }

            // Validate password
            var password = document.getElementById('password');
            if (password.value.length < 8) {
                password.classList.add('error');
                document.getElementById('passwordError').classList.add('show');
                isValid = false;
            }

            // Validate confirm password
            var confirmPassword = document.getElementById('confirmPassword');
            if (password.value !== confirmPassword.value) {
                confirmPassword.classList.add('error');
                document.getElementById('confirmPasswordError').classList.add('show');
                isValid = false;
            }

            return isValid;
        }

        function handleSignup(event) {
            event.preventDefault();

            if (!validateForm()) {
                return false;
            }

            var firstName = document.getElementById('firstName').value;
            var lastName = document.getElementById('lastName').value;
            var email = document.getElementById('email').value;
            var password = document.getElementById('password').value;
            var terms = document.getElementById('terms').checked;

            // In a real application, you would send this to your backend
            console.log('Sign up attempt:', { firstName: firstName, lastName: lastName, email: email, terms: terms });

            // Simulate successful signup
            window.location.href = 'index';

            return false;
        }

        function socialSignup(provider) {
            // In a real application, this would initiate OAuth flow
            console.log('Sign up with ' + provider);
            window.location.href = 'index';
        }
    </script>
</body>
</html>
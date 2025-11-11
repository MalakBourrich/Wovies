<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Wovies - Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/signup.css">
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

        <form id="signupForm" action="sign-up" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">First Name</label>
                    <div class="input-wrapper">
                        <i class="bi bi-person input-icon"></i>
                        <input type="text" class="form-control-custom" id="firstName" name="firstName" placeholder="John">
                    </div>
                    <div class="error-message" id="firstNameError">Please enter your first name</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Last Name</label>
                    <div class="input-wrapper">
                        <i class="bi bi-person input-icon"></i>
                        <input type="text" class="form-control-custom" id="lastName" name="lastName" placeholder="Doe">
                    </div>
                    <div class="error-message" id="lastNameError">Please enter your last name</div>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Email Address</label>
                <div class="input-wrapper">
                    <i class="bi bi-envelope input-icon"></i>
                    <input type="email" class="form-control-custom" id="email" name="email" placeholder="john.doe@example.com">
                </div>
                <div class="error-message" id="emailError">Please enter a valid email address</div>
            </div>

            <div class="form-group">
                <label class="form-label">Password</label>
                <div class="input-wrapper">
                    <i class="bi bi-lock input-icon"></i>
                    <input type="password" class="form-control-custom" id="password" name="password" placeholder="Create a strong password" oninput="checkPasswordStrength()">
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
                    <input type="password" class="form-control-custom" id="confirmPassword" name="confirmPassword" placeholder="Re-enter your password">
                    <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword', 'toggleIcon2')">
                        <i class="bi bi-eye" id="toggleIcon2"></i>
                    </button>
                </div>
                <div class="error-message" id="confirmPasswordError">Passwords do not match</div>
            </div>


            <button type="submit" class="btn-signup">Create Account</button>
        </form>

        <div class="divider">
            <span>or sign up with</span>
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

    function validateForm(event) {
        event.preventDefault(); // Prevent default submission
        console.log('Validating form...');

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
            console.log('First name validation failed');
        }

        // Validate last name
        var lastName = document.getElementById('lastName');
        if (!lastName.value.trim()) {
            lastName.classList.add('error');
            document.getElementById('lastNameError').classList.add('show');
            isValid = false;
            console.log('Last name validation failed');
        }

        // Validate email
        var email = document.getElementById('email');
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email.value)) {
            email.classList.add('error');
            document.getElementById('emailError').classList.add('show');
            isValid = false;
            console.log('Email validation failed');
        }

        // Validate password
        var password = document.getElementById('password');
        if (password.value.length < 8) {
            password.classList.add('error');
            document.getElementById('passwordError').classList.add('show');
            isValid = false;
            console.log('Password validation failed');
        }

        // Validate confirm password
        var confirmPassword = document.getElementById('confirmPassword');
        if (password.value !== confirmPassword.value) {
            confirmPassword.classList.add('error');
            document.getElementById('confirmPasswordError').classList.add('show');
            isValid = false;
            console.log('Confirm password validation failed');
        }

        console.log('Form validation result:', isValid);

        if (isValid) {
            console.log('Submitting form...');
            document.getElementById('signupForm').submit();
        }

        return false;
    }

    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('signupForm').addEventListener('submit', validateForm);
    });
</script>
</body>
</html>
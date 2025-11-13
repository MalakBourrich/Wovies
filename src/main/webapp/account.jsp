<jsp:useBean id="account" scope="request" type="model.Account"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login");
        return;
    }
%>
<html>
<head>
    <title>Wovies - My Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/account.css">
</head>
<body>
    <nav class="navbar-custom">
        <div class="container">
            <div class="navbar-content">
                <div class="nav-left">
                    <div class="logo" onclick="window.location.href='home'">WOVIES</div>
                    <ul class="nav-links">
                        <li><a href="home">Home</a></li>
                        <li><a href="history">History</a></li>
                        <li><a href="watchlist">WatchList</a></li>
                    </ul>
                </div>
                <div class="nav-right">
                    <div class="search-box">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" class="search-input" placeholder="Search movies & series..." id="searchInput">
                    </div>
                    <a href="account" class="btn-account">
                        <i class="bi bi-person-circle"></i>
                        <span>Account</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container content-wrapper">
        <div class="account-header">
            <div class="profile-avatar">
                <div class="avatar-edit" onclick="alert('Upload profile picture feature coming soon!')">
                    <i class="bi bi-camera-fill"></i>
                </div>
            </div>
            <div class="profile-info">
                <h1 class="profile-name" id="profileName">${account.firstName} ${account.lastName}</h1>
                <div class="profile-email" id="profileEmail">${account.email}</div>
                <div class="profile-meta">
                    <div class="meta-item">
                        <i class="bi bi-calendar-check"></i>
                        <span>Member since Oct 2023</span>
                    </div>
                    <div class="meta-item">
                        <i class="bi bi-shield-check"></i>
                        <span>Premium Account</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="tabs-container">
            <button class="tab-btn active" onclick="switchTab('profile')">
                <i class="bi bi-person"></i> Profile
            </button>

            <button class="tab-btn" onclick="switchTab('security')">
                <i class="bi bi-shield-lock"></i> Security
            </button>

        </div>

        <!-- Profile Tab -->
        <div class="tab-content active" id="profileTab">
            <div class="content-card">
                <h2 class="card-title">
                    <i class="bi bi-person-circle"></i>
                    Personal Information
                </h2>
                <div class="success-message" id="profileSuccess">
                    <i class="bi bi-check-circle"></i> Profile updated successfully!
                </div>
                <form id="profileForm" onsubmit="return updateProfile(event)">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">First Name</label>
                            <input type="text" class="form-control-custom" id="firstName" value="${account.firstName}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control-custom" id="lastName" value="${account.lastName}" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <input type="email" class="form-control-custom" id="email" value="${account.email}" required>
                    </div>


                    <div style="display: flex; gap: 1rem;">
                        <button type="submit" class="btn-primary">
                            <i class="bi bi-check-circle"></i> Save Changes
                        </button>
                        <button type="button" class="btn-secondary" onclick="resetForm()">
                            <i class="bi bi-x-circle"></i> Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>


        <!-- Security Tab -->
        <div class="tab-content" id="securityTab">
            <div class="content-card">
                <h2 class="card-title">
                    <i class="bi bi-key"></i>
                    Change Password
                </h2>
                <div class="success-message" id="passwordSuccess">
                    <i class="bi bi-check-circle"></i> Password changed successfully!
                </div>
                <form id="passwordForm" onsubmit="return changePassword(event)">
                    <div class="form-group">
                        <label class="form-label">Current Password</label>
                        <input type="password" class="form-control-custom" id="currentPassword" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">New Password</label>
                        <input type="password" class="form-control-custom" id="newPassword" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Confirm New Password</label>
                        <input type="password" class="form-control-custom" id="confirmPassword" required>
                    </div>
                    <button type="submit" class="btn-primary">
                        <i class="bi bi-shield-check"></i> Update Password
                    </button>
                </form>
            </div>

            <div class="content-card">
                <h2 class="card-title">
                    <i class="bi bi-door-open"></i>
                    Session Management
                </h2>
                <p style="color: #888; margin-bottom: 1.5rem;">Manage your account access and logout securely</p>
                <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                    <button class="btn-danger" onclick="logout()">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const contextPath = '<%= request.getContextPath() %>';
        function switchTab(tabName) {
            // Hide all tabs
            var tabs = document.querySelectorAll('.tab-content');
            tabs.forEach(function(tab) {
                tab.classList.remove('active');
            });

            // Remove active from all buttons
            var btns = document.querySelectorAll('.tab-btn');
            btns.forEach(function(btn) {
                btn.classList.remove('active');
            });

            // Show selected tab
            document.getElementById(tabName + 'Tab').classList.add('active');
            event.target.classList.add('active');
        }

        function updateProfile(event) {
            event.preventDefault();

            var firstName = document.getElementById('firstName').value;
            var lastName = document.getElementById('lastName').value;
            var email = document.getElementById('email').value;

            // Update profile name in header
            // Update profile name in header
            document.getElementById('profileName').textContent = firstName + ' ' + lastName;
            document.getElementById('profileEmail').textContent = email;

            // Update avatar initials
            const initials = (firstName.charAt(0) + lastName.charAt(0)).toUpperCase();
            document.getElementById('avatarInitials').textContent = initials;

            // Show success message
            const successMsg = document.getElementById('profileSuccess');
            successMsg.classList.add('show');
            setTimeout(() => successMsg.classList.remove('show'), 3000);

            return false;
        }

        function resetForm() {
            document.getElementById('profileForm').reset();
        }

        async function changePassword(event) {
            event.preventDefault();

            const current = document.getElementById('currentPassword').value;
            const newPass = document.getElementById('newPassword').value;
            const confirm = document.getElementById('confirmPassword').value;

            if (newPass !== confirm) {
                alert("Passwords do not match!");
                return false;
            }

            if (!current || !newPass) {
                alert("Please fill in all fields!");
                return false;
            }

            try {
                const params = new URLSearchParams();
                params.append('currentPassword', current);
                params.append('newPassword', newPass);


                const response = await fetch(contextPath + "/account", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                        // Servlet only know how to open urlencoded so it can parse it cause im using req.getParameter()
                    },
                    body: params.toString()
                });


                if (response.ok && result == 'success') {

                        const successMsg = document.getElementById('passwordSuccess');
                        successMsg.classList.add('show');
                        setTimeout(() => successMsg.classList.remove('show'), 3000);
                        document.getElementById('passwordForm').reset();
                    } else {
                        alert(result || "Failed to change password!");

                }
            } catch (err) {
                console.error(err);
                alert("An error occurred while changing the password.");
            }



            // Here you can send a POST request to your servlet for password update
            // Example: fetch('/ChangePasswordServlet', { method: 'POST', body: new FormData(document.getElementById('passwordForm')) })


            return false;
        }

        function logout() {
            if (confirm("Are you sure you want to log out?")) {
                // Example redirect to Logout servlet
                window.location.href = "LogoutServlet";
            }
        }



        // Example of loading dynamic data when the page loads (from session or servlet)
        //window.onload = function() {
            // You could replace these with dynamic data fetched from backend
           // const username = "John Doe";
//            const email = "john.doe@example.com";

  //          document.getElementById('profileName').textContent = username;
    //        document.getElementById('profileEmail').textContent = email;
      //  };
    </script>
</body>
</html>


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
        }

        .navbar-custom {
            background: rgba(10, 10, 10, 0.95);
            backdrop-filter: blur(10px);
            padding: 0;
            border-bottom: 1px solid rgba(229, 9, 20, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.5);
        }

        .navbar-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem 0;
        }

        .nav-left {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .logo {
            font-size: 2rem;
            font-weight: 900;
            background: linear-gradient(135deg, #e50914 0%, #ff2a2a 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: 1px;
            cursor: pointer;
        }

        .nav-links {
            display: flex;
            gap: 0.5rem;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-links a {
            color: #b3b3b3;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .nav-links a:hover {
            color: #fff;
            background: rgba(229, 9, 20, 0.1);
        }

        .nav-links a.active {
            color: #fff;
            background: rgba(229, 9, 20, 0.2);
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .search-box {
            position: relative;
        }

        .search-input {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            padding: 0.5rem 1rem 0.5rem 2.5rem;
            border-radius: 25px;
            width: 250px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            background: rgba(255, 255, 255, 0.08);
            border-color: #e50914;
            box-shadow: 0 0 0 3px rgba(229, 9, 20, 0.1);
            outline: none;
            width: 300px;
        }

        .search-input::placeholder {
            color: #888;
        }

        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            pointer-events: none;
        }

        .btn-account {
            background: rgba(229, 9, 20, 0.1);
            border: 1px solid rgba(229, 9, 20, 0.3);
            color: #fff;
            padding: 0.5rem 1.25rem;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-account:hover {
            background: #e50914;
            border-color: #e50914;
            color: #fff;
            box-shadow: 0 4px 15px rgba(229, 9, 20, 0.4);
            transform: translateY(-1px);
        }

        .content-wrapper {
            padding: 3rem 0;
        }

        .account-header {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.8) 0%, rgba(20, 20, 20, 0.9) 100%);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e50914 0%, #ff2a2a 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: #fff;
            font-weight: 700;
            border: 4px solid rgba(229, 9, 20, 0.3);
            position: relative;
        }

        .avatar-edit {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 35px;
            height: 35px;
            background: #e50914;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .avatar-edit:hover {
            background: #ff2a2a;
            transform: scale(1.1);
        }

        .profile-info {
            flex: 1;
        }

        .profile-name {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .profile-email {
            color: #888;
            font-size: 1rem;
            margin-bottom: 0.75rem;
        }

        .profile-meta {
            display: flex;
            gap: 2rem;
            font-size: 0.9rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #b3b3b3;
        }

        .tabs-container {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .tab-btn {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #b3b3b3;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .tab-btn:hover {
            background: rgba(255, 255, 255, 0.05);
            color: #fff;
        }

        .tab-btn.active {
            background: rgba(229, 9, 20, 0.2);
            border-color: #e50914;
            color: #e50914;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        .content-card {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.8) 0%, rgba(20, 20, 20, 0.9) 100%);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
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

        .form-control-custom {
            width: 100%;
            padding: 0.875rem 1rem;
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

        .form-control-custom:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #e50914 0%, #c20812 100%);
            border: none;
            color: #fff;
            padding: 0.875rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(229, 9, 20, 0.5);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            padding: 0.875rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .btn-danger {
            background: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.3);
            color: #dc3545;
            padding: 0.875rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-danger:hover {
            background: #dc3545;
            color: #fff;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 10px;
            padding: 1.5rem;
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: rgba(229, 9, 20, 0.3);
        }

        .stat-icon {
            font-size: 2.5rem;
            color: #e50914;
            margin-bottom: 0.75rem;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .stat-label {
            color: #888;
            font-size: 0.9rem;
        }

        .activity-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .activity-item {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 8px;
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all 0.3s ease;
        }

        .activity-item:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: rgba(255, 255, 255, 0.1);
        }

        .activity-icon {
            width: 45px;
            height: 45px;
            background: rgba(229, 9, 20, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #e50914;
            font-size: 1.1rem;
        }

        .activity-details {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .activity-time {
            font-size: 0.85rem;
            color: #666;
        }

        .success-message {
            background: rgba(76, 175, 80, 0.1);
            border: 1px solid rgba(76, 175, 80, 0.3);
            color: #4caf50;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            display: none;
        }

        .success-message.show {
            display: block;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .search-input {
                width: 150px;
            }

            .search-input:focus {
                width: 180px;
            }

            .account-header {
                flex-direction: column;
                text-align: center;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar-custom">
        <div class="container">
            <div class="navbar-content">
                <div class="nav-left">
                    <div class="logo" onclick="window.location.href='home'">WOVIES</div>
                    <ul class="nav-links">
                        <li><a href="home">Home</a></li>
                        <li><a href="history">myHistory</a></li>
                        <li><a href="watchlist">myWatchList</a></li>
                        <li><a href="suggestions">browseSuggestions</a></li>
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
                <span id="avatarInitials">JD</span>
                <div class="avatar-edit" onclick="alert('Upload profile picture feature coming soon!')">
                    <i class="bi bi-camera-fill"></i>
                </div>
            </div>
            <div class="profile-info">
                <h1 class="profile-name" id="profileName">John Doe</h1>
                <div class="profile-email" id="profileEmail">john.doe@example.com</div>
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
            <button class="tab-btn" onclick="switchTab('activity')">
                <i class="bi bi-activity"></i> Activity
            </button>
            <button class="tab-btn" onclick="switchTab('security')">
                <i class="bi bi-shield-lock"></i> Security
            </button>
            <button class="tab-btn" onclick="switchTab('preferences')">
                <i class="bi bi-sliders"></i> Preferences
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
                            <input type="text" class="form-control-custom" id="firstName" value="John" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control-custom" id="lastName" value="Doe" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <input type="email" class="form-control-custom" id="email" value="john.doe@example.com" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" class="form-control-custom" id="phone" value="+1 (555) 123-4567">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" class="form-control-custom" id="dob" value="1990-01-15">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Bio</label>
                        <textarea class="form-control-custom" id="bio" rows="4" placeholder="Tell us about yourself...">Movie enthusiast and binge-watcher</textarea>
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

        <!-- Activity Tab -->
        <div class="tab-content" id="activityTab">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon"><i class="bi bi-play-circle"></i></div>
                    <div class="stat-number">127</div>
                    <div class="stat-label">Videos Watched</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="bi bi-bookmark"></i></div>
                    <div class="stat-number">23</div>
                    <div class="stat-label">In Watchlist</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="bi bi-star"></i></div>
                    <div class="stat-number">45</div>
                    <div class="stat-label">Videos Rated</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="bi bi-clock-history"></i></div>
                    <div class="stat-number">312h</div>
                    <div class="stat-label">Watch Time</div>
                </div>
            </div>

            <div class="content-card">
                <h2 class="card-title">
                    <i class="bi bi-clock-history"></i>
                    Recent Activity
                </h2>
                <div class="activity-list">
                    <div class="activity-item">
                        <div class="activity-icon"><i class="bi bi-play-circle"></i></div>
                        <div class="activity-details">
                            <div class="activity-title">Watched "Stranger Things" S1E5</div>
                            <div class="activity-time">2 hours ago</div>
                        </div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon"><i class="bi bi-bookmark"></i></div>
                        <div class="activity-details">
                            <div class="activity-title">Added "Oppenheimer" to watchlist</div>
                            <div class="activity-time">Yesterday</div>
                        </div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon"><i class="bi bi-star"></i></div>
                        <div class="activity-details">
                            <div class="activity-title">Rated "Breaking Bad" 5 stars</div>
                            <div class="activity-time">2 days ago</div>
                        </div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon"><i class="bi bi-play-circle"></i></div>
                        <div class="activity-details">
                            <div class="activity-title">Finished watching "The Batman"</div>
                            <div class="activity-time">3 days ago</div>
                        </div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon"><i class="bi bi-bookmark"></i></div>
                        <div class="activity-details">
                            <div class="activity-title">Added "Dune" to watchlist</div>
                            <div class="activity-time">1 week ago</div>
                        </div>
                    </div>
                </div>
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
                    <button class="btn-secondary" onclick="logoutAllDevices()">
                        <i class="bi bi-phone"></i> Logout All Devices
                    </button>
                </div>
            </div>
        </div>

        <!-- Preferences Tab -->
        <div class="tab-content" id="preferencesTab">
            <div class="content-card">
                <h2 class="card-title">
                    <i class="bi bi-bell"></i>
                    Notifications
                </h2>
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 1rem; cursor: pointer;">
                        <input type="checkbox" checked style="width: 20px; height: 20px; accent-color: #e50914;">
                        <div>
                            <div style="font-weight: 600;">Email Notifications</div>
                            <div style="font-size: 0.85rem; color: #888;">Receive updates about new releases</div>
                        </div>
                    </label>
                </div>
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 1rem; cursor: pointer;">
                        <input type="checkbox" checked style="width: 20px; height: 20px; accent-color: #e50914;">
                        <div>
                            <div style="font-weight: 600;">Recommendations</div>
                            <div style="font-size: 0.85rem; color: #888;">Get personalized content suggestions</div>
                        </div>
                    </label>
                </div>
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 1rem; cursor: pointer;">
                        <input type="checkbox" style="width: 20px; height: 20px; accent-color: #e50914;">
                        <div>
                            <div style="font-weight: 600;">Marketing Emails</div>
                            <div style="font-size: 0.85rem; color: #888;">Receive promotional offers and deals</div>
                        </div>
                    </label>
                </div>
                <button class="btn-primary" onclick="savePreferences()">
                    <i class="bi bi-check-circle"></i> Save Preferences
                </button>
            </div>

            <div class="content-card">
                <h2 class="card-title">
                    <i class="bi bi-trash"></i>
                    Delete Account
                </h2>
                <p style="color: #888; margin-bottom: 1.5rem;">
                    Once you delete your account, there is no going back. Please be certain.
                </p>
                <button class="btn-danger" onclick="deleteAccount()">
                    <i class="bi bi-exclamation-triangle"></i> Delete My Account
                </button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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

        function changePassword(event) {
            event.preventDefault();

            const current = document.getElementById('currentPassword').value;
            const newPass = document.getElementById('newPassword').value;
            const confirm = document.getElementById('confirmPassword').value;

            if (newPass !== confirm) {
                alert("Passwords do not match!");
                return false;
            }

            // Here you can send a POST request to your servlet for password update
            // Example: fetch('/ChangePasswordServlet', { method: 'POST', body: new FormData(document.getElementById('passwordForm')) })

            document.getElementById('passwordSuccess').classList.add('show');
            setTimeout(() => document.getElementById('passwordSuccess').classList.remove('show'), 3000);
            document.getElementById('passwordForm').reset();
            return false;
        }

        function logout() {
            if (confirm("Are you sure you want to log out?")) {
                // Example redirect to Logout servlet
                window.location.href = "LogoutServlet";
            }
        }

        function logoutAllDevices() {
            if (confirm("Log out from all devices?")) {
                alert("All sessions have been logged out.");
                // You could call a backend endpoint for this as well
            }
        }

        function savePreferences() {
            alert("Preferences saved successfully!");
        }

        function deleteAccount() {
            if (confirm("This action is irreversible. Do you really want to delete your account?")) {
                alert("Your account has been deleted.");
                window.location.href = "index";
                // In a real scenario, make a DELETE request to your backend
            }
        }

        // Example of loading dynamic data when the page loads (from session or servlet)
        window.onload = function() {
            // You could replace these with dynamic data fetched from backend
            const username = "John Doe";
            const email = "john.doe@example.com";

            document.getElementById('profileName').textContent = username;
            document.getElementById('profileEmail').textContent = email;
        };
    </script>
</body>
</html>


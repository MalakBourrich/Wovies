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
    <title>Wovies - My History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/history.css">
</head>
<body>
    <nav class="navbar-custom">
        <div class="container">
            <div class="navbar-content">
                <div class="nav-left">
                    <div class="logo" onclick="window.location.href='home'">WOVIES</div>
                    <ul class="nav-links">
                        <li><a href="home">Home</a></li>
                        <li><a href="history" class="active">myHistory</a></li>
                        <li><a href="watchlist">myWatchList</a></li>
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
        <div class="page-header">
            <h1 class="page-title">My Watch History</h1>
            <p class="page-subtitle">Track all the movies you've watched</p>
        </div>

        <div class="filter-bar">
            <div class="filter-left">
                <button class="filter-btn active" onclick="filterFavourites('all')">All</button>
                <button class="filter-btn" onclick="filterFavourites('movies')">Movies</button>
                <button class="filter-btn" onclick="filterFavourites('series')">Series</button>
                <button class="filter-btn" onclick="filterFavourites('unwatched')">Unwatched</button>
            </div>
            <button class="btn-clear-history" onclick="clearAllHistory()">
                <i class="bi bi-trash"></i>
                Clear History
            </button>
        </div>

        <div class="history-list" id="historyList">
            <!-- History items will be loaded here -->
        </div>

        <div class="empty-state" id="emptyState" style="display: none;">
            <div class="empty-icon">
                <i class="bi bi-clock-history"></i>
            </div>
            <h2 class="empty-title">No Watch History</h2>
            <p class="empty-text">Start watching movies and series to see your history here</p>
            <a href="home" class="btn-browse">Browse Content</a>
        </div>
    </div>
    <%
        model.History history = (model.History) request.getAttribute("history");
        java.util.List<model.Video> videos = null;
        if (history != null) {
            videos = history.getWatched_list();
        }
    %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var historyData = [] ;

        <% if(videos != null) {
            for (model.Video video : videos) {

        %>
            historyData.push({
                id: "<%= video.getId()%>",
                title: "<%= video.getTitle()%>",
                type: "<%= video.getType()%>",
                year: "<%= video.getUplaodDate()%>",
                description: "<%= video.getDescription()%>"

            });
        <% }
            } %>

        console.log("Loaded history data:" , historyData)
        console.log("📊 Number of items:", historyData.length);

        var currentFilter = 'all';

        function formatDate(dateString) {
            var date = new Date(dateString);
            var today = new Date();
            var yesterday = new Date(today);
            yesterday.setDate(yesterday.getDate() - 1);

            if (date.toDateString() === today.toDateString()) {
                return 'Today';
            } else if (date.toDateString() === yesterday.toDateString()) {
                return 'Yesterday';
            } else {
                var options = { month: 'short', day: 'numeric', year: 'numeric' };
                return date.toLocaleDateString('en-US', options);
            }
        }

        function createHistoryItem(item) {
            var historyItem = document.createElement('div');
            historyItem.className = 'history-item';
            historyItem.onclick = function() { continueWatching(item.id); };

            var typeLabel = item.type === 'movie' ? 'Movie' : 'Series';

            historyItem.innerHTML =
                '<div class="history-thumbnail">' +
                    '<div class="play-icon-small">' +
                        '<i class="bi bi-play-fill"></i>' +
                    '</div>' +
                '</div>' +
                '<div class="history-details">' +
                    '<div class="history-header">' +
                        '<div>' +
                            '<h3 class="history-title">' + item.title + '</h3>' +
                            '<div class="history-meta">' +
                                '<span><i class="bi bi-calendar"></i> ' + item.year + '</span>' +
                                '<span><i class="bi bi-film"></i> ' + typeLabel+ '</span>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                    '<p class="history-description">' + item.description + '</p>' +

                    '<div class="history-actions">' +
                        '<button class="btn-continue" onclick="continueWatching(\'' + item.id + '\', event)">' +
                            '<i class="bi bi-play-circle"></i>  Watch' +
                        '</button>' +
                        '<button class="btn-remove" onclick="removeFromHistory(\'' + item.id + '\', event)">' +
                            '<i class="bi bi-x-circle"></i> Remove' +
                        '</button>' +
                    '</div>' +
                '</div>';

            return historyItem;
        }

        function loadHistory(data) {
            var historyList = document.getElementById('historyList');
            var emptyState = document.getElementById('emptyState');

            if (data.length === 0) {
                historyList.style.display = 'none';
                emptyState.style.display = 'block';
            } else {
                historyList.style.display = 'flex';
                emptyState.style.display = 'none';
                historyList.innerHTML = '';

                data.forEach(function(item) {
                    historyList.appendChild(createHistoryItem(item));
                });
            }
        }

        function filterHistory(type) {
            currentFilter = type;

            // Update active filter button
            var filterBtns = document.querySelectorAll('.filter-btn');
            filterBtns.forEach(function(btn) {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');

            var filtered = historyData;

            if (type === 'movies') {
                filtered = historyData.filter(function(item) {
                    return item.type === 'movie';
                });
            } else if (type === 'series') {
                filtered = historyData.filter(function(item) {
                    return item.type === 'series';
                });
            } else if (type === 'week') {
                var weekAgo = new Date();
                weekAgo.setDate(weekAgo.getDate() - 7);
                filtered = historyData.filter(function(item) {
                    return new Date(item.watchedDate) >= weekAgo;
                });
            } else if (type === 'month') {
                var monthAgo = new Date();
                monthAgo.setMonth(monthAgo.getMonth() - 1);
                filtered = historyData.filter(function(item) {
                    return new Date(item.watchedDate) >= monthAgo;
                });
            }

            loadHistory(filtered);
        }

        function continueWatching(id, event) {
            if (event) event.stopPropagation();
            window.location.href = 'watch?id=' + id;
        }

        function removeFromHistory(id, event) {
            event.stopPropagation();
            if (confirm('Remove this item from your watch history?')) {
                var button = event.target.closest('.btn-remove');
                if (button) {
                    button.disabled = true;
                    button.innerHTML = '<i class="bi bi-hourglass-split"></i> Removing...';
                }

                //  FormData to send in POST body
                var formData = new URLSearchParams();
                formData.append('action', 'remove');
                formData.append('videoId', id);

                //  request to server to remove from database
                fetch('history', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: formData.toString()
                })
                    .then(function(response) {
                        if (response.ok) {
                            // Remove from local array
                            historyData = historyData.filter(function(item) {
                                return item.id !== id;
                            });

                            // Reload the filtered history
                            var filtered = historyData;
                            if (currentFilter === 'movies') {
                                filtered = historyData.filter(function(item) {
                                    return item.type === 'movie';
                                });
                            } else if (currentFilter === 'series') {
                                filtered = historyData.filter(function(item) {
                                    return item.type === 'series';
                                });
                            }
                            loadHistory(filtered);
                        } else {
                            alert('Failed to remove video from history');
                            // Re-enable button
                            if (button) {
                                button.disabled = false;
                                button.innerHTML = '<i class="bi bi-x-circle"></i> Remove';
                            }
                        }
                    })
                    .catch(function(error) {
                        console.error('Error:', error);
                        alert('Error removing video from history');
                        // Re-enable button
                        if (button) {
                            button.disabled = false;
                            button.innerHTML = '<i class="bi bi-x-circle"></i> Remove';
                        }
                    });
            }
        }

        function clearAllHistory() {
            if (confirm('Are you sure you want to clear your entire watch history? This action cannot be undone.')) {
                var formData = new URLSearchParams();
                formData.append('action', 'clear');

                fetch('history', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: formData.toString()
                })
                    .then(function(response) {
                        if (response.ok) {
                            historyData = [];
                            loadHistory(historyData);
                        } else {
                            alert('Failed to clear history');
                        }
                    })
                    .catch(function(error) {
                        console.error('Error:', error);
                        alert('Error clearing history');
                    });
            }
        }
        // Load initial history
        loadHistory(historyData);
    </script>
</body>
</html>
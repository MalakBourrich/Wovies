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
            background-clip: text;
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

        .page-header {
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #888;
            font-size: 1rem;
        }

        .filter-bar {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.8) 0%, rgba(20, 20, 20, 0.9) 100%);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .filter-left {
            display: flex;
            gap: 0.75rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .filter-btn {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #b3b3b3;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .filter-btn:hover {
            background: rgba(255, 255, 255, 0.05);
            color: #fff;
        }

        .filter-btn.active {
            background: rgba(229, 9, 20, 0.2);
            border-color: #e50914;
            color: #e50914;
        }

        .btn-clear-history {
            background: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.3);
            color: #dc3545;
            padding: 0.5rem 1.25rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-clear-history:hover {
            background: #dc3545;
            color: #fff;
        }

        .history-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .history-item {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.8) 0%, rgba(20, 20, 20, 0.9) 100%);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            display: flex;
            gap: 1.5rem;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .history-item:hover {
            border-color: rgba(229, 9, 20, 0.5);
            transform: translateX(5px);
        }

        .history-thumbnail {
            width: 200px;
            min-width: 200px;
            aspect-ratio: 16/9;
            background: linear-gradient(135deg, #2a2a2a 0%, #1a1a1a 100%);
            border-radius: 8px;
            position: relative;
            overflow: hidden;
        }

        .progress-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: rgba(255, 255, 255, 0.2);
        }

        .progress-bar-custom {
            height: 100%;
            background: #e50914;
            transition: width 0.3s ease;
        }

        .play-icon-small {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 50px;
            height: 50px;
            background: rgba(229, 9, 20, 0.9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: #fff;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .history-item:hover .play-icon-small {
            opacity: 1;
        }

        .history-details {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .history-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
        }

        .history-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #fff;
            margin-bottom: 0.25rem;
        }

        .history-meta {
            display: flex;
            gap: 1rem;
            font-size: 0.9rem;
            color: #888;
        }

        .history-meta span {
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .history-description {
            color: #b3b3b3;
            font-size: 0.95rem;
            line-height: 1.5;
            display: -webkit-box;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .history-actions {
            display: flex;
            gap: 0.75rem;
            margin-top: auto;
        }

        .btn-continue {
            background: rgba(229, 9, 20, 0.2);
            border: 1px solid rgba(229, 9, 20, 0.3);
            color: #e50914;
            padding: 0.5rem 1.5rem;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-continue:hover {
            background: #e50914;
            color: #fff;
        }

        .btn-remove {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #888;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-remove:hover {
            background: rgba(220, 53, 69, 0.2);
            border-color: rgba(220, 53, 69, 0.3);
            color: #dc3545;
        }

        .watched-date {
            font-size: 0.85rem;
            color: #666;
        }

        .empty-state {
            text-align: center;
            padding: 5rem 2rem;
        }

        .empty-icon {
            font-size: 5rem;
            color: #333;
            margin-bottom: 1.5rem;
        }

        .empty-title {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
        }

        .empty-text {
            color: #888;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .btn-browse {
            background: linear-gradient(135deg, #e50914 0%, #c20812 100%);
            border: none;
            color: #fff;
            padding: 0.875rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-browse:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(229, 9, 20, 0.5);
            color: #fff;
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

            .history-item {
                flex-direction: column;
            }

            .history-thumbnail {
                width: 100%;
            }

            .filter-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .filter-left {
                justify-content: center;
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
                        <li><a href="history" class="active">myHistory</a></li>
                        <li><a href="watchlist">myWatchList</a></li>
                        <li><a href="suggestions">browseSuggestions</a></li>
                    </ul>
                </div>
                <div class="nav-right">
                    <form action="search" method="get" class="search-box">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" name="q" class="search-input" 
                               placeholder="Search movies & series..." >
                    </form>
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
            <p class="page-subtitle">Track all the movies and series you've watched</p>
        </div>

        <div class="filter-bar">
            <div class="filter-left">
                <button class="filter-btn active" onclick="filterHistory('all')">All</button>
                <button class="filter-btn" onclick="filterHistory('movies')">Movies</button>
                <button class="filter-btn" onclick="filterHistory('series')">Series</button>
                <button class="filter-btn" onclick="filterHistory('week')">This Week</button>
                <button class="filter-btn" onclick="filterHistory('month')">This Month</button>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sample watch history data
        var historyData = [
            {
                id: 1,
                title: "Stranger Things",
                type: "series",
                year: 2023,
                rating: 8.7,
                progress: 65,
                watchedDate: "2024-10-28",
                episode: "S1E5",
                description: "When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces and one strange little girl."
            },
            {
                id: 2,
                title: "Oppenheimer",
                type: "movie",
                year: 2023,
                rating: 8.4,
                progress: 100,
                watchedDate: "2024-10-27",
                duration: "3h 0m",
                description: "The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb."
            },
            {
                id: 3,
                title: "The Last of Us",
                type: "series",
                year: 2023,
                rating: 8.9,
                progress: 45,
                watchedDate: "2024-10-26",
                episode: "S1E3",
                description: "After a global pandemic destroys civilization, a hardened survivor takes charge of a 14-year-old girl who may be humanity's last hope."
            },
            {
                id: 4,
                title: "The Batman",
                type: "movie",
                year: 2022,
                rating: 7.8,
                progress: 100,
                watchedDate: "2024-10-25",
                duration: "2h 56m",
                description: "When a sadistic serial killer begins murdering key political figures in Gotham, Batman is forced to investigate the city's hidden corruption."
            },
            {
                id: 5,
                title: "Breaking Bad",
                type: "series",
                year: 2008,
                rating: 9.5,
                progress: 80,
                watchedDate: "2024-10-24",
                episode: "S3E10",
                description: "A chemistry teacher diagnosed with cancer teams with a former student to manufacture methamphetamine to provide for his family."
            }
        ];

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

            var typeInfo = item.type === 'movie'
                ? item.duration
                : item.episode;

            historyItem.innerHTML =
                '<div class="history-thumbnail">' +
                    '<div class="play-icon-small">' +
                        '<i class="bi bi-play-fill"></i>' +
                    '</div>' +
                    '<div class="progress-overlay">' +
                        '<div class="progress-bar-custom" style="width: ' + item.progress + '%"></div>' +
                    '</div>' +
                '</div>' +
                '<div class="history-details">' +
                    '<div class="history-header">' +
                        '<div>' +
                            '<h3 class="history-title">' + item.title + '</h3>' +
                            '<div class="history-meta">' +
                                '<span><i class="bi bi-calendar"></i> ' + item.year + '</span>' +
                                '<span><i class="bi bi-star-fill" style="color: #ffc107;"></i> ' + item.rating + '</span>' +
                                '<span>' + typeInfo + '</span>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                    '<p class="history-description">' + item.description + '</p>' +
                    '<div class="watched-date">' +
                        '<i class="bi bi-clock"></i> Watched ' + formatDate(item.watchedDate) +
                        ' • ' + item.progress + '% complete' +
                    '</div>' +
                    '<div class="history-actions">' +
                        '<button class="btn-continue" onclick="continueWatching(' + item.id + ', event)">' +
                            '<i class="bi bi-play-circle"></i>' +
                            (item.progress === 100 ? 'Watch Again' : 'Continue Watching') +
                        '</button>' +
                        '<button class="btn-remove" onclick="removeFromHistory(' + item.id + ', event)">' +
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
                var index = historyData.findIndex(function(item) {
                    return item.id === id;
                });
                if (index !== -1) {
                    historyData.splice(index, 1);
                    filterHistory(currentFilter);
                }
            }
        }

        function clearAllHistory() {
            if (confirm('Are you sure you want to clear your entire watch history? This action cannot be undone.')) {
                historyData = [];
                loadHistory(historyData);
            }
        }


        // Load initial history
        loadHistory(historyData);
    </script>
</body>
</html>
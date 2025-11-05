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
    <title>Wovies - My Watchlist</title>
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

        .page-header {
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: start;
        }

        .header-left {
            flex: 1;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .title-icon {
            color: #e50914;
        }

        .page-subtitle {
            color: #888;
            font-size: 1rem;
        }

        .stats-box {
            background: linear-gradient(135deg, rgba(229, 9, 20, 0.1) 0%, rgba(229, 9, 20, 0.05) 100%);
            border: 1px solid rgba(229, 9, 20, 0.3);
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
        }

        .stats-number {
            font-size: 2rem;
            font-weight: 700;
            color: #e50914;
            margin-bottom: 0.25rem;
        }

        .stats-label {
            color: #888;
            font-size: 0.9rem;
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

        .sort-dropdown {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .sort-dropdown:focus {
            outline: none;
            border-color: #e50914;
        }

        .sort-dropdown option {
            background: #1a1a1a;
        }

        .favourites-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .favourite-card {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
        }

        .favourite-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.6);
            border-color: rgba(229, 9, 20, 0.5);
        }

        .card-poster {
            width: 100%;
            aspect-ratio: 2/3;
            background: linear-gradient(135deg, #2a2a2a 0%, #1a1a1a 100%);
            position: relative;
            overflow: hidden;
        }

        .favourite-badge {
            position: absolute;
            top: 0.75rem;
            right: 0.75rem;
            width: 40px;
            height: 40px;
            background: rgba(229, 9, 20, 0.95);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            color: #fff;
            z-index: 10;
        }

        .card-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(0deg, rgba(0,0,0,0.9) 0%, transparent 50%);
            opacity: 0;
            transition: opacity 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 1.5rem;
        }

        .favourite-card:hover .card-overlay {
            opacity: 1;
        }

        .overlay-actions {
            display: flex;
            gap: 0.5rem;
        }

        .btn-overlay {
            flex: 1;
            padding: 0.75rem;
            border-radius: 6px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }

        .btn-play-overlay {
            background: #e50914;
            color: #fff;
        }

        .btn-play-overlay:hover {
            background: #ff2a2a;
        }

        .btn-remove-overlay {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
        }

        .btn-remove-overlay:hover {
            background: rgba(220, 53, 69, 0.8);
        }

        .card-info {
            padding: 1rem;
        }

        .card-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #fff;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .card-meta {
            display: flex;
            gap: 0.75rem;
            font-size: 0.85rem;
            color: #888;
            margin-bottom: 0.5rem;
            flex-wrap: wrap;
        }

        .card-rating {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            color: #ffc107;
        }

        .added-date {
            font-size: 0.8rem;
            color: #666;
            margin-top: 0.5rem;
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

            .page-header {
                flex-direction: column;
                gap: 1.5rem;
            }

            .stats-box {
                width: 100%;
            }

            .favourites-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 1rem;
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
                        <li><a href="history">myHistory</a></li>
                        <li><a href="watchlist" class="active">myWatchList</a></li>
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
        <div class="page-header">
            <div class="header-left">
                <h1 class="page-title">
                    <i class="bi bi-bookmark-fill title-icon"></i>
                    My Watchlist
                </h1>
                <p class="page-subtitle">Movies and series you want to watch later</p>
            </div>
            <div class="stats-box">
                <div class="stats-number" id="totalFavourites">0</div>
                <div class="stats-label">In Watchlist</div>
            </div>
        </div>

        <div class="filter-bar">
            <div class="filter-left">
                <button class="filter-btn active" onclick="filterFavourites('all')">All</button>
                <button class="filter-btn" onclick="filterFavourites('movies')">Movies</button>
                <button class="filter-btn" onclick="filterFavourites('series')">Series</button>
                <button class="filter-btn" onclick="filterFavourites('unwatched')">Unwatched</button>
            </div>
            <select class="sort-dropdown" id="sortSelect" onchange="sortFavourites()">
                <option value="recent">Recently Added</option>
                <option value="title">Title (A-Z)</option>
                <option value="rating">Highest Rated</option>
                <option value="year">Newest First</option>
            </select>
        </div>

        <div class="favourites-grid" id="favouritesGrid">
            <!-- Favourite cards will be loaded here -->
        </div>

        <div class="empty-state" id="emptyState" style="display: none;">
            <div class="empty-icon">
                <i class="bi bi-bookmark"></i>
            </div>
            <h2 class="empty-title">Your Watchlist is Empty</h2>
            <p class="empty-text">Start adding movies and series you want to watch later</p>
            <a href="home" class="btn-browse">Discover Content</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sample favourites data
        var favouritesData = [
            {
                id: 1,
                title: "Stranger Things",
                type: "series",
                year: 2023,
                rating: 8.7,
                addedDate: "2024-10-25"
            },
            {
                id: 3,
                title: "Breaking Bad",
                type: "series",
                year: 2008,
                rating: 9.5,
                addedDate: "2024-10-20"
            },
            {
                id: 2,
                title: "Oppenheimer",
                type: "movie",
                year: 2023,
                rating: 8.4,
                addedDate: "2024-10-18"
            },
            {
                id: 7,
                title: "The Crown",
                type: "series",
                year: 2016,
                rating: 8.6,
                addedDate: "2024-10-15"
            },
            {
                id: 13,
                title: "Dune",
                type: "movie",
                year: 2021,
                rating: 8.0,
                addedDate: "2024-10-12"
            },
            {
                id: 10,
                title: "House of the Dragon",
                type: "series",
                year: 2022,
                rating: 8.5,
                addedDate: "2024-10-10"
            },
            {
                id: 14,
                title: "Top Gun: Maverick",
                type: "movie",
                year: 2022,
                rating: 8.3,
                addedDate: "2024-10-08"
            },
            {
                id: 8,
                title: "Better Call Saul",
                type: "series",
                year: 2015,
                rating: 9.0,
                addedDate: "2024-10-05"
            }
        ];

        var currentFilter = 'all';
        var currentSort = 'recent';

        function formatDate(dateString) {
            var date = new Date(dateString);
            var options = { month: 'short', day: 'numeric', year: 'numeric' };
            return date.toLocaleDateString('en-US', options);
        }

        function createFavouriteCard(item) {
            var card = document.createElement('div');
            card.className = 'favourite-card';

            var typeLabel = item.type === 'movie' ? 'Movie' : 'Series';

            card.innerHTML =
                '<div class="card-poster">' +
                    '<div class="favourite-badge">' +
                        '<i class="bi bi-heart-fill"></i>' +
                    '</div>' +
                    '<div class="card-overlay">' +
                        '<div class="overlay-actions">' +
                            '<button class="btn-overlay btn-play-overlay" onclick="watchContent(' + item.id + ', event)">' +
                                '<i class="bi bi-play-fill"></i> Watch' +
                            '</button>' +
                            '<button class="btn-overlay btn-remove-overlay" onclick="removeFromFavourites(' + item.id + ', event)">' +
                                '<i class="bi bi-heart-fill"></i>' +
                            '</button>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="card-info">' +
                    '<h3 class="card-title">' + item.title + '</h3>' +
                    '<div class="card-meta">' +
                        '<span>' + item.year + '</span>' +
                        '<span>•</span>' +
                        '<span>' + typeLabel + '</span>' +
                    '</div>' +
                    '<div class="card-rating">' +
                        '<i class="bi bi-star-fill"></i>' +
                        '<span>' + item.rating + '</span>' +
                    '</div>' +
                    '<div class="added-date">' +
                        'Added ' + formatDate(item.addedDate) +
                    '</div>' +
                '</div>';

            return card;
        }

        function loadFavourites(data) {
            var favouritesGrid = document.getElementById('favouritesGrid');
            var emptyState = document.getElementById('emptyState');
            var totalElement = document.getElementById('totalFavourites');

            totalElement.textContent = data.length;

            if (data.length === 0) {
                favouritesGrid.style.display = 'none';
                emptyState.style.display = 'block';
            } else {
                favouritesGrid.style.display = 'grid';
                emptyState.style.display = 'none';
                favouritesGrid.innerHTML = '';

                data.forEach(function(item) {
                    favouritesGrid.appendChild(createFavouriteCard(item));
                });
            }
        }

        function filterFavourites(type) {
            currentFilter = type;

            // Update active filter button
            var filterBtns = document.querySelectorAll('.filter-btn');
            filterBtns.forEach(function(btn) {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');

            applyFiltersAndSort();
        }

        function sortFavourites() {
            currentSort = document.getElementById('sortSelect').value;
            applyFiltersAndSort();
        }

        function applyFiltersAndSort() {
            var filtered = favouritesData;

            // Apply filter
            if (currentFilter === 'movies') {
                filtered = favouritesData.filter(function(item) {
                    return item.type === 'movie';
                });
            } else if (currentFilter === 'series') {
                filtered = favouritesData.filter(function(item) {
                    return item.type === 'series';
                });
            }

            // Apply sort
            var sorted = filtered.slice();
            if (currentSort === 'recent') {
                sorted.sort(function(a, b) {
                    return new Date(b.addedDate) - new Date(a.addedDate);
                });
            } else if (currentSort === 'title') {
                sorted.sort(function(a, b) {
                    return a.title.localeCompare(b.title);
                });
            } else if (currentSort === 'rating') {
                sorted.sort(function(a, b) {
                    return b.rating - a.rating;
                });
            } else if (currentSort === 'year') {
                sorted.sort(function(a, b) {
                    return b.year - a.year;
                });
            }

            loadFavourites(sorted);
        }

        function watchContent(id, event) {
            event.stopPropagation();
            window.location.href = 'watch?id=' + id;
        }

        function removeFromFavourites(id, event) {
            event.stopPropagation();
            if (confirm('Remove this from your favourites?')) {
                var index = favouritesData.findIndex(function(item) {
                    return item.id === id;
                });
                if (index !== -1) {
                    favouritesData.splice(index, 1);
                    applyFiltersAndSort();
                }
            }
        }

        // Search functionality
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                var searchTerm = this.value.trim();
                if (searchTerm) {
                    window.location.href = 'search?q=' + encodeURIComponent(searchTerm);
                }
            }
        });

        // Load initial favourites
        loadFavourites(favouritesData);
    </script>
</body>
</html>
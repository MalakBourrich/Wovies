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
    <title>Wovies - Search</title>
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
            text-shadow: 0 0 30px rgba(229, 9, 20, 0.3);
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
            width: 300px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            background: rgba(255, 255, 255, 0.08);
            border-color: #e50914;
            box-shadow: 0 0 0 3px rgba(229, 9, 20, 0.1);
            outline: none;
            width: 350px;
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

        .search-header {
            margin-bottom: 2rem;
        }

        .search-title {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .search-subtitle {
            color: #888;
            font-size: 1rem;
        }

        .search-query {
            color: #e50914;
            font-weight: 600;
        }

        .filters-section {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.8) 0%, rgba(20, 20, 20, 0.9) 100%);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .filter-row {
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .filter-label {
            font-size: 0.9rem;
            color: #888;
            font-weight: 600;
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

        .results-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .movie-card {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            overflow: hidden;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .movie-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.6);
            border-color: rgba(229, 9, 20, 0.5);
        }

        .movie-poster {
            width: 100%;
            aspect-ratio: 2/3;
            background: linear-gradient(135deg, #2a2a2a 0%, #1a1a1a 100%);
            position: relative;
            overflow: hidden;
        }

        .movie-poster img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .play-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .movie-card:hover .play-overlay {
            opacity: 1;
        }

        .play-icon {
            width: 60px;
            height: 60px;
            background: rgba(229, 9, 20, 0.9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: #fff;
        }

        .movie-info {
            padding: 1rem;
        }

        .movie-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #fff;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .movie-meta {
            display: flex;
            gap: 0.75rem;
            font-size: 0.85rem;
            color: #888;
            margin-bottom: 0.5rem;
        }

        .movie-type {
            background: rgba(229, 9, 20, 0.1);
            color: #e50914;
            padding: 0.15rem 0.5rem;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .movie-rating {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            color: #ffc107;
        }

        .no-results {
            text-align: center;
            padding: 4rem 2rem;
        }

        .no-results-icon {
            font-size: 4rem;
            color: #333;
            margin-bottom: 1rem;
        }

        .no-results-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .no-results-text {
            color: #888;
            font-size: 1rem;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .search-input {
                width: 200px;
            }

            .search-input:focus {
                width: 220px;
            }

            .results-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 1rem;
            }

            .filter-row {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar-custom">
        <div class="container">
            <div class="navbar-content">
                <div class="nav-left">
                    <div class="logo" onclick="window.location.href='index'">WOVIES</div>
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
        <div class="search-header">
            <h1 class="search-title">Search Results</h1>
            <p class="search-subtitle">
                Found <span id="resultCount">12</span> results for "<span class="search-query" id="searchQuery">stranger things</span>"
            </p>
        </div>

        <div class="filters-section">
            <div class="filter-row">
                <span class="filter-label">Filter by:</span>
                <button class="filter-btn active" onclick="filterContent('all')">All</button>
                <button class="filter-btn" onclick="filterContent('movie')">Movies</button>
                <button class="filter-btn" onclick="filterContent('series')">Series</button>
                <button class="filter-btn" onclick="filterContent('recent')">Recently Added</button>
            </div>
        </div>

        <div class="results-grid" id="resultsGrid">
            <!-- Results will be loaded here -->
        </div>

        <div class="no-results" id="noResults" style="display: none;">
            <div class="no-results-icon">
                <i class="bi bi-search"></i>
            </div>
            <h2 class="no-results-title">No results found</h2>
            <p class="no-results-text">Try searching with different keywords</p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sample movie/series data
        const contentData = [
            { id: 1, title: "Stranger Things", year: 2023, type: "series", rating: 8.7, seasons: 4 },
            { id: 2, title: "The Last of Us", year: 2023, type: "series", rating: 8.9, seasons: 1 },
            { id: 3, title: "Breaking Bad", year: 2008, type: "series", rating: 9.5, seasons: 5 },
            { id: 4, title: "The Batman", year: 2022, type: "movie", rating: 7.8, duration: "2h 56m" },
            { id: 5, title: "Oppenheimer", year: 2023, type: "movie", rating: 8.4, duration: "3h 0m" },
            { id: 6, title: "Avatar: The Way of Water", year: 2022, type: "movie", rating: 7.6, duration: "3h 12m" },
            { id: 7, title: "Wednesday", year: 2022, type: "series", rating: 8.1, seasons: 1 },
            { id: 8, title: "The Crown", year: 2016, type: "series", rating: 8.6, seasons: 6 },
            { id: 9, title: "Dune", year: 2021, type: "movie", rating: 8.0, duration: "2h 35m" },
            { id: 10, title: "Better Call Saul", year: 2015, type: "series", rating: 9.0, seasons: 6 },
            { id: 11, title: "Top Gun: Maverick", year: 2022, type: "movie", rating: 8.3, duration: "2h 10m" },
            { id: 12, title: "The Mandalorian", year: 2019, type: "series", rating: 8.7, seasons: 3 }
        ];

        let currentFilter = 'all';
        let currentResults = [...contentData];

        // Get search query from URL
        function getSearchQuery() {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get('q') || '';
        }

        // Initialize search
        function initSearch() {
            const query = getSearchQuery();
            document.getElementById('searchInput').value = query;
            document.getElementById('searchQuery').textContent = query;

            // Filter results based on search query
            if (query) {
                currentResults = contentData.filter(item =>
                    item.title.toLowerCase().includes(query.toLowerCase())
                );
            }

            displayResults();
        }

        // Display results
        function displayResults() {
            const resultsGrid = document.getElementById('resultsGrid');
            const noResults = document.getElementById('noResults');

            if (currentResults.length === 0) {
                resultsGrid.style.display = 'none';
                noResults.style.display = 'block';
                document.getElementById('resultCount').textContent = '0';
                return;
            }

            resultsGrid.style.display = 'grid';
            noResults.style.display = 'none';
            document.getElementById('resultCount').textContent = currentResults.length;

            resultsGrid.innerHTML = currentResults.map(function(item) {
                var typeLabel = item.type === 'movie' ? 'Movie' : 'Series';
                var metaInfo = item.type === 'series'
                    ? item.seasons + ' Season' + (item.seasons > 1 ? 's' : '')
                    : item.duration;

                return '<div class="movie-card" onclick="openContent(' + item.id + ')">' +
                    '<div class="movie-poster">' +
                        '<div class="play-overlay">' +
                            '<div class="play-icon">' +
                                '<i class="bi bi-play-fill"></i>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="movie-info">' +
                        '<h3 class="movie-title">' + item.title + '</h3>' +
                        '<div class="movie-meta">' +
                            '<span class="movie-type">' + typeLabel + '</span>' +
                            '<span>' + item.year + '</span>' +
                            '<span>' + metaInfo + '</span>' +
                        '</div>' +
                        '<div class="movie-rating">' +
                            '<i class="bi bi-star-fill"></i>' +
                            '<span>' + item.rating + '</span>' +
                        '</div>' +
                    '</div>' +
                '</div>';
            }).join('');
        }

        // Filter content
        function filterContent(type) {
            currentFilter = type;

            // Update active filter button
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');

            // Filter results
            const query = getSearchQuery();
            let filtered = contentData;

            if (query) {
                filtered = filtered.filter(item =>
                    item.title.toLowerCase().includes(query.toLowerCase())
                );
            }

            if (type !== 'all' && type !== 'recent') {
                filtered = filtered.filter(item => item.type === type);
            }

            if (type === 'recent') {
                filtered = filtered.filter(item => item.year >= 2022);
            }

            currentResults = filtered;
            displayResults();
        }

        // Open content
        function openContent(id) {
            window.location.href = 'watch?id=' + id;
        }

        // Search functionality
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                const searchTerm = this.value.trim();
                if (searchTerm) {
                    window.location.href = 'search?q=' + encodeURIComponent(searchTerm);
                }
            }
        });

        // Initialize on page load
        initSearch();
    </script>
</body>
</html>
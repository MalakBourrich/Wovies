<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Wovies - Stream Unlimited</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #0a0a0a;
            color: #e5e5e5;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            overflow-x: hidden;
        }

        .navbar-custom {
            background: transparent;
            padding: 0;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            transition: background 0.3s ease;
        }

        .navbar-custom.scrolled {
            background: rgba(10, 10, 10, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.5);
        }

        .navbar-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.5rem 0;
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

        .hero-section {
            position: relative;
            height: 85vh;
            display: flex;
            align-items: center;
            background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
            overflow: hidden;
        }

        .hero-bg {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(90deg, rgba(10,10,10,0.9) 0%, rgba(10,10,10,0.3) 50%, rgba(10,10,10,0.9) 100%),
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800"><rect fill="%23222" width="1200" height="800"/></svg>');
            background-size: cover;
            background-position: center;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 650px;
        }

        .hero-badge {
            display: inline-block;
            background: rgba(229, 9, 20, 0.2);
            border: 1px solid rgba(229, 9, 20, 0.5);
            color: #e50914;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .hero-title {
            font-size: 4rem;
            font-weight: 900;
            line-height: 1.1;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #fff 0%, #b3b3b3 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero-description {
            font-size: 1.2rem;
            color: #b3b3b3;
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .hero-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn-play {
            background: linear-gradient(135deg, #e50914 0%, #c20812 100%);
            border: none;
            color: #fff;
            padding: 1rem 2.5rem;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(229, 9, 20, 0.3);
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
        }

        .btn-play:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(229, 9, 20, 0.5);
            color: #fff;
        }

        .btn-info {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            padding: 1rem 2.5rem;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
        }

        .btn-info:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
            color: #fff;
        }

        .content-section {
            padding: 4rem 0;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.75rem;
            font-weight: 700;
        }

        .view-all {
            color: #e50914;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: color 0.3s ease;
        }

        .view-all:hover {
            color: #ff2a2a;
        }

        .content-carousel {
            display: flex;
            gap: 1rem;
            overflow-x: auto;
            scroll-behavior: smooth;
            padding-bottom: 1rem;
        }

        .content-carousel::-webkit-scrollbar {
            height: 8px;
        }

        .content-carousel::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 4px;
        }

        .content-carousel::-webkit-scrollbar-thumb {
            background: #e50914;
            border-radius: 4px;
        }

        .content-card {
            min-width: 280px;
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            overflow: hidden;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .content-card:hover {
            transform: translateY(8px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.6);
            border-color: rgba(229, 9, 20, 0.5);
        }

        .content-poster {
            width: 100%;
            aspect-ratio: 16/9;
            background: linear-gradient(135deg, #2a2a2a 0%, #1a1a1a 100%);
            position: relative;
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

        .content-card:hover .play-overlay {
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

        .content-info {
            padding: 1rem;
        }

        .content-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #fff;
        }

        .content-meta {
            display: flex;
            gap: 0.75rem;
            font-size: 0.85rem;
            color: #888;
            margin-bottom: 0.5rem;
        }

        .content-rating {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            color: #ffc107;
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

            .hero-title {
                font-size: 2.5rem;
            }

            .hero-description {
                font-size: 1rem;
            }

            .hero-buttons {
                flex-direction: column;
            }

            .btn-play, .btn-info {
                width: 100%;
                justify-content: center;
            }

            .content-card {
                min-width: 220px;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar-custom" id="navbar">
        <div class="container">
            <div class="navbar-content">
                <div class="nav-left">
                    <div class="logo" onclick="window.location.href='home.jsp'">WOVIES</div>
                    <ul class="nav-links">
                        <li><a href="home" class="active">Home</a></li>
                        <li><a href="history">myHistory</a></li>
                        <li><a href="favourites">myFavourites</a></li>
                        <li><a href="suggestions">browseSuggestions</a></li>
                    </ul>
                </div>
                <div class="nav-right">
                    <div class="search-box">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" class="search-input" placeholder="Search movies & series..." id="searchInput">
                    </div>
                    <a href="account.jsp" class="btn-account">
                        <i class="bi bi-person-circle"></i>
                        <span>Account</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <section class="hero-section">
        <div class="hero-bg"></div>
        <div class="container">
            <div class="hero-content">
                <div class="hero-badge">
                    <i class="bi bi-star-fill"></i> Featured
                </div>
                <h1 class="hero-title">Stranger Things</h1>
                <p class="hero-description">
                    When a young boy vanishes, a small town uncovers a mystery involving secret experiments,
                    terrifying supernatural forces and one strange little girl.
                </p>
                <div class="hero-buttons">
                    <a href="watch.jsp?id=1" class="btn-play">
                        <i class="bi bi-play-fill"></i>
                        Play Now
                    </a>
                    <a href="#" class="btn-info">
                        <i class="bi bi-info-circle"></i>
                        More Info
                    </a>
                </div>
            </div>
        </div>
    </section>

    <div class="container content-section">
        <div class="section-header">
            <h2 class="section-title">Trending Now</h2>
            <a href="movies.jsp" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="content-carousel" id="trendingCarousel"></div>
    </div>

    <div class="container content-section">
        <div class="section-header">
            <h2 class="section-title">Popular Series</h2>
            <a href="series.jsp" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="content-carousel" id="seriesCarousel"></div>
    </div>

    <div class="container content-section">
        <div class="section-header">
            <h2 class="section-title">New Releases</h2>
            <a href="movies.jsp" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="content-carousel" id="newCarousel"></div>
    </div>

    <div class="container content-section">
        <div class="section-header">
            <h2 class="section-title">Continue Watching</h2>
            <a href="mylist.jsp" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="content-carousel" id="continueCarousel"></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sample content data
        var contentData = {
            trending: [
                { id: 1, title: "The Last of Us", year: 2023, rating: 8.9, type: "series" },
                { id: 2, title: "Oppenheimer", year: 2023, rating: 8.4, type: "movie" },
                { id: 3, title: "Breaking Bad", year: 2008, rating: 9.5, type: "series" },
                { id: 4, title: "The Batman", year: 2022, rating: 7.8, type: "movie" },
                { id: 5, title: "Wednesday", year: 2022, rating: 8.1, type: "series" },
                { id: 6, title: "Avatar: The Way of Water", year: 2022, rating: 7.6, type: "movie" }
            ],
            series: [
                { id: 7, title: "The Crown", year: 2016, rating: 8.6, type: "series" },
                { id: 8, title: "Better Call Saul", year: 2015, rating: 9.0, type: "series" },
                { id: 9, title: "The Mandalorian", year: 2019, rating: 8.7, type: "series" },
                { id: 10, title: "House of the Dragon", year: 2022, rating: 8.5, type: "series" },
                { id: 11, title: "The Witcher", year: 2019, rating: 8.0, type: "series" },
                { id: 12, title: "Stranger Things", year: 2016, rating: 8.7, type: "series" }
            ],
            newReleases: [
                { id: 13, title: "Dune", year: 2021, rating: 8.0, type: "movie" },
                { id: 14, title: "Top Gun: Maverick", year: 2022, rating: 8.3, type: "movie" },
                { id: 15, title: "Everything Everywhere", year: 2022, rating: 7.8, type: "movie" },
                { id: 16, title: "The Menu", year: 2022, rating: 7.2, type: "movie" },
                { id: 17, title: "Glass Onion", year: 2022, rating: 7.2, type: "movie" },
                { id: 18, title: "M3GAN", year: 2023, rating: 6.4, type: "movie" }
            ],
            continue: [
                { id: 1, title: "Stranger Things", year: 2023, rating: 8.7, type: "series", progress: 65 },
                { id: 19, title: "The Night Agent", year: 2023, rating: 7.5, type: "series", progress: 40 },
                { id: 20, title: "Yellowstone", year: 2018, rating: 8.7, type: "series", progress: 80 },
                { id: 21, title: "Dark", year: 2017, rating: 8.8, type: "series", progress: 25 }
            ]
        };

        function createContentCard(item) {
            var card = document.createElement('div');
            card.className = 'content-card';
            card.onclick = function() { openContent(item.id); };

            var typeLabel = item.type === 'movie' ? 'Movie' : 'Series';

            card.innerHTML =
                '<div class="content-poster">' +
                    '<div class="play-overlay">' +
                        '<div class="play-icon">' +
                            '<i class="bi bi-play-fill"></i>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="content-info">' +
                    '<div class="content-title">' + item.title + '</div>' +
                    '<div class="content-meta">' +
                        '<span>' + item.year + '</span>' +
                        '<span>•</span>' +
                        '<span>' + typeLabel + '</span>' +
                    '</div>' +
                    '<div class="content-rating">' +
                        '<i class="bi bi-star-fill"></i>' +
                        '<span>' + item.rating + '</span>' +
                    '</div>' +
                '</div>';

            return card;
        }

        function loadCarousel(carouselId, data) {
            var carousel = document.getElementById(carouselId);
            carousel.innerHTML = '';

            data.forEach(function(item) {
                carousel.appendChild(createContentCard(item));
            });
        }

        function openContent(id) {
            window.location.href = 'watch.jsp?id=' + id;
        }

        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            var navbar = document.getElementById('navbar');
            if (window.scrollY > 100) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Search functionality
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                var searchTerm = this.value.trim();
                if (searchTerm) {
                    window.location.href = 'search.jsp?q=' + encodeURIComponent(searchTerm);
                }
            }
        });

        // Load all carousels
        loadCarousel('trendingCarousel', contentData.trending);
        loadCarousel('seriesCarousel', contentData.series);
        loadCarousel('newCarousel', contentData.newReleases);
        loadCarousel('continueCarousel', contentData.continue);
    </script>
</body>
</html>
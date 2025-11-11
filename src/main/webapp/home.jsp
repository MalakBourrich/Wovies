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
    <title>Wovies - Stream Unlimited</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/home.css">
</head>
<body>
    <nav class="navbar-custom" id="navbar">
        <div class="container">
            <div class="navbar-content">
                <div class="nav-left">
                    <div class="logo" onclick="window.location.href='home'">WOVIES</div>
                    <ul class="nav-links">
                        <li><a href="home" class="active">Home</a></li>
                        <li><a href="history">myHistory</a></li>
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
                    <a href="watch?id=1" class="btn-play">
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
            <a href="movies" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="content-carousel" id="trendingCarousel"></div>
    </div>

    <div class="container content-section">
        <div class="section-header">
            <h2 class="section-title">Popular Series</h2>
            <a href="series" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="content-carousel" id="seriesCarousel"></div>
    </div>

    <div class="container content-section">
        <div class="section-header">
            <h2 class="section-title">New Releases</h2>
            <a href="movies" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="content-carousel" id="newCarousel"></div>
    </div>

    <div class="container content-section">
        <div class="section-header">
            <h2 class="section-title">Continue Watching</h2>
            <a href="mylist" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
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
            window.location.href = 'watch?id=' + id;
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


        // Load all carousels
        loadCarousel('trendingCarousel', contentData.trending);
        loadCarousel('seriesCarousel', contentData.series);
        loadCarousel('newCarousel', contentData.newReleases);
        loadCarousel('continueCarousel', contentData.continue);
    </script>
</body>
</html>
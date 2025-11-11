<%@ page import="com.google.gson.Gson" %>
<%@ page import="model.Home" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login");
        return;
    }
    Home home = new Home();%>
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
                        <li><a href="history">History</a></li>
                        <li><a href="watchlist">Watch List</a></li>
                    </ul>
                </div>
                <div class="nav-right">
                    <form action="search" method="get" class="search-box">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" class="search-input" placeholder="Search movies & series..." id="searchInput">
                    </div>
                    <a href="${pageContext.request.contextPath}/account" class="btn-account">
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


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>

            var contentData = {
            trending: <%= new Gson().toJson(home.getTrendings()) %>,
            series: <%= new Gson().toJson(home.getVideos()) %>,
            newReleases: <%= new Gson().toJson(home.getFeatures()) %>
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
    </script>
</body>
</html>
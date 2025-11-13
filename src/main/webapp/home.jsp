<%@ page import="model.Video" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Home" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login");
        return;
    }

    Home home = (Home) request.getAttribute("home");
    Home featured = home.getFeatured();
    List<Home> trendingVideos = home.getTrendings();
    List<Home> popularMovies = home.getPopularMovies();
    List<Home> newReleases = home.getNewReleases();
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
                        <li><a href="history">History</a></li>
                        <li><a href="watchlist">WatchList</a></li>
                    </ul>
                </div>
                <div class="nav-right">
                    <form action="search" method="get" class="search-box">
                        <i class="bi bi-search search-icon"></i>
                        <input name = "q" type="text" class="search-input" placeholder="Search movies & series..." id="searchInput">
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
        <div class="hero-bg" style="background-image: linear-gradient(90deg, rgba(10,10,10,0.9) 0%, rgba(10,10,10,0.3) 50%, rgba(10,10,10,0.9) 100%), url('https://assets.nflxext.com/ffe/siteui/vlv3/e94073b0-a056-402f-9015-16cb1e7e45c2/web/MA-fr-20251110-TRIFECTA-perspective_72f214d5-2eff-45e2-824e-36148145c2c7_large.jpg');"></div>
        <div class="container">
            <div class="hero-content">
                <div class="hero-badge">
                    <i class="bi bi-star-fill"></i> Featured
                </div>
                <h1 class="hero-title"><%= featured.getVideoTitle() %></h1>
                <p class="hero-description">
                    <%= featured.getDescription()%>
                </p>
                <div class="hero-buttons">
                    <a href="watch?homeId=1" class="btn-play">
                        <i class="bi bi-play-fill"></i>
                        Play Now
                    </a>
                    <a href="watch?homeId=1" class="btn-info">
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
            <a href="search" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="content-carousel" id="trendingCarousel">

            <% for(Home video : trendingVideos) { 
                    String typeLabel = video.getVideoType() != null ? video.getVideoType() : "";
                    String rating = video.getVideoRating() != null ? String.valueOf(video.getVideoRating()) : "N/A";
                    String year = video.getVideoYear() != null ? String.valueOf(video.getVideoYear()) : "";
            %>
                <div class="item">
                    <div class="content-poster" role="button" tabindex="0" aria-label="Play <%= video.getVideoTitle() %>"
                         style="background-image: url('<%= video.getImageUrl() %>');"
                         onclick="window.location.href='watch?homeId=<%= video.getId() %>'"
                         onkeypress="if(event.key === 'Enter'){ window.location.href='watch?homeId=<%= video.getId() %>';}">
                        <div class="play-overlay">
                            <div class="play-icon">
                                <i class="bi bi-play-fill"></i>
                            </div>
                        </div>
                    </div>
                    <div class="content-info">
                        <div class="content-title"><%= video.getVideoTitle() %></div>
                        <div class="content-meta">
                            <span><%= year %></span>
                            <span>•</span>
                            <span><%= typeLabel %></span>
                        </div>
                        <div class="content-rating">
                            <i class="bi bi-star-fill"></i>
                            <span><%= rating %></span>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <div class="container content-section">
        <div class="section-header">
            <h2 class="section-title">Popular Movies</h2>
            <a href="search" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="content-carousel" id="seriesCarousel">
            <% for(Home video : popularMovies) { 
                    String typeLabel = video.getVideoType() != null ? video.getVideoType() : "";
                    String rating = video.getVideoRating() != null ? String.valueOf(video.getVideoRating()) : "N/A";
                    String year = video.getVideoYear() != null ? String.valueOf(video.getVideoYear()) : "";
            %>
                <div class="item">
                    <div class="content-poster" role="button" tabindex="0" aria-label="Play <%= video.getVideoTitle() %>"
                         style="background-image: url('<%= video.getImageUrl() %>');"
                         onclick="window.location.href='watch?homeId=<%= video.getId() %>'"
                         onkeypress="if(event.key === 'Enter'){ window.location.href='watch?homeId=<%= video.getId() %>';}">
                        <div class="play-overlay">
                            <div class="play-icon">
                                <i class="bi bi-play-fill"></i>
                            </div>
                        </div>
                    </div>
                    <div class="content-info">
                        <div class="content-title"><%= video.getVideoTitle() %></div>
                        <div class="content-meta">
                            <span><%= year %></span>
                            <span>•</span>
                            <span><%= typeLabel %></span>
                        </div>
                        <div class="content-rating">
                            <i class="bi bi-star-fill"></i>
                            <span><%= rating %></span>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <div class="container content-section">
        <div class="section-header">
            <h2 class="section-title">New Releases</h2>
            <a href="search" class="view-all">View All <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="content-carousel" id="newCarousel">
            <% for(Home video : newReleases) { 
                    String typeLabel = video.getVideoType() != null ? video.getVideoType() : "";
                    String rating = video.getVideoRating() != null ? String.valueOf(video.getVideoRating()) : "N/A";
                    String year = video.getVideoYear() != null ? String.valueOf(video.getVideoYear()) : "";
            %>
                <div class="item">
                    <div class="content-poster" role="button" tabindex="0" aria-label="Play <%= video.getVideoTitle() %>"
                         style="background-image: url('<%= video.getImageUrl() %>');"
                         onclick="window.location.href='watch?homeId=<%= video.getId() %>'"
                         onkeypress="if(event.key === 'Enter'){ window.location.href='watch?homeId=<%= video.getId() %>';}">
                        <div class="play-overlay">
                            <div class="play-icon">
                                <i class="bi bi-play-fill"></i>
                            </div>
                        </div>
                    </div>
                    <div class="content-info">
                        <div class="content-title"><%= video.getVideoTitle() %></div>
                        <div class="content-meta">
                            <span><%= year %></span>
                            <span>•</span>
                            <span><%= typeLabel %></span>
                        </div>
                        <div class="content-rating">
                            <i class="bi bi-star-fill"></i>
                            <span><%= rating %></span>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
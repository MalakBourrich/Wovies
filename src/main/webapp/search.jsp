<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Video" %>
<%@ page import="model.Movie" %>
<%@ page import="model.Series" %>
<%@ page import="Service.SearchService" %>

<%
    List<Video> searchResults = (List<Video>) request.getAttribute("searchResults");
    SearchService searchService = (SearchService) request.getAttribute("searchService");
    String error = (String) request.getAttribute("error");
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
    <link rel="stylesheet" href="./css/search.css">
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
                    <form action="search" method="get" class="search-box">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" name="q" class="search-input" 
                               placeholder="Search movies & series..." 
                               value="<%= searchService != null ? searchService.getCurrentQuery() : "" %>">
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
        <div class="search-header">
            <h1 class="search-title">Search Results</h1>
            <% if (searchService != null) { %>
            <p class="search-subtitle">
                Found <%= searchService.getResultCount() %> results for "<%= searchService.getCurrentQuery() %>"
            </p>
            <% } %>
        </div>

        <div class="filters-section">
            <div class="filter-row">
                <span class="filter-label">Filter by:</span>
                <form action="search" method="get" class="filter-form">
                    <input type="hidden" name="q" value="<%= searchService != null ? searchService.getCurrentQuery() : "" %>">
                    <% 
                        String[] filters = {"all", "movie", "series", "recent"};
                        String[] filterLabels = {"All", "Movies", "Series", "Recently Added"};
                        String currentFilter = searchService != null ? searchService.getCurrentFilter() : "all";
                        
                        for (int i = 0; i < filters.length; i++) {
                            String filter = filters[i];
                            String label = filterLabels[i];
                            boolean isActive = filter.equals(currentFilter);
                    %>
                        <button type="submit" name="filter" value="<%= filter %>" 
                                class="filter-btn <%= isActive ? "active" : "" %>">
                            <%= label %>
                        </button>
                    <% } %>
                </form>
            </div>
        </div>

        <% if (searchResults != null && !searchResults.isEmpty()) { %>
                <div class="results-grid">
                <%
                    for (Video video : searchResults) {
                        String typeLabel = video.getType().equals("movie") ? "Movie" : "Series";
                        String metaInfo;
                        if (video instanceof Series) {
                            Series series = (Series) video;
                            metaInfo = series.getNumberOfSeasons() + " Season" + 
                                    (series.getNumberOfSeasons() > 1 ? "s" : "");
                        } else if (video instanceof Movie) {
                            Movie movie = (Movie) video;
                            metaInfo = movie.getDuration();
                        } else {
                            metaInfo = "N/A";
                        }
                %>
<form action="watch" method="GET" class="movie-card-form" style="display: block; text-decoration: none;">
    <input type="hidden" name="id" value="<%= video.getId() %>">
    <input type="hidden" name="type" value="<%= video.getType() %>">
    
    <button type="submit" class="movie-card" style="all: unset; cursor: pointer; display: block; width: 100%;">
        <div class="movie-poster" style="background-image: url('<%= video.getImageUrl() %>');">
            <div class="play-overlay">
                <div class="play-icon">
                    <i class="bi bi-play-fill"></i>
                </div>
            </div>
        </div>
        <div class="movie-info">
            <h3 class="movie-title"><%= video.getTitle() %></h3>
            <div class="movie-meta">
                <span class="movie-type"><%= typeLabel %></span>
                <span><%= video.getUplaodDate().split("-")[0] %></span>
                <span><%= metaInfo %></span>
            </div>
            <div class="movie-rating">
                <i class="bi bi-star-fill"></i>
                <span><%= video.getRating() %>/10</span>
            </div>
        </div>
    </button>
</form>

<style>
    /* Additional CSS to ensure the form/button behaves like the original link */
    .movie-card-form {
        margin: 0;
        padding: 0;
    }

    .movie-card-form .movie-card {
        text-align: left;
        color: inherit;
        background: none;
        border: none;
        padding: 0;
        font: inherit;
    }
</style>
                <% 
                    }
                %>
                </div>
            <%
            } else { 
            %>
                <div class="results-grid" style="display:flex;flex-direction: column;">
                    <div class="no-results" id="noResults">
                        <div class="no-results-icon">
                            <i class="bi bi-search"></i>
                        </div>
                        <% 
                            if (error != null) {
                        %>
                            <h2 class="no-results-title"><%= error %></h2>
                            <p class="no-results-text">Try searching with different keywords</p>
                        <% } %>
                    </div>
                </div>
            <% } %>
        

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
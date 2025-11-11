<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="model.WatchListItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDateTime" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login");
        return;
    }
    List<WatchListItem> watchlistItems = (List<WatchListItem>) request.getAttribute("watchlistItems");
    int totalItems = watchlistItems != null ? watchlistItems.size() : 0;
    
%>
<html>
<head>
    <title>Wovies - My Watchlist</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/watchlist.css">
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
            <div class="header-left">
                <h1 class="page-title">
                    <i class="bi bi-bookmark-fill title-icon"></i>
                    My Watchlist
                </h1>
                <p class="page-subtitle">Movies and series you want to watch later</p>
            </div>
            <div class="stats-box">
                <div class="stats-number" id="totalFavourites"><%= totalItems %></div>
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
            <%
                if (watchlistItems != null && watchlistItems.size() > 0) {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d, yyyy");
                    for (WatchListItem item : watchlistItems) {
                        String typeLabel = "series".equals(item.getVideoType()) ? "Series" : "Movie";
                        String addedDate = item.getAddedDate() != null 
                            ? dateFormat.format(item.getAddedDate()) 
                            : "Unknown date";
            %>
                <div class="favourite-card">
                    <div class="card-poster" <%
                        if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) {
                            out.print("style=\"background-image: url('" + item.getImageUrl() + "');\"");
                        } else {
                            out.print("style=\"background-color: #333;\"");
                        }
                    %>>
                        <div class="favourite-badge">
                            <i class="bi bi-heart-fill"></i>
                        </div>
                        <div class="card-overlay">
                            <div class="overlay-actions">
                                <button class="btn-overlay btn-play-overlay" 
                                        onclick="watchContent('<%= item.getId() %>', event)">
                                    <i class="bi bi-play-fill"></i> Watch
                                </button>
                                <button class="btn-overlay btn-remove-overlay" 
                                        onclick="removeFromFavourites('<%= item.getId() %>', event)">
                                    <i class="bi bi-trash-fill"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="card-info">
                        <h3 class="card-title"><%= item.getVideoTitle() != null ? item.getVideoTitle() : "Unknown Title" %></h3>
                        <div class="card-meta">
                            <span><%= item.getVideoYear() != null ? item.getVideoYear() : "N/A" %></span>
                            <span>•</span>
                            <span><%= item.getVideoType() %></span>
                        </div>
                        <div class="card-rating">
                            <i class="bi bi-star-fill"></i>
                            <span><%= item.getVideoRating() != null ? item.getVideoRating() : "N/A" %></span>
                        </div>
                        <div class="added-date">
                            Added <%= addedDate %>
                        </div>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="empty-state" style="display: block; grid-column: 1 / -1;">
                    <div class="empty-icon">
                        <i class="bi bi-bookmark"></i>
                    </div>
                    <h2 class="empty-title">Your Watchlist is Empty</h2>
                    <p class="empty-text">Start adding movies and series you want to watch later</p>
                    <a href="home" class="btn-browse">Discover Content</a>
                </div>
            <%
                }
            %>
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
        function filterFavourites(filterType) {
            // Update active filter button
            var filterBtns = document.querySelectorAll('.filter-btn');
            filterBtns.forEach(function(btn) {
                btn.classList.remove('active');
                if (btn.textContent.toLowerCase().replace(/\s+/g, '') === filterType.toLowerCase()) {
                    btn.classList.add('active');
                }
            });
            
            // Get current sort parameter if exists
            var sortParam = new URLSearchParams(window.location.search).get('sort') || '';
            var href = '?filter=' + filterType;
            if (sortParam) {
                href += '&sort=' + sortParam;
            }
            window.location.href = href;
        }

        function sortFavourites() {
            var sortValue = document.getElementById('sortSelect').value;
            var filterParam = new URLSearchParams(window.location.search).get('filter') || 'all';
            window.location.href = '?filter=' + filterParam + '&sort=' + sortValue;
        }

        function watchContent(videoId, event) {
            event.stopPropagation();
            window.location.href = 'watch?watchListId=' + encodeURIComponent(videoId);
        }

        function removeFromFavourites(videoId, event) {
            event.stopPropagation();
            if (confirm('Remove this from your watchlist?')) {
                // Create and submit form
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = 'watchlist';
                
                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'remove';
                
                var linkInput = document.createElement('input');
                linkInput.type = 'hidden';
                linkInput.name = 'videoId';
                linkInput.value = videoId;
                
                form.appendChild(actionInput);
                form.appendChild(linkInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Set active filter button on page load
        document.addEventListener('DOMContentLoaded', function() {
            var filterParam = new URLSearchParams(window.location.search).get('filter') || 'all';
            var filterBtns = document.querySelectorAll('.filter-btn');
            filterBtns.forEach(function(btn) {
                btn.classList.remove('active');
                var btnFilter = btn.textContent.toLowerCase().replace(/\s+/g, '');
                if (btnFilter === filterParam.toLowerCase().replace(/\s+/g, '')) {
                    btn.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>
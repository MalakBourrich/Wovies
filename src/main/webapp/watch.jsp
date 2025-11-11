<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="Model.Video" %>
<%@ page import="Model.Movie" %>
<%@ page import="Model.Series" %>
<%@ page import="Model.Server" %>
<%@ page import="java.util.List" %>
<%
    String email = (String) session.getAttribute("email");
    Video video = (Video) request.getAttribute("video");
    String fromWatchList = (String) request.getAttribute("fromWatchList");
    List<Server> servers = (List<Server>) request.getAttribute("servers");
    String currentServer = (String) request.getAttribute("currentServer");
    
    // if (email == null) {
    //     response.sendRedirect("login");
    //     return;
    // }
    if (video == null) {
        response.sendRedirect("search?q=");
        return;
    }
%>
<html>
<head>
    <title>Wovies - Watch</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="./css/watch.css">
    
</head>
<body>
    <nav class="navbar-custom">
        <div class="container">
            <div class="navbar-content">
                <div class="nav-left">
                    <div class="logo">WOVIES</div>
                    <ul class="nav-links">
                        <li><a href="home">Home</a></li>
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

    <div class="container content-wrapper">
        <div class="row g-4">
            <div class="col-lg-8">
                <div class="video-container">
                    <%
                        String videoUrl = "";
                        if (servers != null && !servers.isEmpty()) {
                            if (currentServer != null) {
                                videoUrl = servers.stream()
                                    .filter(s -> s.getName().equals(currentServer))
                                    .findFirst()
                                    .map(Server::getUrl)
                                    .orElse("");
                            }
                            
                            // If no URL found (invalid server or no current server), use first server
                            if (videoUrl.isEmpty()) {
                                videoUrl = servers.get(0).getUrl();
                            }
                        }
                    %>
                    <div id="videoWrapper">
                        <iframe id="videoFrame"
                                src="<%= videoUrl %>" 
                                title="Video Player" 
                                width="100%" 
                                height="500px" 
                                frameborder="0" 
                                allowfullscreen>
                        </iframe>
                        <div id="serverError" class="alert alert-danger" style="display: none; margin-top: 10px;">
                            <i class="bi bi-exclamation-triangle"></i> 
                            This server is not responding. Please try another server.
                        </div>
                    </div>
                </div>

                <div class="info-panel">
                    <h1 class="video-title" id="videoTitle"><%= video.getTitle() %></h1>
                    <div class="meta-badges">
                        <span class="badge-custom"><%= video.getUplaodDate() %></span>
                        <% if (video.getType().equals("series")) { %>
                            <span class="badge-custom"><%= ((Series) video).getNumberOfSeasons() %> Season<%= ((Series) video).getNumberOfSeasons() > 1 ? "s" : "" %></span>
                        <% } else if (video.getType().equals("movie")) { %>
                            <span class="badge-custom"><%= ((Movie) video).getDuration() %></span>
                            <span class="badge-custom"><%= ((Movie) video).getAgeRating() %></span>
                            <span class="badge-custom"><%= currentServer %></span>
                        <% } %>
                        
                    </div>
                    <p class="video-description" id="videoDescription"><h2 class="">Description</h2><%= video.getDescription() %></p>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="controls-panel">
                    <div class="section-title">Video Server</div>
                    <form action="watch" method="POST" class="server-grid">
                        <% if(fromWatchList != null && fromWatchList.equals("true")) { %>
                            <input type="hidden" name="watchListId" value="<%= video.getId() %>">
                        <% } %>
                        <input type="hidden" name="videoId" value="<%= video.getId() %>">
                        <% if (servers != null) { 
                            for (Server server : servers) { %>
                                <button type="submit" name="server" value="<%= server.getName() %>" 
                                class="btn btn-outline-light server-btn <%= server.getName().equals(currentServer) ? "btn-danger" : "" %>">
                                <i class="bi bi-play-circle"></i> <%= server.getName() %>
                                </button>
                            <% }
                        } else {
                            if (video.getType().equals("series")) {
                                for (int i = 1; i <= 5; i++) {
                                %>
                                    <button type="submit" name="server" value="Server <%= i %>"
                                        class="btn btn-outline-light server-btn <%= ("Server " + i).equals(currentServer) ? "btn-danger" : "" %>">
                                        <i class="bi bi-play-circle"></i>Server <%= i %>
                                    </button>
                                <%
                                }
                            }
                        } %>
                    </form>

                    <div class="divider"></div>

                    <div class="controls-buttons">
                        <form action="watch" method="POST" class="watch-form">
                            <input type="hidden" name="videoId" value="<%= video.getId() %>">
                            <button type="submit" name="action" value="play" class="btn-play-main">
                                <i class="bi bi-play-circle-fill"></i>
                                Play Now
                            </button>
                        </form>
                        <!-- Add to Watchlist button -->
                        <form action="watchlist" method="POST" class="watchlist-form">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="videoId" value="<%= video.getId() %>">
                            <button type="submit" class="btn-add-watchlist" title="Add to Watchlist">
                                <i class="bi bi-plus-circle"></i>
                                Add to Watchlist
                            </button>
                        </form>
                    </div>
                </div>


            <% if (video.getType().equals("series")) {
                int seasons = ((Series) video).getNumberOfSeasons();
                java.util.Random rnd = new java.util.Random();
                int[] episodesPerSeason = new int[seasons];
                for (int i = 0; i < seasons; i++) {
                    // Randomize episodes between 5 and 20 for each season
                    episodesPerSeason[i] = 5 + rnd.nextInt(16);
                }
                    
                %>

                <div class="season-episode-controls" style="margin-top:15px;">
                    <label for="seasonSelect" class="form-label">Season</label>
                    <select id="seasonSelect" class="form-select" name="season" style="margin-bottom:8px;">
                        <% for (int s = 1; s <= seasons; s++) { %>
                            <option value="<%= s %>">Season <%= s %></option>
                        <% } %>
                    </select>

                    <label for="episodeSelect" class="form-label">Episode</label>
                    <select id="episodeSelect" class="form-select" name="episode">
                        <% int initialEps = episodesPerSeason.length > 0 ? episodesPerSeason[0] : 0;
                        for (int e = 1; e <= initialEps; e++) { %>
                            <option value="<%= e %>">Episode <%= e %></option>
                        <% } %>
                    </select>
                </div>
            <% } %>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Server error handling
        document.getElementById('videoFrame').addEventListener('error', function() {
            document.getElementById('serverError').style.display = 'block';
        });

        // Hide error message when switching servers
        document.querySelectorAll('.server-btn').forEach(button => {
            button.addEventListener('click', function() {
                document.getElementById('serverError').style.display = 'none';
            });
        });

        // Auto-play functionality
        document.getElementById('videoPlayer').addEventListener('canplay', function() {
            if (new URLSearchParams(window.location.search).get('autoplay') === 'true') {
                this.play();
            }
        });
    </script>
</body>
</html>
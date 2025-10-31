<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Wovies - Watch</title>
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
        }

        .btn-account:hover {
            background: #e50914;
            border-color: #e50914;
            color: #fff;
            box-shadow: 0 4px 15px rgba(229, 9, 20, 0.4);
            transform: translateY(-1px);
        }

        .content-wrapper {
            padding: 2rem 0;
        }

        .video-container {
            background: #000;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.6);
            margin-bottom: 2rem;
        }

        video {
            width: 100%;
            display: block;
        }

        .info-panel {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.8) 0%, rgba(20, 20, 20, 0.9) 100%);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

        .video-title {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
            background: linear-gradient(90deg, #fff 0%, #b3b3b3 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .meta-badges {
            display: flex;
            gap: 0.75rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }

        .badge-custom {
            background: rgba(229, 9, 20, 0.1);
            border: 1px solid rgba(229, 9, 20, 0.3);
            color: #e50914;
            padding: 0.35rem 0.75rem;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .video-description {
            color: #b3b3b3;
            line-height: 1.7;
            font-size: 0.95rem;
        }

        .controls-panel {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.8) 0%, rgba(20, 20, 20, 0.9) 100%);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 1.75rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            position: sticky;
            top: 100px;
        }

        .section-title {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: #888;
            margin-bottom: 1rem;
            font-weight: 700;
        }

        .divider {
            height: 1px;
            background: linear-gradient(90deg, transparent 0%, rgba(229, 9, 20, 0.3) 50%, transparent 100%);
            margin: 1.5rem 0;
        }

        .type-selector {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
        }

        .btn-type {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #b3b3b3;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .btn-type:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: rgba(255, 255, 255, 0.15);
            color: #fff;
        }

        .btn-type.active {
            background: linear-gradient(135deg, #e50914 0%, #c20812 100%);
            border-color: #e50914;
            color: #fff;
            box-shadow: 0 4px 15px rgba(229, 9, 20, 0.3);
        }

        .quality-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0.5rem;
            margin-bottom: 1.5rem;
        }

        .quality-btn {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #b3b3b3;
            padding: 0.5rem;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .quality-btn:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: rgba(255, 255, 255, 0.15);
            color: #fff;
        }

        .quality-btn.active {
            background: rgba(229, 9, 20, 0.2);
            border-color: #e50914;
            color: #e50914;
        }

        .form-select-custom {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #fff;
            padding: 0.75rem;
            border-radius: 8px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .form-select-custom:focus {
            background: rgba(255, 255, 255, 0.05);
            border-color: #e50914;
            box-shadow: 0 0 0 3px rgba(229, 9, 20, 0.1);
            outline: none;
            color: #fff;
        }

        .form-select-custom option {
            background: #1a1a1a;
        }

        .episode-list {
            max-height: 400px;
            overflow-y: auto;
            padding-right: 0.5rem;
        }

        .episode-list::-webkit-scrollbar {
            width: 5px;
        }

        .episode-list::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.03);
            border-radius: 10px;
        }

        .episode-list::-webkit-scrollbar-thumb {
            background: linear-gradient(180deg, #e50914 0%, #c20812 100%);
            border-radius: 10px;
        }

        .episode-card {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 0.75rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .episode-card:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: rgba(255, 255, 255, 0.1);
            transform: translateX(4px);
        }

        .episode-card.active {
            background: rgba(229, 9, 20, 0.1);
            border-color: #e50914;
        }

        .episode-header {
            display: flex;
            gap: 1rem;
            margin-bottom: 0.5rem;
        }

        .episode-num {
            font-size: 1.5rem;
            font-weight: 800;
            color: #e50914;
            min-width: 35px;
        }

        .episode-info h4 {
            font-size: 0.95rem;
            font-weight: 600;
            color: #fff;
            margin-bottom: 0.25rem;
        }

        .episode-duration {
            font-size: 0.8rem;
            color: #666;
            margin-bottom: 0.5rem;
        }

        .episode-desc {
            font-size: 0.85rem;
            color: #888;
            line-height: 1.5;
        }

        .btn-play-main {
            width: 100%;
            background: linear-gradient(135deg, #e50914 0%, #c20812 100%);
            border: none;
            color: #fff;
            padding: 1rem;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(229, 9, 20, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-play-main:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(229, 9, 20, 0.5);
        }

        .btn-play-main:active {
            transform: translateY(0);
        }

        @media (max-width: 991px) {
            .controls-panel {
                position: relative;
                top: 0;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .search-input {
                width: 180px;
            }

            .search-input:focus {
                width: 200px;
            }
        }
    </style>
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

    <div class="container content-wrapper">
        <div class="row g-4">
            <div class="col-lg-8">
                <div class="video-container">
                    <video id="videoPlayer" controls>
                        <source src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" type="video/mp4">
                    </video>
                </div>

                <div class="info-panel">
                    <h1 class="video-title" id="videoTitle">Stranger Things - Season 1 Episode 1</h1>
                    <div class="meta-badges">
                        <span class="badge-custom">2023</span>
                        <span class="badge-custom">48 min</span>
                        <span class="badge-custom">16+</span>
                        <span class="badge-custom">4K Available</span>
                    </div>
                    <p class="video-description" id="videoDescription">
                        On his way home from a friend's house, young Will sees something terrifying.
                        Nearby, a sinister secret lurks in the depths of a government lab. A mysterious girl
                        with psychokinetic abilities escapes from a laboratory and crosses paths with a group
                        of friends searching for their missing companion.
                    </p>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="controls-panel">
                    <div class="section-title">Content Type</div>
                    <div class="type-selector">
                        <button class="btn-type" id="movieBtn" onclick="selectType('movie')">
                            <i class="bi bi-film"></i> Movie
                        </button>
                        <button class="btn-type active" id="seriesBtn" onclick="selectType('series')">
                            <i class="bi bi-collection-play"></i> Series
                        </button>
                    </div>

                    <div class="divider"></div>

                    <div class="section-title">Video Quality</div>
                    <div class="quality-grid">
                        <button class="quality-btn" onclick="selectQuality('360p')">360p</button>
                        <button class="quality-btn" onclick="selectQuality('480p')">480p</button>
                        <button class="quality-btn" onclick="selectQuality('720p')">720p</button>
                        <button class="quality-btn active" onclick="selectQuality('1080p')">1080p</button>
                        <button class="quality-btn" onclick="selectQuality('4K')">4K UHD</button>
                    </div>

                    <div class="divider"></div>

                    <div id="seriesSection">
                        <div class="section-title">Season & Episode</div>
                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <select class="form-select-custom w-100" id="seasonSelect" onchange="loadSeason()">
                                    <option value="1">Season 1</option>
                                    <option value="2">Season 2</option>
                                    <option value="3">Season 3</option>
                                    <option value="4">Season 4</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <select class="form-select-custom w-100" id="episodeSelect" onchange="selectEpisodeFromDropdown()">
                                    <option value="1">Episode 1</option>
                                </select>
                            </div>
                        </div>

                        <div class="section-title">All Episodes</div>
                        <div class="episode-list" id="episodeList"></div>

                        <div class="divider"></div>
                    </div>

                    <button class="btn-play-main" onclick="playVideo()">
                        <i class="bi bi-play-circle-fill"></i>
                        Play Now
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const episodes = {
            1: [
                { num: 1, title: "The Vanishing of Will Byers", duration: "48m", desc: "On his way home from a friend's house, young Will sees something terrifying. Nearby, a sinister secret lurks in the depths of a government lab." },
                { num: 2, title: "The Weirdo on Maple Street", duration: "55m", desc: "Lucas, Mike and Dustin try to talk to the girl they found in the woods. Hopper questions an anxious Joyce about an unsettling phone call." },
                { num: 3, title: "Holly, Jolly", duration: "51m", desc: "An increasingly concerned Nancy looks for Barb and finds out what Jonathan's been up to. Joyce is convinced Will is trying to talk to her." },
                { num: 4, title: "The Body", duration: "50m", desc: "Refusing to believe Will is dead, Joyce tries to connect with her son. The boys give Eleven a makeover. Nancy and Jonathan form an unlikely alliance." },
                { num: 5, title: "The Flea and the Acrobat", duration: "52m", desc: "Hopper breaks into the lab while Nancy and Jonathan confront the force that took Will. The boys ask Mr. Clarke how to travel to another dimension." },
                { num: 6, title: "The Monster", duration: "46m", desc: "A frantic Jonathan looks for Nancy in the darkness, but Steve's looking for her, too. Hopper and Joyce uncover the truth about the lab's experiments." },
                { num: 7, title: "The Bathtub", duration: "42m", desc: "Eleven struggles to reach Will, while Lucas warns that the bad men are coming. Nancy and Jonathan show the police what Jonathan caught on camera." },
                { num: 8, title: "The Upside Down", duration: "54m", desc: "Dr. Brenner holds Hopper and Joyce for questioning while the boys wait with Eleven in the gym. Back at the Byers', Nancy and Jonathan prepare for battle." }
            ],
            2: [
                { num: 1, title: "MADMAX", duration: "48m", desc: "As the town preps for Halloween, a high-scoring rival shakes things up at the arcade, and a skeptical Hopper inspects a field of rotting pumpkins." },
                { num: 2, title: "Trick or Treat, Freak", duration: "53m", desc: "After Will sees something terrible on trick-or-treat night, Mike wonders whether Eleven's still out there. Nancy wrestles with the truth about Barb." },
                { num: 3, title: "The Pollywog", duration: "51m", desc: "Dustin adopts a strange new pet, and Eleven grows increasingly impatient. A well-meaning Bob urges Will to stand up to his fears." },
                { num: 4, title: "Will the Wise", duration: "46m", desc: "An ailing Will opens up to Joyce, and while Hopper digs for the truth, Eleven unearths a surprising discovery." }
            ]
        };

        let currentSeason = 1;
        let currentEpisode = 1;
        let currentQuality = '1080p';
        let contentType = 'series';

        function loadSeason() {
            currentSeason = parseInt(document.getElementById('seasonSelect').value);
            loadEpisodes();
        }

        function loadEpisodes() {
            const episodeList = document.getElementById('episodeList');
            const episodeSelect = document.getElementById('episodeSelect');

            episodeList.innerHTML = '';
            episodeSelect.innerHTML = '';

            const seasonEpisodes = episodes[currentSeason] || episodes[1];

            seasonEpisodes.forEach(function(ep) {
                const episodeCard = document.createElement('div');
                episodeCard.className = 'episode-card' + (ep.num === currentEpisode ? ' active' : '');
                episodeCard.onclick = function() { selectEpisode(ep.num); };

                episodeCard.innerHTML =
                    '<div class="episode-header">' +
                        '<div class="episode-num">' + ep.num + '</div>' +
                        '<div class="episode-info">' +
                            '<h4>' + ep.title + '</h4>' +
                            '<div class="episode-duration">' + ep.duration + '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="episode-desc">' + ep.desc + '</div>';

                episodeList.appendChild(episodeCard);

                const option = document.createElement('option');
                option.value = ep.num;
                option.textContent = 'Episode ' + ep.num;
                if (ep.num === currentEpisode) option.selected = true;
                episodeSelect.appendChild(option);
            });

            updateVideoInfo();
        }

        function selectEpisode(episodeNum) {
            currentEpisode = episodeNum;
            document.getElementById('episodeSelect').value = episodeNum;
            loadEpisodes();
        }

        function selectEpisodeFromDropdown() {
            currentEpisode = parseInt(document.getElementById('episodeSelect').value);
            loadEpisodes();
        }

        function updateVideoInfo() {
            const seasonEpisodes = episodes[currentSeason] || episodes[1];
            const episode = seasonEpisodes.find(function(ep) { return ep.num === currentEpisode; });

            if (episode) {
                document.getElementById('videoTitle').textContent = 'Stranger Things - Season ' + currentSeason + ' Episode ' + episode.num;
                document.getElementById('videoDescription').textContent = episode.desc;
            }
        }

        function selectQuality(quality) {
            currentQuality = quality;
            document.querySelectorAll('.quality-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
        }

        function selectType(type) {
            contentType = type;
            document.getElementById('movieBtn').classList.remove('active');
            document.getElementById('seriesBtn').classList.remove('active');
            document.getElementById(type + 'Btn').classList.add('active');

            const seriesSection = document.getElementById('seriesSection');
            if (type === 'series') {
                seriesSection.style.display = 'block';
            } else {
                seriesSection.style.display = 'none';
            }
        }

        function playVideo() {
            const video = document.getElementById('videoPlayer');
            video.currentTime = 0;
            video.play();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        // Search functionality
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                const searchTerm = this.value.trim();
                if (searchTerm) {
                    window.location.href = 'search.jsp?q=' + encodeURIComponent(searchTerm);
                }
            }
        });

        loadEpisodes();
    </script>
</body>
</html>
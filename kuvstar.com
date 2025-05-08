<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KUV STAR</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #000;
            background-image: url('grainy-texture.png'); /* Add a grainy texture image */
            background-size: cover;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
            overflow-y: auto; /* Ensure scroll bar is shown */
        }
        .top-bar {
            background-color: rgba(184, 184, 184, 0.48);
            color: #fff;
            text-align: center;
            padding: 5px;
            border-radius: 10px;
            margin: 10px auto;
            max-width: 90%;
            font-size: 14px;
            position: relative;
        }
        .social-icons {
            position: absolute;
            top: 50%;
            left: 10px;
            transform: translateY(-50%);
            display: flex;
            gap: 30px;
        }
        .social-icons a {
            text-decoration: none;
        }
        .social-icons .icon {
            width: 24px;
            height: 24px;
        }
        .top-image {
            text-align: center;
            margin: 10px auto;
        }
        .top-image .banner {
            max-width: 50%; /* Reduce the width to make the image smaller */
            height: 40%;
            border-radius: 10px;
        }
        .top-bar p {
            font-family: 'Courier New', Courier, monospace; /* Change the font here */
        }
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 200px;
            height: 100%;
            background-color: rgba(27, 27, 27, 0.75);
            color: #fff;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.5);
            border-right: 2px solid #fff; /* Add a white outline to the right */
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
            margin-top: 40px; /* Move the options down */
        }
        .sidebar ul li {
            margin: 20px 0;
        }
        .sidebar ul li a {
            text-decoration: none;
            color: #fff;
            font-size: 12.9px;
            font-family: 'Canva Sans', sans-serif;
            font-weight: bold;
            text-transform: uppercase;
        }
        .sidebar ul li a.active {
            text-decoration: underline;
        }
        .content {
            margin-left: 220px;
            padding: 20px;
        }
        .sidebar-title {
            font-size: 18px; /* Make the title smaller */
            margin: 0;
        }
        .page {
            display: none;
        }
        .page.active {
            display: block;
        }
        .search-bar {
            margin-top: 20px; /* Add spacing below the title */
            text-align: center;
            width: 100%; /* Make the search bar fit the width of the sidebar */
        }
        .search-input {
            width: calc(100% - 20px); /* Add padding to fit within the sidebar */
            box-sizing: border-box; /* Include padding and border in the element's total width */
            padding: 5px 10px; /* Revert search bar size */
            border: 1px solid #ccc;
            border-radius: 10px; /* Make it less round */
            outline: none;
            font-size: 14px; /* Revert font size */
        }
        .search-input::placeholder {
            color: #aaa;
        }
        .logo {
            text-align: center;
            margin-top: -50px; /* Move the logo way up to the very top */
            padding-top: 0; /* Remove extra padding */
            position: relative;
        }
        .social-icons-top {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            display: flex;
            gap: 10px;
        }
        .social-icons-top .icon {
            width: 24px; /* Revert social media icon size */
            height: 24px;
            padding: 0; /* Remove extra padding */
            background-color: transparent; /* Remove white background */
            border-radius: 0; /* Remove circular shape */
        }
        .slideshow {
            text-align: center;
            margin-top: 50px;
            position: relative;
            overflow: hidden; /* Ensure images don't overflow the container */
            max-width: 80%;
            height: auto;
            margin-left: auto;
            margin-right: auto;
        }
        .slideshow-images {
            display: flex;
            transition: transform 1s ease-in-out; /* Smooth sliding effect */
        }
        .slideshow-image {
            min-width: 100%;
            height: auto;
            border-radius: 10px;
        }
        .logo-image {
            max-width: 40px; /* Make the logo smaller */
            height: auto;
        }
        .social-icons .icon, .social-icons-top .icon {
            background-color: #fff; /* Add white background */
            border-radius: 50%; /* Make it circular */
            padding: 5px; /* Add padding for spacing */
        }
        .top-panel {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.1); /* Semi-transparent background */
            padding: 10px 20px;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .logo {
            flex: 1;
            text-align: left;
        }
        .search-bar {
            flex: 2;
            text-align: center;
        }
        .social-icons-top {
            flex: 1;
            text-align: right;
            display: flex;
            gap: 10px;
        }
        .sidebar-header {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px; /* Add spacing between the logo and title */
        }
        .sidebar-footer {
            width: 100%; /* Fit the width of the sidebar */
            height: 100px; /* Set the height of the square panel */
            background-color: #fff; /* White background */
            position: absolute;
            bottom: 0;
            left: 0;
        }
        .social-icons-footer {
            display: flex;
            justify-content: space-around;
            align-items: center;
            height: 80%; /* Reduce height to move icons up */
            margin-top: 10px; /* Add margin to adjust spacing */
        }
        .icon-footer {
            width: 30px; /* Adjust size to fit the sidebar */
            height: auto;
            background-color: transparent; /* Remove white background */
            border-radius: 0; /* Remove circular shape */
        }
        .artist-title {
            font-family: 'Canva Sans', sans-serif;
            font-size: 24px; /* Increase font size */
            font-weight: bold;
            color: #fff;
            text-decoration: underline;
            text-transform: uppercase; /* Make it all caps */
            margin-top: 40px; /* Move it further down */
            margin-left: 20px; /* Move it more to the right */
        }
        .artist-section {
            margin-top: 10px; /* Move the artist section slightly up */
        }
        .artist-image {
            display: block;
            margin: 10px 0 0 10px; /* Move further to the left */
            max-width: 30%; /* Keep the image small */
            border-radius: 10px; /* Optional: Add rounded corners */
        }
        .artist-caption {
            text-align: left; /* Align the caption to the left */
            margin-left: 10px; /* Move it further to the left */
            font-family: 'Canva Sans', sans-serif;
            font-size: 18px;
            font-weight: bold;
            color: #fff;
            text-transform: uppercase; /* Make text all caps */
            margin-top: 10px;
        }
        .sliding-text-container {
            width: 100%;
            overflow: hidden;
            background-color: rgba(0, 0, 0, 0.8); /* Optional: Add background color */
            color: #fff;
            text-align: center;
            padding: 10px 0;
            position: relative;
        }
        .sliding-text {
            display: inline-block;
            white-space: nowrap;
            animation: slide 10s linear infinite;
        }
        @keyframes slide {
            0% {
                transform: translateX(100%);
            }
            100% {
                transform: translateX(-100%);
            }
        }
        .scrolling-text-bar {
            width: 100%;
            overflow: hidden;
            background-color: rgba(0, 0, 0, 0.6); /* Semi-transparent background */
            color: #fff;
            text-align: center;
            padding: 10px 0;
            position: relative;
            margin-top: 20px; /* Add spacing above the bar */
        }
        .scrolling-text {
            display: inline-block;
            white-space: nowrap;
            animation: scroll-text 15s linear infinite; /* Infinite scrolling */
        }
        @keyframes scroll-text {
            0% {
                transform: translateX(100%);
            }
            100% {
                transform: translateX(-100%); /* Ensure it completely exits the screen */
            }
        }
        .magazine-title {
            font-family: 'Canva Sans', sans-serif;
            font-size: 24px;
            font-weight: bold;
            color: #fff;
            text-decoration: underline;
            text-transform: uppercase;
            margin-top: 40px;
            margin-left: 20px; /* Align with artist section */
        }
        .magazine-section {
            margin-top: 80px; /* Increase spacing above the magazine section */
        }
        .magazine-container {
            display: flex;
            gap: 10px; /* Reduce spacing between the magazines */
            margin-left: 20px; /* Align with artist section */
        }
        .magazine-item {
            text-align: center;
            flex: 1; /* Ensure magazines fit beside each other */
        }
        .magazine-image {
            max-width: 80%; /* Adjust size of the magazines */
            height: auto;
            border-radius: 10px;
        }
        .magazine-caption {
            font-family: 'Canva Sans', sans-serif;
            font-size: 18px;
            font-weight: bold;
            color: #fff;
            text-transform: uppercase;
            margin-top: 10px;
        }
        .events-section {
            margin-top: 80px; /* Add spacing above the events section */
        }
        .events-title {
            font-family: 'Canva Sans', sans-serif;
            font-size: 24px;
            font-weight: bold;
            color: #fff;
            text-decoration: underline;
            text-transform: uppercase;
            margin-top: 40px;
            margin-left: 20px; /* Align with other sections */
        }
        .events-content {
            margin-left: 20px; /* Align with other sections */
            font-family: Arial, sans-serif;
            font-size: 16px;
            color: #fff;
        }
        .event-image {
            max-width: 100px; /* Set a fixed size for event images */
            height: auto;
            margin-bottom: 10px; /* Add spacing below the image */
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <img src="logo.png" alt="KUV STAR Logo" class="logo-image">
            <h1 class="sidebar-title">KUV STAR</h1>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="Search..." class="search-input">
        </div>
        <ul>
            <li><a href="#main" class="nav-link active">MAIN</a></li>
            <li><a href="#artist" class="nav-link">ARTIST</a></li>
            <li><a href="#magazines" class="nav-link">MAGAZINES</a></li>
            <li><a href="#events" class="nav-link">EVENTS</a></li>
        </ul>
        <div class="sidebar-footer">
            <div class="social-icons-footer">
                <a href="https://www.youtube.com/@KUVSTAR_Official" target="_blank">
                    <img src="youtube.png" alt="YouTube" class="icon-footer">
                </a>
                <a href="https://discord.gg/kae5vJkBX3" target="_blank">
                    <img src="discord.png" alt="Discord" class="icon-footer">
                </a>
                <a href="https://www.tiktok.com/@plushboutique_official" target="_blank">
                    <img src="tiktok.png" alt="TikTok" class="icon-footer">
                </a>
            </div>
        </div>
    </div>
    <div class="top-panel">
        <div class="logo">
            <img src="logo.png" alt="KUV STAR Logo" class="logo-image">
        </div>
        <div class="search-bar">
            <input type="text" placeholder="Search..." class="search-input">
        </div>
        <div class="social-icons-top">
            <a href="https://www.youtube.com/@KUVSTAR_Official" target="_blank">
                <img src="youtube.png" alt="YouTube" class="icon">
            </a>
            <a href="https://discord.gg/kae5vJkBX3" target="_blank">
                <img src="discord.png" alt="Discord" class="icon">
            </a>
            <a href="https://www.tiktok.com/@plushboutique_official" target="_blank">
                <img src="tiktok.png" alt="TikTok" class="icon">
            </a>
        </div>
    </div>
    <div class="content">
        <div class="top-bar">
            <div class="social-icons">
                <a href="https://www.youtube.com/@KUVSTAR_Official" target="_blank">
                    <img src="youtube.png" alt="YouTube" class="icon">
                </a>
                <a href="https://discord.gg/kae5vJkBX3" target="_blank">
                    <img src="discord.png" alt="Discord" class="icon">
                </a>
                <a href="https://www.tiktok.com/@plushboutique_official" target="_blank">
                    <img src="tiktok.png" alt="TikTok" class="icon">
                </a>
            </div>
            <p>WELCOME TO KUV STAR</p>
        </div>
        <div class="top-image">
            <img src="kitty poster.jpg" alt="Kitty Poster" class="banner">
        </div>
        <nav>
            <ul style="justify-content: center;">
            </ul>
        </nav>
        <div class="container">
            <div class="profile-header">
            </div> 
            <div class="tabs">
            </div>
            <div id="posts" class="gallery">
            </div>
            <div id="reels" class="gallery" style="display: none;">
            </div>
        </div>
        <div class="sliding-text-container">
            <div class="sliding-text">
                Welcome to KUV STAR! | Explore the Artist Section | Discover Models and Events
            </div>
        </div>
        <div class="slideshow">
            <div class="slideshow-images">
                <img src="banner1.jpg" alt="Banner 1" class="slideshow-image">
                <img src="banner2.jpg" alt="Banner 2" class="slideshow-image">
                <img src="banner3.jpg" alt="Banner 3" class="slideshow-image">
                <img src="banner4.jpg" alt="Banner 4" class="slideshow-image">
                <img src="banner5.jpg" alt="Banner 5" class="slideshow-image">
            </div>
        </div>
        <div class="scrolling-text-bar">
            <div class="scrolling-text">
                Welcome to KUV STAR! | Explore the Artist Section | Discover Models and Events | Stay Tuned for Updates!
            </div>
        </div>
        <div class="artist-section">
            <h2 class="artist-title">Artist</h2>
            <p>Welcome to the artist section. Add artist-specific content here.</p>
            <img src="artist-image.jpg" alt="Artist Image" class="artist-image">
            <p class="artist-caption">FEATURED ARTIST</p>
        </div>
        <div class="magazine-section">
            <h2 class="magazine-title">Magazines</h2>
            <p>Welcome to the magazine section. Add magazine-specific content here.</p>
            <div class="magazine-container">
                <div class="magazine-item">
                    <a href="https://heyzine.com/flip-book/c34a9aa273.html" target="_blank">
                        <img src="1.png" alt="Magazine Image" class="magazine-image">
                    </a>
                    <p class="magazine-caption">GLOW UP MAGAZINE</p>
                </div>
                <div class="magazine-item">
                    <a href="https://online.fliphtml5.com/conkd/gtlm/" target="_blank">
                        <img src="turn it up cover.png" alt="Second Magazine Image" class="magazine-image">
                    </a>
                    <p class="magazine-caption">TURN IT UP MAGAZINE Ft. Rebelle</p>
                </div>
                <div class="magazine-item">
                    <a href="https://example.com/magazine3" target="_blank">
                        <img src="magazine3.png" alt="Third Magazine Image" class="magazine-image">
                    </a>
                    <p class="magazine-caption">INSPIRE MAGAZINE</p>
                </div>
            </div>
        </div>
        <div class="events-section">
            <h2 class="events-title">Events</h2>
            <div class="events-content">
                <p>Welcome to the events section.</p>
                <ul>
                    <li>
                        <img src="event1.png" alt="Event 1 Image" class="event-image">
                        Event 1: Kitty Debut Showcase.
                    </li>
                    <li>
                        <img src="event2.png" alt="Event 2 Image" class="event-image">
                        Event 2: Kuv Star First Fashion Show.
                    </li>
                    <li>
                        <img src="event3.png" alt="Event 3 Image" class="event-image">
                        Event 3: Upcoming Talent Hunt.
                    </li>
                </ul>
            </div>
        </div>
        <div id="main" class="page active">Welcome to the Main Page</div>
        <div id="artist" class="page" style="display: none;">Welcome to the Artist Page</div>
        <div id="magazines" class="page" style="display: none;">Welcome to the Magazines Page</div>
        <div id="events" class="page" style="display: none;">Welcome to the Events Page</div>
    </div>
    <script>
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                const target = link.getAttribute('href').substring(1);
                document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
                document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
                link.classList.add('active');
                if (target === 'artist') {
                    document.querySelector('.artist-section').scrollIntoView({ behavior: 'smooth' }); // Scroll to artist section
                } else if (target === 'magazines') {
                    document.querySelector('.magazine-section').scrollIntoView({ behavior: 'smooth' }); // Scroll to magazine section
                } else if (target === 'events') {
                    document.querySelector('.events-section').scrollIntoView({ behavior: 'smooth' }); // Scroll to events section
                } else if (target === 'main') {
                    window.scrollTo({ top: 0, behavior: 'smooth' }); // Scroll to the top
                } else {
                    document.querySelector(`#${target}`).scrollIntoView({ behavior: 'smooth' });
                }
            });
        });

        const slideshowContainer = document.querySelector('.slideshow-images');
        const totalSlides = document.querySelectorAll('.slideshow-image').length;
        let currentSlide = 0;

        setInterval(() => {
            currentSlide = (currentSlide + 1) % totalSlides;
            slideshowContainer.style.transform = `translateX(-${currentSlide * 100}%)`;
        }, 3000); // Change slide every 3 seconds
    </script>
</body>
</html>

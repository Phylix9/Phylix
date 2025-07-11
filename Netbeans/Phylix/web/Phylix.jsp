<%-- 
    Document   : Phylix
    Created on : Jul 1, 2025, 3:08:08 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <Title>Phylix</Title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/LogoPhylix.png" type="img/png">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="Styles2.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
</head>
<body>     
    <div class="sidebar">
        <div class="top">
            <div class="logo">
                <img src="src/LogoPhylix.png" alt="Imagen central" id="LogoPhylix">
                <span>Phylix</span>
            </div>
            <i class="bx bx-menu" id="btn"></i>
        </div>
        <ul>
            <li>
                <a href="/Phylix/">
                    <i class="bx bx-home-alt"></i>
                    <span class="nav-item">Principal</span>
                </a>
                <span class="tooltip">Principal</span>
            </li>
            <li>
                <a href="PhylixInfo">
                    <i class="bx bx-buildings"></i>
                    <span class="nav-item">Acerca de</span>
                </a>
                <span class="tooltip">Acerca de</span>
            </li>
            <li>
                <a href="FitData">
                    <i class="bx bx-code"></i>
                    <span class="nav-item">Proyecto</span>
                </a>
                <span class="tooltip">Proyecto</span>
            </li>
            <li>
                <a href="Miembros">
                    <i class='bx bxs-id-card'></i>
                    <span class="nav-item">Nosotros</span>
                </a>
                <span class="tooltip">Equipo</span>
            </li>
        </ul>
    </div>
    <header>
        <div class="content">
            <h1 id="TituloE">PHYLIX</h1>
            <p id="SloganE">Innovando tu futuro digital</p>
        </div>
    </header>
    

<footer class="footer">

    <div class="container">

        <div class="footer-row">

            <div class="footer-links">
                <h4>Propiedad</h4>
                <ul>
                    <li><a href="#">&copy; 2024 Phylix.</a></li>
                </ul>
            </div>
            <div class="footer-links">
                <h4>Programadores</h4>
                <ul>
                    <li><a href="#">Karla</a></li>
                    <li><a href="#">Julieta</a></li>
                    <li><a href="#">Christian</a></li>
                    <li><a href="#">Abraham</a></li>
                </ul>
            </div>
            <div class="footer-links">
                <h4>Contactanos</h4>
                <ul>
                    <li><a href="#">Nosotros</a></li>
                    <li><a href="#">phylix5IM9@gmail.com</a></li>
                </ul>
            </div>
            <div class="footer-links">
                <h4>Siguenos</h4>
                <div class="social-link">
                    <a href="https://www.facebook.com/profile.php?id=61566664822814&mibextid=LQQJ4d"><i class="fab fa-facebook-f"></i></a>
                    <a href="https://www.instagram.com/phylix_official?igsh=MTNvb3VvY2dlbGtm"><i class="fab fa-instagram"></i></a>
                    <a href="https://x.com/phylix5im9/status/1839495022829306317?s=46&t=CErG4mdE38hn7Yl5WGVeGQ"><i class="fab fa-twitter"></i></a>
                    <a href="https://github.com/Phylix9"><i class="fab fa-github"></i></a>
                </div>
            </div>   

        </div>
    </div>

</footer>
</body>

<script>
let btn = document.querySelector('#btn');
let sidebar = document.querySelector('.sidebar');

btn.onclick = function () {
    sidebar.classList.toggle('active');
};
</script>
</html>
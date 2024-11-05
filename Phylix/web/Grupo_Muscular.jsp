<%-- 
    Document   : Grupo_Muscular
    Created on : Nov 4, 2024, 10:50:10 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <title>FitData - Rutinas Semanales</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css">
    <link rel="stylesheet" href="Styles14.css">
</head>
<body>
    <nav>
        <div class="nav__logo">
          <a href="Proyecto.html"><img src="src/LogoFitdata2.png" alt="logo"/></a>
        </div>
        <ul class="nav__links">
          <li class="link"><a href="Proyecto.html">Inicio</a></li>
          <li class="link"><a href="Dietas.html">Dietas</a></li>
          <li class="link"><a href="Informacion.html">Informacion</a></li>
        </ul>
      </nav>

    <section class="section__container">
        <div class="header__content">
            <header class="section__header">
                <h2>Selecciona Tu Rutina Semanal</h2>
                <p class="section__subheader">
                    Elige entre una rutina personalizada o una predeterminada para maximizar tus resultados.
                </p>
            </header>
        </div>

        <div class="header__container">
            <div class="header__image">
                <header class="section__header">
                    <h3>Tren superior</h3>
                </header>
                <div class="image-container">
                    <a href="Espalda.jsp" class="image-wrapper">
                        <img src="src/espalda.jpg" alt="Espalda" class="hero-image">
                        <span class="image-text">Espalda</span>
                    </a>
                    <a href="Pecho.jsp" class="image-wrapper">
                        <img src="src/pecho.jpeg" alt="Pecho" class="hero-image">
                        <span class="image-text">Pecho</span>
                    </a>
                    <a href="Brazo.jsp" class="image-wrapper">
                        <img src="src/brazo.jpg" alt="Brazo" class="hero-image">
                        <span class="image-text">Brazo</span>
                    </a>
                    <a href="Full.jsp" class="image-wrapper">
                        <img src="src/full.jpg" alt="Full" class="hero-image">
                        <span class="image-text">Full Body</span>
                    </a>
                </div>
            </div>
            <div class="header__image">
                <header class="section__header">
                    <h3>Tren inferior</h3>
                </header>
                <div class="image-container">
                    <a href="Cuadriceps.jsp" class="image-wrapper">
                        <img src="src/extension.png" alt="Cuadriceps" class="hero-image">
                        <span class="image-text">Cuadriceps</span>
                    </a>
                    <a href="Femoral.jsp" class="image-wrapper">
                        <img src="src/femoral2.jpg" alt="Femoral" class="hero-image">
                        <span class="image-text">Femoral</span>
                    </a>
                    <a href="Gluteo.jsp" class="image-wrapper">
                        <img src="src/sentadilla.jpg" alt="Gluteo" class="hero-image">
                        <span class="image-text">Glúteo</span>
                    </a>
                    <a href="Abdomen.jsp" class="image-wrapper">
                        <img src="src/abdominales.jpg" alt="Abdomen" class="hero-image">
                        <span class="image-text">Abdomen</span>
                    </a>
                </div>
            </div>
        </div>
        
    <footer class="section__container footer__container">
      <span class="bg__blur"></span>
      <span class="bg__blur footer__blur"></span>
      <div class="footer__col">
        <div class="footer__logo"><img src="src/logoFitData.png" alt="logo" /></div>
        <p>
          Da el primer paso hacia una persona más sana y fuerte con nuestros
          planes inmejorables. ¡Logremos y conquistemos juntos!
        </p>
        <div class="footer__socials">
          <a href="https://www.facebook.com/profile.php?id=61566664822814&mibextid=LQQJ4d"><i class="ri-facebook-fill"></i></a>
          <a href="https://www.instagram.com/phylix_official?igsh=MTNvb3VvY2dlbGtm"><i class="ri-instagram-line"></i></a>
          <a href="https://x.com/phylix5im9/status/1839495022829306317?s=46&t=CErG4mdE38hn7Yl5WGVeGQ"><i class="ri-twitter-fill"></i></a>
        </div>
      </div>
      <div class="footer__col">
        <h4>Company</h4>
        <a href="#">Business</a>
        <a href="#">Partnership</a>
        <a href="#">Network</a>
      </div>
      <div class="footer__col">
        <h4>About Us</h4>
        <a href="#">Blogs</a>
        <a href="#">Security</a>
        <a href="#">Careers</a>
      </div>
      <div class="footer__col">
        <h4>Contact</h4>
        <a href="#">Contact Us</a>
        <a href="#">Privacy Policy</a>
        <a href="#">Terms & Conditions</a>
      </div>
    </footer>
    <div class="footer__bar">
      Copyright © 2024 FitData. Todos los derechos reservados.
    </div>
</body>
</html>

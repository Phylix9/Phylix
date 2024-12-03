<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <title>FitData - Rutinas Semanales</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css">
    <link rel="stylesheet" href="Styles6.css">
</head>
<body>
    <nav>
        <div class="nav__logo">
          <a href="FitData"><img src="src/LogoFitdata2.png" alt="logo"/></a>
        </div>
        <ul class="nav__links">
          <li class="link"><a href="FitData">Inicio</a></li>
          <li class="link"><a href="Dietas.jsp">Dietas</a></li>
          <li class="link"><a href="Informacion.jsp">Informacion</a></li>
        </ul>
        
        <div id="authButtonContainer">
            <% 
                String username = (String) session.getAttribute("nombre_usuario");
                if (username != null) { %>
              <div class="user-icon" onclick="toggleDropdown()">
                <i class="ri-user-line" style="font-size: 24px; color: #fff;"></i>
                <div class="dropdown-menu">
                    <ul>
                        <li><a href="Perfil.jsp">Ver Perfil</a>
                        <li><a href="Logout">Cerrar Sesión</a>
                    </ul>
                </div>
              </div>
            <% } else { %>
              <button class="btn" onclick="location.href='Login.html'">Login</button>
            <% } %>
          </div>
      </nav>

      <section class="section__container">
        <div class="header__container">
            <div class="header__content">
                <header class="section__header">
                    <h2>Selecciona Tu Rutina Semanal</h2>
                    <p class="section__subheader">
                        Elige entre una rutina personalizada o una predeterminada para maximizar tus resultados.
                    </p>
                </header>
            </div>
            <div class="header__image">
                <img src="src/rutinas.png" 
                     alt="Fitness Training"
                     class="hero-image">
            </div>
        </div>

        <div class="explore__header">
            <h3>Opciones de Rutinas</h3>
        </div>

        <div class="explore__grid">
            <div class="explore__card">
                <span class="card__icon">
                    <i class="ri-check-line"></i>
                </span>
                <h4>Tu propio plan adaptado a ti</h4>
                <p>Selecciona tus objetivos y preferencias para crear una rutina única.</p>
                <button class="btn" onclick="location.href='Grupo_Muscular.jsp'">Crear Rutina</button>
            </div>
            <div class="explore__card">
                <span class="card__icon">
                    <i class="ri-heart-pulse-line"></i>
                </span>
                <h4>Planes de entrenamiento predefinidos</h4>
                <p>Elige los ejercicios que tenemos para que formes tu rutina y te sientas lo mas comodo posible.</p>
                <button class="btn"  onclick="location.href='Rutinas_predet.html'">Ver Rutinas</button>
            </div>
        </div>
    </section>

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
          
    <script>
        function toggleDropdown() {
            const dropdown = document.querySelector('.dropdown-menu');
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }

        document.addEventListener('click', (event) => {
            const dropdown = document.querySelector('.dropdown-menu');
            const userIcon = document.querySelector('.user-icon');

            if (dropdown && !userIcon.contains(event.target)) {
                dropdown.style.display = 'none';
            }
        });
    </script>
</body>
</html>
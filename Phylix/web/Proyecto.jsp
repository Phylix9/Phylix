<%-- 
    Document   : Proyecto
    Created on : Nov 2, 2024, 11:15:34 PM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link
      href="https://cdn.jsdelivr.net/npm/remixicon@3.4.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="Styles3.css" />
    <title>FitData</title>
  </head>
  <body>
    <button class="back-button" onclick="location.href='index.jsp'">
        <i class="ri-arrow-left-line"></i>
    </button>

    <nav>
        <div class="nav__logo">
            <a href="#"><img src="src/LogoFitdata2.png" alt="logo"/></a>
        </div>
        <ul class="nav__links">
            <li class="link"><a href="Proyecto.jsp">Inicio</a></li>
            <li class="link"><a href="Rutinas.html">Rutinas</a></li>
            <li class="link"><a href="Dietas.html">Dietas</a></li>
            <li class="link"><a href="Informacion.html">Informacion</a></li>
        </ul>
        <div id="authButtonContainer">
            <% 
                String username = (String) session.getAttribute("nombre_usuario");
                if (username != null) { %>
              <div class="user-icon" onclick="toggleDropdown()">
                <i class="ri-user-line" style="font-size: 24px; color: #fff;"></i>
                <div class="dropdown-menu">
                    <ul>
                        <li><a href="Perfil.html">Ver Perfil</a>
                        <li><a href="Logout">Cerrar Sesión</a>
                    </ul>
                </div>
              </div>
            <% } else { %>
              <button class="btn" onclick="location.href='Login.html'">Login</button>
            <% } %>
          </div>
    </nav>

    <header class="section__container header__container">
        <div class="header__content">
            <span class="bg__blur"></span>
            <span class="bg__blur header__blur"></span>
            <h1><span>FIT</span>DATA</h1>
            <h4>SALUD EN UN SOLO CLICK</h4>
            <p>
                FitData es una Aplicacion que tiene como objetivo mejorar y dar soluciones a la salud de las personas mediante rutinas de ejercicios y planes de alimentacion.
            </p>
            <button class="btn" onclick="location.href='Login.html'">Inicia Ahora</button>
        </div>
        <div class="header__image">
            <img src="src/header.png" alt="header" />
        </div>
    </header>

    <section class="section__container explore__container">
      <div class="explore__header">
        <h2 class="section__header">EXPLORA NUESTRO PROGRAMA</h2>
      </div>
      <div class="explore__grid">
        <div class="explore__card">
          <span><i class="ri-boxing-fill"></i></span>
          <h4>Fuerza</h4>
          <p>
            Abrace la esencia de la fuerza mientras profundizamos en sus diversas
            dimensiones física, mental y emocional.
          </p>
        </div>
        <div class="explore__card">
          <span><i class="ri-heart-pulse-fill"></i></span>
          <h4>Bienestar fisico</h4>
          <p>
            Abarca una gama de actividades que mejoran la salud, la fuerza,
            flexibilidad y bienestar general.
          </p>
        </div>
        <div class="explore__card">
          <span><i class="ri-run-line"></i></span>
          <h4>Perder Peso</h4>
          <p>
            A través de una combinación de rutinas de ejercicios y orientación de expertos, lograremos
            empoderarte para alcanzar tus metas.
          </p>
        </div>
        <div class="explore__card">
          <span><i class="ri-shopping-basket-fill"></i></span>
          <h4>Ganar Masa Muscular</h4>
          <p>
            Diseñado para la gente individualista, nuestro programa ofrece un enfoque eficaz.
            para ganar peso de manera sostenible.
          </p>
        </div>
      </div>
    </section>

    <section class="section__container class__container">
      <div class="class__image">
        <span class="bg__blur"></span>
        <img src="src/class-1.jpg" alt="class" class="class__img-1" />
        <img src="src/class-2.jpg" alt="class" class="class__img-2" />
      </div>
      <div class="class__content">
        <h2 class="section__header">LA VIDA SALUDABLE QUE BUSCAS</h2>
        <p>
          Cada accion está cuidadosamente seleccionada para mantenerte involucrado y
          desafiado, asegurando que nunca llegues a un punto muerto en tu estado físico
          siempre dando tu maximo esfuerzo con ayuda de nosotros.
        </p>
      </div>
    </section>

    <section class="section__container join__container">
      <h2 class="section__header">PORQUE UNIRTE A NOSOTROS?</h2>
      <p class="section__subheader">
        Tendras el como cambiar tu vida y hacerla una mas saludable con grandes beneficios para ti.
      </p>
      <div class="join__image">
        <img src="src/join.jpg" alt="Join" />
        <div class="join__grid">
          <div class="join__card">
            <span><i class="ri-user-star-fill"></i></span>
            <div class="join__card__content">
              <h4>Gente Especilizada</h4>
              <p>Apoyo de gente especilizada que te podra acercar a tus metas.</p>
            </div>
          </div>
          <div class="join__card">
            <span><i class="ri-vidicon-fill"></i></span>
            <div class="join__card__content">
              <h4>Gran Personalizacion</h4>
              <p>Ejecicios completamente personalizados o predeterminados</p>
            </div>
          </div>
          <div class="join__card">
            <span><i class="ri-building-line"></i></span>
            <div class="join__card__content">
              <h4>Buena Organizacion</h4>
              <p>Apoyo en la organizacion y desarrollo tuyo.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <footer class="section__container footer__container">
      <!-- Footer content -->
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

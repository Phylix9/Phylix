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
    <style>
  #bot-float-button {
  position: fixed;
  bottom: 30px;
  right: 30px;
  background-color: var(--secondary-color);
  color: white;
  padding: 18px;
  border-radius: 50%;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
  cursor: pointer;
  z-index: 999;
  transition: background-color 0.3s ease;
}

#bot-float-button:hover {
  background-color: var(--secondary-color-dark);
}

#bot-float-button i {
  font-size: 24px;
}

#bot-window {
  display: none;
  position: fixed;
  bottom: 90px; 
  right: 30px;
  width: 450px;
  height: 460px;
  border: 1px solid #ccc;
  background: white;
  z-index: 999;
  box-shadow: 0 8px 16px rgba(0,0,0,0.3);
  border-radius: 10px;
  overflow: hidden;
}

#login-modal {
  display: none;
  position: fixed;
  bottom: 90px; 
  right: 30px;
  width: 350px;
  height: 460px;
  border: 1px solid #ccc;
  background: white;
  z-index: 999;
  box-shadow: 0 8px 16px rgba(0,0,0,0.3);
  border-radius: 10px;
  overflow: hidden;
}
#login-modal iframe {
  width: 100%;
  height: 100%;
  border: none;
}

#bot-window iframe {
  width: 100%;
  height: 100%;
  border: none;
}

.modal {
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background-color: rgba(0, 0, 0, 0.6);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 1000;
      }

      /* Contenedor del formulario */
      .modal-content {
        background-color: #1f2937; /* azul oscuro */
        padding: 30px;
        border-radius: 16px;
        width: 360px;
        color: #f1f5f9;
        font-family: 'Segoe UI', sans-serif;
        box-shadow: 0 10px 25px rgba(0,0,0,0.5);
        text-align: center;
      }

      /* Títulos y etiquetas */
      .modal-content h2 {
        margin-bottom: 20px;
        font-size: 22px;
        color: #60a5fa;
      }

      .modal-content label {
        display: block;
        margin-top: 12px;
        font-weight: 500;
        text-align: left;
      }

      /* Inputs */
      .modal-content input {
        width: 100%;
        padding: 10px;
        margin-top: 4px;
        border-radius: 10px;
        border: none;
        background-color: #374151;
        color: #f9fafb;
        font-size: 15px;
      }

      /* Botón */
      .modal-content button {
        margin-top: 20px;
        width: 100%;
        padding: 12px;
        border: none;
        border-radius: 10px;
        background-color: #3b82f6;
        color: white;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.3s ease;
      }

      .modal-content button:hover {
        background-color: #2563eb;
      }
      
      .modal-content .secundario {
        background-color: transparent;
        color: #93c5fd;
        border: 2px solid #60a5fa;
        margin-top: 10px;
      }

      .modal-content .secundario:hover {
        background-color: #1e3a8a;
        color: #fff;
      }

  </style>
  </head>
  <body>
    <button class="back-button" onclick="location.href='Pruebabot.html'">
    </button>
    <nav>
        <div class="nav__logo">
            <img src="src/LogoFitdata2.png" alt="logo"/>
        </div>
        <ul class="nav__links">
            <li class="link"><a href="index.html">Phylix</a></li>
            <% 
                String currentPage = request.getRequestURI();
                if (currentPage.endsWith("FitData")) { 
            %>
            <li class="link"><a href="FitDataa">Inicio</a></li>
            <% } %>
            <li class="link"><a href="Rutinas">Rutinas</a></li>
            <li class="link"><a href="Dietas">Dietas</a></li>
            <li class="link"><a href="Informacion">Informacion</a></li>
        </ul>
        <div id="authButtonContainer">
            <% 
                String username = (String) session.getAttribute("nombre_usuario");
                if (username != null) { %>
              <div class="user-icon" onclick="toggleDropdown()">
                <i class="ri-user-line" style="font-size: 24px; color: #fff;"></i>
                <div class="dropdown-menu">
                    <ul>
                        <li><a href="Perfil">Ver Perfil</a></li>
                        <li><a href="Progreso">Ver Progreso</a></li>
                        <li><a href="Logout">Cerrar Sesión</a></li>
                    </ul>
                </div>
              </div>
            <% } else { %>
              <button class="btn" onclick="location.href='Acceder'">Acceder</button>
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
        
    <div id="bot-float-button" onclick="toggleBot()">
        <i class="ri-robot-line"></i>
    </div>
        
    <div id="bot-window">
        <iframe src="fitdatabot.jsp" frameborder="0"></iframe>
    </div>
    
    <div id="login-modal">
        <iframe src="LoginBot.html" frameborder="0"></iframe>
    </div>


    <script>
        function toggleDropdown() {
            const dropdown = document.querySelector('.dropdown-menu');
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }
        
        function toggleBot() {
            const idUsuario = <%= session.getAttribute("id_usuario") != null ? session.getAttribute("id_usuario") : "null" %>;

            if (idUsuario === null) {
              const loginModal = document.getElementById('login-modal');
              loginModal.style.display = loginModal.style.display === 'block' ? 'none' : 'block';
              return; 
            }
            const botWindow = document.getElementById('bot-window');
            botWindow.style.display = botWindow.style.display === 'block' ? 'none' : 'block';
        }

        function cerrarLoginModal() {
          document.getElementById('login-modal').style.display = 'none';
        }



        document.addEventListener('click', (event) => {
            const dropdown = document.querySelector('.dropdown-menu');
            const userIcon = document.querySelector('.user-icon');

            if (dropdown && !userIcon.contains(event.target)) {
                dropdown.style.display = 'none';
            }
        });
        

        const INACTIVITY_TIMEOUT = 2 * 60 * 1000; 
        let inactivityTimer;

        function handleInactivity() {
          alert("Se excedió el límite de inactividad, se cerró tu sesión.");
          window.location.href = "Logout"; 
        }

        function resetInactivityTimer() {
          clearTimeout(inactivityTimer);
          inactivityTimer = setTimeout(handleInactivity, INACTIVITY_TIMEOUT);
        }

        // Detecta cualquier interacción del usuario para reiniciar el temporizador
        ["mousemove", "keydown", "mousedown", "touchstart"].forEach(event => {
          document.addEventListener(event, resetInactivityTimer);
        });

        // Inicializa el temporizador al cargar la página
        resetInactivityTimer();

    </script>


  </body>
</html>



<%-- 
    Document   : Abraham
    Created on : Jul 1, 2025, 3:16:39 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Curriculum</title>
  <script src="https://unpkg.com/feather-icons"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CV/styles.css">
</head>

<body>
  <div class="container">
    <div class="profile">
      <div class="profile_container">
        <div class="profile_profileImg">
          <img src="${pageContext.request.contextPath}/CV/fotoAbraham.jpg" alt="shaif arfan">
        </div>
        <div>
          <h1 class="profile_name">
            <span class="profile_name_firstName">Abraham</span>
            <span class="profile_name_lastName">Torres</span>
          </h1>
          <p class="profile_title">Estudiante</p>
          <p class="description profile_description">
            Soy alguien a quien le gusta divertirse, experimentar y descubrir cosas nuevas, además de liderar, Estudiante de Cecyt 9 "Juan de Dios Batiz" en ultimo año, cursando la carrera de Tecnico en Programacion
          </p>
        </div>
      </div>
    </div>
    <div class="group-1">
      <div class="skills">
        <h3 class="title">Aprendiendo</h3>
        <ul class="skills_list description">
          <li>JavaScript</li>
          <li>PHP & Wordpress</li>
          <li>Linux</li>
          <li>HTML CSS</li>
          <li>Java</li>
        </ul>
      </div>
      <div class="ref">
        <h3 class="title">Referencia</h3>
        <div class="ref_item">
          <h4 class="ref_name">Luz Maria Vargas</h4>
          <p class="description">Supervisó mi trabajo en un proyecto de desarrollo web</p>
        </div>
        <div class="ref_item">
          <h4 class="ref_name">German Gutierrez Galan</h4>
          <p class="description">Profesor de Programación, Cecyt 9 "Juan de Dios Batiz"</p>
        </div>
      </div>

      <div class="edu">
        <h3 class="title">Educacion</h3>
        <div class="edu_item">
          <p class="item_preTitle">2012-2022</p>
          <h4 class="item_title">Estudiante</h4>
          <p class="item_subtitle">
            Instituto Ovalle Monday
          </p>
        </div>
        <div class="edu_item">
          <p class="item_preTitle">2022-Actualidad</p>
          <h4 class="item_title">Tecnico en Programacion</h4>
          <p class="item_subtitle">
            Centro de Estudios Cientificos y Tecnologicos No 9 Juan de Dios Batiz
          </p>
        </div>
      </div>

      <div class="certification">
        <h3 class="title">Certificacion</h3>
        <div class="certification_item">
          <p class="item_preTitle">2022</p>
          <h4 class="item_title">Nivel B2 en Ingles</h4>
          <p class="description">
            Tuve una educación bilingüe que me permitió realizar una certificación de Cambridge, en la que obtuve nivel B2.
          </p>
        </div>
      </div>
    </div>
    <div class="group-2">
      <div class="exp">
        <h3 class="title">Experiencia Academica</h3>
        <div class="exp_item">
          <p class="item_preTitle">2022 - present</p>
          <h4 class="item_title">Desarrollo de Proyecto</h4>
          <p class="item_subtitle">Estudiante de Carrera Técnica en Programación</p>
          <p class=" description">
            Preparacion y Desarrollo de un proyecto escolar que proporcionó ayuda a una pequeña empresa.
            Preparación y Desarrollo de un proyecto que busca tener un impacto y mejorar la salud de los usuarios.
          </p>
        </div>
        <div class="exp_item">
          <p class="item_preTitle">2020 - 2021</p>
          <h4 class="item_title">Taller de Tecnologías de la Comunicación</h4>
          <p class="item_subtitle">Estudiante de Escuela Secundaria</p>
          <p class="description">
            Desarrollo de un proyecto que permitía a los usuarios visualizar y elegir colores de Pantone con HTML.
            Aprendizaje sobre el uso de Pixlr Editor y uso básico de Scratch.
          </p>
        </div>
      </div>
      <div class="awards">
        <h3 class="title">Recursos</h3>
        <div class="awards_item">
            <p class="item_preTitle"></p>
            <h4 class="item_title">Idiomas</h4>
            <p class="description">
                <ul>
                    <li>Español - Nativo</li>
                    <li>Inglés - Avanzado</li>
                    <li>Francés - Basico</li>
                </ul>
            </p>
        </div>
        <div class="awards_item">
            <p class="item_preTitle"></p>
            <h4 class="item_title">Habilidades</h4>
            <p class="description">
                <ul>
                    <li>Liderazgo</li>
                    <li>Trabajo en equipo</li>
                    <li>Responsabilidad</li>
                    <li>Respeto</li>
                    <li>Resiliente</li>
                </ul>
            </p>
        </div>
    </div>
    

      <div class="interest">
        <h3 class="title">Interesado</h3>
        <div class="interest_items">
          <div class="interest_item">
            <i data-feather="monitor"></i>
            <span>Videojuegos</span>
          </div>
          <div class="interest_item">
            <i data-feather="life-buoy"></i>
            <span>Fútbol</span>
          </div>
          <div class="interest_item">
            <i data-feather="map"></i>
            <span>Viajar</span>
          </div>
        </div>

      </div>
    </div>
    <hr>
    <div class="group-3">
      <div class="contact">
        <h3 class="title">Contact</h3>
        <div class="contact_info">
          <p class="description">
            CDMX, Mexico
          </p>
          <p class="description">
            +52 55 35911603
          </p>
          <p class="description">
            torres.trejo.abraham@gmail.com
          </p>
        </div>
      </div>
      <div class="social">
        <h3 class="title">Socials</h3>
        <div class="social_items">
          <a href="#" target="_b" class="social_item">
            <i data-feather="github"></i>
            <span>/Abraham-Torres10</span>
          </a>
          <a href="#" target="_blank" class="social_item">
            <i data-feather="facebook"></i>
            <span>/Abraham Torres</span>
          </a>
          <a href="#" target="_blank" class="social_item">
            <i data-feather="instagram"></i>
            <span>/abrahamtt10</span>
          </a>
        </div>
      </div>
    </div>
  </div>
  <script>
    feather.replace()
  </script>
</body>

</html>
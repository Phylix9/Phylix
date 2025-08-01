<%-- 
    Document   : PhylixInfo
    Created on : Jul 1, 2025, 3:09:17 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/LogoPhylix.png" type="img/png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="Styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <title>Acerca de</title>
</head>
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
                <a href="<%= request.getContextPath() %>/Phylix.jsp">
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
                <a href="Proyecto.jsp">
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
<body>
    <div class="titulo">
        <h1 id="TituloE">Sobre Phylix</h1>
    </div>
  <div class="container">
    <div class="card">
      <div class="titulito">
        <h3>Misión</h3>
      </div>
      <div class="content">
        <h3>Mision</h3>
        <p>Conectar a las personas con la tecnología de manera significativa, creando soluciones de software que inspiren, simplifiquen y enriquezcan sus vidas.</p>
      </div>
    </div>
    <div class="card">
      <div class="titulito">
        <h3>Visión</h3>
      </div>
      <div class="content">
        <h3>Vision</h3>
        <p>Revolucionar el mundo digital con software que solucione problemas y anticipe las necesidades del futuro, contribuyendo a un mundo más conectado, inteligente y sostenible.</p>
      </div>
    </div>
    <div class="card">
      <div class="titulito">
        <h3>Objetivo</h3>
      </div>
      <div class="content">
        <h3>Objetivo</h3>
        <p>El objetivo principal de Phylix es ser líder en desarrollo de software, ofreciendo servicios de máxima calidad para ganar la confianza y lealtad de nuestros clientes, mientras promovemos valores que inspiran un estilo de vida tecnológico.</p>
      </div>
    </div>
    <div class="card2">
      <div class="titulito">
        <h3>Filosofía</h3>
      </div>
      <div class="content">
        <h3>Filosofia</h3>
        <p>La filosofía de Phylix se centra en la excelencia, innovación y compromiso con el cliente, priorizando su seguridad y agregando valor a sus operaciones. Con un enfoque en la calidad, eficiencia y creatividad, la empresa busca superar expectativas. Phylix trabaja con integridad, transparencia y adaptabilidad, respondiendo a cambios tecnológicos y nuevas necesidades para ofrecer soluciones relevantes y efectivas, con el objetivo de ser un socio confiable que impulse el éxito de sus clientes.</p>
      </div>
    </div>
    <div class="card2">
      <div class="titulito">
        <h3>Valores</h3>
      </div>
      <div class="content">
        <h3>Valores</h3>
        <ul class="listas">
          <li>Confianza: Cumplir promesas con ética y transparencia, gestionando cualquier situación adversa.</li>
          <li>Transparencia: Proporcionar información clara y precisa.</li>
          <li>Empatía: Comprender y compartir los sentimientos y perspectivas de clientes y empleados.</li>
          <li>Responsabilidad: Actuar de manera ética, transparente y legal en todas las operaciones.</li>
          <li>Compromiso: Cumplir nuestras obligaciones como desarrolladores para garantizar la satisfacción del cliente.</li>
      </ul>
      </div>
    </div>
    <div class="card2">
      <div class="titulito">
        <h3>Políticas</h3>
      </div>
      <div class="content">
        <h3>Politicas</h3>
        <ul class="listas">
          <li>Phylix asegura la privacidad y seguridad de los datos de los clientes cumpliendo con las regulaciones.</li>
          <li>Promueve mejoras continuas basadas en la retroalimentación de los usuarios.</li>
          <li>Ofrece una experiencia excepcional desde el primer uso.</li>
          <li>Innova de manera responsable, evaluando el impacto ético y social de sus tecnologías.</li>
      </ul>
      </div>
    </div>
    <div class="card2">
      <div class="titulito">
        <h3>Estrategias</h3>
      </div>
      <div class="content">
        <h3>Estrategias</h3>
        <ul class="listas">
          <li>Garantizar una experiencia de usuario excepcional, priorizando usabilidad y satisfacción.</li>
          <li>Desarrollar contenido relevante y optimizar el sitio web para aumentar la visibilidad y ofrecer recursos del software.</li>
          <li>Innovar continuamente, siguiendo las últimas tendencias tecnológicas para mejorar eficiencia y seguridad.</li>
          <li>Colaborar con instituciones para establecer alianzas estratégicas y ofrecer servicios integrales, fortaleciendo la posición en el mercado.</li>
      </ul>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="vanilla-tilt.js"></script>
  <script>
    VanillaTilt.init(document.querySelectorAll(".card")
    ,{
		max: 25,
		speed: 400,
    glare: true,
    "max-glare": 1,
	});
  </script>
  <script>
    VanillaTilt.init(document.querySelectorAll(".card2")
    ,{
		max: 25,
		speed: 400,
    glare: true,
    "max-glare": 1,
	});
  </script>
  <script>
    let btn = document.querySelector('#btn');
    let sidebar = document.querySelector('.sidebar');
    
    btn.onclick = function () {
        sidebar.classList.toggle('active');
    };
</script>
</body>
</html>
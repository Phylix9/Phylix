<%-- 
    Document   : Miembros
    Created on : Jul 1, 2025, 3:09:35 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/LogoPhylix.png" type="img/png">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="Styles4.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
    <title>Miembros</title>
</head>

<body>
    <div class="titulo">
        <h1 id="TituloE">Sobre Nosotros</h1>
    </div>
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
    
	<div class="wrapper">
		<div class="card">
			<img src="src/pfp-Karla.jpeg" alt="">
			<div class="info">
				<h1>Karla Gomez Delgado</h1>
				<p>Desarrolladora de Software</p>
				<a href="Karla" class="btn">Conoce Mas</a>
			</div>
		</div>
		<div class="card">
			<img src="src/pfp-July.jpeg " alt="">
			<div class="info">
				<h1>Julieta Quiroz Ventura</h1>
				<p>Desarrolladora de Software</p>
				<a href="Julieta" class="btn">Conoce Mas</a>
			</div>
		</div>
		<div class="card">
			<img src="src/pfp-Chris.jpeg" alt="">
			<div class="info">
				<h1>Christian Andre Ramirez Vega</h1>
				<p>Desarrollador de Software</p>
				<a href="Christian" class="btn">Conoce Mas</a>
			</div>
		</div>
		<div class="card">
			<img src="src/pfp-Abraham.jpeg" alt="">
			<div class="info">
				<h1>Abraham Torres Trejo</h1>
				<p>Desarrollador de Software</p>
				<a href="Abraham" class="btn">Conoce Mas</a>
			</div>
		</div>
	</div>

    <script>
        const btn = document.getElementById('btn');
        const sidebar = document.querySelector('.sidebar');
    
        btn.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });
    </script>

</body>
</html>
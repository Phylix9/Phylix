<%-- 
    Document   : Perfil
    Created on : Nov 4, 2024, 10:49:24 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil del Usuario</title>
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="Styles13.css">
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <div class="sidebar">
        <img 
            src="src/pfp-Abraham.jpeg" alt="Profile" class="profile-picture"/>
        <h2></h2>
        <a href="Perfil.html"><i data-lucide="user"></i> Perfil</a>
        <a href="MisDietas.html"><i data-lucide="cookie"></i> Mis Dietas</a>
        <a href="MisRutinas.html"><i data-lucide="dumbbell"></i> Mis Rutinas</a>
        <a href="Logout"><i data-lucide="log-out"></i> Cerrar Sesión</a>
    </div>

    <div class="container">
        <h1>Perfil del Usuario</h1>

        <div class="info-section">
            <h2>Información de Usuario <%= session.getAttribute("id_usuario") %></h2>
            <div class="info">
                <label>Nombre: <%= session.getAttribute("nombre") %></label>
                <span></span>
            </div>
            <div class="info">
                <label>Nombre de Usuario: <%= session.getAttribute("nombre_usuario") %></label>
                <span></span>
            </div>
            <div class="info">
                <label>Correo Electrónico: <%= session.getAttribute("correo_usuario") %></label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Información Básica</h2>
            <div class="info">
                <label>Edad: <%= session.getAttribute("edad") %></label>
                <span></span>
            </div>
            <div class="info">
                <label>Género: <%= session.getAttribute("genero") %></label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Información de Salud</h2>
            <div class="info">
                <label>Estatura: <%= session.getAttribute("estatura") %> metros</label>
                <span></span>
            </div>
            <div class="info">
                <label>Peso: <%= session.getAttribute("peso") %> kg</label>
                <span></span>
            </div>
            <div class="info">
                <label>IMC: <%= session.getAttribute("IMC") %> </label>
                <span></span>
            </div>
            <div class="info">
                <label>Condiciones Médicas: <%= session.getAttribute("condiciones") %></label>
                <span></span>
            </div>
            <div class="info">
                <label>Medicamentos: <%= session.getAttribute("medicamentos") %></label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Nivel de Actividad Física</h2>
            <div class="info">
                <label>Frecuencia de Actividad: <%= session.getAttribute("actividad") %></label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Objetivos Personales</h2>
            <div class="info">
                <label>Objetivo de Salud: <%= session.getAttribute("objetivos") %></label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Alergias y Restricciones</h2>
            <div class="info">
                <label>Alergias: <%= session.getAttribute("alergias") %></label>
                <span></span>
            </div>
            <div class="info">
                <label>Restricciones Alimenticias: <%= session.getAttribute("restricciones") %></label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Otros Factores</h2>
            <div class="info">
                <label>Nivel de Estrés: <%= session.getAttribute("estres") %></label>
                <span></span>
            </div>
            <div class="info">
                <label>Horas de Sueño: <%= session.getAttribute("suenio") %></label>
                <span></span>
            </div>
        </div>

    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>
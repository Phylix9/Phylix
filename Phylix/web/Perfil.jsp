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
            src="#" alt="Profile" class="profile-picture"/>
        <h2></h2>
        <a href="Perfil.html"><i data-lucide="user"></i> Perfil</a>
        <a href="Dietas.html"><i data-lucide="cookie"></i> Mis Dietas</a>
        <a href="Rutinas.html"><i data-lucide="dumbbell"></i> Mis Rutinas</a>
        <a href="Configuracion.html"><i data-lucide="settings"></i> Configuración</a>
        <a href="logout.java"><i data-lucide="log-out"></i> Cerrar Sesión</a>
    </div>

    <div class="container">
        <h1>Perfil del Usuario</h1>

        <div class="info-section">
            <h2>Información de Usuario</h2>
            <div class="info">
                <label>Nombre:</label>
                <span></span>
            </div>
            <div class="info">
                <label>Nombre de Usuario:</label>
                <span></span>
            </div>
            <div class="info">
                <label>Correo Electrónico:</label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Información Básica</h2>
            <div class="info">
                <label>Edad:</label>
                <span></span>
            </div>
            <div class="info">
                <label>Género:</label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Información de Salud</h2>
            <div class="info">
                <label>Estatura:</label>
                <span></span>
            </div>
            <div class="info">
                <label>Peso:</label>
                <span></span>
            </div>
            <div class="info">
                <label>IMC:</label>
                <span></span>
            </div>
            <div class="info">
                <label>Condiciones Médicas:</label>
                <span></span>
            </div>
            <div class="info">
                <label>Medicamentos:</label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Nivel de Actividad Física</h2>
            <div class="info">
                <label>Frecuencia de Actividad:</label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Objetivos Personales</h2>
            <div class="info">
                <label>Objetivo de Salud:</label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Alergias y Restricciones</h2>
            <div class="info">
                <label>Alergias:</label>
                <span></span>
            </div>
            <div class="info">
                <label>Restricciones Alimenticias:</label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Otros Factores</h2>
            <div class="info">
                <label>Nivel de Estrés:</label>
                <span>Moderado</span>
            </div>
            <div class="info">
                <label>Horas de Sueño:</label>
                <span></span>
            </div>
        </div>

        <div class="info-section">
            <h2>Configuración de Cuenta</h2>
            <div class="info">
                <label>Privacidad del Perfil:</label>
                <span></span>
            </div>
            <div class="info">
                <label>Notificaciones:</label>
                <span></span>
            </div>
            <div class="info">
                <label>Idioma:</label>
                <span></span>
            </div>
        </div>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>
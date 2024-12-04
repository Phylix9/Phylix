<%-- 
    Document   : Perfil
    Created on : Nov 4, 2024, 10:49:24 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="clases.Medidas"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil del Usuario</title>
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.4.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="Styles13.css">
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <div class="sidebar">
        <button class="back-button" onclick="location.href='FitData'">
        <i class="ri-arrow-left-line"></i>
    </button>
        <form  id="form-upload" action="AnadirImagen" method="post" enctype="multipart/form-data">
            <label for="file-input">
                <img src="ImagenPerfil" alt="Profile" class="profile-picture" />
            </label>
            <input type="file" accept="image/*" name="archivo" id="file-input" style="display: none;" />
            <!-- <button type="submit">Subir Imagen</button> -->
        </form>
        
        <a href="MisDietas"><i data-lucide="cookie"></i> Mis Dietas</a>
        <a href="Eliminardieta.jsp"><i data-lucide="person-standing"></i> Gestionar Dieta</a>
        <a href="CrearRutina"><i data-lucide="dumbbell"></i> Mis Rutinas</a>
        <a href="Eliminarrutina.jsp"><i data-lucide="utensils-crossed"></i> Gestionar Rutina</a>
        <a href="#" onclick="habilitarEdicion(event)"><i data-lucide="user-round-pen"></i> Modificar perfil</a>
        <a href="EliminarPerfil"><i data-lucide="user-round-x"></i> Eliminar perfil</a>
        <a href="Logout"><i data-lucide="log-out"></i> Cerrar Sesión</a>
    </div>

    <%
         List<Medidas> medidas = (List<Medidas>) request.getAttribute("medidas");
         String username = (String) session.getAttribute("nombre_usuario");
         Double altura = null;
         if (medidas != null){
            for (Medidas medida : medidas) {
                altura = medida.getAltura();
            }
        }
    %>
    <div class="container">
        <h1>Perfil de <%= username %> </h1>

        <form id="form-modificar-perfil" action="ModificarPerfil" method="post">
            <div class="info-section">
                <h2>Información de Usuario</h2>
                <div class="info">
                    <label>Nombre:</label>
                    <input type="text" name="nombre" id="nombre" value="<%= session.getAttribute("nombre") %>" disabled required />
                </div>
                <div class="info">
                    <label>Nombre de Usuario:</label>
                    <input type="text" name="nombre_usuario" id="usuario" value="<%= session.getAttribute("nombre_usuario") %>" disabled required/>
                </div>
                <div class="info">
                    <label>Correo Electrónico: <%= session.getAttribute("correo_usuario") %></label>
                    <input type="hidden" name="correo_usuario" value="<%= session.getAttribute("correo_usuario") %>" />
                </div>

            </div>

            <div class="info-section">
                <h2>Información Básica</h2>
                <div class="info">
                    <label>Edad:</label>
                    <input type="number" name="edad" id="edad" value="<%= session.getAttribute("edad") %>" disabled required/>
                </div>
                <div class="info">
                    <label>Género:</label>
                    <input type="text" name="genero" id="genero" value="<%= session.getAttribute("genero") %>" disabled required/>
                </div>
            </div>

            <div class="info-section">
                <h2>Información de Salud</h2>
                <% if (altura != null && altura > 0) { 
                    for (Medidas medida : medidas) { %>
                    <div class="info">
                        <label>Estatura (m):</label>
                        <input type="number" step="0.01" name="altura" id="altura" value="<%= medida.getAltura() %>" disabled required/>
                    </div>
                    <div class="info">
                        <label>Peso (kg):</label>
                        <input type="number" step="0.1" name="peso" id="peso" value="<%= medida.getPeso() %>" disabled required/>
                    </div>
                    
                    <div class="info">
                        <label>IMC :</label>
                        <input type="number" name="Imc" id="Imc" value="<%= medida.getImc() %>" disabled required readonly/>
                    </div>
                <% } 
                } %>
                <div class="info">
                    <label>Condiciones Médicas:</label>
                    <input type="text" name="condiciones" id="condiciones" value="<%= session.getAttribute("condiciones") %>" disabled required/>
                </div>
                <div class="info">
                    <label>Medicamentos:</label>
                    <input type="text" name="medicamentos" id="medicamentos" value="<%= session.getAttribute("medicamentos") %>" disabled required/>
                </div>
            </div>

            <div class="info-section">
                <h2>Nivel de Actividad Física</h2>
                <div class="info">
                    <label>Frecuencia de Actividad:</label>
                    <input type="text" name="actividad" id="actividad" value="<%= session.getAttribute("actividad") %>" disabled required/>
                </div>
            </div>

            <div class="info-section">
                <h2>Objetivos Personales</h2>
                <div class="info">
                    <label>Objetivo de Salud:</label>
                    <input type="text" name="objetivos" id="objetivos" value="<%= session.getAttribute("objetivos") %>" disabled required/>
                </div>
            </div>

            <div class="info-section">
                <h2>Alergias y Restricciones</h2>
                <div class="info">
                    <label>Alergias:</label>
                    <input type="text" name="alergias" id="alergias" value="<%= session.getAttribute("alergias") %>" disabled required/>
                </div>
                <div class="info">
                    <label>Restricciones Alimenticias:</label>
                    <input type="text" name="restricciones" id="restriccones" value="<%= session.getAttribute("restricciones") %>" disabled required/>
                </div>
            </div>

            <div class="info-section">
                <h2>Otros Factores</h2>
                <div class="info">
                    <label>Nivel de Estrés:</label>
                    <input type="text" name="estres" id="estres" value="<%= session.getAttribute("estres") %>" disabled required/>
                </div>
                <div class="info">
                    <label>Horas de Sueño:</label>
                    <input name="suenio" id="suenio" value="<%= session.getAttribute("suenio") %>" disabled required/>
                </div>
            </div>

            <button id="guardar-cambios" type="submit" style="display:none;">Guardar Cambios</button>
        </form>
    </div>

    <script>
        function habilitarEdicion(event) {
            event.preventDefault();
            const inputs = document.querySelectorAll('input');
            inputs.forEach(input => {
                if(input.id !== "email" ){
                    input.disabled = false;
                }
            });
            document.getElementById('guardar-cambios').style.display = 'block';
        }
        
        lucide.createIcons();
        
        
    document.getElementById('file-input').addEventListener('change', function() {
        if (this.files && this.files[0]) {
            document.getElementById('form-upload').submit(); 
        }
    });
    </script>
</body>
</html>
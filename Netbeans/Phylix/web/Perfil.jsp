<%-- 
    Document   : Perfil
    Created on : Nov 4, 2024, 10:49:24 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="clases.Medidas"%>
<%@ page import="java.sql.*" %>


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
        <button class="back-button" onclick="location.href='FitDataa'">
        <i class="ri-arrow-left-line"></i>
    </button>
        <form  id="form-upload" action="AnadirImagen" method="post" enctype="multipart/form-data">
            <label for="file-input">
                <img src="ImagenPerfil" alt="Profile" class="profile-picture" />
            </label>
            <input type="file" accept="image/*" name="archivo" id="file-input" style="display: none;" />
            <!-- <button type="submit">Subir Imagen</button> -->
        </form>
        
        <a href="MisDietas.jsp"><i data-lucide="cookie"></i> Mis Dietas</a>
        <a href="Eliminardieta.jsp"><i data-lucide="utensils-crossed"></i> Gestionar Dieta</a>
        <a href="MisRutinas.jsp"><i data-lucide="dumbbell"></i> Mis Rutinas</a>
        <a href="Eliminarrutina.jsp"><i data-lucide="person-standing"></i> Gestionar Rutina</a>
        <a href="#" onclick="habilitarEdicion(event)"><i data-lucide="user-round-pen"></i> Modificar perfil</a>
        <a href="EliminarPerfil"><i data-lucide="user-round-x"></i> Eliminar perfil</a>
        <a href="Logout"><i data-lucide="log-out"></i> Cerrar Sesión</a>
    </div>

    <%
        String username = "";
        String nombre = "";
        String correo = "";
        int edad = 0;
        String genero = "";
        String condiciones = "";
        String medicamentos = "";
        String frecuencia = "";
        String objetivo = "";
        String alergias = "";
        String restricciones = "";
        String estres = "";
        String suenio = "";

        Double pesoUsuario = null;
        Double alturaUsuario = null;
        Double imcUsuario = null;

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            Integer idUsuario = (Integer) session.getAttribute("id_usuario");

            if (idUsuario != null) {
                // Obtener datos de Usuario
                stmt = con.prepareStatement("SELECT * FROM Usuario WHERE id_usuario = ?");
                stmt.setInt(1, idUsuario);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    username = rs.getString("nombre_usuario");
                    correo = rs.getString("correo_usuario");
                    edad = rs.getInt("edad_usuario");
                    genero = rs.getString("sexo_usuario");
                }
                rs.close();
                stmt.close();

                // Obtener datos del cuestionario
                stmt = con.prepareStatement("SELECT * FROM Cuestionario WHERE id_usuario = ?");
                stmt.setInt(1, idUsuario);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    nombre = rs.getString("nombre_completo");
                    condiciones = rs.getString("condicion_usuario");
                    medicamentos = rs.getString("medicamento_usuario");
                    frecuencia = rs.getString("frecuencia_usuario");
                    objetivo = rs.getString("objetivo_usuario");
                    alergias = rs.getString("alergias_usuario");
                    restricciones = rs.getString("restriccion_usuario");
                    estres = rs.getString("estres_usuario");
                    suenio = rs.getString("sueno_usuario");
                }
                rs.close();
                stmt.close();

                // Obtener IMC
                stmt = con.prepareStatement("SELECT * FROM IMC WHERE id_usuario = ? ORDER BY id_imc DESC LIMIT 1");
                stmt.setInt(1, idUsuario);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    pesoUsuario = rs.getDouble("peso_usuario");
                    alturaUsuario = rs.getDouble("altura_usuario");
                    imcUsuario = rs.getDouble("imc_usuario");
                }
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                out.println("<p>Error al cerrar la base: " + e.getMessage() + "</p>");
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
                    <input type="text" name="nombre" id="nombre" value="<%= nombre %>" disabled required />
                </div>
                <div class="info">
                    <label>Nombre de Usuario:</label>
                    <input type="text" name="nombre_usuario" id="usuario" value="<%= username %>" disabled required/>
                </div>
                <div class="info">
                    <label>Correo Electrónico: <%= correo %></label>
                    <input type="hidden" name="correo_usuario" value="<%= correo %>" />
                </div>

            </div>

            <div class="info-section">
                <h2>Información Básica</h2>
                <div class="info">
                    <label>Edad:</label>
                    <input type="number" name="edad" id="edad" value="<%= edad %>" disabled required/>
                </div>
                <div class="info">
                    <label>Género:</label>
                    <input type="text" name="genero" id="genero" value="<%= genero %>" disabled required/>
                </div>
            </div>

            <div class="info-section">
                <h2>Información de Salud</h2>

                    <div class="info">
                        <label>Estatura (m):</label>
                        <input type="number" step="0.01" name="altura" id="altura" 
                               value="<%= (alturaUsuario != null) ? alturaUsuario : "" %>" 
                               disabled required/>
                    </div>

                    <div class="info">
                        <label>Peso (kg):</label>
                        <input type="number" step="0.1" name="peso" id="peso" 
                               value="<%= (pesoUsuario != null) ? pesoUsuario : "" %>" 
                               disabled required/>
                    </div>

                    <div class="info">
                        <label>IMC :</label>
                        <input type="number" name="Imc" id="Imc" 
                               value="<%= (imcUsuario != null) ? String.format("%.2f", imcUsuario) : "" %>" 
                               disabled required readonly/>
                    </div>

                <div class="info">
                    <label>Condiciones Médicas:</label>
                    <input type="text" name="condiciones" id="condiciones" value="<%= condiciones %>" disabled required/>
                </div>
                <div class="info">
                    <label>Medicamentos:</label>
                    <input type="text" name="medicamentos" id="medicamentos" value="<%= medicamentos %>" disabled required/>
                </div>
            </div>

            <div class="info-section">
                <h2>Nivel de Actividad Física</h2>
                <div class="info">
                    <label>Frecuencia de Actividad:</label>
                    <input type="text" name="actividad" id="actividad" value="<%= frecuencia %>" disabled required/>
                </div>
            </div>

            <div class="info-section">
                <h2>Objetivos Personales</h2>
                <div class="info">
                    <label>Objetivo de Salud:</label>
                    <input type="text" name="objetivos" id="objetivos" value="<%= objetivo %>" disabled required/>
                </div>
            </div>

            <div class="info-section">
                <h2>Alergias y Restricciones</h2>
                <div class="info">
                    <label>Alergias:</label>
                    <input type="text" name="alergias" id="alergias" value="<%= alergias %>" disabled required/>
                </div>
                <div class="info">
                    <label>Restricciones Alimenticias:</label>
                    <input type="text" name="restricciones" id="restriccones" value="<%= restricciones %>" disabled required/>
                </div>
            </div>

            <div class="info-section">
                <h2>Otros Factores</h2>
                <div class="info">
                    <label>Nivel de Estrés:</label>
                    <input type="text" name="estres" id="estres" value="<%= estres %>" disabled required/>
                </div>
                <div class="info">
                    <label>Horas de Sueño:</label>
                    <input name="suenio" id="suenio" value="<%= suenio %>" disabled required/>
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
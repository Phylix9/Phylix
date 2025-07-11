<%-- 
    Document   : Cuadriceps
    Created on : Nov 4, 2024, 10:53:53 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css">
    <link rel="stylesheet" href="Styles7.css">
    <title>Cuadriceps</title>
</head>
<body>

    <button class="back-button" onclick="window.history.back();">
        <i class="ri-arrow-left-line"></i>
    </button>

    <%
        String username = (String) session.getAttribute("nombre_usuario");
    %>
    <h2>Elige tus Ejercicios <%=username%></h2>
    
    <form action="CrearRutina" method="post">
        <h3>Ingresa el nombre de tu rutina</h3>
        <input type="text" name="nombreRutina" id="nombreRutina">
    <div class="checkbox-container">
        <div class="checkbox-group" id="Cuadriceps">
            <input type="hidden" name="grupoEjercicio0" value="Cuadriceps">
            <label>Elige 3 Ejercicios para Cuádriceps</label>
            <label><input type="checkbox" name="ejercicio1_1" value="Sentadilla con barra"> Sentadilla con barra</label>
            <label><input type="checkbox" name="ejercicio1_2" value="Prensa de piernas"> Prensa de piernas</label>
            <label><input type="checkbox" name="ejercicio1_3" value="Extensión de piernas en máquina"> Extensión de piernas en máquina</label>
            <label><input type="checkbox" name="ejercicio1_4" value="Zancadas con mancuernas"> Zancadas con mancuernas</label>
            <label><input type="checkbox" name="ejercicio1_5" value="Hack Squat"> Hack Squat</label>
            <div class="error-message">Por favor, selecciona exactamente 3 ejercicios.</div>
        </div>

        <div class="checkbox-group" id="Pantorrilla">
            <input type="hidden" name="grupoEjercicio1" value="Pantorrilla">
            <label>Elige 3 Ejercicios para Pantorrilla</label>
            <label><input type="checkbox" name="ejercicio2_1" value="Elevación de gemelos de pie"> Elevación de gemelos de pie</label>
            <label><input type="checkbox" name="ejercicio2_2" value="Elevación de gemelos sentado"> Elevación de gemelos sentado</label>
            <label><input type="checkbox" name="ejercicio2_3" value="Prensa para pantorrillas"> Prensa para pantorrillas</label>
            <label><input type="checkbox" name="ejercicio2_4" value="Step con elevación de gemelos"> Step con elevación de gemelos</label>
            <label><input type="checkbox" name="ejercicio2_5" value="Saltos con peso"> Saltos con peso</label>
            <div class="error-message">Por favor, selecciona exactamente 3 ejercicios.</div>
        </div>

        <div class="checkbox-group" id="Abductor">
            <input type="hidden" name="grupoEjercicio2" value="Abductor">
            <label>Elige 2 Ejercicios para Abductor</label>
            <label><input type="checkbox" name="ejercicio3_1" value="Abducción de cadera en máquina"> Abducción de cadera en máquina</label>
            <label><input type="checkbox" name="ejercicio3_2" value="Elevaciones laterales de pierna"> Elevaciones laterales de pierna</label>
            <label><input type="checkbox" name="ejercicio3_3" value="Puente con abducción de cadera"> Puente con abducción de cadera</label>
            <label><input type="checkbox" name="ejercicio3_4" value="Ejercicio con banda de resistencia (abducción de cadera)"> Ejercicio con banda de resistencia (abducción de cadera)</label>
            <label><input type="checkbox" name="ejercicio3_5" value="Sentadillas laterales"> Sentadillas laterales</label>
            <div class="error-message">Por favor, selecciona exactamente 2 ejercicios.</div>
        </div>

        

        <!--
        <div class="checkbox-group" id="Abductores">
            <label>Elige 2 Ejercicios Complementarios</label>
            <label><input type="checkbox" name="abductores" value="Cable"> Abducción de pierna en cable</label>
            <label><input type="checkbox" name="abductores" value="Bandas"> Abducción con banda de resistencia</label>
            <label><input type="checkbox" name="gluteo" value="Hip thrust"> Hip Thrust</label>
            <label><input type="checkbox" name="gluteo" value="Patada de glúteo"> Patada de glúteo en polea</label>
            <label><input type="checkbox" name="gluteo" value="Cable Pull-through"> Cable Pull-through</label>
            <div class="error-message">Por favor, selecciona exactamente 2 ejercicios.</div>
        </div>
        --->
    
        <!---
        <div class="checkbox-group" id="Abdomen">
            <label>Elige 2 Ejercicios para Abdomen</label>
            <label><input type="checkbox" name="abdomen" value="Crunch"> Crunch abdominal</label>
            <label><input type="checkbox" name="abdomen" value="Plancha"> Plancha</label>
            <label><input type="checkbox" name="abdomen" value="Levantamiento de piernas"> Levantamiento de piernas</label>
            <label><input type="checkbox" name="abdomen" value="Mountain Climbers"> Mountain Climbers</label>
            <label><input type="checkbox" name="abdomen" value="Russian Twist"> Russian Twist</label>
            <div class="error-message">Por favor, selecciona exactamente 2 ejercicios.</div>
        </div>
    
        
        <div class="checkbox-group" id="Cardio">
            <label>Elige 2 Ejercicios de Cardio</label>
            <label><input type="checkbox" name="cardio" value="Caminadora"> Caminadora</label>
            <label><input type="checkbox" name="cardio" value="Elíptica"> Elíptica</label>
            <label><input type="checkbox" name="cardio" value="Bicicleta"> Bicicleta estática</label>
            <label><input type="checkbox" name="cardio" value="Cuerda"> Saltar la cuerda</label>
            <label><input type="checkbox" name="cardio" value="Remo"> Máquina de remo</label>
            <div class="error-message">Por favor, selecciona exactamente 2 ejercicios.</div>
        </div>
        --->
    </div>
    <div class="center-container">
        <h3>Selecciona el día de la semana</h3>
        <div class="styled-select">
            <select name="diaRutina" required>
                <%
                    List<String> diasDisponibles = (List<String>) request.getAttribute("diasDisponibles");

                    if (diasDisponibles != null && !diasDisponibles.isEmpty()) {
                        for (String dia : diasDisponibles) {
                %>
                            <option value="<%= dia %>">
                                <%= dia.substring(0,1).toUpperCase() + dia.substring(1).toLowerCase() %>
                            </option>
                <%
                        }
                    } else {
                %>
                    <option disabled selected>No hay días disponibles</option>
                <%
                    }
                %>
            </select>
        </div>
    </div>


    <div class="button-container">
        <input type="submit" class="btn" name="Cuadriceps" value="Crear Rutina">
    </div>
    </form>

    <script>
        function limitarCheckboxes(id, max) {
            const group = document.getElementById(id);
            const checkboxes = group.querySelectorAll('input[type="checkbox"]');
            
            checkboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    const seleccionadas = group.querySelectorAll('input[type="checkbox"]:checked');
                    if (seleccionadas.length > max) {
                        this.checked = false;
                        group.classList.add('error');
                    } else {
                        group.classList.remove('error');
                    }
                });
            });
        }

        ['Cuadriceps', 'Pantorrilla'].forEach(id => {
            limitarCheckboxes(id, 3);
        });

        ['Abductor'].forEach(id => {
            limitarCheckboxes(id, 2);
        });
    </script>
</body>
</html>

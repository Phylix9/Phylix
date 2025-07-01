<%-- 
    Document   : Full
    Created on : Nov 4, 2024, 10:51:10 AM
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
    <title>Full Body</title>
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
        <div class="checkbox-group" id="Hombros">
            <label>Elige 1 Ejercicio para Hombro</label>
            <label><input type="checkbox" name="ejercicio1_1" value="Press supino"> Press militar agarre supino con mancuernas</label>
            <label><input type="checkbox" name="ejercicio1_1" value="Press neutro"> Press militar agarre neutro con mancuernas</label>
            <label><input type="checkbox" name="ejercicio1_1" value="Press barra"> Press militar con barra</label>
            <label><input type="checkbox" name="ejercicio1_1" value="Laterales"> Elevaciones laterales</label>
            <label><input type="checkbox" name="ejercicio1_1" value="Frontales"> Elevaciones frontales</label>
            <div class="error-message">Por favor, selecciona exactamente 1 ejercicio.</div>
        </div>

        <div class="checkbox-group" id="Biceps">
            <label>Elige 1 Ejercicio para Bíceps</label>
            <label><input type="checkbox" name="ejercicio1_2" value="Curl barra"> Curl con barra normal o z</label>
            <label><input type="checkbox" name="ejercicio1_2" value="Curl mancuernas"> Curl con mancuernas</label>
            <label><input type="checkbox" name="ejercicio1_2" value="Curl martillo"> Curl martillo, con mancuernas o barra, agarre neutro</label>
            <label><input type="checkbox" name="ejercicio1_2" value="Curl araña"> Curl en banco inclinado, con las mancuernas por detrás del pecho</label>
            <label><input type="checkbox" name="ejercicio1_2" value="Curl predicador"> Curl soportado en un banco, con barra o en máquina</label>
            <div class="error-message">Por favor, selecciona exactamente 1 ejercicio.</div>
        </div>

        <div class="checkbox-group" id="Triceps">
            <label>Elige 1 Ejercicio para Triceps</label>
            <label><input type="checkbox" name="ejercicio1_3" value="Press frances"> Press francés con barra z</label>
            <label><input type="checkbox" name="ejercicio1_3" value="Extension polea baja"> Extensión de triceps con cuerda, en polea baja</label>
            <label><input type="checkbox" name="ejercicio1_3" value="Fondos"> Fondos en paralelas para tríceps</label>
            <label><input type="checkbox" name="ejercicio1_3" value="Press cerrado"> Press de pecho cerrado, enfoque en triceps</label>
            <label><input type="checkbox" name="ejercicio1_3" value="Copas"> Contracción y extensión de triceps con mancuerna, trasnuca</label>
            <div class="error-message">Por favor, selecciona exactamente 1 ejercicio.</div>
        </div>

        <div class="checkbox-group" id="Pecho">
            <label>Elige 1 Ejercicio para Pecho</label>
            <label><input type="checkbox" name="ejercicio2_1" value="Press pecho"> Press de pecho en banco plano</label>
            <label><input type="checkbox" name="ejercicio2_1" value="Press inclinado"> Press de pecho en banco inclinado</label>
            <label><input type="checkbox" name="ejercicio2_1" value="Cruces polea"> Cruces de arriba hacia abajo en polea</label>
            <label><input type="checkbox" name="ejercicio2_1" value="Aperturas"> Aperturas de pecho en máquina o con mancuernas</label>
            <label><input type="checkbox" name="ejercicio2_1" value="Press declinado"> Press de pecho en banco declinado</label>
            <div class="error-message">Por favor, selecciona exactamente 1 ejercicio.</div>
        </div>

        <div class="checkbox-group" id="Espalda">
            <label>Elige 1 Ejercicios para Espalda</label>
            <label><input type="checkbox" name="ejercicio2_2" value="Jalon pecho"> Jalón al pecho en máquina</label>
            <label><input type="checkbox" name="ejercicio2_2" value="Remo supino"> Remo con barra agarre supino</label>
            <label><input type="checkbox" name="ejercicio2_2" value="Pull over"> Pull over con cuerda en polea</label>
            <label><input type="checkbox" name="ejercicio2_2" value="Remo neutro"> Remo agarre neutro con mancuernas o en máquina</label>
            <label><input type="checkbox" name="ejercicio2_2" value="Jalon triangulo"> Jalón al pecho en máquina con agarre en forma de triángulo</label>
            <div class="error-message">Por favor, selecciona exactamente 1 ejercicio.</div>
        </div>

        <div class="checkbox-group" id="Cuadriceps">
            <label>Elige 1 Ejercicio para Cuádriceps</label>
            <label><input type="checkbox" name="ejercicio2_3" value="Sentadilla"> Sentadilla con barra</label>
            <label><input type="checkbox" name="ejercicio2_3" value="Prensa"> Prensa de piernas</label>
            <label><input type="checkbox" name="ejercicio2_3" value="Extension"> Extensión de piernas en máquina</label>
            <label><input type="checkbox" name="ejercicio2_3" value="Zancadas"> Zancadas con mancuernas</label>
            <label><input type="checkbox" name="ejercicio2_3" value="Hack Squat"> Hack Squat</label>
            <div class="error-message">Por favor, selecciona exactamente 1 ejercicio.</div>
        </div>

        <div class="checkbox-group" id="Femoral">
            <label>Elige 1 Ejercicio para Femoral</label>
            <label><input type="checkbox" name="ejercicio3_1" value="Curl sentado"> Curl de piernas sentado</label>
            <label><input type="checkbox" name="ejercicio3_1" value="Curl acostado"> Curl de piernas acostado</label>
            <label><input type="checkbox" name="ejercicio3_1" value="Peso muerto"> Peso muerto rumano</label>
            <label><input type="checkbox" name="ejercicio3_1" value="Hip Thrust"> Hip Thrust</label>
            <label><input type="checkbox" name="ejercicio3_1" value="Sentadilla profunda"> Sentadilla profunda</label>
            <div class="error-message">Por favor, selecciona exactamente 1 ejercicio.</div>
        </div>
    
        <div class="checkbox-group" id="Abdomen">
            <label>Elige 1 Ejercicio para Abdomen</label>
            <label><input type="checkbox" name="ejercicio3_2" value="Crunch"> Crunch abdominal</label>
            <label><input type="checkbox" name="ejercicio3_2" value="Plancha"> Plancha</label>
            <label><input type="checkbox" name="ejercicio3_2" value="Levantamiento de piernas"> Levantamiento de piernas</label>
            <label><input type="checkbox" name="ejercicio3_2" value="Mountain Climbers"> Mountain Climbers</label>
            <label><input type="checkbox" name="ejercicio3_2" value="Russian Twist"> Russian Twist</label>
            <div class="error-message">Por favor, selecciona exactamente 1 ejercicio.</div>
        </div>
    
        <div class="checkbox-group" id="Cardio">
            <label>Elige 1 Ejercicio de Cardio</label>
            <label><input type="checkbox" name="ejercicio3_3" value="Caminadora"> Caminadora</label>
            <label><input type="checkbox" name="ejercicio3_3" value="Elíptica"> Elíptica</label>
            <label><input type="checkbox" name="ejercicio3_3" value="Bicicleta"> Bicicleta estática</label>
            <label><input type="checkbox" name="ejercicio3_3" value="Cuerda"> Saltar la cuerda</label>
            <label><input type="checkbox" name="ejercicio3_3" value="Remo"> Máquina de remo</label>
            <div class="error-message">Por favor, selecciona exactamente 1 ejercicio.</div>
        </div>
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
        <input type="submit" class="btn" name="Full" value="Crear Rutina">
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

        ['Hombros', 'Biceps', 'Triceps', 'Pecho', 'Espalda', 'Cuadriceps',
         'Femoral', 'Abdomen', 'Cardio'].forEach(id => {
            limitarCheckboxes(id, 1);
        });
    </script>
</body>
</html>
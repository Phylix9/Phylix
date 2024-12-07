<%-- 
    Document   : Abdomen
    Created on : Nov 4, 2024, 10:53:57 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css">
    <link rel="stylesheet" href="Styles7.css">
    <title>Abdomen</title>
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
    <div class="checkbox-group" id="Abdomen">
        <input type="hidden" name="grupoEjercicio0" value="Abdomen">
        <label>Elige 3 Ejercicios para Abdomen</label>
        <label><input type="checkbox" name="ejercicio1_1" value="Crunch"> Crunch abdominal</label>
        <label><input type="checkbox" name="ejercicio1_2" value="Plancha"> Plancha</label>
        <label><input type="checkbox" name="ejercicio1_3" value="Levantamiento de piernas"> Levantamiento de piernas</label>
        <label><input type="checkbox" name="ejercicio1_4" value="Mountain Climbers"> Mountain Climbers</label>
        <label><input type="checkbox" name="ejercicio1_5" value="Russian Twist"> Russian Twist</label>
        <div class="error-message">Por favor, selecciona exactamente 3 ejercicios.</div>
    </div>

    <div class="checkbox-group" id="Espaldabaja">
        <input type="hidden" name="grupoEjercicio1" value="Espalda Baja">
        <label>Elige 3 Ejercicios para Espalda baja</label>
        <label><input type="checkbox" name="ejercicio2_1" value="Extension"> Extensión lumbar</label>
        <label><input type="checkbox" name="ejercicio2_2" value="BuenosDias"> Buenos días con barra</label>
        <label><input type="checkbox" name="ejercicio2_3" value="PlanchaInvertida"> Plancha invertida</label>
        <label><input type="checkbox" name="ejercicio2_4" value="PaseoGranjero"> Paseo del granjero</label>
        <label><input type="checkbox" name="ejercicio2_5" value="Puente"> Puente</label>
        <div class="error-message">Por favor, selecciona exactamente 3 ejercicios.</div>
    </div>    

    <div class="checkbox-group" id="Cardio">
        <input type="hidden" name="grupoEjercicio2" value="Cardio">
        <label>Elige 1 Ejercicio de Cardio</label>
        <label><input type="checkbox" name="ejercicio3_1" value="Caminadora"> Caminadora</label>
        <label><input type="checkbox" name="ejercicio3_2" value="Elíptica"> Elíptica</label>
        <label><input type="checkbox" name="ejercicio3_3" value="Bicicleta"> Bicicleta estática</label>
        <label><input type="checkbox" name="ejercicio3_4" value="Cuerda"> Saltar la cuerda</label>
        <label><input type="checkbox" name="ejercicio3_5" value="Remo"> Máquina de remo</label>
        <div class="error-message">Por favor, selecciona exactamente 1 ejercicio.</div>
    </div>
</div>


    <div class="button-container">
        <input type="submit" class="btn" name="Abdomen" value="Crear Rutina">
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

        ['Abdomen', 'Espaldabaja'].forEach(id => {
            limitarCheckboxes(id, 3);
        });
        ['Cardio'].forEach(id => {
            limitarCheckboxes(id, 1);
        });
    </script>
</body>
</html>

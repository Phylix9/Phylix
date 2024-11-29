<%-- 
    Document   : Espalda
    Created on : Nov 4, 2024, 10:53:31 AM
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
    <title>Rutinas Predeterminadas</title>
</head>
<body>

    <button class="back-button" onclick="window.history.back();">
        <i class="ri-arrow-left-line"></i>
    </button>

    <h2>Elige tus Ejercicios</h2>
    
    <form action="CrearRutina" method="post">
    <div class="checkbox-container">
    
    <div class="checkbox-group" id="Espalda">
            <input type="hidden" name="grupoEjercicio0" value="Espalda">
            <label>Elige 3 Ejercicios para Espalda</label>
            <label><input type="checkbox" name="ejercicio1_1" value="Jalón al pecho en máquina"> Jalón al pecho en máquina</label>
            <label><input type="checkbox" name="ejercicio1_2" value="Remo con barra agarre supino"> Remo con barra agarre supino</label>
            <label><input type="checkbox" name="ejercicio1_3" value="Pull over con cuerda en polea"> Pull over con cuerda en polea</label>
            <label><input type="checkbox" name="ejercicio1_4" value="Remo agarre neutro con mancuernas o en máquina"> Remo agarre neutro con mancuernas o en máquina</label>
            <label><input type="checkbox" name="ejercicio1_5" value="Jalón al pecho en máquina con agarre en forma de triángulo"> Jalón al pecho en máquina con agarre en forma de triángulo</label>
            <div class="error-message">Por favor, selecciona exactamente 3 ejercicios.</div>
    </div>
    <div class="checkbox-group" id="Biceps">
        <input type="hidden" name="grupoEjercicio1" value="Biceps">
        <label>Elige 3 Ejercicios para Bíceps</label>
        <label><input type="checkbox" name="ejercicio2_1" value="Curl con barra normal o z"> Curl con barra normal o z</label>
        <label><input type="checkbox" name="ejercicio2_2" value="Curl con mancuernas"> Curl con mancuernas</label>
        <label><input type="checkbox" name="ejercicio2_3" value="Curl martillo, con mancuernas o barra, agarre neutro"> Curl martillo, con mancuernas o barra, agarre neutro</label>
        <label><input type="checkbox" name="ejercicio2_4" value="Curl en banco inclinado, con las mancuernas por detrás del pecho"> Curl en banco inclinado, con las mancuernas por detrás del pecho</label>
        <label><input type="checkbox" name="ejercicio2_5" value="Curl soportado en un banco, con barra o en máquina"> Curl soportado en un banco, con barra o en máquina</label>
        <div class="error-message">Por favor, selecciona exactamente 3 ejercicios.</div>
    </div>
        
    <div class="checkbox-group" id="Hombros">
        <input type="hidden" name="grupoEjercicio2" value="Hombros">
        <label>Elige 2 Ejercicios para Hombro</label>
        <label><input type="checkbox" name="ejercicio3_1" value="Press militar agarre supino con mancuernas"> Press militar agarre supino con mancuernas</label>
        <label><input type="checkbox" name="ejercicio3_2" value="Press militar agarre neutro con mancuernas"> Press militar agarre neutro con mancuernas</label>
        <label><input type="checkbox" name="ejercicio3_3" value="Press militar con barra"> Press militar con barra</label>
        <label><input type="checkbox" name="ejercicio3_4" value="Elevaciones laterales"> Elevaciones laterales</label>
        <label><input type="checkbox" name="ejercicio3_5" value="Elevaciones frontales"> Elevaciones frontales</label>
        <div class="error-message">Por favor, selecciona exactamente 2 ejercicios.</div>
    </div>
        
</div>



    <!-- 
    <div class="checkbox-group" id="Abdomen">
        <label>Elige 2 Ejercicios Complementarios</label>
        <label><input type="checkbox" name="abdomen" value="Crunch"> Crunch abdominal</label>
        <label><input type="checkbox" name="abdomen" value="Plancha"> Plancha</label>
        <label><input type="checkbox" name="cardio" value="Curl"> Curl para Antebrazo</label>
        <label><input type="checkbox" name="cardio" value="Encogimiento"> Encogimientos hacia arriba de hombros con barra o mancuernas</label>
        <label><input type="checkbox" name="cardio" value="Dominadas"> Dominadas </label>
        <div class="error-message">Por favor, selecciona exactamente 2 ejercicios.</div>
    </div>
    -->
    </div>

    <div class="button-container">
        <input type="submit" class="btn" name="Espalda"value="Crear Rutina">
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

        ['Biceps','Espalda'].forEach(id => {
            limitarCheckboxes(id, 3);
        });
        ['Hombros'].forEach(id => {
            limitarCheckboxes(id, 2);
        });
    </script>
</body>
</html>

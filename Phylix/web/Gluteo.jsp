<%-- 
    Document   : Gluteo
    Created on : Nov 4, 2024, 10:50:44 AM
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
    <div class="checkbox-group" id="Cuadriceps">
        <input type="hidden" name="grupoEjercicio0" value="Cuadriceps">
        <label>Elige 2 Ejercicios para Cuádriceps</label>
        <label><input type="checkbox" name="ejercicio1_1" value="Sentadilla con barra"> Sentadilla con barra</label>
        <label><input type="checkbox" name="ejercicio1_2" value="Prensa de piernas"> Prensa de piernas</label>
        <label><input type="checkbox" name="ejercicio1_3" value="Extensión de piernas en máquina"> Extensión de piernas en máquina</label>
        <label><input type="checkbox" name="ejercicio1_4" value="Zancadas con mancuernas"> Zancadas con mancuernas</label>
        <label><input type="checkbox" name="ejercicio1_5" value="Hack Squat"> Hack Squat</label>
        <div class="error-message">Por favor, selecciona exactamente 2 ejercicios.</div>
    </div>

    <div class="checkbox-group" id="Femoral">
        <input type="hidden" name="grupoEjercicio1" value="Femoral">
        <label>Elige 2 Ejercicios para Femoral</label>
        <label><input type="checkbox" name="ejercicio2_1" value="Curl de piernas sentado"> Curl de piernas sentado</label>
        <label><input type="checkbox" name="ejercicio2_2" value="Curl de piernas acostado"> Curl de piernas acostado</label>
        <label><input type="checkbox" name="ejercicio2_3" value="Peso muerto rumano"> Peso muerto rumano</label>
        <label><input type="checkbox" name="ejercicio2_4" value="Peso muerto sumo"> Peso muerto sumo</label>
        <label><input type="checkbox" name="ejercicio2_5" value="Hip Thrust"> Hip Thrust</label>
        <div class="error-message">Por favor, selecciona exactamente 2 ejercicios.</div>
    </div>

    <div class="checkbox-group" id="Gluteo">
        <input type="hidden" name="grupoEjercicio1" value="Glúteo">
        <label>Elige 3 Ejercicios para Glúteo</label>
        <label><input type="checkbox" name="ejercicio3_1" value="Hip Thrust"> Hip Thrust</label>
        <label><input type="checkbox" name="ejercicio3_2" value="Puente de glúteo"> Puente de glúteo</label>
        <label><input type="checkbox" name="ejercicio3_3" value="Sentadilla profunda"> Sentadilla profunda</label>
        <label><input type="checkbox" name="ejercicio3_4" value="Patada de glúteo en polea"> Patada de glúteo en polea</label>
        <label><input type="checkbox" name="ejercicio3_5" value="Cable Pull-through"> Cable Pull-through</label>
        <div class="error-message">Por favor, selecciona exactamente 3 ejercicios.</div>
    </div>
</div>

    </div>

    <div class="button-container">
        <input type="submit" class="btn" name="Gluteo" value="Crear Rutina">
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

        ['Cuadriceps', 'Femoral'].forEach(id => {
            limitarCheckboxes(id, 2);
        });
        ['Gluteo'].forEach(id => {
            limitarCheckboxes(id, 3);
        });
    </script>
</body>
</html>

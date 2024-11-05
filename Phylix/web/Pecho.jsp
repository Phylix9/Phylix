<%-- 
    Document   : Pecho
    Created on : Nov 4, 2024, 10:45:57 AM
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
    <div class="checkbox-group" id="Triceps">
        <input type="hidden" name="grupoEjercicio0" value="Triceps">
        <label>Elige 3 Ejercicios para Triceps</label>
        <label><input type="checkbox" name="ejercicio1_1" value="Press francés con barra z"> Press francés con barra z</label>
        <label><input type="checkbox" name="ejercicio1_2" value="Extensión de triceps con cuerda, en polea baja"> Extensión de triceps con cuerda, en polea baja</label>
        <label><input type="checkbox" name="ejercicio1_3" value="Fondos en paralelas para tríceps"> Fondos en paralelas para tríceps</label>
        <label><input type="checkbox" name="ejercicio1_4" value="Press de pecho cerrado, enfoque en triceps"> Press de pecho cerrado, enfoque en triceps</label>
        <label><input type="checkbox" name="ejercicio1_5" value="Contracción y extensión de triceps con mancuerna, trasnuca"> Contracción y extensión de triceps con mancuerna, trasnuca</label>
        <div class="error-message">Por favor, selecciona exactamente 3 ejercicios.</div>
    </div>

    <div class="checkbox-group" id="Pecho">
        <input type="hidden" name="grupoEjercicio1" value="Pecho">
        <label>Elige 3 Ejercicios para Pecho</label>
        <label><input type="checkbox" name="ejercicio2_1" value="Press de pecho en banco plano"> Press de pecho en banco plano</label>
        <label><input type="checkbox" name="ejercicio2_2" value="Press de pecho en banco inclinado"> Press de pecho en banco inclinado</label>
        <label><input type="checkbox" name="ejercicio2_3" value="Cruces de arriba hacia abajo en polea"> Cruces de arriba hacia abajo en polea</label>
        <label><input type="checkbox" name="ejercicio2_4" value="Aperturas de pecho en máquina o con mancuernas"> Aperturas de pecho en máquina o con mancuernas</label>
        <label><input type="checkbox" name="ejercicio2_5" value="Press de pecho en banco declinado"> Press de pecho en banco declinado</label>
        <div class="error-message">Por favor, selecciona exactamente 3 ejercicios.</div>
    </div>

    <div class="checkbox-group" id="Abdomen">
        <input type="hidden" name="grupoEjercicio2" value="Complementarios">
        <label>Elige 2 Ejercicios Complementarios</label>
        <label><input type="checkbox" name="ejercicio3_1" value="Abdominales regulares"> Abdominales regulares</label>
        <label><input type="checkbox" name="ejercicio3_2" value="Curl para Antebrazo"> Curl para Antebrazo</label>
        <label><input type="checkbox" name="ejercicio3_3" value="Curl inverso para Antebrazo"> Curl inverso para Antebrazo</label>
        <label><input type="checkbox" name="ejercicio3_4" value="Push Ups/Lagartijas"> Push Ups/Lagartijas</label>
        <label><input type="checkbox" name="ejercicio3_5" value="Cruces de abajo hacia arriba en polea"> Cruces de abajo hacia arriba en polea</label>
        <div class="error-message">Por favor, selecciona exactamente 2 ejercicios.</div>
    </div>
</div>

        
        <div class="button-container">
            <input type="submit" class="btn" name="Pecho" value="Crear Rutina">
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

        ['Triceps', 'Pecho'].forEach(id => {
            limitarCheckboxes(id, 3);
        });
        ['Abdomen'].forEach(id => {
            limitarCheckboxes(id, 2);
        });
    </script>
</body>
</html>


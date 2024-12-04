<%-- 
    Document   : Cuestionario
    Created on : Nov 4, 2024, 10:55:05 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <link rel="stylesheet" href="Styles11.css"/>
    <title>Cuestionario de Salud</title>
</head>
<body>
    <button class="back-button" onclick="history.back()">
        <i class="fas fa-chevron-left"></i>
        Volver
    </button>

    <div class="content-wrapper">
        <h1>Cuestionario de Salud</h1>
        <p>Necesitamos saber un poco mas sobre ti</p>
        <form action="Cuestionario" method="post">
            <div class="section">
                <div class="section-header">
                    <i class="fas fa-heart section-header-icon"></i>
                    <h2>Información Básica</h2>
                </div>
                <label for="nombre">Nombre completo:</label>
                <input type="text" id="nombre" name="nombrecompleto" required>

                <label for="edad">Edad:</label>
                <input type="number" id="edad" name="edad" min="0" max="110" required>

                <label for="genero">Género:</label>
                <select id="genero" name="genero" onchange="toggleExtraField('genero', 'generoOtro')">
                    <option value="femenino">Femenino</option>
                    <option value="masculino">Masculino</option>
                    <option value="otro">Otro</option>
                </select>
                <input type="text" id="generoOtro" name="generoOtro" placeholder="Especifica otro género" class="extra-field">

            </div>

            <div class="section">
                <div class="section-header">
                    <i class="fas fa-notes-medical section-header-icon"></i>
                    <h2>Historial Médico</h2>
                </div>
                <label>¿Tienes alguna condición médica?</label>
                <select id="condiciones" name="condiciones" onchange="toggleExtraField('condiciones', 'condicionesOtro')">
                    <option value="ninguna">Ninguna</option>
                    <option value="diabetes">Diabetes</option>
                    <option value="hipertension">Hipertensión</option>
                    <option value="asma">Asma</option>
                    <option value="otro">Otra</option>
                </select>
                <input type="text" id="condicionesOtro" name="condicionesOtro" placeholder="Especifica otra condición" class="extra-field">

                <label>¿Estás tomando algún medicamento?</label>
                <select id="medicamentos" name="medicamentos" onchange="toggleExtraField('medicamentos', 'medicamentosOtro')">
                    <option value="ninguno">Ninguno</option>
                    <option value="antihipertensivos">Antihipertensivos</option>
                    <option value="insulina">Insulina</option>
                    <option value="antibioticos">Antibióticos</option>
                    <option value="otro">Otro</option>
                </select>
                <input type="text" id="medicamentosOtro" name="medicamentosOtro" placeholder="Especifica otro medicamento" class="extra-field">
            </div>

            <div class="section">
                <div class="section-header">
                    <i class="fas fa-running section-header-icon"></i>
                    <h2>Nivel de Actividad Física</h2>
                </div>
                <label>¿Con qué frecuencia realizas actividad física?</label>
                <select id="actividad" name="actividad">
                    <option value="ninguna">Ninguna</option>
                    <option value="baja">Baja (1-2 veces por semana)</option>
                    <option value="moderada">Moderada (3-4 veces por semana)</option>
                    <option value="alta">Alta (5 o más veces por semana)</option>
                </select>
            </div>

            <div class="section">
                <div class="section-header">
                    <i class="fas fa-bullseye section-header-icon"></i>
                    <h2>Objetivos Personales</h2>
                </div>
                <label>¿Cuáles son tus objetivos de salud?</label>
                <select id="objetivos" name="objetivos" onchange="toggleExtraField('objetivos', 'objetivosOtro')">
                    <option value="bajar de peso">Bajar de peso</option>
                    <option value="ganar musculo">Ganar músculo</option>
                    <option value="mejorar resistencia">Mejorar resistencia</option>
                    <option value="mantener la salud">Mantener la salud</option>
                </select>
                <input type="text" id="objetivosOtro" name="objetivosOtro" placeholder="Especifica otro objetivo" class="extra-field">
            </div>

            <div class="section">
                <div class="section-header">
                    <i class="fas fa-apple-alt section-header-icon"></i>
                    <h2>Alergias y Restricciones Alimenticias</h2>
                </div>
                <label>¿Tienes alguna alergia?</label>
                <select id="alergias" name="alergias" onchange="toggleExtraField('alergias', 'alergiasOtro')">
                    <option value="ninguna">Ninguna</option>
                    <option value="gluten">Gluten</option>
                    <option value="lactosa">Lactosa</option>
                    <option value="frutos_secos">Frutos secos</option>
                    <option value="mariscos">Mariscos</option>
                    <option value="otro">Otra</option>
                </select>
                <input type="text" id="alergiasOtro" name="alergiasOtro" placeholder="Especifica otra alergia" class="extra-field">

                <label>¿Tienes alguna restricción alimenticia?</label>
                <select id="restricciones" name="restricciones" onchange="toggleExtraField('restricciones', 'restriccionesOtro')">
                    <option value="ninguna">Ninguna</option>
                    <option value="vegetariana">Vegetariana</option>
                    <option value="vegana">Vegana</option>
                    <option value="sin_gluten">Sin gluten</option>
                    <option value="baja_en_calorias">Baja en calorías</option>
                    <option value="otro">Otra</option>
                </select>
                <input type="text" id="restriccionesOtro" name="restriccionesOtro" placeholder="Especifica otra restricción" class="extra-field">
            </div>

            <div class="section">
                <div class="section-header">
                    <i class="fas fa-moon section-header-icon"></i>
                    <h2>Otros Factores</h2>
                </div>
                <label>Nivel de estrés:</label>
                <select name="estres">
                    <option value="bajo">Bajo</option>
                    <option value="moderado">Moderado</option>
                    <option value="alto">Alto</option>
                </select>

                <label>Horas de sueño diarias promedio:</label>
                <select name="suenio">
                    <option value="menos_6">Menos de 6 horas</option>
                    <option value="6_8">6 a 8 horas</option>
                    <option value="mas_8">Más de 8 horas</option>
                </select>
            </div>

            <button type="submit" class="submit-btn">
                <i class="fas fa-paper-plane"></i>
                Enviar Cuestionario
            </button>
        </form>
    </div>

    <script>
        function toggleExtraField(selectId, fieldId) {
            const selectElement = document.getElementById(selectId);
            const fieldElement = document.getElementById(fieldId);

            if (selectElement.value === 'otro') {
                fieldElement.style.display = 'block';
                fieldElement.classList.add('visible');
                fieldElement.addEventListener('input', () => {
                    selectElement.setAttribute('name', '');
                    fieldElement.setAttribute('name', selectId);
                });
            } else {
                fieldElement.style.display = 'none';
                fieldElement.classList.remove('visible');
                selectElement.setAttribute('name', selectId);
                fieldElement.setAttribute('name', '');
            }
        }
    </script>
</body>
</html>
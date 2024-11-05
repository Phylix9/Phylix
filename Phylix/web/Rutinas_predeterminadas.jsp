<%-- 
    Document   : Rutinas_predenterminadas
    Created on : Nov 4, 2024, 10:52:28 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutinas Establecidas</title>
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="Styles8.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
</head>
<body>

    <button class="back-button" onclick="window.history.back();">
        <i class="ri-arrow-left-line"></i>
    </button>    

    <main>
        <h1>Rutinas Establecidas</h1>
        <div id="selected-plan" class="selected-plan"></div>

        <div class="plans-grid">

            <section class="plan-card" data-plan="plan1">
                <div class="plan-header">
                    <h2>Rutina de Pecho 1 - Fuerza</h2>
                </div>
                <div class="routine-list">
                    <div class="routine-item"><span class="routine-time">Ejercicio 1</span><p>Press de banca con barra: 4 series de 6-8 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 2</span><p>Press inclinado con mancuernas: 4 series de 8-10 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 3</span><p>Press declinado con barra o mancuernas: 3 series de 10 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 4</span><p>Fondos en paralelas: 3 series al fallo</p></div>
                    <button class="select-btn" onclick="selectPlan('plan1', 'Rutina de Pecho 1')">Seleccionar Rutina</button>
                </div>
            </section>

            <section class="plan-card" data-plan="plan2">
                <div class="plan-header">
                    <h2>Rutina de Pecho 2 - Hipertrofia</h2>
                </div>
                <div class="routine-list">
                    <div class="routine-item"><span class="routine-time">Ejercicio 1</span><p>Press de banca plano con mancuernas: 4 series de 10-12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 2</span><p>Aperturas en banco inclinado: 4 series de 12-15 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 3</span><p>Press en máquina Smith: 3 series de 12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 4</span><p>Cruce de poleas: 4 series de 15 repeticiones</p></div>
                    <button class="select-btn" onclick="selectPlan('plan2', 'Rutina de Pecho 2')">Seleccionar Rutina</button>
                </div>
            </section>

            <section class="plan-card" data-plan="plan3">
                <div class="plan-header">
                    <h2>Rutina de Espalda 1 - Ancho</h2>
                </div>
                <div class="routine-list">
                    <div class="routine-item"><span class="routine-time">Ejercicio 1</span><p>Dominadas con agarre amplio: 4 series al fallo</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 2</span><p>Jalón en polea con agarre supino: 4 series de 10-12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 3</span><p>Remo con barra: 3 series de 8-10 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 4</span><p>Pullover en polea alta: 3 series de 12-15 repeticiones</p></div>
                    <button class="select-btn" onclick="selectPlan('plan3', 'Rutina de Espalda 1')">Seleccionar Rutina</button>
                </div>
            </section>

            <section class="plan-card" data-plan="plan4">
                <div class="plan-header">
                    <h2>Rutina de Espalda 2 - Grosor</h2>
                </div>
                <div class="routine-list">
                    <div class="routine-item"><span class="routine-time">Ejercicio 1</span><p>Remo en barra T: 4 series de 8-10 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 2</span><p>Remo en polea baja: 4 series de 10-12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 3</span><p>Peso muerto convencional: 3 series de 6-8 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 4</span><p>Hiperextensiones: 3 series de 15 repeticiones</p></div>
                    <button class="select-btn" onclick="selectPlan('plan4', 'Rutina de Espalda 2')">Seleccionar Rutina</button>
                </div>
            </section>

            <section class="plan-card" data-plan="plan5">
                <div class="plan-header">
                    <h2>Rutina de Cuádriceps 1 - Volumen</h2>
                </div>
                <div class="routine-list">
                    <div class="routine-item"><span class="routine-time">Ejercicio 1</span><p>Sentadilla con barra: 4 series de 8-10 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 2</span><p>Prensa de piernas en máquina: 4 series de 10-12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 3</span><p>Extensiones de piernas en máquina: 3 series de 12-15 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 4</span><p>Sentadillas búlgaras: 3 series de 12 repeticiones por pierna</p></div>
                    <button class="select-btn" onclick="selectPlan('plan5', 'Rutina de Cuádriceps 1')">Seleccionar Rutina</button>
                </div>
            </section>

            <section class="plan-card" data-plan="plan6">
                <div class="plan-header">
                    <h2>Rutina de Cuádriceps 2 - Definición</h2>
                </div>
                <div class="routine-list">
                    <div class="routine-item"><span class="routine-time">Ejercicio 1</span><p>Sentadilla frontal con barra: 4 series de 8-10 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 2</span><p>Zancadas en máquina Smith: 4 series de 12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 3</span><p>Prensa de piernas en ángulo cerrado: 4 series de 10-12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 4</span><p>Sissy Squat: 3 series de 15 repeticiones</p></div>
                    <button class="select-btn" onclick="selectPlan('plan6', 'Rutina de Cuádriceps 2')">Seleccionar Rutina</button>
                </div>
            </section>

            <section class="plan-card" data-plan="plan7">
                <div class="plan-header">
                    <h2>Rutina de Femoral 1 - Gluteo </h2>
                </div>
                <div class="routine-list">
                    <div class="routine-item"><span class="routine-time">Ejercicio 1</span><p>Peso muerto rumano: 4 series de 10-12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 2</span><p>Curl de piernas acostado: 4 series de 10-12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 3</span><p>Hip Thrust: 3 series de 12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 4</span><p>Patada de glúteos en máquina: 3 series de 15 repeticiones</p></div>
                    <button class="select-btn" onclick="selectPlan('plan7', 'Rutina de Femoral 1')">Seleccionar Rutina</button>
                </div>
            </section>

            <section class="plan-card" data-plan="plan8">
                <div class="plan-header">
                    <h2>Rutina de Femoral 2 - Desarrollo Femoral</h2>
                </div>
                <div class="routine-list">
                    <div class="routine-item"><span class="routine-time">Ejercicio 1</span><p>Peso muerto rumano con barra: 4 series de 8-10 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 2</span><p>Curl de piernas acostado en máquina: 4 series de 12 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 3</span><p>Sentadilla sumo con mancuernas o barra: 3 series de 10-12 repeticiones                    </p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 4</span><p>Desplante invertido: 3 series de 10-12 repeticiones por pierna</p></div>
                    <button class="select-btn" onclick="selectPlan('plan8', 'Rutina de Femoral 2')">Seleccionar Rutina</button>
                </div>
            </section>
            
            <section class="plan-card" data-plan="plan9">
                <div class="plan-header">
                    <h2>Rutina de Cuerpo Completo</h2>
                </div>
                <div class="routine-list">
                    <div class="routine-item"><span class="routine-time">Ejercicio 1</span><p>Sentadilla con barra: 4 series de 6-8 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 2</span><p>Peso muerto convencional: 4 series de 6-8 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 3</span><p>Press de banca con barra: 4 series de 8-10 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 4</span><p>Remo con barra: 4 series de 10 repeticiones</p></div>
                    <div class="routine-item"><span class="routine-time">Ejercicio 5</span><p>Press militar con barra: 3 series de 10 repeticiones</p></div>
                    <button class="select-btn" onclick="selectPlan('plan9', 'Rutina de Cuerpo Completo')">Seleccionar Rutina</button>
                </div>
            </section>
        </div>
    </main>

    <script>
        function selectPlan(planId, planName) {
            document.querySelectorAll('.plan-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            const selectedCard = document.querySelector(`[data-plan="${planId}"]`);
            selectedCard.classList.add('selected');
            
            const selectedCard = document.querySelector(`[data-plan="${planId}"]`);
            selectedCard.classList.add('selected');

            const selectedPlanDiv = document.getElementById('selected-plan');
            selectedPlanDiv.innerHTML = `
                <div class="selected-message">
                    <p>Has seleccionado: <strong>${planName}</strong></p>
                    <button class="clear-btn" onclick="clearSelection()">Cambiar Selección</button>
                </div>`;
            selectedPlanDiv.style.display = 'block';
        }

        function clearSelection() {
            // Limpia cualquier selección visible
            document.querySelectorAll('.plan-card').forEach(card => {
                card.classList.remove('selected');
            });
            document.getElementById('selected-plan').style.display = 'none';
        }
    </script>
</body>
</html>
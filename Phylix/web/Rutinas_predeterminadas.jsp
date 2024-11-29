<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutinas Establecidas</title>
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="Styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
</head>
<body>
    <div class="min-h-screen">
        <button 
            onclick="window.history.back();" 
            class="back-button" 
            aria-label="Regresar"
        >
            <i class="ri-arrow-left-line"></i>
        </button>

        <main class="container">
            <h1>Rutinas Establecidas</h1>

            <div id="selected-plan" class="selected-plan"></div>

            <div class="plans-grid">
                <section class="plan-card" data-plan="plan1">
                    <div class="plan-header">
                        <h2>Rutina de Pecho 1 - Fuerza</h2>
                    </div>
                    <div class="routine-list">
                        <div class="routine-item">
                            <span class="routine-number">Ejercicio 1</span>
                            <p>Press de banca con barra: 4 series de 6-8 repeticiones</p>
                        </div>
                        <div class="routine-item">
                            <span class="routine-number">Ejercicio 2</span>
                            <p>Press inclinado con mancuernas: 4 series de 8-10 repeticiones</p>
                        </div>
                        <div class="routine-item">
                            <span class="routine-number">Ejercicio 3</span>
                            <p>Press declinado con barra o mancuernas: 3 series de 10 repeticiones</p>
                        </div>
                        <div class="routine-item">
                            <span class="routine-number">Ejercicio 4</span>
                            <p>Fondos en paralelas: 3 series al fallo</p>
                        </div>
                        <button class="select-btn" onclick="selectPlan('plan1', 'Rutina de Pecho 1 - Fuerza')">
                            Seleccionar Rutina
                        </button>
                    </div>
                </section>
                <!-- Add more plan sections here as needed -->
            </div>
        </main>
    </div>

    <script>
        function selectPlan(planId, planName) {
    // Deselect all plan cards
    document.querySelectorAll('.plan-card').forEach(card => {
        card.classList.remove('selected');
    });

    // Select current plan card
    const selectedCard = document.querySelector(`[data-plan="${planId}"]`);
    selectedCard.classList.add('selected');

    // Show selected plan message
    const selectedPlanDiv = document.getElementById('selected-plan');
    selectedPlanDiv.innerHTML = `
        <div class="selected-message">
            <p>Has seleccionado: <strong>${planName}</strong></p>
            <button class="clear-btn" onclick="createRoutine('${planId}')">
                Crear Rutina
            </button>
        </div>`;
    selectedPlanDiv.classList.add('active');
}

function createRoutine(planId) {
    // Replace this with your actual routine creation logic
    console.log(`Creating routine for plan: ${planId}`);
    // Example: Redirect to a routine creation page
    // window.location.href = `create-routine.html?plan=${planId}`;
}
    </script>
</body>
</html>
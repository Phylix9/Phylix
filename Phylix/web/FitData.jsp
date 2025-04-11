<%-- 
    Document   : FitData
    Created on : Apr 10, 2025, 9:59:48 PM
    Author     : chris
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_usuario") == null) {
        response.sendRedirect("Proyecto.jsp");
        return;
    }
    String username = (String) sesion.getAttribute("nombre_usuario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FITDATA</title>
    <link rel="stylesheet" href="StyleP.css">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.4.0/fonts/remixicon.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"></script>
</head>
<body>
    <header>
        <div class="container">
            <div class="logo">
                <a href="FitData.jsp"><img src="src/LogoFitdata2.png" alt="FITDATA"></a>
            </div>
            <nav>
                <ul>
                    <li><a href="FitData.jsp">Inicio</a></li>
                    <li><a href="Rutinas.jsp">Rutinas</a></li>
                    <li><a href="Dietas.jsp">Dietas</a></li>
                    <li><a href="Informacion.jsp">Informacion</a></li>
                </ul>
            </nav>
            <div class="user-menu">
                <div class="user-avatar">
                    <img src="src/perfil.png" alt="Usuario">
                </div>
                <span class="username"><%= username %></span>
                <div class="dropdown-menu">
                    <a href="Perfil.jsp">Mi Perfil</a>
                    <a href="Logout">Cerrar Sesión</a>
                </div>
            </div>
        </div>
    </header>

    <main>
        <section class="profile-header">
            <div class="container">
                <div class="profile-info">
                    <div class="profile-details">
                        <h1>¡Hola, <%= username %>!</h1>
                        <p class="profile-stats">Miembro desde: <span>15/03/2023</span></p>
                        <p class="profile-stats">Programa: <span>Perder Peso</span></p>
                        <div class="profile-progress">
                            <div class="progress-bar">
                                <div class="progress" style="width: 75%"></div>
                            </div>
                            <span>75% hacia tu objetivo</span>
                        </div>
                    </div>
                </div>
                <div class="quick-stats">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <img src="src/dias_activo.png" alt="Días">
                        </div>
                        <div class="stat-info">
                            <span class="stat-value">43</span>
                            <span class="stat-label">Días activos</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <img src="src/perdida_peso.png" alt="Peso">
                        </div>
                        <div class="stat-info">
                            <span class="stat-value">-8.5 kg</span>
                            <span class="stat-label">Pérdida de peso</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <img src="src/entrenamientos.png" alt="Entrenamientos">
                        </div>
                        <div class="stat-info">
                            <span class="stat-value">28</span>
                            <span class="stat-label">Entrenamientos</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="profile-dashboard">
            <div class="container">
                <div class="dashboard-grid">
                    <div class="dashboard-card progress-card">
                        <h2>Mi Progreso</h2>
                        <div class="progress-charts">
                            <div class="chart-container">
                                <canvas id="weightChart"></canvas>
                            </div>
                            <div class="chart-container">
                                <canvas id="bodyMeasurementsChart"></canvas>
                            </div>
                        </div>
                        <div class="progress-metrics">
                            <div class="metric">
                                <span class="metric-label">Peso Inicial</span>
                                <span class="metric-value">89.5 kg</span>
                            </div>
                            <div class="metric">
                                <span class="metric-label">Peso Actual</span>
                                <span class="metric-value">81.0 kg</span>
                            </div>
                            <div class="metric">
                                <span class="metric-label">Objetivo</span>
                                <span class="metric-value">75.0 kg</span>
                            </div>
                        </div>
                        <a href="Progreso.jsp" class="btn btn-secondary">Ver Detalles Completos</a>
                    </div>

                    <div class="dashboard-card workout-card">
                        <h2>Mis Rutinas</h2>
                        <div class="workout-calendar">
                            <div class="calendar-header">
                                <span>Abril 2025</span>
                                <div class="calendar-nav">
                                    <button class="calendar-btn">&lt;</button>
                                    <button class="calendar-btn">&gt;</button>
                                </div>
                            </div>
                            <div class="calendar-days">
                                <div class="calendar-day completed">L</div>
                                <div class="calendar-day completed">M</div>
                                <div class="calendar-day completed">X</div>
                                <div class="calendar-day today">J</div>
                                <div class="calendar-day">V</div>
                                <div class="calendar-day rest">S</div>
                                <div class="calendar-day rest">D</div>
                            </div>
                        </div>
                        <div class="today-workout">
                            <h3>Rutina para Hoy: Cardio + Piernas</h3>
                            <div class="workout-plan">
                                <div class="exercise">
                                    <span class="exercise-name">Sentadillas</span>
                                    <span class="exercise-details">4 series x 12 rep</span>
                                </div>
                                <div class="exercise">
                                    <span class="exercise-name">Zancadas</span>
                                    <span class="exercise-details">3 series x 10 rep</span>
                                </div>
                                <div class="exercise">
                                    <span class="exercise-name">Prensa de piernas</span>
                                    <span class="exercise-details">4 series x 10 rep</span>
                                </div>
                                <div class="exercise">
                                    <span class="exercise-name">Elíptica</span>
                                    <span class="exercise-details">20 minutos</span>
                                </div>
                            </div>
                            <div class="workout-actions">
                                <a href="MisRutinas.jsp" class="btn btn-secondary">Ver Todas las Rutinas</a>

                            </div>
                        </div>
                    </div>

                    <div class="dashboard-card diet-card">
                        <h2>Mi Plan de Alimentación</h2>
                        <div class="diet-summary">
                            <div class="diet-macros">
                                <div class="macro-chart">
                                    <canvas id="macrosChart"></canvas>
                                </div>
                                <div class="macro-legend">
                                    <div class="macro-item">
                                        <span class="color-box protein"></span>
                                        <span>Proteínas: 30%</span>
                                    </div>
                                    <div class="macro-item">
                                        <span class="color-box carbs"></span>
                                        <span>Carbohidratos: 45%</span>
                                    </div>
                                    <div class="macro-item">
                                        <span class="color-box fats"></span>
                                        <span>Grasas: 25%</span>
                                    </div>
                                </div>
                            </div>
                            <div class="today-meals">
                                <h3>Comidas de Hoy</h3>
                                <div class="meal">
                                    <span class="meal-time">Desayuno</span>
                                    <span class="meal-desc">Avena con frutas y yogur</span>
                                    <span class="meal-cals">350 kcal</span>
                                </div>
                                <div class="meal">
                                    <span class="meal-time">Almuerzo</span>
                                    <span class="meal-desc">Ensalada de pollo con quinoa</span>
                                    <span class="meal-cals">520 kcal</span>
                                </div>
                                <div class="meal">
                                    <span class="meal-time">Merienda</span>
                                    <span class="meal-desc">Batido de proteínas con plátano</span>
                                    <span class="meal-cals">280 kcal</span>
                                </div>
                                <div class="meal">
                                    <span class="meal-time">Cena</span>
                                    <span class="meal-desc">Salmón con verduras al vapor</span>
                                    <span class="meal-cals">450 kcal</span>
                                </div>
                            </div>
                        </div>
                        <a href="MisDietas.jsp" class="btn btn-secondary">Ver Plan Completo</a>
                    </div>

                    <div class="dashboard-card muscles-card">
                        <h2>Grupos Musculares Trabajados</h2>
                        <div class="muscle-groups">
                            <div class="muscle-map">
                                <div class="muscle-highlight chest" data-strength="90"></div>
                                <div class="muscle-highlight back" data-strength="75"></div>
                                <div class="muscle-highlight arms" data-strength="85"></div>
                                <div class="muscle-highlight legs" data-strength="60"></div>
                                <div class="muscle-highlight core" data-strength="70"></div>
                            </div>
                            <div class="muscle-stats">
                                <div class="muscle-stat">
                                    <span class="muscle-name">Pecho</span>
                                    <div class="muscle-bar">
                                        <div class="muscle-progress" style="width: 90%"></div>
                                    </div>
                                </div>
                                <div class="muscle-stat">
                                    <span class="muscle-name">Espalda</span>
                                    <div class="muscle-bar">
                                        <div class="muscle-progress" style="width: 75%"></div>
                                    </div>
                                </div>
                                <div class="muscle-stat">
                                    <span class="muscle-name">Brazos</span>
                                    <div class="muscle-bar">
                                        <div class="muscle-progress" style="width: 85%"></div>
                                    </div>
                                </div>
                                <div class="muscle-stat">
                                    <span class="muscle-name">Piernas</span>
                                    <div class="muscle-bar">
                                        <div class="muscle-progress" style="width: 60%"></div>
                                    </div>
                                </div>
                                <div class="muscle-stat">
                                    <span class="muscle-name">Core</span>
                                    <div class="muscle-bar">
                                        <div class="muscle-progress" style="width: 70%"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a href="balance-muscular.jsp" class="btn btn-secondary">Análisis de Balance Muscular</a>
                    </div>
                </div>
            </div>
        </section>
    </main>
  
    <footer class="section__container footer__container">
    </footer>
    <div class="footer__bar">
      Copyright © 2024 FitData. Todos los derechos reservados.
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const weightCtx = document.getElementById('weightChart').getContext('2d');
            const weightChart = new Chart(weightCtx, {
                type: 'line',
                data: {
                    labels: ['Ene', 'Feb', 'Mar', 'Abr'],
                    datasets: [{
                        label: 'Peso (kg)',
                        data: [89.5, 86.2, 83.1, 81.0],
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 2,
                        tension: 0.3
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: false,
                            min: 70,
                            max: 95
                        }
                    }
                }
            });

            const measurementsCtx = document.getElementById('bodyMeasurementsChart').getContext('2d');
            const measurementsChart = new Chart(measurementsCtx, {
                type: 'line',
                data: {
                    labels: ['Ene', 'Feb', 'Mar', 'Abr'],
                    datasets: [{
                        label: 'Cintura (cm)',
                        data: [98, 95, 93, 91],
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 2,
                        tension: 0.3,
                        fill: false
                    }, {
                        label: 'Pecho (cm)',
                        data: [102, 101, 100, 99],
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 2,
                        tension: 0.3,
                        fill: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });

            const macrosCtx = document.getElementById('macrosChart').getContext('2d');
            const macrosChart = new Chart(macrosCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Proteínas', 'Carbohidratos', 'Grasas'],
                    datasets: [{
                        data: [30, 45, 25],
                        backgroundColor: [
                            'rgba(54, 162, 235, 0.8)',
                            'rgba(75, 192, 192, 0.8)',
                            'rgba(255, 206, 86, 0.8)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        });
        
        function toggleDropdown() {
            const dropdown = document.querySelector('.dropdown-menu');
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }
        
        function toggleBot() {
            const idUsuario = <%= session.getAttribute("id_usuario") != null ? session.getAttribute("id_usuario") : "null" %>;

            if (idUsuario === null) {
              const loginModal = document.getElementById('login-modal');
              loginModal.style.display = loginModal.style.display === 'block' ? 'none' : 'block';
              return; 
            }
            const botWindow = document.getElementById('bot-window');
            botWindow.style.display = botWindow.style.display === 'block' ? 'none' : 'block';
        }

        function cerrarLoginModal() {
          document.getElementById('login-modal').style.display = 'none';
        }



        document.addEventListener('click', (event) => {
            const dropdown = document.querySelector('.dropdown-menu');
            const userIcon = document.querySelector('.user-icon');

            if (dropdown && !userIcon.contains(event.target)) {
                dropdown.style.display = 'none';
            }
        });
        
        const INACTIVITY_TIMEOUT = 2 * 60 * 1000; 
        let inactivityTimer;

        function handleInactivity() {
          alert("Se excedió el límite de inactividad, se cerró tu sesión.");
          window.location.href = "Logout"; 
        }

        function resetInactivityTimer() {
          clearTimeout(inactivityTimer);
          inactivityTimer = setTimeout(handleInactivity, INACTIVITY_TIMEOUT);
        }

        ["mousemove", "keydown", "mousedown", "touchstart"].forEach(event => {
          document.addEventListener(event, resetInactivityTimer);
        });
        
        resetInactivityTimer();
        
    </script>
</body>
</html>

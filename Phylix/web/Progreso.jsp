<%-- 
    Document   : progreso
    Created on : Apr 7, 2025, 12:01:59 AM
    Author     : Chris
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FITDATA - Mi Progreso</title>
    <link rel="stylesheet" href="Style19.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
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
                <span class="username"> </span>
                <div class="dropdown-menu">
                    <a href="Perfil.jsp">Mi Perfil</a>
                    <a href="Logout">Cerrar Sesion</a>
                </div>
            </div>
        </div>
    </header>

    <main>
        <section class="progress-header">
            <div class="container">
                <div class="page-title">
                    <h1>Mi Progreso Detallado</h1>
                    <p>Seguimiento completo de todos tus avances y métricas</p>
                </div>
                <div class="progress-nav">
                    <a href="#weight-section" class="progress-nav-item active">
                        <div class="nav-icon"><img src="src/entrenamientos.png" alt="Peso"></div>
                        <span>Peso</span>
                    </a>
                    <a href="#measurements-section" class="progress-nav-item">
                        <div class="nav-icon"><img src="src/perdida_peso.png" alt="Medidas"></div>
                        <span>Medidas</span>
                    </a>
                    <a href="#strength-section" class="progress-nav-item">
                        <div class="nav-icon"><img src="src/fuerza.png" alt="Fuerza"></div>
                        <span>Fuerza</span>
                    </a>
                    <a href="#photos-section" class="progress-nav-item">
                        <div class="nav-icon"><img src="src/fotos.png" alt="Fotos"></div>
                        <span>Fotos</span>
                    </a>
                </div>
            </div>
        </section>

        <section class="progress-summary">
            <div class="container">
                <div class="summary-card">
                    <div class="summary-stats">
                        <div class="stat-box">
                            <div class="stat-value">-8.5 kg</div>
                            <div class="stat-label">Peso total perdido</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">-7 cm</div>
                            <div class="stat-label">Reducción de cintura</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">+12.5%</div>
                            <div class="stat-label">Aumento de fuerza</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-value">+20%</div>
                            <div class="stat-label">Mejora cardiovascular</div>
                        </div>
                    </div>
                    <div class="summary-timeline">
                        <div class="timeline-progress">
                            <div class="timeline-bar">
                                <div class="timeline-filled" style="width: 75%"></div>
                            </div>
                            <div class="timeline-stats">
                                <div class="timeline-start">15/03/2023</div>
                                <div class="timeline-current">Hoy: 06/04/2025</div>
                                <div class="timeline-end">15/07/2025</div>
                            </div>
                        </div>
                        <div class="timeline-info">
                            <div class="days-count">43 días activos completados</div>
                            <div class="days-remaining">56 días hasta tu objetivo</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section id="weight-section" class="progress-section">
            <div class="container">
                <div class="section-header">
                    <h2>Control de Peso</h2>
                    <div class="section-actions">
                        <div class="timeframe-selector">
                            <button class="timeframe-btn active" data-period="weekly">Semanal</button>
                            <button class="timeframe-btn" data-period="monthly">Mensual</button>
                            <button class="timeframe-btn" data-period="all">Todo</button>
                        </div>
                        <button class="action-btn add-data-btn" onclick="showWeightModal()">+ Añadir Peso</button>
                    </div>
                </div>
                
                <div class="charts-container">
                    <div class="chart-card primary-chart">
                        <div class="chart-header">
                            <h3>Evolución del Peso</h3>
                            <div class="chart-legend">
                                <div class="legend-item">
                                    <span class="color-dot weight"></span>
                                    <span>Peso actual</span>
                                </div>
                                <div class="legend-item">
                                    <span class="color-dot target"></span>
                                    <span>Objetivo</span>
                                </div>
                            </div>
                        </div>
                        <div class="chart-body">
                            <canvas id="weightLineChart" height="300"></canvas>
                        </div>
                    </div>
                    
                    <div class="chart-card secondary-charts">
                        <div class="chart-row">
                            <div class="small-chart">
                                <h3>Pérdida de peso (kg)</h3>
                                <div class="chart-body">
                                    <canvas id="weightLossChart" height="150"></canvas>
                                </div>
                            </div>
                            <div class="small-chart">
                                <h3>Ritmo semanal</h3>
                                <div class="chart-body">
                                    <canvas id="weeklyPaceChart" height="150"></canvas>
                                </div>
                            </div>
                        </div>
                        
                        <div class="stat-highlights">
                            <div class="highlight-item">
                                <div class="highlight-value">-0.7 kg</div>
                                <div class="highlight-label">Promedio semanal</div>
                            </div>
                            <div class="highlight-item">
                                <div class="highlight-value">-2.1 kg</div>
                                <div class="highlight-label">Último mes</div>
                            </div>
                            <div class="highlight-item">
                                <div class="highlight-value">-1.2 kg</div>
                                <div class="highlight-label">Mejor semana</div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="data-table">
                    <h3>Registro de Peso</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Peso (kg)</th>
                                <th>Cambio</th>
                                <th>Notas</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>06/04/2025</td>
                                <td>81.0</td>
                                <td class="change-positive">-0.5 kg</td>
                                <td>Después del entrenamiento de cardio</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>30/03/2025</td>
                                <td>81.5</td>
                                <td class="change-positive">-0.7 kg</td>
                                <td>En ayunas</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>23/03/2025</td>
                                <td>82.2</td>
                                <td class="change-positive">-0.9 kg</td>
                                <td>Después de la semana de déficit intenso</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>16/03/2025</td>
                                <td>83.1</td>
                                <td class="change-positive">-1.0 kg</td>
                                <td>-</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="pagination">
                        <button class="pagination-btn">&lt;</button>
                        <span class="pagination-info">Página 1 de 3</span>
                        <button class="pagination-btn">&gt;</button>
                    </div>
                </div>
            </div>
        </section>

        <section id="measurements-section" class="progress-section">
            <div class="container">
                <div class="section-header">
                    <h2>Medidas Corporales</h2>
                    <div class="section-actions">
                        <div class="timeframe-selector">
                            <button class="timeframe-btn active" data-period="weekly">Semanal</button>
                            <button class="timeframe-btn" data-period="monthly">Mensual</button>
                            <button class="timeframe-btn" data-period="all">Todo</button>
                        </div>
                        <button class="action-btn add-data-btn" onclick="showMeasurementModal()">+ Añadir Medidas</button>
                    </div>
                </div>
                
                <div class="charts-container">
                    <div class="chart-card primary-chart">
                        <div class="chart-header">
                            <h3>Evolución de Medidas</h3>
                            <div class="chart-legend">
                                <div class="legend-item">
                                    <span class="color-dot chest"></span>
                                    <span>Pecho</span>
                                </div>
                                <div class="legend-item">
                                    <span class="color-dot waist"></span>
                                    <span>Cintura</span>
                                </div>
                                <div class="legend-item">
                                    <span class="color-dot hips"></span>
                                    <span>Caderas</span>
                                </div>
                                <div class="legend-item">
                                    <span class="color-dot thigh"></span>
                                    <span>Muslo</span>
                                </div>
                                <div class="legend-item">
                                    <span class="color-dot arm"></span>
                                    <span>Brazo</span>
                                </div>
                            </div>
                        </div>
                        <div class="chart-body">
                            <canvas id="measurementsLineChart" height="300"></canvas>
                        </div>
                    </div>
                    
                    <div class="chart-card body-visual">
                        <h3>Composición Corporal</h3>
                        <div class="body-composition">
                            <div class="body-image">
                                <img src="" alt=".">
                                <div class="body-markers">
                                    <div class="marker chest" data-value="-3cm"></div>
                                    <div class="marker waist" data-value="-7cm"></div>
                                    <div class="marker hips" data-value="-5cm"></div>
                                    <div class="marker thigh" data-value="-4cm"></div>
                                    <div class="marker arm" data-value="-1cm"></div>
                                </div>
                            </div>
                            <div class="body-stats">
                                <div class="body-stat">
                                    <div class="stat-name">IMC (Índice de Masa Corporal)</div>
                                    <div class="stat-bar">
                                        <div class="stat-progress" style="width: 65%;"></div>
                                        <div class="stat-marker" style="left: 85%;">Inicial</div>
                                        <div class="stat-marker" style="left: 65%;">Actual</div>
                                        <div class="stat-marker" style="left: 50%;">Objetivo</div>
                                    </div>
                                    <div class="stat-labels">
                                        <span>Bajo peso</span>
                                        <span>Normal</span>
                                        <span>Sobrepeso</span>
                                        <span>Obesidad</span>
                                    </div>
                                </div>
                                <div class="body-stat">
                                    <div class="stat-name">Grasa Corporal Estimada: 19%</div>
                                    <div class="stat-bar">
                                        <div class="stat-progress" style="width: 58%;"></div>
                                        <div class="stat-marker" style="left: 75%;">Inicial</div>
                                        <div class="stat-marker" style="left: 58%;">Actual</div>
                                        <div class="stat-marker" style="left: 45%;">Objetivo</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="data-table">
                    <h3>Registro de Medidas (cm)</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Pecho</th>
                                <th>Cintura</th>
                                <th>Caderas</th>
                                <th>Muslo Der.</th>
                                <th>Brazo Der.</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>06/04/2025</td>
                                <td>99</td>
                                <td>91</td>
                                <td>97</td>
                                <td>58</td>
                                <td>35</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>06/03/2025</td>
                                <td>100</td>
                                <td>93</td>
                                <td>98</td>
                                <td>59</td>
                                <td>35</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>06/02/2025</td>
                                <td>101</td>
                                <td>95</td>
                                <td>100</td>
                                <td>61</td>
                                <td>36</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>06/01/2025</td>
                                <td>102</td>
                                <td>98</td>
                                <td>102</td>
                                <td>62</td>
                                <td>36</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <section id="strength-section" class="progress-section">
            <div class="container">
                <div class="section-header">
                    <h2>Progreso de Fuerza</h2>
                    <div class="section-actions">
                        <select class="exercise-selector">
                            <option value="all">Todos los ejercicios</option>
                            <option value="squat">Sentadilla</option>
                            <option value="bench">Press Banca</option>
                            <option value="deadlift">Peso Muerto</option>
                        </select>
                        <button class="action-btn add-data-btn" onclick="showStrengthModal()">+ Añadir Registro</button>
                    </div>
                </div>
                
                <div class="charts-container strength-charts">
                    <div class="chart-card primary-chart">
                        <div class="chart-header">
                            <h3>Evolución de Cargas (1RM)</h3>
                            <div class="chart-legend">
                                <div class="legend-item">
                                    <span class="color-dot squat"></span>
                                    <span>Sentadilla</span>
                                </div>
                                <div class="legend-item">
                                    <span class="color-dot bench"></span>
                                    <span>Press Banca</span>
                                </div>
                                <div class="legend-item">
                                    <span class="color-dot deadlift"></span>
                                    <span>Peso Muerto</span>
                                </div>
                            </div>
                        </div>
                        <div class="chart-body">
                            <canvas id="strengthProgressChart" height="300"></canvas>
                        </div>
                    </div>
                    
                    <div class="chart-card pentagon-chart">
                        <h3>Balance de Fuerza</h3>
                        <div class="chart-body">
                            <canvas id="strengthRadarChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
                <!--
                <div class="strength-highlights">
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <img src="images/icons/squat.svg" alt="Sentadilla">
                        </div>
                        <div class="highlight-info">
                            <div class="highlight-name">Sentadilla</div>
                            <div class="highlight-values">
                                <div class="highlight-current">110 kg</div>
                                <div class="highlight-change">+15 kg</div>
                            </div>
                            <div class="highlight-bar">
                                <div class="highlight-progress" style="width: 75%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <img src="images/icons/bench.svg" alt="Press Banca">
                        </div>
                        <div class="highlight-info">
                            <div class="highlight-name">Press Banca</div>
                            <div class="highlight-values">
                                <div class="highlight-current">85 kg</div>
                                <div class="highlight-change">+10 kg</div>
                            </div>
                            <div class="highlight-bar">
                                <div class="highlight-progress" style="width: 65%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <img src="images/icons/deadlift.svg" alt="Peso Muerto">
                        </div>
                        <div class="highlight-info">
                            <div class="highlight-name">Peso Muerto</div>
                            <div class="highlight-values">
                                <div class="highlight-current">130 kg</div>
                                <div class="highlight-change">+20 kg</div>
                            </div>
                            <div class="highlight-bar">
                                <div class="highlight-progress" style="width: 80%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <img src="images/icons/overhead.svg" alt="Press Militar">
                        </div>
                        <div class="highlight-info">
                            <div class="highlight-name">Press Militar</div>
                            <div class="highlight-values">
                                <div class="highlight-current">60 kg</div>
                                <div class="highlight-change">+7.5 kg</div>
                            </div>
                            <div class="highlight-bar">
                                <div class="highlight-progress" style="width: 70%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="highlight-card">
                        <div class="highlight-icon">
                            <img src="images/icons/row.svg" alt="Remo">
                        </div>
                        <div class="highlight-info">
                            <div class="highlight-name">Remo Barra</div>
                            <div class="highlight-values">
                                <div class="highlight-current">90 kg</div>
                                <div class="highlight-change">+12.5 kg</div>
                            </div>
                            <div class="highlight-bar">
                                <div class="highlight-progress" style="width: 75%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                -->

                <div class="data-table">
                    <h3>Historial de Entrenamiento</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Ejercicio</th>
                                <th>Series</th>
                                <th>Repeticiones</th>
                                <th>Peso (kg)</th>
                                <th>1RM Estimado</th>
                                <th>Notas</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>05/04/2025</td>
                                <td>Press Banca</td>
                                <td>4</td>
                                <td>8</td>
                                <td>75</td>
                                <td>85 kg</td>
                                <td>Buena forma, fácil</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>03/04/2025</td>
                                <td>Sentadilla</td>
                                <td>5</td>
                                <td>5</td>
                                <td>100</td>
                                <td>110 kg</td>
                                <td>Profundidad completa</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>01/04/2025</td>
                                <td>Peso Muerto</td>
                                <td>3</td>
                                <td>5</td>
                                <td>120</td>
                                <td>130 kg</td>
                                <td>Mejor técnica</td>
                                <td class="actions-cell">
                                    <button class="table-btn edit-btn">Editar</button>
                                    <button class="table-btn delete-btn">Eliminar</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="pagination">
                        <button class="pagination-btn">&lt;</button>
                        <span class="pagination-info">Página 1 de 5</span>
                        <button class="pagination-btn">&gt;</button>
                    </div>
                </div>
            </div>
        </section>
        
<script>
document.addEventListener('DOMContentLoaded', function() {
    const dates = ['15/03/2025', '23/03/2025', '30/03/2025', '06/04/2025'];
    const targetWeight = 75; // Peso objetivo
    
    Chart.defaults.font.family = "'Poppins', 'Helvetica Neue', 'Helvetica', 'Arial', sans-serif";
    Chart.defaults.font.size = 12;
    Chart.defaults.color = '#6e7a8a';

    Chart.defaults.responsive = true;
    Chart.defaults.maintainAspectRatio = false;

    const weightData = {
        labels: dates,
        datasets: [
            {
                label: 'Peso (kg)',
                data: [89.5, 83.1, 81.5, 81.0],
                fill: false,
                borderColor: '#4a8af4',
                backgroundColor: 'rgba(74, 138, 244, 0.1)',
                tension: 0.4,
                pointBackgroundColor: '#4a8af4',
                pointRadius: 5,
                pointHoverRadius: 7
            },
            {
                label: 'Objetivo',
                data: [targetWeight, targetWeight, targetWeight, targetWeight],
                borderColor: 'rgba(46, 204, 113, 0.7)',
                borderDash: [5, 5],
                borderWidth: 2,
                pointRadius: 0,
                fill: false
            }
        ]
    };

    const weightChartConfig = {
        type: 'line',
        data: weightData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            aspectRatio: 2,
            layout: {
                padding: {
                    left: 10,
                    right: 10,
                    top: 20,
                    bottom: 10
                }
            },
            scales: {
                y: {
                    beginAtZero: false,
                    min: Math.min(targetWeight - 5, ...weightData.datasets[0].data) - 2,
                    max: Math.max(...weightData.datasets[0].data) + 2,
                    ticks: {
                        stepSize: 2
                    },
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            },
            plugins: {
                tooltip: {
                    backgroundColor: 'rgba(0, 0, 0, 0.7)',
                    padding: 10,
                    caretSize: 6,
                    titleFont: {
                        size: 14
                    },
                    titleMarginBottom: 10
                },
                legend: {
                    display: false
                }
            },
            interaction: {
                intersect: false,
                mode: 'index'
            }
        }
    };

    const weightLossData = {
        labels: ['Marzo', 'Abril'],
        datasets: [{
            label: 'Pérdida (kg)',
            data: [6.4, 2.1],
            backgroundColor: ['rgba(46, 204, 113, 0.7)', 'rgba(46, 204, 113, 0.7)'],
            borderColor: ['rgba(46, 204, 113, 1)', 'rgba(46, 204, 113, 1)'],
            borderWidth: 1
        }]
    };

    const weightLossConfig = {
        type: 'bar',
        data: weightLossData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            aspectRatio: 1.5,
            layout: {
                padding: 10
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    };

    const weeklyPaceData = {
        labels: ['Semana 1', 'Semana 2', 'Semana 3', 'Semana 4'],
        datasets: [{
            label: 'Cambio semanal (kg)',
            data: [-1.0, -0.9, -0.7, -0.5],
            backgroundColor: 'rgba(52, 152, 219, 0.7)',
            borderColor: 'rgba(52, 152, 219, 1)',
            borderWidth: 1,
            barPercentage: 0.6
        }]
    };

    const weeklyPaceConfig = {
        type: 'bar',
        data: weeklyPaceData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            aspectRatio: 1.5,
            layout: {
                padding: 10
            },
            scales: {
                y: {
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    };

    const measurementsData = {
        labels: ['01/2025', '02/2025', '03/2025', '04/2025'],
        datasets: [
            {
                label: 'Pecho (cm)',
                data: [102, 101, 100, 99],
                borderColor: '#e74c3c',
                backgroundColor: 'transparent',
                tension: 0.4,
                pointRadius: 4
            },
            {
                label: 'Cintura (cm)',
                data: [98, 95, 93, 91],
                borderColor: '#3498db',
                backgroundColor: 'transparent',
                tension: 0.4,
                pointRadius: 4
            },
            {
                label: 'Caderas (cm)',
                data: [102, 100, 98, 97],
                borderColor: '#9b59b6',
                backgroundColor: 'transparent',
                tension: 0.4,
                pointRadius: 4
            },
            {
                label: 'Muslo (cm)',
                data: [62, 61, 59, 58],
                borderColor: '#f39c12',
                backgroundColor: 'transparent',
                tension: 0.4,
                pointRadius: 4
            },
            {
                label: 'Brazo (cm)',
                data: [36, 36, 35, 35],
                borderColor: '#1abc9c',
                backgroundColor: 'transparent',
                tension: 0.4,
                pointRadius: 4
            }
        ]
    };

    const measurementsConfig = {
        type: 'line',
        data: measurementsData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            aspectRatio: 2,
            layout: {
                padding: 10
            },
            scales: {
                y: {
                    beginAtZero: false,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: 'rgba(0, 0, 0, 0.7)',
                    padding: 10
                }
            },
            interaction: {
                intersect: false,
                mode: 'index'
            }
        }
    };

    const strengthData = {
        labels: ['01/2025', '02/2025', '03/2025', '04/2025'],
        datasets: [
            {
                label: 'Sentadilla (kg)',
                data: [95, 100, 105, 110],
                borderColor: '#e74c3c',
                backgroundColor: 'rgba(231, 76, 60, 0.1)',
                tension: 0.4,
                fill: false
            },
            {
                label: 'Press Banca (kg)',
                data: [75, 78, 82, 85],
                borderColor: '#3498db',
                backgroundColor: 'rgba(52, 152, 219, 0.1)',
                tension: 0.4,
                fill: false
            },
            {
                label: 'Peso Muerto (kg)',
                data: [110, 118, 125, 130],
                borderColor: '#2ecc71',
                backgroundColor: 'rgba(46, 204, 113, 0.1)',
                tension: 0.4,
                fill: false
            }
        ]
    };

    const strengthConfig = {
        type: 'line',
        data: strengthData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            aspectRatio: 2,
            layout: {
                padding: 10
            },
            scales: {
                y: {
                    beginAtZero: false,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: 'rgba(0, 0, 0, 0.7)',
                    padding: 10
                }
            },
            interaction: {
                intersect: false,
                mode: 'index'
            }
        }
    };

    const radarData = {
        labels: [
            'Sentadilla',
            'Press Banca',
            'Peso Muerto',
            'Press Militar',
            'Remo'
        ],
        datasets: [
            {
                label: 'Actual',
                data: [110, 85, 130, 60, 90],
                fill: true,
                backgroundColor: 'rgba(52, 152, 219, 0.3)',
                borderColor: '#3498db',
                pointBackgroundColor: '#3498db',
                pointBorderColor: '#fff',
                pointHoverBackgroundColor: '#fff',
                pointHoverBorderColor: '#3498db'
            },
            {
                label: 'Inicial',
                data: [95, 75, 110, 52.5, 77.5],
                fill: true,
                backgroundColor: 'rgba(149, 165, 166, 0.3)',
                borderColor: '#95a5a6',
                pointBackgroundColor: '#95a5a6',
                pointBorderColor: '#fff',
                pointHoverBackgroundColor: '#fff',
                pointHoverBorderColor: '#95a5a6'
            }
        ]
    };

    const radarConfig = {
        type: 'radar',
        data: radarData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            aspectRatio: 1,
            layout: {
                padding: 10
            },
            elements: {
                line: {
                    borderWidth: 2
                }
            },
            scales: {
                r: {
                    angleLines: {
                        color: 'rgba(0, 0, 0, 0.1)'
                    },
                    grid: {
                        color: 'rgba(0, 0, 0, 0.1)'
                    },
                    ticks: {
                        backdropColor: 'transparent',
                        color: '#6e7a8a',
                        z: 1,
                        maxTicksLimit: 5
                    },
                    pointLabels: {
                        color: '#2c3e50',
                        font: {
                            size: 12,
                            weight: 'bold'
                        }
                    },
                    max: 150
                }
            },
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        boxWidth: 12,
                        padding: 15
                    }
                }
            }
        }
    };

    function setupChartContainer(chartElement) {
        if (!chartElement) return;
        
        const parentContainer = chartElement.closest('.chart-body');
        if (parentContainer) {
            if (!parentContainer.style.height) {
                if (chartElement.id.includes('Radar')) {
                    parentContainer.style.height = '300px';
                } else if (chartElement.id.includes('Loss') || chartElement.id.includes('Pace')) {
                    parentContainer.style.height = '200px';
                } else {
                    parentContainer.style.height = '300px';
                }
            }
        }
    }

    function initializeCharts() {
        const chartElements = [
            { id: 'weightLineChart', config: weightChartConfig },
            { id: 'weightLossChart', config: weightLossConfig },
            { id: 'weeklyPaceChart', config: weeklyPaceConfig },
            { id: 'measurementsLineChart', config: measurementsConfig },
            { id: 'strengthProgressChart', config: strengthConfig },
            { id: 'strengthRadarChart', config: radarConfig }
        ];

        chartElements.forEach(chart => {
            const element = document.getElementById(chart.id);
            if (element) {
                setupChartContainer(element);
                new Chart(element, chart.config);
            }
        });
    }

    initializeCharts();

    window.showWeightModal = function() {
        alert('Funcionalidad para añadir peso - pendiente de implementar');
    };

    window.showMeasurementModal = function() {
        alert('Funcionalidad para añadir medidas - pendiente de implementar');
    };

    window.showStrengthModal = function() {
        alert('Funcionalidad para añadir registro de fuerza - pendiente de implementar');
    };

    const timeframeBtns = document.querySelectorAll('.timeframe-btn');
    timeframeBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            this.parentElement.querySelectorAll('.timeframe-btn').forEach(b => {
                b.classList.remove('active');
            });
            this.classList.add('active');
            
            const period = this.getAttribute('data-period');
            console.log(`Cambiando vista a periodo: ${period}`);
            
        });
    });

    window.addEventListener('resize', function() {
        setTimeout(function() {
            initializeCharts();
        }, 300);
    });
});
</script>
</body>
</html>

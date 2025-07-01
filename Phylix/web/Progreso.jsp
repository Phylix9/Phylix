<%-- 
    Document   : progreso
    Created on : Apr 7, 2025, 12:01:59 AM
    Author     : Chris
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>



<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Progreso</title>
    <link rel="stylesheet" href="Styles29.css">
    <link rel="icon" href="src/logoFitData.png" type="img/png">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
    <style>
        #bot-float-button {
        position: fixed;
        bottom: 30px;
        right: 30px;
        background-color: var(--secondary-color);
        color: white;
        padding: 18px;
        border-radius: 50%;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        cursor: pointer;
        z-index: 999;
        transition: background-color 0.3s ease;
      }

      #bot-float-button:hover {
        background-color: var(--secondary-color-dark);
      }

      #bot-float-button i {
        font-size: 24px;
      }

      #bot-window {
        display: none;
        position: fixed;
        bottom: 90px; 
        right: 30px;
        width: 450px;
        height: 460px;
        border: 1px solid #ccc;
        background: white;
        z-index: 999;
        box-shadow: 0 8px 16px rgba(0,0,0,0.3);
        border-radius: 10px;
        overflow: hidden;
      }

      #login-modal {
        display: none;
        position: fixed;
        bottom: 90px; 
        right: 30px;
        width: 350px;
        height: 460px;
        border: 1px solid #ccc;
        background: white;
        z-index: 999;
        box-shadow: 0 8px 16px rgba(0,0,0,0.3);
        border-radius: 10px;
        overflow: hidden;
      }
      #login-modal iframe {
        width: 100%;
        height: 100%;
        border: none;
      }

      #bot-window iframe {
        width: 100%;
        height: 100%;
        border: none;
      }
      
    </style>

</head>
<body>
    <header>
        <div class="container">
            <div class="logo">
                <a href="FitDataa"><img src="src/LogoFitdata2.png" alt="FITDATA"></a>
            </div>
            <nav>
                <ul>
                    <li><a href="FitDataa">Inicio</a></li>
                    <li><a href="Rutinas.jsp">Rutinas</a></li>
                    <li><a href="Dietas.jsp">Dietas</a></li>
                    <li><a href="Informacion.jsp">Informacion</a></li>
                </ul>
            </nav>
            <div class="user-menu">
                <div class="user-avatar">
                    <img src="ImagenPerfil" alt="Usuario">
                </div>
                <span class="username"> </span>
                <div class="dropdown-menu">
                    <a href="Perfil.jsp">Mi Perfil</a>
                    <a href="Logout">Cerrar Sesion</a>
                </div>
            </div>
        </div>
    </header>

<%
    String datosPesoJSON = (String) request.getAttribute("datosJSON");
    if (datosPesoJSON == null) {
        datosPesoJSON = "{\"fechas\":[],\"pesos\":[],\"objetivo\":0,\"pesoInicial\":0}";
    }
    String datosPesoSafe = datosPesoJSON.replace("\"", "\\\"");

    String datosMedidasJSON = (String) request.getAttribute("medidasJSON");
    if (datosMedidasJSON == null) {
        datosMedidasJSON = "{\"fechas\":[],\"pecho\":[],\"cintura\":[],\"caderas\":[],\"muslo\":[],\"brazo\":[]}";
    }
    String datosMedidasSafe = datosMedidasJSON.replace("\"", "\\\"");
    
    String datosFuerzaJSON = (String) request.getAttribute("fuerzaJSON");
    if (datosFuerzaJSON == null) {
        datosFuerzaJSON = "{\"fechas\":[],\"sentadilla\":[],\"pressPecho\":[],\"pesoMuerto\":[],\"pressMilitar\":[],\"curlBiceps\":[],\"remo\":[]}";
    }
    String datosFuerzaSafe = datosFuerzaJSON.replace("\"", "\\\"");
    
    List<String> fechasMedidas = (List<String>) request.getAttribute("fechaMedidas");
    List<Double> cintura = (List<Double>) request.getAttribute("cintura");
    List<Double> pecho = (List<Double>) request.getAttribute("pecho");
    List<Double> caderas = (List<Double>) request.getAttribute("caderas");
    List<Double> muslo = (List<Double>) request.getAttribute("muslo");
    List<Double> brazo = (List<Double>) request.getAttribute("brazo");
    
    List<String> fechaCargas = (List<String>) request.getAttribute("fechaCargas");
    List<Double> sentadilla = (List<Double>) request.getAttribute("sentadilla");
    List<Double> pressPecho = (List<Double>) request.getAttribute("pressPecho");
    List<Double> pesoMuerto = (List<Double>) request.getAttribute("pesoMuerto");
    List<Double> pressMilitar = (List<Double>) request.getAttribute("pressMilitar");
    List<Double> curlBiceps = (List<Double>) request.getAttribute("curlBiceps");
    List<Double> remo = (List<Double>) request.getAttribute("remo");
    
    HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("id_usuario") == null) {
            response.sendRedirect("Proyecto.jsp");
            return;
        }
        String username = (String) sesion.getAttribute("nombre_usuario");
        int id_usuario = (int) session.getAttribute("id_usuario");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean mostrarModal = false;
        int registrosCargas = 0;


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitdata", "root", "AT10220906");

            // Medidas últimos 15 días
            ps = con.prepareStatement(
                "SELECT COUNT(*) FROM Cargas WHERE id_usuario = ? AND fecha >= DATE_SUB(CURDATE(), INTERVAL 13 DAY)"
            );
            ps.setInt(1, id_usuario);
            rs = ps.executeQuery();
            rs.next();
            registrosCargas = rs.getInt(1);
            rs.close();
            ps.close();


            if (registrosCargas == 0) {
                mostrarModal = true;
            }
            else{
                mostrarModal = false;
            }

        } catch (Exception e) {
            out.println("Error al obtener datos: " + e.getMessage());
        } finally {
            if (con != null) con.close();
        }
%>



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

                </div>
            </div>
        </section>



        <section id="weight-section" class="progress-section">
            <div class="container">
                <div class="section-header">
                    <h2>Control de Peso</h2>
                </div>
                <div class="charts-container">
                    <div class="chart-card primary-chart">
                        <div class="chart-header">
                            <h3>Evolución del Peso</h3>
                        </div>
                        <div class="chart-body">
                            <canvas id="weightLineChart" height="300"></canvas>
                        </div>
                    </div>
                    <div class="chart-card secondary-chart">
                        <div class="chart-header">
                            <h3>Análisis del Peso Corporal</h3>
                        </div>
                        <div class="chart-body">
                            <%= request.getAttribute("analisisPeso") %>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <section id="measurements-section" class="progress-section">
            <div class="container">
                <div class="section-header">
                    <h2>Medidas Corporales</h2>
                </div>
                <div class="charts-container">
                    <div class="chart-card primary-chart">
                        <div class="chart-header">
                            <h3>Evolución de Medidas</h3>
                        </div>
                        <div class="chart-body">
                            <canvas id="measurementsChart" height="300"></canvas>
                        </div>
                    </div>
                    <div class="chart-card secondary-chart">
                        <div class="chart-header">
                            <h3>Análisis de Medidas Corporales</h3>
                        </div>
                        <div class="chart-body2">
                            <%= request.getAttribute("analisisMedidas") %>
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
                                <th>Muslo</th>
                                <th>Brazo</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            if (fechasMedidas == null || fechasMedidas.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="6" style="text-align: center;">No hay medidas aun</td>
                            </tr>
                        <%
                            } else {
                                for (int i = 0; i < 6; i++) {
                        %>
                            <tr>
                                <td><%= fechasMedidas.get(i) %></td>
                                <td><%= pecho.get(i) %></td>
                                <td><%= cintura.get(i) %></td>
                                <td><%= caderas.get(i) %></td>
                                <td><%= muslo.get(i) %></td>
                                <td><%= brazo.get(i) %></td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>

            </div>
        </section>

        <section id="strength-section" class="progress-section">
            <div class="container">
                <button class="action-btn add-data-btn" id="abrirModalBtn">Registrar cargas actuales</button>
                <div class="section-header">
                    <h2>Progreso de Fuerza</h2>
                </div>
                
                <div class="charts-container strength-charts">
                    <div class="chart-card primary-chart">
                        <div class="chart-header">
                            <h3>Evolución de Carga Máxima (PR) por Ejercicio</h3>
                        </div>
                        <div class="chart-body">
                            <canvas id="strengthChart" height="300"></canvas>
                        </div>
                    </div>
                    
                    <div class="chart-card pentagon-chart">
                        <h3>Balance de Fuerza Actual</h3>
                        <div class="chart-body">
                            <canvas id="radarChart" height="300"></canvas>
                        </div>
                    </div>
                </div>

                <%
                    String[] ejercicios = {
                        "Sentadilla", "Press Banca", "Peso Muerto", 
                        "Press Militar", "Curl Bíceps", "Remo"
                    };

                    List<Double>[] pesos = new List[] {
                        sentadilla, pressPecho, pesoMuerto, 
                        pressMilitar, curlBiceps, remo
                    };


                %>

                <div class="charts-container strength-charts">
                    <div class="data-table chart-card primary-chart">
                        <h3>Record Personal por Ejercicio </h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>Ejercicio</th>

                                    <th>Personal Record Actual</th>
                                    <th>Próximo Objetivo (15 días)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    boolean hayCargas = false;

                                    // Revisar si al menos un ejercicio tiene datos válidos
                                    for (int e = 0; e < ejercicios.length; e++) {
                                        if (pesos[e] != null && !pesos[e].isEmpty()) {
                                            hayCargas = true;
                                            break;
                                        }
                                    }

                                    if (!hayCargas || fechaCargas == null || fechaCargas.isEmpty()) {
                                %>
                                    <tr>
                                        <td colspan="4" style="text-align: center;">No hay cargas registradas aún</td>
                                    </tr>
                                <%
                                    } else {
                                        for (int e = 0; e < ejercicios.length; e++) {
                                            Map<String, Double> fechaToPeso = new LinkedHashMap<>();

                                            for (int i = 0; i < fechaCargas.size(); i++) {
                                                String fecha = fechaCargas.get(i);
                                                Double peso = pesos[e].get(i);

                                                if (peso != null) {
                                                    // Si ya hay una entrada para esa fecha, guardar el mayor peso
                                                    if (!fechaToPeso.containsKey(fecha) || peso > fechaToPeso.get(fecha)) {
                                                        fechaToPeso.put(fecha, peso);
                                                    }
                                                }
                                            }

                                            // Obtener las fechas más recientes (ordenando)
                                            List<String> fechasOrdenadas = new ArrayList<>(fechaToPeso.keySet());
                                            fechasOrdenadas.sort(Collections.reverseOrder()); // fechas descendente

                                            int count = 0;
                                            for (String fecha : fechasOrdenadas) {
                                                if (count >= 2) break;

                                                double pr = fechaToPeso.get(fecha);
                                                double estimado = Math.round(pr * 1.02);

                                %>
                                    <tr>
                                        <td><%= fecha %></td>
                                        <td><%= ejercicios[e] %></td>
                                        <td><%= pr %> kg</td>
                                        <td><%= estimado %> kg</td>
                                    </tr>
                                <%
                                                count++;
                                            }
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                     <div class="chart-card pentagon-chart">
                        <div class="chart-header">
                            <h3>Análisis de Cargas</h3>
                        </div>
                        <div class="chart-body3">
                            <%= request.getAttribute("analisisCargas") %>
                            <%= request.getAttribute("analisisFuerzaGeneral") %>
                        </div>
                    </div>       
                </div>
                        
            </div>
        </section>
    </main>
                        
     <div id="dataModal" class="modal">
        <div class="modal-content">
          <h2>Ingresa tus Records Personales</h2>
          <form id="userDataForm">
            <label for="sentadilla">Peso Máximo Sentadilla (kg):</label>
            <input type="number" id="sentadilla" name="sentadilla" step="0.1" required><br>

            <label for="press">Peso Máximo Press de Pecho (kg):</label>
            <input type="number" id="press" name="press" step="0.1" required><br>

            <label for="pesom">Peso Máximo Peso Muerto (kg):</label>
            <input type="number" id="pesom" name="pesom" step="0.1" required><br>
            
            <label for="pressm">Peso Máximo Press Militar (kg):</label>
            <input type="number" id="pressm" name="pressm" step="0.1" required><br>
            
            <label for="biceps">Peso Máximo Curl Biceps (kg):</label>
            <input type="number" id="biceps" name="biceps" step="0.1" required><br>
            
            <label for="remo">Peso Máximo Remo (kg):</label>
            <input type="number" id="remo" name="remo" step="0.1" required><br><br>

            <button type="submit">Guardar Datos</button>
            <button type="button" id="posponerBtn" class="secundario">Recordarme más tarde</button>
            
          </form>
        </div>
    </div>

<script>
document.addEventListener('DOMContentLoaded', function() {


    Chart.defaults.font.family = "'Poppins', 'Helvetica Neue', 'Helvetica', 'Arial', sans-serif";
    Chart.defaults.font.size = 12;
    Chart.defaults.color = '#6e7a8a';
    Chart.defaults.responsive = true;
    Chart.defaults.maintainAspectRatio = false;

    const mostrarModal = <%= mostrarModal %>;  
    console.log("Mostrar modal:", mostrarModal);

    const modal = document.getElementById("dataModal");
        if (modal && mostrarModal) {
            modal.style.display = "flex";
        }
    const abrirModalBtn = document.getElementById("abrirModalBtn");
        if (abrirModalBtn) {
            abrirModalBtn.addEventListener("click", function () {
                const modal = document.getElementById("dataModal");
                if (modal) {
                    modal.style.display = "flex";
                }
            });
        }

        // 3. Cerrar el modal con botón "Posponer"
        const posponerBtn = document.getElementById("posponerBtn");
        if (posponerBtn) {
            posponerBtn.addEventListener("click", function () {
                modal.style.display = "none";
            });
        }

        // 4. Envío del formulario
        const form = document.getElementById("userDataForm");
        if (form) {
            form.addEventListener("submit", function (e) {
                e.preventDefault();

                const sentadilla = document.getElementById("sentadilla").value;
                const press = document.getElementById("press").value;
                const pesom = document.getElementById("pesom").value;
                const pressm = document.getElementById("pressm").value;
                const biceps = document.getElementById("biceps").value;
                const remo = document.getElementById("remo").value;

                // Validación
                if (!sentadilla || !press || !pesom || !pressm || !biceps || !remo) {
                    alert("Por favor, completa todos los campos.");
                    return;
                }

                fetch('GuardarDatos', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    },
                    body: JSON.stringify({
                        sentadilla: parseFloat(sentadilla),
                        press: parseFloat(press),
                        pesom: parseFloat(pesom),
                        pressm: parseFloat(pressm),
                        biceps: parseFloat(biceps),
                        remo: parseFloat(remo)
                    })
                })
                    .then(response => {
                        if (response.ok) {
                            alert("Datos guardados exitosamente. Actualizando dashboard...");
                            modal.style.display = "none";
                            window.location.reload();
                        } else {
                            throw new Error('Error en la respuesta del servidor');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert("Hubo un error al guardar los datos. Por favor, inténtalo de nuevo.");
                    });
            });
        }
    
    // Variables globales para los gráficos
    let weightChart, weightLossChart, weeklyPaceChart;
    let measurementsChart, strengthChart, radarChart;
    
    const datosProgreso = JSON.parse("<%= datosPesoSafe %>");
    const datosMedidas = JSON.parse("<%= datosMedidasSafe %>");
    const datosFuerza = JSON.parse("<%= datosFuerzaSafe %>");
    
    const fechaElement = document.getElementById('fecha');
    if (fechaElement) {
        fechaElement.valueAsDate = new Date();
    }

    function loadProgressData() {
        try {
            if (datosProgreso?.fechas?.length && datosProgreso?.pesos?.length) {
                createCharts(datosProgreso);
            } else {
                console.warn('No hay datos válidos de progreso.');
            }

            if (datosMedidas?.fechas?.length) {
                createMeasurementsChart(datosMedidas); // <- pasa el segundo JSON aquí
            } else {
                console.warn('No hay datos válidos de medidas.');
            }
            
            if (datosFuerza?.fechas?.length) {
                createStrengthChart(datosFuerza); // <- pasa el segundo JSON aquí
            } else {
                console.warn('No hay datos válidos de medidas.');
            }
            
            if (datosFuerza?.fechas?.length) {
                createRadarChart(datosFuerza); // <- pasa el segundo JSON aquí
            } else {
                console.warn('No hay datos válidos de medidas.');
            }

        } catch (error) {
            console.error('Error al procesar datos:', error);
        }
    }

    function calculateWeightLoss(weights) {
        if (weights.length === 0) return [];       
        const initialWeight = weights[0];
        return weights.map(weight => initialWeight - weight);
    }

    function calculateWeeklyPace(weights, dates) {
        if (weights.length < 2) return [];        
        const weeklyPace = [];
        for (let i = 1; i < weights.length; i++) {
            const currentDate = new Date(dates[i]);
            const previousDate = new Date(dates[i-1]);
            const daysDiff = (currentDate - previousDate) / (1000 * 60 * 60 * 24);
            const weeklyRate = ((weights[i-1] - weights[i]) / daysDiff) * 7;
            weeklyPace.push(Math.max(0, weeklyRate)); 
        }
        return weeklyPace;
    }

    function createCharts(data) {
        const { fechas, pesos, objetivo, pesoInicial } = data;
        if (!fechas || !pesos || fechas.length === 0 || pesos.length === 0) {
            console.error('Datos insuficientes para crear gráficos');
            showExampleData();
            return;
        }

        // Calcular datos derivados
        const weightLossData = calculateWeightLoss(pesos);
        const weeklyPaceData = calculateWeeklyPace(pesos, fechas);
        
        console.log('Datos procesados:', {
            fechas,
            weightLossData,
            weeklyPaceData: weeklyPaceData.length
        });
        
        // Crear gráficos
        try {
            createWeightChart(fechas, pesos, objetivo);
            createWeightLossChart(fechas, weightLossData);
            createWeeklyPaceChart(fechas.slice(1), weeklyPaceData);
            createMeasurementsChart(data);
            createStrengthChart(data);
            createRadarChart(data);
            
            
            console.log('Gráficos creados exitosamente');
        } catch (error) {
            console.error('Error al crear gráficos:', error);
        }
    }

    // Gráfico principal de evolución del peso
    function createWeightChart(dates, weights, targetWeight) {
        const ctx = document.getElementById('weightLineChart');
        if (!ctx) return;

        if (weightChart) {
            weightChart.destroy();
        }

        const targetData = new Array(dates.length).fill(targetWeight);

        weightChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: dates,
                datasets: [
                    {
                        label: 'Peso Actual',
                        data: weights,
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 3,
                        tension: 0.4,
                        pointBackgroundColor: 'rgba(54, 162, 235, 1)',
                        pointBorderColor: '#ffffff',
                        pointBorderWidth: 2,
                        pointRadius: 5,
                        fill: false
                    },
                    {
                        label: 'Objetivo',
                        data: targetData,
                        backgroundColor: 'rgba(40, 167, 69, 0.1)',
                        borderColor: 'rgba(40, 167, 69, 1)',
                        borderWidth: 2,
                        borderDash: [10, 5],
                        tension: 0,
                        pointRadius: 2,
                        fill: false
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: {
                    intersect: false,
                    mode: 'index'
                },
                plugins: {
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#ffffff',
                        bodyColor: '#ffffff',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                const label = context.dataset.label || '';
                                const index = context.dataIndex;
                                const value = context.parsed.y;

                                if (label.includes('Peso Actual')) {
                                    const output = [];

                                    // Peso actual
                                    if (value !== undefined) {
                                        output.push(label + ': ' + value.toFixed(1) + ' kg');
                                    } else {
                                        output.push(label + ': N/A');
                                    }

                                    // Cambio de peso
                                    const datos = context.dataset.data;
                                    let anteriorIndex = index - 1;
                                    while (anteriorIndex >= 0 && (datos[anteriorIndex] === null || datos[anteriorIndex] === undefined)) {
                                        anteriorIndex--;
                                    }

                                    if (anteriorIndex >= 0 && datos[anteriorIndex] !== null && datos[anteriorIndex] !== undefined) {
                                        const anterior = Number(datos[anteriorIndex]);
                                        const cambio = value - anterior;
                                        const signo = cambio >= 0 ? '+' : '';
                                        output.push('Cambio de peso resepcto al ultimo peso: ' + signo + cambio.toFixed(1) + ' kg');
                                    } else {
                                        output.push('Cambio de peso: N/A');
                                    }


                                    return output;
                                }

                                // Para otros datasets, solo mostrar su valor
                                if (value !== null && value !== undefined) {
                                    return label + ': ' + value.toFixed(1) + ' kg';
                                }

                                return null;
                            }


                        }
                    },
                    legend: {
                        display: true,
                        position: 'top',
                        labels: {
                            usePointStyle: true,
                            padding: 20
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: false,
                        min: Math.min(targetWeight - 5, ...weights) - 2,
                        max: Math.max(...weights) + 2,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.1)',
                            lineWidth: 1
                        },
                        ticks: {
                            callback: function(value) {
                                return value.toFixed(1) + ' kg';
                            }
                        }
                    },
                    x: {
                        grid: {
                            color: 'rgba(0, 0, 0, 0.1)',
                            lineWidth: 1
                        },
                        ticks: {
                            autoSkip: false,
                            maxRotation: 0,
                            minRotation: 0,
                            font: {
                                size: 12
                            }
                        }
                    }
                }
            }
        });
    }


    // Gráfico de pérdida de peso
    function createWeightLossChart(dates, weightLossData) {
        const ctx = document.getElementById('weightLossChart');
        if (!ctx) return;

        if (weightLossChart) {
            weightLossChart.destroy();
        }

        weightLossChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: dates,
                datasets: [{
                    label: 'Pérdida de peso (kg)',
                    data: weightLossData,
                    backgroundColor: 'rgba(46, 204, 113, 0.7)',
                    borderColor: '#2ecc71',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value + ' kg';
                            }
                        }
                    },
                    x: {
                        ticks: {
                            maxRotation: 45,
                            minRotation: 0,
                            font: {
                                size: 10
                            }
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return `Pérdida: ${context.parsed.y.toFixed(1)} kg`;
                            }
                        }
                    }
                }
            }
        });
    }

    // Gráfico de ritmo semanal
    function createWeeklyPaceChart(dates, weeklyPaceData) {
        const ctx = document.getElementById('weeklyPaceChart');
        if (!ctx) return;

        if (weeklyPaceChart) {
            weeklyPaceChart.destroy();
        }

        weeklyPaceChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: dates,
                datasets: [{
                    label: 'Ritmo semanal (kg/semana)',
                    data: weeklyPaceData,
                    fill: true,
                    backgroundColor: 'rgba(255, 159, 64, 0.2)',
                    borderColor: '#ff9f40',
                    tension: 0.4,
                    pointBackgroundColor: '#ff9f40',
                    pointRadius: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value.toFixed(1) + ' kg/sem';
                            }
                        }
                    },
                    x: {
                        ticks: {
                            maxRotation: 45,
                            minRotation: 0,
                            font: {
                                size: 10
                            }
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return `Ritmo: ${context.parsed.y.toFixed(2)} kg/semana`;
                            }
                        }
                    }
                }
            }
        });
    }
    
    function createMeasurementsChart(data) {
        const ctx = document.getElementById('measurementsChart');
        if (!ctx) return;

        if (measurementsChart) {
            measurementsChart.destroy();
        }

        const dataChart = {
            labels: data.fechas,
            datasets: [
                {
                    label: 'Pecho',
                    data: data.pecho,
                    borderColor: '#2ecc71',
                    pointRadius: 4,
                    pointStyle: 'circle',                   
                    pointBorderColor: '#2ecc71',
                    pointBorderWidth: 2,
                    tension: 0.7
                },
                {
                label: 'Cintura',
                data: data.cintura,
                borderColor: '#2b6cb0',
                backgroundColor: 'transparent',
                tension: 0.7,
                pointRadius: 4,
                pointStyle: 'circle',
                pointBorderColor: '#2b6cb0',
                pointBorderWidth: 2
            },
            {
                label: 'Caderas',
                data: data.caderas,
                borderColor: '#b794f4',
                backgroundColor: 'transparent',
                tension: 0.7,
                pointRadius: 4,
                pointStyle: 'circle',
                pointBorderColor: '#b794f4', 
                pointBorderWidth: 2
            },
            {
                label: 'Muslo',
                data: data.muslo,
                borderColor: '#f39c12',
                backgroundColor: 'transparent',
                tension: 0.7,
                pointRadius: 4,
                pointStyle: 'circle',
                pointBorderColor: '#f39c12',
                pointBorderWidth: 2
            },
            {
                label: 'Brazo',
                data: data.brazo,
                borderColor: '#e74c3c',
                backgroundColor: 'transparent',
                tension: 0.7,
                pointRadius: 4,
                pointStyle: 'circle',
                pointBorderColor: '#e74c3c',
                pointBorderWidth: 2
            }
        ]
        };


        measurementsChart = new Chart(ctx, {
            type: 'line',
            data: dataChart,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                aspectRatio: 2,
                layout: { padding: 10 },
                scales: {
                    y: {
                        beginAtZero: false,
                        grid: { color: 'rgba(0, 0, 0, 0.05)' }
                    },
                    x: {
                        grid: { display: false }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        labels: {
                            usePointStyle: true
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.7)',
                        padding: 10,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += context.parsed.y.toFixed(1) + ' cm';
                                }
                                return label;
                            }
                        }
                    }
                },
                interaction: {
                    intersect: false,
                    mode: 'index'
                }
            }
        });
    }


    function createStrengthChart(data) {
        const ctx = document.getElementById('strengthChart');
        if (!ctx) return;

        if (strengthChart) {
            strengthChart.destroy();
        }

        const chartData = {
            labels: data.fechas,
            datasets: [
                {
                    label: 'Sentadilla',
                    data: data.sentadilla,
                    borderColor: '#e74c3c',
                    backgroundColor: 'rgba(231, 76, 60, 0.1)',
                    tension: 0.4,
                    fill: false,
                    pointStyle: 'circle',
                    pointBorderColor: '#e74c3c',
                    pointBorderWidth: 2
                },
                {
                    label: 'Press de Pecho',
                    data: data.pressPecho,
                    borderColor: '#3498db',
                    backgroundColor: 'rgba(52, 152, 219, 0.1)',
                    tension: 0.4,
                    fill: false,
                    pointStyle: 'circle',
                    pointBorderColor: '#3498db',
                    pointBorderWidth: 2
                },
                {
                    label: 'Peso Muerto',
                    data: data.pesoMuerto,
                    borderColor: '#2ecc71',
                    backgroundColor: 'rgba(46, 204, 113, 0.1)',
                    tension: 0.4,
                    fill: false,
                    pointStyle: 'circle',
                    pointBorderColor: '#2ecc71',
                    pointBorderWidth: 2
                },
                {
                    label: 'Press Militar',
                    data: data.pressMilitar,
                    borderColor: '#9b59b6',
                    backgroundColor: 'rgba(155, 89, 182, 0.1)',
                    tension: 0.4,
                    fill: false,
                    pointStyle: 'circle',
                    pointBorderColor: '#9b59b6',
                    pointBorderWidth: 2
                },
                {
                    label: 'Curl Bíceps',
                    data: data.curlBiceps,
                    borderColor: '#f1c40f',
                    backgroundColor: 'rgba(241, 196, 15, 0.1)',
                    tension: 0.4,
                    fill: false,
                    pointStyle: 'circle',
                    pointBorderColor: '#f1c40f',
                    pointBorderWidth: 2
                },
                {
                    label: 'Remo',
                    data: data.remo,
                    borderColor: '#1abc9c',
                    backgroundColor: 'rgba(26, 188, 156, 0.1)',
                    tension: 0.4,
                    fill: false,
                    pointStyle: 'circle',
                    pointBorderColor: '#1abc9c',
                    pointBorderWidth: 2
                }
            ]
        };

        strengthChart = new Chart(ctx, {
            type: 'line',
            data: chartData,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                aspectRatio: 2,
                layout: { padding: 10 },
                scales: {
                    y: {
                        beginAtZero: false,
                        grid: { color: 'rgba(0, 0, 0, 0.05)' }
                    },
                    x: {
                        grid: { display: false }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        labels: {
                            usePointStyle: true
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.7)',
                        padding: 10,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += context.parsed.y.toFixed(1) + ' kg';
                                }
                                return label;
                            }
                        }
                    }
                },
                interaction: {
                    intersect: false,
                    mode: 'index'
                }
            }
        });
    }






    function createRadarChart(data) {
        const ctx = document.getElementById('radarChart');
        if (!ctx) return;

        if (radarChart) {
            radarChart.destroy();
        }

        const chartData = {
            labels: ['Sentadilla', 'Press Banca', 'Peso Muerto', 'Press Militar', 'Remo'],
            datasets: [
                {
                    label: 'Actual',
                    data: [
                        data.sentadilla?.at(-1) || 0,
                        data.pressPecho?.at(-1) || 0,
                        data.pesoMuerto?.at(-1) || 0,
                        data.pressMilitar?.at(-1) || 0,
                        data.remo?.at(-1) || 0
                    ],
                    fill: true,
                    backgroundColor: 'rgba(0, 188, 212, 0.3)',  // fondo translúcido
                    borderColor: '#00bcd4',                    // borde principal
                    pointBackgroundColor: '#00bcd4',
                    pointBorderColor: '#ffffff',
                    pointHoverBorderColor: '#00bcd4'
                },
                {
                    label: 'Inicial',
                    data: [
                        data.sentadilla?.[0] || 0,
                        data.pressPecho?.[0] || 0,
                        data.pesoMuerto?.[0] || 0,
                        data.pressMilitar?.[0] || 0,
                        data.remo?.[0] || 0
                    ], 
                    fill: true,
                    backgroundColor: 'rgba(231, 76, 60, 0.3)',
                    borderColor: '#e74c3c',
                    pointBackgroundColor: '#e74c3c',
                    pointBorderColor: '#fff',
                    pointHoverBackgroundColor: '#fff',
                    pointHoverBorderColor: '#e74c3c'
                }
            ]
        };

        radarChart = new Chart(ctx, {
            type: 'radar',
            data: chartData,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                aspectRatio: 1,
                layout: { padding: 10 },
                elements: {
                    line: { borderWidth: 2 }
                },
                scales: {
                    r: {
                        angleLines: { color: 'rgba(0, 0, 0, 0.1)' },
                        grid: { color: 'rgba(0, 0, 0, 0.1)' },
                        ticks: {
                            backdropColor: 'transparent',
                            color: '#6e7a8a',
                            z: 1,
                            maxTicksLimit: 5
                        },
                        pointLabels: {
                            color: '#8c8c8c',
                            font: {
                                size: 12,
                                weight: 'bold'
                            }
                        },
                        suggestedMax: 150 // Puedes ajustar según tus máximos reales
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        labels: {
                            usePointStyle: true
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.7)',
                        padding: 10,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.r !== null) {
                                    label += context.parsed.r.toFixed(1) + ' kg';
                                }
                                return label;
                            }
                        }
                    }
                },
                interaction: {
                    intersect: false,
                    mode: 'index'
                }
            }
        });
    }




    // Configurar contenedores de gráficos
    function setupChartContainer(chartElement) {
        if (!chartElement) return;
        
        const parentContainer = chartElement.closest('.chart-body');
        if (parentContainer) {
            if (!parentContainer.style.height) {
                if (chartElement.id.includes('Loss') || chartElement.id.includes('Pace')) {
                    parentContainer.style.height = '200px';
                } else {
                    parentContainer.style.height = '300px';
                }
            }
        }
    }

    // Configurar todos los contenedores
    ['weightLineChart', 'weightLossChart', 'weeklyPaceChart', 'measurementsChart', 'strengthChart', 'radarChart'].forEach(id => {
        const element = document.getElementById(id);
        if (element) {
            setupChartContainer(element);
        }
    });

    // Event listeners para botones de marco temporal
    const timeframeBtns = document.querySelectorAll('.timeframe-btn');
    timeframeBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            this.parentElement.querySelectorAll('.timeframe-btn').forEach(b => {
                b.classList.remove('active');
            });
            this.classList.add('active');
            
            const period = this.getAttribute('data-period');
            console.log(`Cambiando vista a periodo: ${period}`);
            // Aquí podrías filtrar los datos según el período seleccionado
            // filterDataByPeriod(period);
        });
    });

    // Manejar redimensionamiento de ventana
    window.addEventListener('resize', function() {
        setTimeout(function() {
            if (weightChart) weightChart.resize();
            if (weightLossChart) weightLossChart.resize();
            if (weeklyPaceChart) weeklyPaceChart.resize();
            if (measurementsChart) measurementsChart.resize();
            if (strengthChart) strengthChart.resize();
            if (radarChart) radarChart.resize();
        }, 300);
    });

    // Inicializar carga de datos
    loadProgressData();    
});
</script>
</body>
</html>
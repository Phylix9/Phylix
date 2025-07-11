<%-- 
    Document   : FitData
    Created on : Apr 10, 2025, 9:59:48 PM
    Author     : chris
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List, java.util.Map"%>
<%@ page import="com.Phylix.Ejercicio" %>
<%@ page import="com.Phylix.Comida" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitData</title>
    <link rel="stylesheet" href="StyleFD.css">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.4.0/fonts/remixicon.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    
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
      
      .modal {
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background-color: rgba(0, 0, 0, 0.6);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 1000;
      }

      /* Contenedor del formulario */
      .modal-content {
        background-color: #1f2937; /* azul oscuro */
        padding: 20px;
        border-radius: 16px;
        width: 360px;
        color: #f1f5f9;
        height: 95%;
        font-family: 'Segoe UI', sans-serif;
        box-shadow: 0 10px 25px rgba(0,0,0,0.5);
        text-align: center;
      }

      /* Títulos y etiquetas */
      .modal-content h2 {
        margin-bottom: 20px;
        font-size: 22px;
        color: #60a5fa;
      }

      .modal-content label {
        display: block;
        margin-top: 12px;
        font-weight: 500;
        text-align: left;
      }

      /* Inputs */
      .modal-content input {
        width: 100%;
        padding: 10px;
        margin-top: 4px;
        border-radius: 10px;
        border: none;
        background-color: #374151;
        color: #f9fafb;
        font-size: 15px;
      }

      /* Botón */
      .modal-content button {
        margin-top: 0px;
        width: 100%;
        padding: 12px;
        border: none;
        border-radius: 10px;
        background-color: #3b82f6;
        color: white;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.3s ease;
      }

      .modal-content button:hover {
        background-color: #2563eb;
      }
      
      .modal-content .secundario {
        background-color: transparent;
        color: #93c5fd;
        border: 2px solid #60a5fa;
        margin-top: 10px;
      }

      .modal-content .secundario:hover {
        background-color: #1e3a8a;
        color: #fff;
      }


  </style>
</head>
<body>
    <%
        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("id_usuario") == null) {
            response.sendRedirect("Proyecto.jsp");
            return;
        }
        String username = (String) sesion.getAttribute("nombre_usuario");
        int id_usuario = (int) session.getAttribute("id_usuario");
        String nombreDia = (String) request.getAttribute("nombre_dia");
        Connection con = null;
        Connection con2 = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        ResultSet rs = null;

        boolean mostrarModal = false;
        String fechaRegistro = "";
        String objetivo = "";
        BigDecimal progreso = BigDecimal.ZERO;
        long diasActivos = 0;
        double pesoInicial = 0;
        double pesoActual = 0;
        double perdidaPeso = 0;
        int registrosMedidas= 0;
        int registrosIMC= 0;
        int registrosEntreno= 0;

        if (request.getAttribute("pesoInicial") != null) {
            pesoInicial = (Double) request.getAttribute("pesoInicial");
            pesoActual = (Double) request.getAttribute("pesoActual");
            perdidaPeso = pesoInicial - pesoActual;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitdata", "root", "AT10220906");

            ps = con.prepareStatement("SELECT fecha_registro, progreso, peso_inicial, ultima_conexion FROM Usuario WHERE id_usuario = ?");
            ps.setInt(1, id_usuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                fechaRegistro = rs.getDate("fecha_registro").toString();
                progreso = rs.getBigDecimal ("progreso");
                pesoInicial = rs.getDouble("peso_inicial");

                java.sql.Date fechaSQL = rs.getDate("fecha_registro");
                java.time.LocalDate inicio = fechaSQL.toLocalDate();
                
                java.time.LocalDate hoy = java.time.LocalDate.now();
                diasActivos = java.time.temporal.ChronoUnit.DAYS.between(inicio, hoy) + 1;
            }
            rs.close();
            ps.close();

            ps = con.prepareStatement("SELECT objetivo_usuario FROM Cuestionario WHERE id_usuario = ?");
            ps.setInt(1, id_usuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                objetivo = rs.getString("objetivo_usuario");
            }
            rs.close();
            ps.close();

            // Último peso del usuario en IMC
            ps = con.prepareStatement("SELECT peso_usuario FROM IMC WHERE id_usuario = ? ORDER BY fecha DESC LIMIT 1");
            ps.setInt(1, id_usuario);
            rs = ps.executeQuery();
            if (rs.next()) {
                pesoActual = rs.getDouble("peso_usuario");
                perdidaPeso = pesoInicial - pesoActual;
            }
            rs.close();
            ps.close();

            // IMC últimos 15 días
            ps = con.prepareStatement(
                "SELECT COUNT(*) FROM IMC WHERE id_usuario = ? AND fecha >= DATE_SUB(CURDATE(), INTERVAL 13 DAY)"
            );
            ps.setInt(1, id_usuario);
            rs = ps.executeQuery();
            rs.next();
            registrosIMC = rs.getInt(1);
            rs.close();
            ps.close();

            // Medidas últimos 15 días
            ps = con.prepareStatement(
                "SELECT COUNT(*) FROM Medidas WHERE id_usuario = ? AND fecha >= DATE_SUB(CURDATE(), INTERVAL 13 DAY)"
            );
            ps.setInt(1, id_usuario);
            rs = ps.executeQuery();
            rs.next();
            registrosMedidas = rs.getInt(1);
            rs.close();
            ps.close();

            ps = con.prepareStatement("SELECT COUNT(*) FROM Rutinasper WHERE id_usuario = ? AND estado= 'hecho'");
            ps.setInt(1, id_usuario);
            rs = ps.executeQuery();
            rs.next();
            registrosEntreno = rs.getInt(1);
            rs.close();
            ps.close();

            if (registrosMedidas == 0 && registrosIMC == 0) {
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

        String nombreRutina = (String) request.getAttribute("nombre_rutina");
        List<Map<String, String>> ejercicios = (List<Map<String, String>>) request.getAttribute("ejercicios");
    %>
    <header>
        <div class="container">
            <div class="logo">
                <a href="FitDataa"><img src="src/LogoFitdata2.png" alt="FITDATA"></a>
            </div>
            <nav>
                <ul>
                    <li><a href="Progreso">Progreso</a></li>
                    <li><a href="Rutinas">Rutinas</a></li>
                    <li><a href="Dietas">Dietas</a></li>
                    <li><a href="Informacion">Información</a></li>
                </ul>
            </nav>
            <div class="user-menu">
                <div class="user-avatar">
                    <img src="ImagenPerfil" alt="Usuario">
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
                        <p class="profile-stats">Miembro desde: <span><%= fechaRegistro %></span></p>
                        <p class="profile-stats">Programa: <span><%= objetivo %></span></p>
                        <div class="profile-progress">
                            <div class="progress-bar">
                                <div class="progress" style="width: <%= progreso %>%"></div>
                            </div>
                            <span><%= progreso %>% hacia tu objetivo</span>
                        </div>
                    </div>
                </div>
                <div class="quick-stats">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <img src="src/dias_activo.png" alt="Días">
                        </div>
                        <div class="stat-info">
                            <span class="stat-value"><%= diasActivos %></span>
                            <span class="stat-label">Días activos</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <img src="src/perdida_peso.png" alt="Peso">
                        </div>
                        <div class="stat-info">
                            <span class="stat-value"> <%= String.format("%.1f", perdidaPeso) %> kg</span>
                            <span class="stat-label">Pérdida de peso</span>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <img src="src/entrenamientos.png" alt="Entrenamientos">
                        </div>
                        <div class="stat-info">
                            <span class="stat-value">1</span>
                            <span class="stat-label">Entrenamientos en esta semana</span>
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
                        <span class="metric-value"><%= request.getAttribute("pesoInicial") %> kg</span>
                    </div>
                    <div class="metric">
                        <span class="metric-label">Peso Actual</span>
                        <span class="metric-value"><%= request.getAttribute("pesoActual") %> kg</span>
                    </div>
                    <div class="metric">
                        <span class="metric-label">Objetivo Final</span>
                        <span class="metric-value"><%= request.getAttribute("pesoObjetivo") %> kg</span>
                    </div>
                    <div class="metric">
                        <span class="metric-label">Objetivo Próximo Mes</span>
                        <span class="metric-value"><%= request.getAttribute("pesoObjetivoMensual") %> kg</span>
                    </div>
                </div>
                <a href="Progreso" class="btn btn-secondary">Ver Detalles Completos</a>
            </div>
                    
                <div class="dashboard-card workout-card">
                    <h2>Mis Rutinas</h2>
                    <div class="workout-calendar">
                        <div class="calendar-header">
                            <span><%= java.time.LocalDate.now().getMonth().name() %> <%= java.time.LocalDate.now().getYear() %></span>
                        </div>
                        <div class="calendar-days">
                            <%
                                String estado = (String) request.getAttribute("estado_rutina");
                                String[] diasSemana = {"L", "M", "X", "J", "V", "S", "D"};
                                String diaActual = "";
                                switch (java.time.LocalDate.now().getDayOfWeek()) {
                                    case MONDAY: diaActual = "L"; break;
                                    case TUESDAY: diaActual = "M"; break;
                                    case WEDNESDAY: diaActual = "X"; break;
                                    case THURSDAY: diaActual = "J"; break;
                                    case FRIDAY: diaActual = "V"; break;
                                    case SATURDAY: diaActual = "S"; break;
                                    case SUNDAY: diaActual = "D"; break;
                                }

                                for (String dia : diasSemana) {
                                String claseCss = "";
                                String textoDia = dia;
                                if (dia.equals(diaActual)) {
                                    claseCss = "today";
                                    if ("hecho".equals(estado)) {
                                        claseCss = "completed";
                                        textoDia = "✔";
                                    }
                                }
                            %>
                                <div class="calendar-day <%= claseCss %>"><%= textoDia %></div>
                            <%
                            } %>
                        </div>
                    </div>

                    <div class="today-workout">
                        <%
                            String nombreRutinaa = (String) request.getAttribute("nombre_rutina");

                        %>
                        <h3>Rutina para Hoy: 
                            <%= nombreRutinaa != null ? nombreRutinaa : "Sin rutina asignada" %>
                        </h3>
                        <div class="workout-plan">
                            <%
                                if ("descanso".equals(estado)) {
                            %>
                                <p>Hoy es día de descanso.</p>
                            <%
                                } else if ("hecho".equals(estado)) {
                            %>
                                <p>¡Felicidades, completaste tu entrenamiento diario!</p>
                            <%
                                } else {
                                    List<Ejercicio> ejercicios2 = (List<Ejercicio>) request.getAttribute("ejercicios");
                                    if (ejercicios2 != null && !ejercicios2.isEmpty()) {
                                        for (Ejercicio ejercicio : ejercicios2) {
                            %>
                                            <div class="exercise">
                                                <span class="exercise-name"><%= ejercicio.getNombre() %></span>
                                                <span class="exercise-details"><%= ejercicio.getDetalle() %></span>
                                            </div>
                            <%
                                        }
                                    } else {
                            %>
                                        <p>No hay ejercicios asignados para hoy.</p>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>
                    <%
                        con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitdata", "root", "AT10220906");

                        boolean rutinaCompletada = false;
                        try {
                            ps2 = con2.prepareStatement("SELECT estado FROM Rutinasper WHERE id_usuario = ? AND dia_rutina = ? ORDER BY id_rut DESC LIMIT 1");
                            ps2.setInt(1, id_usuario);
                            ps2.setString(2, nombreDia);
                            rs = ps2.executeQuery();
                            if (rs.next()) {
                                String estadoRutina = rs.getString("estado");
                                if ("hecho".equalsIgnoreCase(estadoRutina) || "descanso".equalsIgnoreCase(estadoRutina)) {
                                    rutinaCompletada = true;
                                }
                            }
                            rs.close();
                            ps2.close();
                        } catch (Exception e) {
                            out.println("Error al verificar estado de la rutina: " + e.getMessage());
                        }
                    %>
                        
                    <div class="workout-actions">
                        <form method="post" >
                            <% if (!rutinaCompletada) { %>
                            <button type="button" class="btn btn-secondary" onclick="marcarDescanso()">Día de descanso</button>
                            <button type="button" class="btn btn-secondary" onclick="entrenamientoHecho()">Entrenamiento hecho</button>
                            <% } %>
                            <a href="MisRutinas.jsp">
                                <button type="button" class="btn btn-secondary">Ver todas las rutinas</button>
                            </a>
                        </form>
                    </div>
                </div>
                </div>
                <div class="center-wrapper">            
                    <div class="dashboard-card diet-card">
                        <h2>Mi Plan de Alimentación</h2>
                        <div class="diet-summary">
                            <div class="today-meals">
                            <%
                                List<Comida> comidas = (List<Comida>) request.getAttribute("comidasDelDia");

                                int totalProteinas = 0;
                                int totalCarbos = 0;
                                int totalGrasas = 0;
                                int totalVitaminas = 0;

                                if (comidas != null) {
                                    for (Comida comida : comidas) {
                                        totalProteinas += comida.getPorcionProteina();
                                        totalCarbos += comida.getPorcionCarbohidrato();
                                        totalGrasas += comida.getPorcionGrasa();
                                        totalVitaminas += comida.getPorcionVitamina();
                                    }
                                }

                                int totalMacros = totalProteinas + totalCarbos + totalGrasas + totalVitaminas;

                                int porcentajeProteinas = totalMacros > 0 ? (totalProteinas * 100 / totalMacros) : 0;
                                int porcentajeCarbos = totalMacros > 0 ? (totalCarbos * 100 / totalMacros) : 0;
                                int porcentajeGrasas = totalMacros > 0 ? (totalGrasas * 100 / totalMacros) : 0;
                                int porcentajeVitaminas = totalMacros > 0 ? (totalVitaminas * 100 / totalMacros) : 0;

                                String[] nombresComida = { "Desayuno", "Almuerzo", "Comida", "Merienda", "Cena" };

                                if (comidas == null || comidas.isEmpty() || totalMacros == 0) {
                            %>
                                <p><strong>No tienes comida asignada para hoy.</strong></p>
                            <%
                                } else {
                                    for (int i = 0; i < comidas.size(); i++) {
                                        Comida c = comidas.get(i);
                            %>
                                <div class="meal-row">
                                    <div class="meal-time"><strong><%= nombresComida[i] %></strong></div>
                                    <div class="meal-desc"><%= c.getProteina() %> con <%= c.getCarbohidrato() %> y <%= c.getVitamina() %></div>
                                    <div class="meal-fat">Incluye grasa: <%= c.getGrasa() %></div>
                                </div>
                            <%
                                    }
                                }
                            %>
                            </div>

                            <% if (comidas != null && !comidas.isEmpty() && totalMacros > 0) { %>
                            <div class="diet-macros">
                                <div class="macro-chart">
                                    <canvas id="macrosChart"></canvas>
                                </div>
                                <div class="macro-legend">
                                    <div class="macro-item">
                                        <span class="color-box protein"></span>
                                        <span>Proteínas: <%= porcentajeProteinas %>%</span>
                                    </div>
                                    <div class="macro-item">
                                        <span class="color-box carbs"></span>
                                        <span>Carbohidratos: <%= porcentajeCarbos %>%</span>
                                    </div>
                                    <div class="macro-item">
                                        <span class="color-box fats"></span>
                                        <span>Grasas: <%= porcentajeGrasas %>%</span>
                                    </div>
                                    <div class="macro-item">
                                        <span class="color-box vitamins"></span>
                                        <span>Vitaminas: <%= porcentajeVitaminas %>%</span>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <a href="MisDietas.jsp" class="btn btn-secondary">Ver Plan Completo</a>
                    </div>
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
                        
    <div id="bot-float-button" onclick="toggleBot()">
        <i class="ri-robot-line"></i>
    </div>
        
    <div id="bot-window">
        <iframe src="fitdatabot.jsp" frameborder="0"></iframe>
    </div>
    
    <div id="login-modal">
        <iframe src="LoginBot.html" frameborder="0"></iframe>
    </div>                    

                            
    <div id="dataModal" class="modal">
        <div class="modal-content">
          <h2>Ingresa tu información</h2>
          <form id="userDataForm">
            <label for="peso">Peso actual (kg):</label>
            <input type="number" id="peso" name="peso" step="0.1" required><br>

            <label for="cintura">Medida de cintura (cm):</label>
            <input type="number" id="cintura" name="cintura" step="0.1" required><br>

            <label for="pecho">Medida de pecho (cm):</label>
            <input type="number" id="pecho" name="pecho" step="0.1" required><br>
            
            <label for="pecho">Medida de cadera (cm):</label>
            <input type="number" id="cadera" name="cadera" step="0.1" required><br>
            
            <label for="pecho">Medida de muslo (cm):</label>
            <input type="number" id="muslo" name="muslo" step="0.1" required><br>
            
            <label for="pecho">Medida de brazo (cm):</label>
            <input type="number" id="brazo" name="brazo" step="0.1" required><br><br>

            <button type="submit">Guardar Datos</button>
            <button type="button" id="posponerBtn" class="secundario">Recordarme más tarde</button>
            
          </form>
        </div>
    </div>
                        
    <%-- Script section for FitData.jsp --%>
    

<script>
    console.log("fromServlet en JSP: <%= request.getAttribute("fromServlet") %>");

    document.addEventListener('DOMContentLoaded', function() {
        // Verificar si los datos vienen del servlet
        const fromServlet = "<%= request.getAttribute("fromServlet") %>" === "true";
        
        // Obtener datos del servlet o usar valores por defecto
        let mesesPeso, pesos, cinturas, pechos;
        
        if (fromServlet) {
            // Datos del servlet - Parsear JSON strings correctamente
            try {
                const mesesPesoStr = '<%= request.getAttribute("mesesPeso") != null ? request.getAttribute("mesesPeso") : "[]" %>';
                const pesosStr = '<%= request.getAttribute("pesos") != null ? request.getAttribute("pesos") : "[]" %>';
                const cinturasStr = '<%= request.getAttribute("cinturas") != null ? request.getAttribute("cinturas") : "[]" %>';
                const pechosStr = '<%= request.getAttribute("pechos") != null ? request.getAttribute("pechos") : "[]" %>';
                
                mesesPeso = JSON.parse(mesesPesoStr);
                pesos = JSON.parse(pesosStr);
                cinturas = JSON.parse(cinturasStr);
                pechos = JSON.parse(pechosStr);
                
                console.log('Datos del servlet cargados:', {
                    mesesPeso: mesesPeso,
                    pesos: pesos,
                    cinturas: cinturas,
                    pechos: pechos
                });
            } catch (error) {
                console.error('Error al parsear datos del servlet:', error);
                // Usar datos por defecto en caso de error
                fromServlet = false;
            }
        }
        
        if (!fromServlet) {
            // Datos por defecto si no hay datos del servlet
            mesesPeso = ["Ene", "Feb", "Mar", "Abr", "May", "Jun"];
            pesos = [<%= request.getAttribute("pesoInicial") != null ? request.getAttribute("pesoInicial") : "70.0" %>, 
                     <%= request.getAttribute("pesoActual") != null ? request.getAttribute("pesoActual") : "68.0" %>];
            cinturas = [80, 78, 76, 75, 74, 73];
            pechos = [95, 96, 97, 98, 99, 100];
            
            console.log('Usando datos por defecto');
        }

        // Datos adicionales del servlet
        const pesoObjetivoMensual = <%= request.getAttribute("pesoObjetivoMensual") != null ? request.getAttribute("pesoObjetivoMensual") : "0" %>;
        const pesoObjetivoFinal = <%= request.getAttribute("pesoObjetivo") != null ? request.getAttribute("pesoObjetivo") : "57.0" %>;
        const pesoActualJS = <%= request.getAttribute("pesoActual") != null ? request.getAttribute("pesoActual") : "70.0" %>;
        const pesoInicial = <%= request.getAttribute("pesoInicial") != null ? request.getAttribute("pesoInicial") : "75.0" %>;

        // Validar que tenemos datos válidos
        if (!Array.isArray(mesesPeso) || mesesPeso.length === 0) {
            mesesPeso = ["Ene", "Feb", "Mar", "Abr", "May", "Jun"];
        }
        
        if (!Array.isArray(pesos) || pesos.length === 0) {
            pesos = [pesoInicial, pesoActualJS];
        }
        
        if (!Array.isArray(cinturas) || cinturas.length === 0) {
            cinturas = [80, 78, 76, 75, 74, 73];
        }
        
        if (!Array.isArray(pechos) || pechos.length === 0) {
            pechos = [95, 96, 97, 98, 99, 100];
        }

        console.log('Datos finales a usar:', {
            mesesPeso: mesesPeso,
            pesos: pesos,
            cinturas: cinturas,
            pechos: pechos,
            pesoObjetivoMensual: pesoObjetivoMensual,
            pesoObjetivoFinal: pesoObjetivoFinal
        });
        // Preparar datos para gráfico de peso con proyección
        const mesesConProyeccion = [...mesesPeso];
        const pesosConProyeccion = [...pesos];

        // Agregar proyección del próximo mes
        const fechaActual = new Date();
        const proximoMes = new Date(fechaActual.getFullYear(), fechaActual.getMonth() + 1, 1);
        const nombreProximoMes = proximoMes.toLocaleDateString('es-ES', { month: 'short' });

        if (pesoObjetivoMensual > 0 && pesoObjetivoMensual !== pesoActualJS) {
            mesesConProyeccion.push(nombreProximoMes);
            pesosConProyeccion.push(pesoObjetivoMensual);
        }
        
        // Gráfico de Peso
        const weightCtx = document.getElementById('weightChart').getContext('2d');
        const weightChart = new Chart(weightCtx, {
            type: 'line',
            data: {
                labels: mesesConProyeccion,
                datasets: [{
                    label: 'Peso Actual (kg)',
                    data: pesosConProyeccion.slice(0, pesos.length), // Solo datos reales
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 3,
                    tension: 0.4,
                    pointBackgroundColor: 'rgba(54, 162, 235, 1)',
                    pointBorderColor: '#ffffff',
                    pointBorderWidth: 2,
                    pointRadius: 5,
                    fill: true
                }, {
                    label: 'Proyección Próximo Mes',
                    data: [...Array(pesos.length - 1).fill(null), pesosConProyeccion[pesos.length - 1], pesoObjetivoMensual],
                    backgroundColor: 'rgba(255, 193, 7, 0.2)',
                    borderColor: 'rgba(255, 193, 7, 1)',
                    borderWidth: 3,
                    borderDash: [8, 4],
                    tension: 0.4,
                    pointBackgroundColor: 'rgba(255, 193, 7, 1)',
                    pointBorderColor: '#ffffff',
                    pointBorderWidth: 2,
                    pointRadius: 6,
                    pointStyle: 'triangle',
                    fill: false
                }, {
                    label: 'Objetivo Final',
                    data: Array(mesesConProyeccion.length).fill(pesoObjetivoFinal),
                    backgroundColor: 'rgba(40, 167, 69, 0.1)',
                    borderColor: 'rgba(40, 167, 69, 1)',
                    borderWidth: 2,
                    borderDash: [12, 6],
                    tension: 0,
                    pointRadius: 0,
                    fill: false
                }]
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
                        min: Math.min(...pesosConProyeccion, pesoObjetivoFinal) - 3,
                        max: Math.max(...pesosConProyeccion, pesoObjetivoFinal) + 3,
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
                        }
                    }
                }
            }
        });


        
        // Gráfico de Medidas Corporales
        const measurementsCtx = document.getElementById('bodyMeasurementsChart').getContext('2d');
        const measurementsChart = new Chart(measurementsCtx, {
            type: 'line',
            data: {
                labels: mesesPeso,
                datasets: [{
                    label: 'Cintura (cm)',
                    data: cinturas,
                    borderColor: 'rgba(255, 99, 132, 1)',
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderWidth: 3,
                    tension: 0.4,
                    fill: true,
                    pointBackgroundColor: 'rgba(255, 99, 132, 1)',
                    pointBorderColor: '#ffffff',
                    pointBorderWidth: 2,
                    pointRadius: 5
                }, {
                    label: 'Pecho (cm)',
                    data: pechos,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderWidth: 3,
                    tension: 0.4,
                    fill: true,
                    pointBackgroundColor: 'rgba(75, 192, 192, 1)',
                    pointBorderColor: '#ffffff',
                    pointBorderWidth: 2,
                    pointRadius: 5
                }]
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
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += context.parsed.y + ' cm';
                                }
                                return label;
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
                        grid: {
                            color: 'rgba(0, 0, 0, 0.1)',
                            lineWidth: 1
                        },
                        ticks: {
                            callback: function(value) {
                                return value + ' cm';
                            }
                        }
                    },
                    x: {
                        grid: {
                            color: 'rgba(0, 0, 0, 0.1)',
                            lineWidth: 1
                        }
                    }
                }
            }
        });

        const porciones = [
                        <%= totalProteinas %>,
                        <%= totalCarbos %>,
                        <%= totalGrasas %>,
                        <%= totalVitaminas %>
                    ];
        // Gráfico de Macros
        const macrosCtx = document.getElementById('macrosChart').getContext('2d');
        const macrosChart = new Chart(macrosCtx, {
            type: 'doughnut',
            data: {
                labels: ['Proteínas', 'Carbohidratos', 'Grasas', 'Vitaminas'],
                datasets: [{
                    data: [
                        <%= porcentajeProteinas %>,
                        <%= porcentajeCarbos %>,
                        <%= porcentajeGrasas %>,
                        <%= porcentajeVitaminas %>
                    ],
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.8)',    // Proteínas
                        'rgba(75, 192, 192, 0.8)',    // Carbohidratos
                        'rgba(255, 206, 86, 0.8)',    // Grasas
                        'rgba(153, 102, 255, 0.8)'    // Vitaminas (lila)
                    ],
                    borderWidth: 3,
                    borderColor: [
                        'rgba(54, 162, 235, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(153, 102, 255, 1)'
                    ],
                    hoverBorderWidth: 4,
                    hoverBackgroundColor: [
                        'rgba(54, 162, 235, 0.9)',
                        'rgba(75, 192, 192, 0.9)',
                        'rgba(255, 206, 86, 0.9)',
                        'rgba(153, 102, 255, 0.9)'
                    ]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#ffffff',
                        bodyColor: '#ffffff',
                        callbacks: {
                            label: function(context) {
                            const index = context.dataIndex;
                            return context.label + `: ` + ((porciones[index])/5) + ` g`;
                        }
                        }
                    }
                },
                cutout: '60%'
            }
        });
        
        // Función global para actualizar gráficos
        window.actualizarGraficos = function() {
            weightChart.update();
            measurementsChart.update();
            macrosChart.update();
        };

        // Mostrar información adicional del servlet si está disponible
        if (fromServlet) {
            console.log('Datos cargados desde el servlet:');
            console.log('Peso inicial:', <%= request.getAttribute("pesoInicial") %>);
            console.log('Peso actual:', <%= request.getAttribute("pesoActual") %>);
            console.log('Peso objetivo:', <%= request.getAttribute("pesoObjetivo") %>);
            console.log('Peso objetivo mensual:', <%= request.getAttribute("pesoObjetivoMensual") %>);
            console.log('IMC actual:', <%= request.getAttribute("imcActual") %>);
            console.log('Progreso:', <%= request.getAttribute("progresoPorcentaje") %>);
        }
    });
    
    const todayKey = new Date().toISOString().slice(0, 10); // "2025-06-24"
    const entrenamiento = localStorage.getItem("entrenamiento-" + todayKey);

    window.onload = function () {
        const diaActualDiv = document.querySelector('.calendar-day.today');
        if (entrenamiento === "true" && diaActualDiv) {
            diaActualDiv.classList.add('completed');
            diaActualDiv.textContent = "✔"; // o "C", o cualquier texto como "completed"
        }
    };

    function entrenamientoHecho() {
        const todayKey = new Date().toISOString().slice(0, 10);
        localStorage.setItem("entrenamiento-" + todayKey, "true");
        localStorage.removeItem("descanso-" + todayKey);

        const diaActualDiv = document.querySelector('.calendar-day.today');
        if (diaActualDiv) {
            diaActualDiv.classList.add('completed');
            diaActualDiv.textContent = "✔"; // esto reemplaza el texto del día
        }

        // Enviar estado "hecho" al servlet
        const form = document.createElement("form");
        form.method = "POST";
        form.action = "RutinaDelDia";

        const input = document.createElement("input");
        input.type = "hidden";
        input.name = "accion";
        input.value = "hecho";

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }   


    function marcarDescanso() {
    const todayKey = new Date().toISOString().slice(0, 10);
    localStorage.setItem("descanso-" + todayKey, "true");
    localStorage.removeItem("entrenamiento-" + todayKey);

    const workoutPlan = document.querySelector('.workout-plan');
    if (workoutPlan) {
        workoutPlan.innerHTML = "<p>Hoy es día de descanso</p>";
    }

    const diaActualDiv = document.querySelector('.calendar-day.today');
    if (diaActualDiv) {
        diaActualDiv.classList.remove('completed');
        diaActualDiv.textContent = diaActualDiv.getAttribute("data-dia") || diaActualDiv.textContent;
    }

    // Enviar estado "descanso" al servlet
    const form = document.createElement("form");
    form.method = "POST";
    form.action = "RutinaDelDia";

    const input = document.createElement("input");
    input.type = "hidden";
    input.name = "accion";
    input.value = "descanso";

    form.appendChild(input);
    document.body.appendChild(form);
    form.submit();
}


    // Funciones auxiliares
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
        const isVisible = botWindow.style.display === 'block';
        botWindow.style.display = isVisible ? 'none' : 'block';

        
        if (!isVisible) {
        const chatContainer = document.querySelector('.bot-window'); // cambia a tu clase real si es distinta
        if (chatContainer) {
            setTimeout(() => {
                chatContainer.scrollTop = chatContainer.scrollHeight;
            }, 100); // pequeño retraso para asegurar que los elementos ya estén visibles
        }
    }
}

    function cerrarLoginModal() {
        document.getElementById('login-modal').style.display = 'none';
    }

    // Event listeners
    document.addEventListener('click', (event) => {
        const dropdown = document.querySelector('.dropdown-menu');
        const userMenu = document.querySelector('.user-menu');

        if (dropdown && userMenu && !userMenu.contains(event.target)) {
            dropdown.style.display = 'none';
        }
    });
    
    // Sistema de inactividad
    const INACTIVITY_TIMEOUT = 15 * 60 * 1000; 
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
    
    // Modal de datos
    const mostrarModal = <%= mostrarModal %>;           
    window.onload = function() {
        
        console.log("Mostrar modal:", mostrarModal);
        console.log("Elemento modal:", document.getElementById("dataModal"));
        if (mostrarModal) {
            document.getElementById("dataModal").style.display = "flex";
        }
        
        document.getElementById("posponerBtn").addEventListener("click", function() {
            document.getElementById("dataModal").style.display = "none";
        });

        document.getElementById("userDataForm").addEventListener("submit", function(e) {
            e.preventDefault();

            const peso = document.getElementById("peso").value;
            const cintura = document.getElementById("cintura").value;
            const pecho = document.getElementById("pecho").value;
            const cadera = document.getElementById("cadera").value;
            const muslo = document.getElementById("muslo").value;
            const brazo = document.getElementById("brazo").value;

            // Validación básica
            if (!peso || !cintura || !pecho || !cadera || !muslo || !brazo) {
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
                    peso: parseFloat(peso), 
                    cintura: parseInt(cintura), 
                    pecho: parseInt(pecho), 
                    cadera: parseInt(cadera), 
                    muslo: parseInt(muslo), 
                    brazo: parseInt(brazo) 
                })
            })
            .then(response => {
                if (response.ok) {
                    alert("Datos guardados exitosamente. Actualizando dashboard...");
                    document.getElementById("dataModal").style.display = "none";
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
    };
</script>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="image/png">
    <title>Información sobre IMC</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.4.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="Styles10.css">
</head>
<body>
    <button class="back-button" onclick="location.href='Proyecto.jsp'">
        <i class="ri-arrow-left-line"></i>
    </button>
    <main>
            <% 
            int idUsuario = (int) session.getAttribute("id_usuario");
            String username = (String) session.getAttribute("nombre_usuario");
            String url = "jdbc:mysql://localhost/FitData";
            String user = "root";
            String password = "AT10220906";
            Double imc = null;
            Double estatura = null;
            Double peso = null;
            try (Connection con = DriverManager.getConnection(url, user, password)) {

                String query = "SELECT imc_usuario, peso_usuario, altura_usuario FROM IMC WHERE id_usuario = ?";
                try (PreparedStatement stmt = con.prepareStatement(query)) {
                    stmt.setInt(1, idUsuario);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            imc = rs.getDouble("imc_usuario");
                            peso = rs.getDouble("peso_usuario");
                            estatura = rs.getDouble("altura_usuario");

                            session.setAttribute("IMC", imc);
                            session.setAttribute("peso", peso);
                            session.setAttribute("estatura", estatura);
                        }
                    }
                }
            } catch (SQLException e) {
                session.setAttribute("error", "Error en la base de datos: " + e.getMessage());
                response.sendRedirect("Proyecto.jsp");
                return;
            }
        %>
        <section id="imc" class="imc-section">
            <h1>Índice de Masa Corporal (IMC) 
                <% if(username!=null){%>
                    de <%= username%> 
                <%}%></h1>
            <div class="calculator-container">
                <div class="calculator-form">
                    <% 
                        if (username != null && imc > 0) {
                    %>
                    <script>
                            document.addEventListener('DOMContentLoaded', function () {
                            initGauge();
                            updateGauge(imc);
                            calculateIMC();
                            
                            });
                    </script>
                    
                    <form action="IMC" method="post">
                            <div class="input-group" >
                                <label for="weight" >Tu Peso(kg) es:</label>
                                <input type="number" name="peso" id="weight" min="30" max="300" step="0.1" value="<%= peso %>" required>
                            </div>
                            <div class="input-group" >
                                <label for="height"> Tu Altura (m) es:</label>
                                <input type="number" name="estatura" id="height" min="1" max="2.5" step="0.01" value="<%= estatura %>" required>
                            </div>
                            <input type="hidden" classname="imc" id="hiddenIMC" value="<%= imc %>">
                            <button class="calculate-btn">Calcular mi IMC</button>
                    </form>
                    <% }else {%>
                    <form action="IMC" method="post">
                            <div class="input-group">
                                <label for="weight">Peso (kg)</label>
                                <input type="number" id="weight" name="peso" min="30" max="300" step="0.1" required>
                            </div>
                            <div class="input-group">
                                <label for="height">Altura (m)</label>
                                <input type="number" id="height" name="estatura" min="1" max="2.5" step="0.01" required>
                            </div>
                            <button type="submit" class="calculate-btn">Calcular IMC</button>
                    </form>
                        <% } %>
                </div>
                <div class="result-container">
                    <canvas id="imcGauge" width="750" height="750"></canvas>
                    <div id="imcResult" class="imc-result"></div>
                    <h3 id="imc-value" style="display: none;">Tu IMC:</h3>
                    <p id="cat-value" style="display: none;">Categoría:</p>
                </div>
            </div>
        </section>
                
                <div class="info-card">
                <p>El Índice de Masa Corporal (IMC) es un indicador que se usa para estimar si una persona tiene un peso adecuado para su altura. Sin embargo, el IMC tiene sus limitaciones. Por ejemplo, no distingue entre masa muscular y grasa, por lo que un atleta con mucha masa muscular podría tener un IMC elevado a pesar de estar en buena forma física.</p>
                
                <div class="imc-categories">
                    <div class="category">
                        <span class="dot bajo-peso"></span>
                        <span>Bajo peso: &lt;18.5</span>
                    </div>
                    <div class="category">
                        <span class="dot normal"></span>
                        <span>Normal: 18.5 - 24.9</span>
                    </div>
                    <div class="category">
                        <span class="dot sobrepeso"></span>
                        <span>Sobrepeso: 25 - 29.9</span>
                    </div>
                    <div class="category">
                        <span class="dot obesidad"></span>
                        <span>Obesidad: ≥30</span>
                    </div>
                </div>
            </div>
        </section>

        <section id="tallas" class="sizes-section">
            <h1>Guía de Tallas</h1>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Talla</th>
                            <th>Pecho (cm)</th>
                            <th>Cintura (cm)</th>
                            <th>Caderas (cm)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>S</td>
                            <td>86-91</td>
                            <td>71-76</td>
                            <td>91-96</td>
                        </tr>
                        <tr>
                            <td>M</td>
                            <td>92-97</td>
                            <td>77-82</td>
                            <td>97-102</td>
                        </tr>
                        <tr>
                            <td>L</td>
                            <td>98-103</td>
                            <td>83-88</td>
                            <td>103-108</td>
                        </tr>
                        <tr>
                            <td>XL</td>
                            <td>104-109</td>
                            <td>89-94</td>
                            <td>109-114</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <section id="vida" class="daily-section">
            <h1>Para la Vida Diaria</h1>
            <div class="tips-container">
                <div class="tip-card">
                    <h3>Balance calórico</h3>
                    <p>El balance calórico es la diferencia entre las calorías que consumes y las que quemas. Para mantener el peso, necesitas un balance neutro.</p>
                </div>
                <div class="tip-card">
                    <h3>Frecuencia de ejercicio</h3>
                    <p>150 minutos de actividad aeróbica moderada o 75 minutos de actividad intensa a la semana.</p>
                </div>
                <div class="tip-card">
                    <h3>Medición de grasa</h3>
                    <p>Medir el porcentaje de grasa corporal puede proporcionar información más detallada sobre la composición de tu cuerpo.</p>
                </div>
                <div class="tip-card">
                    <h3>Calidad del sueño</h3>
                    <p>Dormir bien es crucial para la salud y el rendimiento deportivo. La falta de sueño puede afectar el rendimiento.</p>
                </div>
                <div class="tip-card">
                    <h3>Hidratación</h3>
                    <p>2-3 litros de agua al día es una buena meta para la mayoría de los adultos.</p>
                </div>
            </div>
        </section>
    </main>

    <footer class="section__container footer__container">
        <span class="bg__blur"></span>
        <span class="bg__blur footer__blur"></span>
        <div class="footer__col">
          <div class="footer__logo"><img src="src/logoFitData.png" alt="logo" /></div>
          <p>
            Da el primer paso hacia una persona más sana y fuerte con nuestros
            planes inmejorables. ¡Logremos y conquistemos juntos!
          </p>
          <div class="footer__socials">
            <a href="https://www.facebook.com/profile.php?id=61566664822814&mibextid=LQQJ4d"><i class="ri-facebook-fill"></i></a>
            <a href="https://www.instagram.com/phylix_official?igsh=MTNvb3VvY2dlbGtm"><i class="ri-instagram-line"></i></a>
            <a href="https://x.com/phylix5im9/status/1839495022829306317?s=46&t=CErG4mdE38hn7Yl5WGVeGQ"><i class="ri-twitter-fill"></i></a>
          </div>
        </div>
        <div class="footer__col">
          <h4>Company</h4>
          <a href="#">Business</a>
          <a href="#">Partnership</a>
          <a href="#">Network</a>
        </div>
        <div class="footer__col">
          <h4>About Us</h4>
          <a href="#">Blogs</a>
          <a href="#">Security</a>
          <a href="#">Careers</a>
        </div>
        <div class="footer__col">
          <h4>Contact</h4>
          <a href="#">Contact Us</a>
          <a href="#">Privacy Policy</a>
          <a href="#">Terms & Conditions</a>
        </div>
      </footer>
      <div class="footer__bar">
        Copyright © 2024 FitData. Todos los derechos reservados.
      </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            let imcGauge;

            function initGauge() {
                const ctx = document.getElementById('imcGauge').getContext('2d');
                imcGauge = new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        datasets: [{
                            data: [1],
                            backgroundColor: ['#e0e0e0'],
                            circumference: 180,
                            rotation: 270
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        cutout: '80%',
                        plugins: {
                            tooltip: { enabled: false },
                            legend: { display: false }
                        }
                    }
                });
            }

            function updateGauge(imc) {
                let color;
                if (imc < 18.5) color = '#3498db';
                else if (imc < 25) color = '#2ecc71';
                else if (imc < 30) color = '#f1c40f';
                else color = '#e74c3c';

                imcGauge.data.datasets[0].backgroundColor = [color];
                imcGauge.update();
            }

            function calculateIMC() {
                
                
                const weight = parseFloat(document.getElementById('weight').value);
                const height = parseFloat(document.getElementById('height').value);
                let imc = parseFloat(document.getElementById('hiddenIMC')?.value);

                if (isNaN(weight) || isNaN(height) || weight <= 0 || height <= 0) {
                    alert("Por favor, ingresa un peso y una altura válidos.");
                    return false;
                }

                if (!imc) {
                    imc = weight / (height * height);
                }

                updateGauge(imc);
                displayResult(imc);
                return true;
            }


            function displayResult(imc) {
                const cat = document.getElementById('cat-value');
                const imc_html = document.getElementById('imc-value');

                let category;
                if (imc < 18.5) category = 'Bajo peso';
                else if (imc < 25) category = 'Peso normal';
                else if (imc < 30) category = 'Sobrepeso';
                else category = 'Obesidad';

                cat.innerHTML = "Categoría: " + category;
                imc_html.innerHTML = "Tu IMC: " + imc.toFixed(1);

                imc_html.style.display = "block";
                cat.style.display = "block";
            }

            window.addEventListener('load', initGauge);
        </script>
    </main>
</body>
</html>

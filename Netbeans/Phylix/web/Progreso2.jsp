<%-- 
    Document   : Progreso2
    Created on : Jun 26, 2025, 12:02:53 AM
    Author     : Abraham
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Progreso de Peso - Phylix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .card-custom {
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .progress-custom {
            height: 30px;
            border-radius: 15px;
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .chart-container {
            position: relative;
            height: 400px;
            margin: 20px 0;
        }
        .btn-primary-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 10px 30px;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <h1 class="text-center mb-0">Mi Progreso de Peso</h1>
                <p class="text-center text-muted">Seguimiento de tu transformación</p>
            </div>
        </div>

        <!-- Estadísticas principales -->
        <div class="row mb-4">
            <div class="col-md-3 col-sm-6">
                <div class="stat-card text-center">
                    <h5>Peso Inicial</h5>
                    <h2>${pesoInicial != null ? String.format("%.1f", pesoInicial) : "0.0"} kg</h2>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-card text-center">
                    <h5>Peso Actual</h5>
                    <h2>${pesoActual != null ? String.format("%.1f", pesoActual) : "0.0"} kg</h2>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-card text-center">
                    <h5>Pérdida Total</h5>
                    <h2>${perdidaTotal != null ? String.format("%.1f", perdidaTotal) : "0.0"} kg</h2>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-card text-center">
                    <h5>Registros</h5>
                    <h2>${cantidadRegistros != null ? cantidadRegistros : 0}</h2>
                </div>
            </div>
        </div>

        <!-- Progreso hacia el objetivo -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card card-custom">
                    <div class="card-body">
                        <h5 class="card-title">Progreso hacia el Objetivo</h5>
                        <p class="text-muted">Objetivo: ${objetivo != null ? String.format("%.1f", objetivo) : "0.0"} kg</p>
                        <div class="progress progress-custom">
                            <div class="progress-bar bg-success" role="progressbar" 
                                 style="width: ${porcentajeObjetivo != null ? porcentajeObjetivo : 0}%" 
                                 aria-valuenow="${porcentajeObjetivo != null ? porcentajeObjetivo : 0}" 
                                 aria-valuemin="0" aria-valuemax="100">
                                ${porcentajeObjetivo != null ? String.format("%.1f", porcentajeObjetivo) : "0.0"}%
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Gráfico de progreso -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card card-custom">
                    <div class="card-body">
                        <h5 class="card-title">Gráfico de Progreso</h5>
                        <div class="chart-container">
                            <canvas id="pesoChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Formulario para nuevo registro -->
        <div class="row mb-4">
            <div class="col-md-6 mx-auto">
                <div class="card card-custom">
                    <div class="card-body">
                        <h5 class="card-title">Registrar Nuevo Peso</h5>
                        <form id="pesoForm">
                            <div class="mb-3">
                                <label for="peso" class="form-label">Peso (kg)</label>
                                <input type="number" class="form-control" id="peso" name="peso" 
                                       step="0.1" min="30" max="300" required>
                            </div>
                            <div class="mb-3">
                                <label for="fecha" class="form-label">Fecha</label>
                                <input type="date" class="form-control" id="fecha" name="fecha" required>
                            </div>
                            <div class="mb-3">
                                <label for="altura" class="form-label">Altura (metros) - Opcional</label>
                                <input type="number" class="form-control" id="altura" name="altura" 
                                       step="0.01" min="1.00" max="2.50" placeholder="Dejar vacío para usar altura registrada">
                            </div>
                            <button type="submit" class="btn btn-primary-custom w-100">
                                Registrar Peso
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tabla de registros -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card card-custom">
                    <div class="card-body">
                        <h5 class="card-title">Historial de Registros</h5>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>Fecha</th>
                                        <th>Peso (kg)</th>
                                        <th>Cambio</th>
                                    </tr>
                                </thead>
                                <tbody id="historialTabla">
                                    <%
                                        List<String> fechas = (List<String>) request.getAttribute("fechas");
                                        List<Double> pesos = (List<Double>) request.getAttribute("pesos");
                                        
                                        if (fechas != null && pesos != null && !fechas.isEmpty()) {
                                            DecimalFormat df = new DecimalFormat("#0.0");
                                            for (int i = 0; i < fechas.size(); i++) {
                                                String fecha = fechas.get(i);
                                                Double peso = pesos.get(i);
                                                String cambio = "";
                                                String colorClass = "";
                                                
                                                if (i > 0) {
                                                    double diferencia = peso - pesos.get(i-1);
                                                    if (diferencia > 0) {
                                                        cambio = "+" + df.format(diferencia);
                                                        colorClass = "text-danger";
                                                    } else if (diferencia < 0) {
                                                        cambio = df.format(diferencia);
                                                        colorClass = "text-success";
                                                    } else {
                                                        cambio = "0.0";
                                                        colorClass = "text-muted";
                                                    }
                                                } else {
                                                    cambio = "Inicial";
                                                    colorClass = "text-info";
                                                }
                                    %>
                                    <tr>
                                        <td><%= fecha %></td>
                                        <td><%= df.format(peso) %> kg</td>
                                        <td class="<%= colorClass %>"><%= cambio %></td>
                                    </tr>
                                    <%
                                            }
                                        } else {
                                    %>
                                    <tr>
                                        <td colspan="3" class="text-center text-muted">No hay registros disponibles</td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modals para mensajes -->
    <div class="modal fade" id="mensajeModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="mensajeTitulo">Mensaje</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p id="mensajeTexto"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Datos del JSP
        const datosProgreso = ${datosJSON != null ? datosJSON : "{\"fechas\":[],\"pesos\":[],\"objetivo\":0,\"pesoInicial\":0}"};
        
        // Configurar fecha por defecto (hoy)
        document.getElementById('fecha').valueAsDate = new Date();
        
        // Crear gráfico
        function crearGrafico() {
            const ctx = document.getElementById('pesoChart').getContext('2d');
            const fechas = datosProgreso.fechas || [];
            const pesos = datosProgreso.pesos || [];
            const objetivo = datosProgreso.objetivo || 0;
            
            // Crear línea de objetivo
            const lineaObjetivo = Array(fechas.length).fill(objetivo);
            
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: fechas,
                    datasets: [{
                        label: 'Peso Real',
                        data: pesos,
                        borderColor: 'rgb(75, 192, 192)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        tension: 0.4,
                        fill: true
                    }, {
                        label: 'Objetivo',
                        data: lineaObjetivo,
                        borderColor: 'rgb(255, 99, 132)',
                        backgroundColor: 'rgba(255, 99, 132, 0.1)',
                        borderDash: [5, 5],
                        tension: 0.1,
                        fill: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: false,
                            title: {
                                display: true,
                                text: 'Peso (kg)'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Fecha'
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: true
                        },
                        tooltip: {
                            mode: 'index',
                            intersect: false
                        }
                    }
                }
            });
        }
        
        // Manejar envío del formulario
        document.getElementById('pesoForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            
            fetch('Progreso', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    mostrarMensaje('Éxito', 'Peso registrado correctamente', 'success');
                    // Recargar la página después de un breve delay
                    setTimeout(() => {
                        window.location.reload();
                    }, 1500);
                } else {
                    mostrarMensaje('Error', data.message || 'Error al registrar el peso', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                mostrarMensaje('Error', 'Error de conexión', 'error');
            });
        });
        
        // Función para mostrar mensajes
        function mostrarMensaje(titulo, texto, tipo) {
            document.getElementById('mensajeTitulo').textContent = titulo;
            document.getElementById('mensajeTexto').textContent = texto;
            
            const modal = document.getElementById('mensajeModal');
            const modalHeader = modal.querySelector('.modal-header');
            
            // Cambiar color del header según el tipo
            modalHeader.className = 'modal-header';
            if (tipo === 'success') {
                modalHeader.classList.add('bg-success', 'text-white');
            } else if (tipo === 'error') {
                modalHeader.classList.add('bg-danger', 'text-white');
            }
            
            new bootstrap.Modal(modal).show();
        }
        
        // Inicializar cuando cargue la página
        document.addEventListener('DOMContentLoaded', function() {
            crearGrafico();
            
            // Actualizar datos cada 30 segundos (opcional)
            setInterval(function() {
                actualizarDatos();
            }, 30000);
        });
        
        // Función para actualizar datos via AJAX
        function actualizarDatos() {
            fetch('Progreso', {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                // Actualizar datos globales
                datosProgreso.fechas = data.fechas || [];
                datosProgreso.pesos = data.pesos || [];
                datosProgreso.objetivo = data.objetivo || 0;
                datosProgreso.pesoInicial = data.pesoInicial || 0;
                
                console.log('Datos actualizados:', data);
            })
            .catch(error => {
                console.log('Error al actualizar datos:', error);
            });
        }
    </script>
</body>
</html>
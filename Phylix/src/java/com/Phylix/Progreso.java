package com.Phylix;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "Progreso", urlPatterns = {"/Progreso"})
public class Progreso extends HttpServlet {
    private final String url = "jdbc:mysql://localhost:3306/FitData";
    private final String user = "root";
    private final String pass = "AT10220906";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Integer id_usuario = (Integer) session.getAttribute("id_usuario");
        
        // Si no hay usuario autenticado, redirigir al login
        if (id_usuario == null) {
            response.sendRedirect("FitDataa");
            return;
        }
        
        // Obtener datos del progreso para enviar al JSP
        List<String> fechas = new ArrayList<>();
        List<Double> pesos = new ArrayList<>();
        List<String> fechasMedidas = new ArrayList<>();
        List<Integer> cinturaList = new ArrayList<>();
        List<Integer> pechoList = new ArrayList<>();
        List<Integer> caderasList = new ArrayList<>();
        List<Integer> musloList = new ArrayList<>();
        List<Integer> brazoList = new ArrayList<>();
        
        List<String> fechasMedidas2 = new ArrayList<>();
        List<Integer> cinturaList2 = new ArrayList<>();
        List<Integer> pechoList2 = new ArrayList<>();
        List<Integer> caderasList2 = new ArrayList<>();
        List<Integer> musloList2 = new ArrayList<>();
        List<Integer> brazoList2 = new ArrayList<>();
        
        List<String> fechasCargas = new ArrayList<>();
        List<Double> sentadillaList = new ArrayList<>();
        List<Double> pressPechoList = new ArrayList<>();
        List<Double> pesoMuertoList = new ArrayList<>();
        List<Double> pressMilitarList = new ArrayList<>();
        List<Double> curlBicepsList = new ArrayList<>();
        List<Double> remoList = new ArrayList<>();
        
        List<String> fechasCargas2 = new ArrayList<>();
        List<Double> sentadillaList2 = new ArrayList<>();
        List<Double> pressPechoList2 = new ArrayList<>();
        List<Double> pesoMuertoList2 = new ArrayList<>();
        List<Double> pressMilitarList2 = new ArrayList<>();
        List<Double> curlBicepsList2 = new ArrayList<>();
        List<Double> remoList2 = new ArrayList<>();
        
        double objetivo = 75.0;
        double pesoInicial = 0.0;
        
        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            
            // Obtener datos del usuario
            String usuarioSql = "SELECT peso_inicial FROM Usuario WHERE id_usuario = ?";
            try (PreparedStatement usuarioStmt = conn.prepareStatement(usuarioSql)) {
                usuarioStmt.setInt(1, id_usuario);
                ResultSet usuarioRs = usuarioStmt.executeQuery();
                if (usuarioRs.next()) {
                    pesoInicial = usuarioRs.getDouble("peso_inicial");
                    if (pesoInicial > 0) {
                        objetivo = pesoInicial * 0.86;
                    }
                }
            } catch (SQLException e) {
                System.out.println("Error al obtener datos del usuario: " + e.getMessage());
            }

            // Obtener el IMC inicial si existe
            String imcInicialSql = "SELECT fecha_registro, peso_inicial FROM IMC_Inicial WHERE id_usuario = ?";
            try (PreparedStatement imcInicialStmt = conn.prepareStatement(imcInicialSql)) {
                imcInicialStmt.setInt(1, id_usuario);
                ResultSet imcInicialRs = imcInicialStmt.executeQuery();
                if (imcInicialRs.next()) {
                    fechas.add(imcInicialRs.getString("fecha_registro"));
                    pesos.add(imcInicialRs.getDouble("peso_inicial"));
                }
            } catch (SQLException e) {
                System.out.println("No se encontró IMC inicial: " + e.getMessage());
            }

            // Obtener datos de progreso de la tabla IMC
            String imcSql = "SELECT DATE_FORMAT(fecha, '%Y-%m-%d') as fecha_formateada, peso_usuario " +
                           "FROM IMC WHERE id_usuario = ? ORDER BY fecha ASC";
            
            try (PreparedStatement imcStmt = conn.prepareStatement(imcSql)) {
                imcStmt.setInt(1, id_usuario);
                ResultSet imcRs = imcStmt.executeQuery();
                
                while (imcRs.next()) {
                    String fecha = imcRs.getString("fecha_formateada");
                    double peso = imcRs.getDouble("peso_usuario");
                    
                    if (!fechas.contains(fecha)) {
                        fechas.add(fecha);
                        pesos.add(peso);
                    }
                }
            }

            // Si no hay datos en IMC pero hay peso inicial, usar solo ese dato
            if (fechas.isEmpty() && pesoInicial > 0) {
                String fechaRegistroSql = "SELECT DATE_FORMAT(fecha_registro, '%Y-%m-%d') as fecha_registro FROM Usuario WHERE id_usuario = ?";
                try (PreparedStatement fechaStmt = conn.prepareStatement(fechaRegistroSql)) {
                    fechaStmt.setInt(1, id_usuario);
                    ResultSet fechaRs = fechaStmt.executeQuery();
                    if (fechaRs.next()) {
                        fechas.add(fechaRs.getString("fecha_registro"));
                        pesos.add(pesoInicial);
                    }
                }
            }
            
            

            String medidasSql = "SELECT DATE_FORMAT(fecha, '%Y-%m-%d') AS fecha_formateada, cintura, pecho, caderas, muslo, brazo " +
                                "FROM Medidas WHERE id_usuario = ? ORDER BY fecha ASC";

            try (PreparedStatement medidasStmt = conn.prepareStatement(medidasSql)) {
                medidasStmt.setInt(1, id_usuario);
                ResultSet medidasRs = medidasStmt.executeQuery();

                while (medidasRs.next()) {
                    fechasMedidas.add(medidasRs.getString("fecha_formateada"));
                    cinturaList.add(medidasRs.getInt("cintura"));
                    pechoList.add(medidasRs.getInt("pecho"));
                    caderasList.add(medidasRs.getInt("caderas"));
                    musloList.add(medidasRs.getInt("muslo"));
                    brazoList.add(medidasRs.getInt("brazo"));
                }
            } catch (SQLException e) {
                System.out.println("Error obteniendo medidas: " + e.getMessage());
            }

            String cargasSql = "SELECT DATE_FORMAT(fecha, '%Y-%m-%d') AS fecha_formateada, sentadilla, press_pecho, peso_muerto, press_militar, curl_biceps, remo " +
                   "FROM Cargas WHERE id_usuario = ? ORDER BY fecha ASC";

                try (PreparedStatement cargasStmt = conn.prepareStatement(cargasSql)) {
                    cargasStmt.setInt(1, id_usuario);
                    ResultSet cargasRs = cargasStmt.executeQuery();

                    while (cargasRs.next()) {
                        fechasCargas.add(cargasRs.getString("fecha_formateada"));
                        sentadillaList.add(cargasRs.getDouble("sentadilla"));
                        pressPechoList.add(cargasRs.getDouble("press_pecho"));
                        pesoMuertoList.add(cargasRs.getDouble("peso_muerto"));
                        pressMilitarList.add(cargasRs.getDouble("press_militar"));
                        curlBicepsList.add(cargasRs.getDouble("curl_biceps"));
                        remoList.add(cargasRs.getDouble("remo"));
                    }
                } catch (SQLException e) {
                    System.out.println("Error obteniendo cargas: " + e.getMessage());
                }
                
                String cargas2Sql = "SELECT DATE_FORMAT(fecha, '%Y-%m-%d') AS fecha_formateada, sentadilla, press_pecho, peso_muerto, press_militar, curl_biceps, remo " +
                   "FROM Cargas WHERE id_usuario = ? ORDER BY fecha ASC";

                try (PreparedStatement cargasStmt = conn.prepareStatement(cargas2Sql)) {
                    cargasStmt.setInt(1, id_usuario);
                    ResultSet cargasRs = cargasStmt.executeQuery();

                    while (cargasRs.next()) {
                        fechasCargas2.add(cargasRs.getString("fecha_formateada"));
                        sentadillaList2.add(cargasRs.getDouble("sentadilla"));
                        pressPechoList2.add(cargasRs.getDouble("press_pecho"));
                        pesoMuertoList2.add(cargasRs.getDouble("peso_muerto"));
                        pressMilitarList2.add(cargasRs.getDouble("press_militar"));
                        curlBicepsList2.add(cargasRs.getDouble("curl_biceps"));
                        remoList2.add(cargasRs.getDouble("remo"));
                    }
                } catch (SQLException e) {
                    System.out.println("Error obteniendo cargas: " + e.getMessage());
                }
                
                String medidas2Sql = "SELECT DATE_FORMAT(fecha, '%Y-%m-%d') AS fecha_formateada, cintura, pecho, caderas, muslo, brazo " +
                                "FROM Medidas WHERE id_usuario = ? ORDER BY fecha DESC";

                try (PreparedStatement medidasStmt = conn.prepareStatement(medidas2Sql)) {
                    medidasStmt.setInt(1, id_usuario);
                    ResultSet medidasRs = medidasStmt.executeQuery();

                    while (medidasRs.next()) {
                        fechasMedidas2.add(medidasRs.getString("fecha_formateada"));
                        cinturaList2.add(medidasRs.getInt("cintura"));
                        pechoList2.add(medidasRs.getInt("pecho"));
                        caderasList2.add(medidasRs.getInt("caderas"));
                        musloList2.add(medidasRs.getInt("muslo"));
                        brazoList2.add(medidasRs.getInt("brazo"));
                    }
                } catch (SQLException e) {
                    System.out.println("Error obteniendo medidas: " + e.getMessage());
                }

                // Convertir los datos a JSON y enviarlos como atributo para el JSP
                
            // Convertir los datos a JSON y enviarlos como atributo para el JSP
            
            
        } catch (SQLException e) {
            e.printStackTrace();
            // En caso de error, enviar listas vacías
        }
        
        // Enviar los datos como atributos del request
        request.setAttribute("fechas", fechas);
        request.setAttribute("pesos", pesos);
        request.setAttribute("objetivo", objetivo);
        request.setAttribute("pesoInicial", pesoInicial);
        request.setAttribute("cantidadRegistros", fechas.size());
        
        // Calcular estadísticas adicionales si hay datos
        if (!pesos.isEmpty()) {
            double pesoActual = pesos.get(pesos.size() - 1);
            double perdidaTotal = pesoInicial - pesoActual;
            double porcentajeObjetivo = objetivo > 0 ? ((pesoInicial - pesoActual) / (pesoInicial - objetivo)) * 100 : 0;
            
            request.setAttribute("pesoActual", pesoActual);
            request.setAttribute("perdidaTotal", perdidaTotal);
            request.setAttribute("porcentajeObjetivo", Math.min(100, Math.max(0, porcentajeObjetivo)));
        } else {
            request.setAttribute("pesoActual", pesoInicial);
            request.setAttribute("perdidaTotal", 0.0);
            request.setAttribute("porcentajeObjetivo", 0.0);
        }
        
        // Convertir a JSON para el JavaScript (opcional, para compatibilidad)
        Gson gson = new Gson();
            Map<String, Object> jsonData = new HashMap<>();
            jsonData.put("fechas", fechas);
            jsonData.put("pesos", pesos);
            jsonData.put("objetivo", objetivo);
            jsonData.put("pesoInicial", pesoInicial);
            String jsonDatosString = gson.toJson(jsonData);
            request.setAttribute("datosJSON", jsonDatosString);
        
        Gson gsonMedidas = new Gson();
            Map<String, Object> jsonMedidas = new HashMap<>();
            jsonMedidas.put("fechas", fechasMedidas);
            jsonMedidas.put("cintura", cinturaList);
            jsonMedidas.put("pecho", pechoList);
            jsonMedidas.put("caderas", caderasList);
            jsonMedidas.put("muslo", musloList);
            jsonMedidas.put("brazo", brazoList);
            String jsonMedidasString = gsonMedidas.toJson(jsonMedidas);
            request.setAttribute("medidasJSON", jsonMedidasString);
        
        Gson gsonCargas = new Gson();
                Map<String, Object> jsonCargas = new HashMap<>();
                jsonCargas.put("fechas", fechasCargas);
                jsonCargas.put("sentadilla", sentadillaList);
                jsonCargas.put("pressPecho", pressPechoList);
                jsonCargas.put("pesoMuerto", pesoMuertoList);
                jsonCargas.put("pressMilitar", pressMilitarList);
                jsonCargas.put("curlBiceps", curlBicepsList);
                jsonCargas.put("remo", remoList);
                String jsonFuerzaString = gsonCargas.toJson(jsonCargas);
                request.setAttribute("fuerzaJSON", jsonFuerzaString);
                
                request.setAttribute("fechaCargas", fechasCargas2);
                request.setAttribute("sentadilla", sentadillaList2);
                request.setAttribute("pressPecho", pressPechoList2);
                request.setAttribute("pesoMuerto", pesoMuertoList2);
                request.setAttribute("pressMilitar", pressMilitarList2);
                request.setAttribute("curlBiceps", curlBicepsList2);
                request.setAttribute("remo", remoList);
                
                request.setAttribute("fechaMedidas", fechasMedidas2);
                request.setAttribute("cintura", cinturaList2);
                request.setAttribute("pecho", pechoList2);
                request.setAttribute("caderas", caderasList2);
                request.setAttribute("muslo", musloList2);
                request.setAttribute("brazo", brazoList2);

        request.getRequestDispatcher("Progreso.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verificar si es una petición AJAX
        String contentType = request.getHeader("Content-Type");
        String accept = request.getHeader("Accept");
        
        if ((contentType != null && contentType.contains("application/json")) ||
            (accept != null && accept.contains("application/json"))) {
            
            // Es una petición AJAX, devolver JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Cache-Control", "no-cache");
            
            HttpSession session = request.getSession();
            Integer id_usuario = (Integer) session.getAttribute("id_usuario");
            
            if (id_usuario == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"error\":\"Usuario no autenticado\"}");
                    out.flush();
                }
                return;
            }
            
            

            List<String> fechas = new ArrayList<>();
            List<Double> pesos = new ArrayList<>();
            double objetivo = 75.0;
            double pesoInicial = 0.0;

            try (Connection conn = DriverManager.getConnection(url, user, pass)) {
                
                // Obtener datos del usuario
                String usuarioSql = "SELECT peso_inicial FROM Usuario WHERE id_usuario = ?";
                try (PreparedStatement usuarioStmt = conn.prepareStatement(usuarioSql)) {
                    usuarioStmt.setInt(1, id_usuario);
                    ResultSet usuarioRs = usuarioStmt.executeQuery();
                    if (usuarioRs.next()) {
                        pesoInicial = usuarioRs.getDouble("peso_inicial");
                        if (pesoInicial > 0) {
                            objetivo = pesoInicial * 0.85;
                        }
                    }
                } catch (SQLException e) {
                    System.out.println("Error al obtener datos del usuario: " + e.getMessage());
                }

                // Obtener el IMC inicial si existe
                String imcInicialSql = "SELECT fecha_registro, peso_inicial FROM IMC_Inicial WHERE id_usuario = ?";
                try (PreparedStatement imcInicialStmt = conn.prepareStatement(imcInicialSql)) {
                    imcInicialStmt.setInt(1, id_usuario);
                    ResultSet imcInicialRs = imcInicialStmt.executeQuery();
                    if (imcInicialRs.next()) {
                        fechas.add(imcInicialRs.getString("fecha_registro"));
                        pesos.add(imcInicialRs.getDouble("peso_inicial"));
                    }
                } catch (SQLException e) {
                    System.out.println("No se encontró IMC inicial: " + e.getMessage());
                }

                // Obtener datos de progreso de la tabla IMC
                String imcSql = "SELECT DATE_FORMAT(fecha, '%Y-%m-%d') as fecha_formateada, peso_usuario " +
                               "FROM IMC WHERE id_usuario = ? ORDER BY fecha ASC";
                
                try (PreparedStatement imcStmt = conn.prepareStatement(imcSql)) {
                    imcStmt.setInt(1, id_usuario);
                    ResultSet imcRs = imcStmt.executeQuery();
                    
                    while (imcRs.next()) {
                        String fecha = imcRs.getString("fecha_formateada");
                        double peso = imcRs.getDouble("peso_usuario");
                        
                        if (!fechas.contains(fecha)) {
                            fechas.add(fecha);
                            pesos.add(peso);
                        }
                    }
                }

                // Si no hay datos en IMC pero hay peso inicial, usar solo ese dato
                if (fechas.isEmpty() && pesoInicial > 0) {
                    String fechaRegistroSql = "SELECT DATE_FORMAT(fecha_registro, '%Y-%m-%d') as fecha_registro FROM Usuario WHERE id_usuario = ?";
                    try (PreparedStatement fechaStmt = conn.prepareStatement(fechaRegistroSql)) {
                        fechaStmt.setInt(1, id_usuario);
                        ResultSet fechaRs = fechaStmt.executeQuery();
                        if (fechaRs.next()) {
                            fechas.add(fechaRs.getString("fecha_registro"));
                            pesos.add(pesoInicial);
                        }
                    }
                }
                
                List<String> fechasMedidas = new ArrayList<>();
                List<Integer> cinturaList = new ArrayList<>();
                List<Integer> pechoList = new ArrayList<>();
                List<Integer> caderasList = new ArrayList<>();
                List<Integer> musloList = new ArrayList<>();
                List<Integer> brazoList = new ArrayList<>();

                String cargasSql = "SELECT DATE_FORMAT(fecha, '%Y-%m-%d') AS fecha_formateada, sentadilla, press_pecho, peso_muerto, press_militar, curl_biceps, remo " +
                   "FROM Cargas WHERE id_usuario = ? ORDER BY fecha ASC";

                List<String> fechasCargas = new ArrayList<>();
                List<Double> sentadillaList = new ArrayList<>();
                List<Double> pressPechoList = new ArrayList<>();
                List<Double> pesoMuertoList = new ArrayList<>();
                List<Double> pressMilitarList = new ArrayList<>();
                List<Double> curlBicepsList = new ArrayList<>();
                List<Double> remoList = new ArrayList<>();

                try (PreparedStatement cargasStmt = conn.prepareStatement(cargasSql)) {
                    cargasStmt.setInt(1, id_usuario);
                    ResultSet cargasRs = cargasStmt.executeQuery();

                    while (cargasRs.next()) {
                        fechasCargas.add(cargasRs.getString("fecha_formateada"));
                        sentadillaList.add(cargasRs.getDouble("sentadilla"));
                        pressPechoList.add(cargasRs.getDouble("press_pecho"));
                        pesoMuertoList.add(cargasRs.getDouble("peso_muerto"));
                        pressMilitarList.add(cargasRs.getDouble("press_militar"));
                        curlBicepsList.add(cargasRs.getDouble("curl_biceps"));
                        remoList.add(cargasRs.getDouble("remo"));
                    }
                } catch (SQLException e) {
                    System.out.println("Error obteniendo cargas: " + e.getMessage());
                }

                // Convertir los datos a JSON y enviarlos como atributo para el JSP
                Gson gsonCargas = new Gson();
                Map<String, Object> jsonCargas = new HashMap<>();
                jsonCargas.put("fechas", fechasCargas);
                jsonCargas.put("sentadilla", sentadillaList);
                jsonCargas.put("pressPecho", pressPechoList);
                jsonCargas.put("pesoMuerto", pesoMuertoList);
                jsonCargas.put("pressMilitar", pressMilitarList);
                jsonCargas.put("curlBiceps", curlBicepsList);
                jsonCargas.put("remo", remoList);


                
                
                
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"error\":\"Error al acceder a la base de datos: " + e.getMessage() + "\"}");
                    out.flush();
                }
                return;
            }

            // Crear respuesta JSON
            Gson gson = new Gson();
            try (PrintWriter out = response.getWriter()) {
                Map<String, Object> jsonMap = new HashMap<>();
                jsonMap.put("fechas", fechas);
                jsonMap.put("pesos", pesos);
                jsonMap.put("objetivo", objetivo);
                jsonMap.put("count", fechas.size());
                jsonMap.put("pesoInicial", pesoInicial);
                
                String json = gson.toJson(jsonMap);
                System.out.println("JSON enviado: " + json);
                out.print(json);
                out.flush();
            }
        } else {
            // No es una petición AJAX, procesar como request normal
            processRequest(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Integer id_usuario = (Integer) session.getAttribute("id_usuario");
        
        if (id_usuario == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"error\":\"Usuario no autenticado\"}");
                out.flush();
            }
            return;
        }

        String peso = request.getParameter("peso");
        String fecha = request.getParameter("fecha");
        String altura = request.getParameter("altura");
        
        if (peso != null && fecha != null) {
            try (Connection conn = DriverManager.getConnection(url, user, pass)) {
                
                // Si no se proporciona altura, obtenerla del usuario
                double alturaValue = 1.70;
                if (altura != null && !altura.isEmpty()) {
                    alturaValue = Double.parseDouble(altura);
                } else {
                    String alturaQuery = "SELECT altura_inicial FROM Usuario WHERE id_usuario = ?";
                    try (PreparedStatement alturaStmt = conn.prepareStatement(alturaQuery)) {
                        alturaStmt.setInt(1, id_usuario);
                        ResultSet alturaRs = alturaStmt.executeQuery();
                        if (alturaRs.next()) {
                            alturaValue = alturaRs.getDouble("altura_inicial");
                        }
                    }
                }
                
                // Insertar en la tabla IMC
                String sql = "INSERT INTO IMC (id_usuario, peso_usuario, altura_usuario, fecha) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, id_usuario);
                    stmt.setDouble(2, Double.parseDouble(peso));
                    stmt.setDouble(3, alturaValue);
                    stmt.setDate(4, java.sql.Date.valueOf(fecha));
                    
                    int rowsAffected = stmt.executeUpdate();
                    
                    try (PrintWriter out = response.getWriter()) {
                        if (rowsAffected > 0) {
                            out.print("{\"success\":true,\"message\":\"Peso registrado correctamente\"}");
                        } else {
                            out.print("{\"success\":false,\"message\":\"Error al registrar el peso\"}");
                        }
                        out.flush();
                    }
                }
            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"error\":\"Error al procesar los datos: " + e.getMessage() + "\"}");
                    out.flush();
                }
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"error\":\"Faltan parámetros requeridos (peso, fecha)\"}");
                out.flush();
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para manejo de datos de progreso de peso";
    }
}
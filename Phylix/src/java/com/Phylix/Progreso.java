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
        String objetivoUsuario = "";
        
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
                
                try (Connection con2 = DriverManager.getConnection(url, user, pass)) {
                    PreparedStatement ps = con2.prepareStatement("SELECT objetivo_usuario FROM Cuestionario WHERE id_usuario = ?");
                    ps.setInt(1, id_usuario);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) objetivoUsuario = rs.getString("objetivo_usuario");
                } catch (Exception e) {
                    objetivoUsuario = "desconocido";
                }
            
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

            String analisisPeso = analizarPeso(pesos, objetivo, objetivoUsuario);
            String analisisMedidas = analizarMedidas(cinturaList2, pechoList2, brazoList2, musloList2, caderasList2);

            // Análisis de cargas individuales
            StringBuilder analisisCargas = new StringBuilder();
            analisisCargas.append("<div class='analisis-cargas'>");
            analisisCargas.append("<ul>");
            analisisCargas.append(analizarCargasIndividual("Sentadilla", sentadillaList2));
            analisisCargas.append(analizarCargasIndividual("Press Banca", pressPechoList2));
            analisisCargas.append(analizarCargasIndividual("Peso Muerto", pesoMuertoList2));
            analisisCargas.append(analizarCargasIndividual("Press Militar", pressMilitarList2));
            analisisCargas.append(analizarCargasIndividual("Curl Bíceps", curlBicepsList2));
            analisisCargas.append(analizarCargasIndividual("Remo", remoList2));
            analisisCargas.append("</ul>");
            analisisCargas.append("</div>");

            // Análisis general de fuerza (NUEVO - Opcional pero recomendado)
            String analisisFuerzaGeneral = analizarFuerzaGeneral(sentadillaList2, pressPechoList2, pesoMuertoList2);



            // Enviar a JSP
            request.setAttribute("analisisPeso", analisisPeso);
            request.setAttribute("analisisMedidas", analisisMedidas);
            request.setAttribute("analisisCargas", analisisCargas.toString());
            request.setAttribute("analisisFuerzaGeneral", analisisFuerzaGeneral);
        request.getRequestDispatcher("Progreso.jsp").forward(request, response);
    }
    
    private String analizarPeso(List<Double> pesos, double objetivo, String objetivoUsuario) {
        if (pesos.isEmpty()) return "No hay datos de peso disponibles para analizar.";

        StringBuilder resultado = new StringBuilder();
        resultado.append("<div class='analisis-peso'>");

        double pesoActual = pesos.get(pesos.size() - 1);
        double pesoInicial = pesos.get(0);
        double cambioTotal = pesoActual - pesoInicial;

        // Análisis de tendencia general
        resultado.append("<p><strong>Progreso General:</strong> ");
        if (Math.abs(cambioTotal) < 0.5) {
            resultado.append("Tu peso se ha mantenido relativamente estable desde el inicio ");
            resultado.append(String.format("(variación de %.1f kg). ", cambioTotal));
            resultado.append("Esto puede indicar una recomposición corporal exitosa si has estado entrenando consistentemente.");
        } else if (cambioTotal < 0) {
            resultado.append(String.format("Has perdido %.1f kg desde el inicio. ", Math.abs(cambioTotal)));
            if (objetivoUsuario.toLowerCase().contains("bajar") || objetivoUsuario.toLowerCase().contains("perder")) {
                resultado.append("¡Excelente progreso hacia tu objetivo de pérdida de peso! ");
            } else {
                resultado.append("Esta pérdida podría no estar alineada con tu objetivo. Considera revisar tu nutrición. ");
            }
        } else {
            resultado.append(String.format("Has ganado %.1f kg desde el inicio. ", cambioTotal));
            if (objetivoUsuario.toLowerCase().contains("ganar musculo") || objetivoUsuario.toLowerCase().contains("masa") || objetivoUsuario.toLowerCase().contains("volumen")) {
                resultado.append("¡Buen progreso en tu objetivo de ganancia de peso! ");
            } else {
                resultado.append("Este aumento podría requerir ajustes si tu objetivo es reducir grasa corporal. ");
            }
        }
        resultado.append("</p>");

        // Análisis de tendencia reciente (últimas 2-3 mediciones)
        if (pesos.size() >= 2) {
            resultado.append("<p><strong>Tendencia Reciente:</strong> ");
            double cambioReciente = pesos.get(pesos.size() - 1) - pesos.get(pesos.size() - 2);

            if (Math.abs(cambioReciente) < 0.3) {
                resultado.append("Tu peso está estabilizado en las últimas mediciones. ");
                resultado.append("Esto es normal y puede indicar que tu cuerpo se está adaptando a tu rutina actual.");
            } else if (cambioReciente < 0) {
                resultado.append(String.format("Has perdido %.1f kg en tu última medición. ", Math.abs(cambioReciente)));
                resultado.append("Mantén la consistencia en tu plan para continuar con esta tendencia positiva.");
            } else {
                resultado.append(String.format("Has ganado %.1f kg en tu última medición. ", cambioReciente));
                resultado.append("Evalúa si este cambio está alineado con tus objetivos actuales.");
            }
            resultado.append("</p>");
        }

        // Análisis del objetivo
        if (objetivo > 0) {
            double distanciaObjetivo = Math.abs(pesoActual - objetivo);
            resultado.append("<p><strong>Progreso hacia el Objetivo:</strong> ");
            if (distanciaObjetivo <= 2.0) {
                resultado.append("¡Estás muy cerca de tu peso objetivo! ");
                resultado.append("Considera enfocarte en mantener este peso y mejorar tu composición corporal.");
            } else {
                resultado.append(String.format("Te encuentras a %.1f kg de tu peso objetivo. ", distanciaObjetivo));
                resultado.append("Mantén la consistencia en tu plan para alcanzar tu meta.");
            }
            resultado.append("</p>");
        }

        // Evaluación general
        resultado.append("<p><strong>Evaluación General:</strong> ");
        int indicadoresPositivos = 0;

        // Evaluar si el cambio total está alineado con el objetivo
        if (objetivoUsuario.toLowerCase().contains("bajar de peso") || objetivoUsuario.toLowerCase().contains("perder")) {
            if (cambioTotal <= 0) indicadoresPositivos++;
        } else if (objetivoUsuario.toLowerCase().contains("ganar musculo") || objetivoUsuario.toLowerCase().contains("masa") || objetivoUsuario.toLowerCase().contains("volumen")) {
            if (cambioTotal >= 0) indicadoresPositivos++;
        } else {
            if (Math.abs(cambioTotal) < 1.0) indicadoresPositivos++; // Estabilidad para mantenimiento
        }

        // Evaluar tendencia reciente
        if (pesos.size() >= 2) {
            double cambioReciente = pesos.get(pesos.size() - 1) - pesos.get(pesos.size() - 2);
            if ((objetivoUsuario.toLowerCase().contains("bajar de peso") && cambioReciente <= 0) ||
                (objetivoUsuario.toLowerCase().contains("ganar musculo") && cambioReciente >= 0) ||
                (!objetivoUsuario.toLowerCase().contains("bajar de peso") && !objetivoUsuario.toLowerCase().contains("ganar musculo") && Math.abs(cambioReciente) < 0.5)) {
                indicadoresPositivos++;
            }
        }

        // Evaluar proximidad al objetivo
        if (objetivo > 0 && Math.abs(pesoActual - objetivo) <= 3.0) {
            indicadoresPositivos++;
        }

        if (indicadoresPositivos >= 2) {
            resultado.append("Tu control de peso está siendo exitoso y constante. ");
            resultado.append("El balance calórico y tu metabolismo están respondiendo bien a tu plan actual.");
        } else if (indicadoresPositivos == 1) {
            resultado.append("Tu peso muestra progreso parcial, pero la velocidad de cambio podría optimizarse. ");
            resultado.append("Considera ajustar las calorías diarias o la frecuencia de pesaje para mejores resultados.");
        } else {
            resultado.append("La evolución de tu peso sugiere que el balance calórico necesita ajustes importantes. ");
            resultado.append("Revisa tu ingesta calórica diaria y la consistencia en el seguimiento del peso.");
        }
        
        resultado.append("</p>");

        resultado.append("</div>");
        return resultado.toString();
    }

    private String analizarMedidas(List<Integer> cintura, List<Integer> pecho, List<Integer> brazo, List<Integer> muslo, List<Integer> caderas) {
        if (cintura.isEmpty()) return "No hay datos de medidas corporales disponibles para analizar.";

        StringBuilder resultado = new StringBuilder();
        resultado.append("<div class='analisis-medidas'>");

        if (cintura.size() < 2) {
            resultado.append("<p>Se necesitan al menos dos mediciones para realizar un análisis comparativo.</p>");
            resultado.append("</div>");
            return resultado.toString();
        }

        resultado.append("<ul>");

        if (!pecho.isEmpty() && pecho.size() >= 2) {
            int cambioPecho = pecho.get(0) - pecho.get(pecho.size() - 1);
            resultado.append("<li><strong>Pecho:</strong> ");
            if (Math.abs(cambioPecho) < 1) {
                resultado.append("Medida estable. ");
            } else if (cambioPecho < 0) {
                resultado.append(String.format("Crecimiento de %d cm. ", Math.abs(cambioPecho)));
                resultado.append("Indica desarrollo muscular en la zona pectoral.");
            } else {
                resultado.append(String.format("Reducción de %d cm. ", cambioPecho));
                resultado.append("Posible pérdida de masa muscular o grasa en la zona.");
            }
            resultado.append("</li>");
        }
        
        int cambioCintura = cintura.get(0) - cintura.get(cintura.size() - 1);
        resultado.append("<li><strong>Cintura:</strong> ");
        if (Math.abs(cambioCintura) < 1) {
            resultado.append("Sin cambios significativos. Mantén la consistencia para ver mejores resultados.");
        } else if (cambioCintura > 0) {
            resultado.append(String.format("Reducción de %d cm. ¡Excelente progreso! ", cambioCintura));
            resultado.append("Esto indica una reducción efectiva de grasa abdominal.");
        } else {
            resultado.append(String.format("Aumento de %d cm. ", Math.abs(cambioCintura)));
            resultado.append("Considera revisar tu dieta y aumentar el cardio para reducir grasa abdominal.");
        }
        resultado.append("</li>");

        if (!caderas.isEmpty() && caderas.size() >= 2) {
            int cambioCaderas = caderas.get(0) - caderas.get(caderas.size() - 1);
            resultado.append("<li><strong>Caderas:</strong> ");
            if (Math.abs(cambioCaderas) < 1) {
                resultado.append("Medida estable. ");
            } else if (cambioCaderas > 0) {
                resultado.append(String.format("Reducción de %d cm. ", cambioCaderas));
                resultado.append("Indica reducción de grasa en la zona de caderas.");
            } else {
                resultado.append(String.format("Aumento de %d cm. ", Math.abs(cambioCaderas)));
                resultado.append("Podría indicar desarrollo muscular en glúteos o acumulación de grasa en la zona.");
            }
            resultado.append("</li>");
        }
                
        if (!muslo.isEmpty() && muslo.size() >= 2) {
            int cambioMuslo = muslo.get(0) - muslo.get(muslo.size() - 1);
            resultado.append("<li><strong>Muslo:</strong> ");
            if (Math.abs(cambioMuslo) < 1) {
                resultado.append("Medida estable. ");
            } else if (cambioMuslo < 0) {
                resultado.append(String.format("Crecimiento de %d cm. ", Math.abs(cambioMuslo)));
                resultado.append("Excelente desarrollo de la musculatura de piernas.");
            } else {
                resultado.append(String.format("Reducción de %d cm. ", cambioMuslo));
                resultado.append("Podría indicar pérdida de grasa o necesidad de intensificar el entrenamiento de piernas.");
            }
            resultado.append("</li>");
        }

        if (!brazo.isEmpty() && brazo.size() >= 2) {
            int cambioBrazo = brazo.get(0) - brazo.get(brazo.size() - 1);
            resultado.append("<li><strong>Brazo:</strong> ");
            if (Math.abs(cambioBrazo) < 1) {
                resultado.append("Sin cambios notables. ");
            } else if (cambioBrazo < 0) {
                resultado.append(String.format("Crecimiento de %d cm. ", Math.abs(cambioBrazo)));
                resultado.append("¡Buen desarrollo muscular en brazos!");
            } else {
                resultado.append(String.format("Reducción de %d cm. ", cambioBrazo));
                resultado.append("Considera intensificar el entrenamiento de brazos.");
            }
            resultado.append("</li>");
        }

        resultado.append("</ul>");

        // Análisis general
        resultado.append("<p><strong>Evaluación General:</strong> ");
        int cambiosPositivos = 0;
        if (cambioCintura > 0) cambiosPositivos++;
        if (!pecho.isEmpty() && pecho.size() >= 2 && (pecho.get(0) - pecho.get(pecho.size() - 1)) < 0) cambiosPositivos++;
        if (!brazo.isEmpty() && brazo.size() >= 2 && (brazo.get(0) - brazo.get(brazo.size() - 1)) < 0) cambiosPositivos++;
        if (!caderas.isEmpty() && caderas.size() >= 2 && (caderas.get(0) - caderas.get(caderas.size() - 1)) > 0) cambiosPositivos++;

        if (cambiosPositivos >= 2) {
            resultado.append("Tus medidas muestran una recomposición corporal exitosa. ");
            resultado.append("Continúa con tu plan actual para mantener estos resultados positivos.");
        } else if (cambiosPositivos == 1) {
            resultado.append("Algunas medidas están mejorando mientras otras se mantienen estables. ");
            resultado.append("Considera enfocar el entrenamiento en las zonas que no están respondiendo como esperabas.");
          }else {
            resultado.append("Las medidas sugieren que podrías necesitar ajustes en tu programa. ");
            resultado.append("Evalúa incrementar la intensidad del entrenamiento y revisar tu alimentación.");
           }
        resultado.append("</p>");

        resultado.append("</div>");
        return resultado.toString();
    }

    private String analizarCargasIndividual(String ejercicio, List<Double> datos) {
        if (datos.isEmpty()) return "";
        if (datos.size() < 2) return "<li><strong>" + ejercicio + ":</strong> Se necesitan más registros para analizar el progreso.</li>";

        double cargaInicial = datos.get(0);
        double cargaActual = datos.get(datos.size() - 1);
        double cambioTotal = cargaActual - cargaInicial;
        double porcentajeMejora = (cambioTotal / cargaInicial) * 100;

        // Análisis de tendencia reciente
        double cambioReciente = datos.get(datos.size() - 1) - datos.get(datos.size() - 2);

        StringBuilder resultado = new StringBuilder();
        resultado.append("<li><strong>").append(ejercicio).append(":</strong> ");

        // Análisis del progreso total
        if (Math.abs(cambioTotal) < 1.0) {
            resultado.append("Carga estable desde el inicio. ");
            if (datos.size() > 5) {
                resultado.append("Considera aplicar sobrecarga progresiva para continuar mejorando.");
            }
        } else if (cambioTotal > 0) {
            resultado.append(String.format("Mejora de %.1f kg (%.1f%%) desde el inicio. ", cambioTotal, porcentajeMejora));
            if (porcentajeMejora > 20) {
                resultado.append("¡Progreso excelente! ");
            } else if (porcentajeMejora > 10) {
                resultado.append("Buen progreso constante. ");
            } else {
                resultado.append("Progreso moderado. ");
            }
        } else {
            resultado.append(String.format("Reducción de %.1f kg desde el inicio. ", Math.abs(cambioTotal)));
            resultado.append("Considera revisar tu técnica, descanso o nutrición. ");
        }

        // Análisis de tendencia reciente
        if (Math.abs(cambioReciente) > 1.0) {
            if (cambioReciente > 0) {
                resultado.append(String.format("Última sesión: +%.1f kg. ", cambioReciente));
            } else {
                resultado.append(String.format("Última sesión: -%.1f kg. ", Math.abs(cambioReciente)));
                resultado.append("Posible fatiga o necesidad de deload. ");
            }
        }

        // Recomendaciones específicas por ejercicio
        if (cambioTotal > 0 && porcentajeMejora < 5 && datos.size() > 6) {
            switch (ejercicio.toLowerCase()) {
                case "sentadilla":
                    resultado.append("Tip: Enfócate en la profundidad y considera periodización.");
                    break;
                case "press banca":
                case "press pecho":
                    resultado.append("Tip: Varía el agarre y incluye ejercicios accesorios.");
                    break;
                case "peso muerto":
                    resultado.append("Tip: Trabaja la técnica y fortalece el core.");
                    break;
                case "press militar":
                    resultado.append("Tip: Mejora la movilidad de hombros y estabilidad del core.");
                    break;
                case "curl bíceps":
                    resultado.append("Tip: Enfócate en la conexión mente-músculo y control excéntrico.");
                    break;
                case "remo":
                    resultado.append("Tip: Mejora la activación de dorsales y retracción escapular.");
                    break;
            }
        }

        resultado.append("</li>");
        return resultado.toString();
    }

    // Función adicional para crear un resumen general de fuerza
    private String analizarFuerzaGeneral(List<Double> sentadilla, List<Double> press, List<Double> pesoMuerto) {
        if (sentadilla.isEmpty() || press.isEmpty() || pesoMuerto.isEmpty()) {
            return "No hay suficientes datos para analizar el progreso general de fuerza.";
        }

        StringBuilder resultado = new StringBuilder();
        resultado.append("<div class='analisis-fuerza-general'>");

        if (sentadilla.size() >= 2 && press.size() >= 2 && pesoMuerto.size() >= 2) {
            double progresoSentadilla = ((sentadilla.get(sentadilla.size() - 1) - sentadilla.get(0)) / sentadilla.get(0)) * 100;
            double progresoPress = ((press.get(press.size() - 1) - press.get(0)) / press.get(0)) * 100;
            double progresoPesoMuerto = ((pesoMuerto.get(pesoMuerto.size() - 1) - pesoMuerto.get(0)) / pesoMuerto.get(0)) * 100;

            double progresoPromedio = (progresoSentadilla + progresoPress + progresoPesoMuerto) / 3;

            resultado.append("<p><strong>Progreso Promedio en Ejercicios Principales:</strong> ");
            resultado.append("Has aumentado un ").append(String.format("%.1f%%", progresoPromedio));

            if (progresoPromedio > 15) {
                resultado.append(" con respecto a tus cargas iniciales - ¡Progreso excepcional! Tu fuerza está mejorando significativamente.");
            } else if (progresoPromedio > 8) {
                resultado.append(" - Buen progreso constante. Mantén la consistencia.");
            } else if (progresoPromedio > 0) {
                resultado.append(" - Progreso moderado. Considera ajustar la programación.");
            } else {
                resultado.append(" - Estancamiento detectado. Recomendamos revisar tu programa de entrenamiento.");
            }
            resultado.append("</p>");

            // Determinar el movimiento más fuerte
            String movimientoFuerte = "Sentadilla";
            double mayorProgreso = progresoSentadilla;
            if (progresoPress > mayorProgreso) {
                movimientoFuerte = "Press Banca";
                mayorProgreso = progresoPress;
            }
            if (progresoPesoMuerto > mayorProgreso) {
                movimientoFuerte = "Peso Muerto";
                mayorProgreso = progresoPesoMuerto;
            }

            resultado.append("<p><strong>Ejercicio con Mayor Progreso:</strong> ");
            resultado.append(movimientoFuerte);
            resultado.append(String.format(" (%.1f%% de mejora)", mayorProgreso));
            resultado.append("</p>");
        }

        resultado.append("</div>");
        return resultado.toString();
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
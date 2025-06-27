/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Phylix;

import com.Phylix.Comida;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

import org.json.JSONObject;
import com.google.gson.Gson;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;

/**
 *
 * @author Abraham
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/DashboardServlet"})
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    // Configuración de base de datos - ajusta según tu configuración
    private final String url = "jdbc:mysql://localhost:3306/FitData";
    private final String user = "root";
    private final String pass = "AT10220906";
    
    // Límites saludables para cambios de peso mensual
    private static final double MAX_PERDIDA_MENSUAL_KG = 1.7;
    private static final double MAX_GANANCIA_MENSUAL_KG = 1.0;
    private static final double TOLERANCIA_PESO_OBJETIVO = 0.5;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DashboardServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashboardServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("Hasta el final del try, enviando al JSP");
        HttpSession session = request.getSession();
        Integer idUsuarioObj = (Integer) session.getAttribute("id_usuario");
        
        // Validar sesión
        if (idUsuarioObj == null) {
            response.sendRedirect("Proyecto.jsp");
            return;
        }
        
        int idUsuario = idUsuarioObj;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(url, user, pass)) {
                
            // Obtener día de la semana en español
            String diaActual = "";
            switch (java.time.LocalDate.now().getDayOfWeek()) {
                case MONDAY: diaActual = "Lunes"; break;
                case TUESDAY: diaActual = "Martes"; break;
                case WEDNESDAY: diaActual = "Miercoles"; break;
                case THURSDAY: diaActual = "Jueves"; break;
                case FRIDAY: diaActual = "Viernes"; break;
                case SATURDAY: diaActual = "Sabado"; break;
                case SUNDAY: diaActual = "Domingo"; break;
            }
            
            request.setAttribute("nombre_dia", diaActual);
            
            List<Comida> comidasDelDia = new ArrayList<>();
            String sql = "SELECT * FROM Comidas WHERE id_usuario = ? AND dia_comida = ? ORDER BY id_comida ASC LIMIT 5";



            try (Connection con = DriverManager.getConnection(url, user, pass);
                 PreparedStatement stmt = con.prepareStatement(sql)) {

                stmt.setInt(1, idUsuario);
                stmt.setString(2, diaActual);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Comida comida = new Comida(
                            rs.getInt("id_comida"),
                            rs.getString("proteina"),
                            rs.getString("carbohidrato"),
                            rs.getString("vitamina"),
                            rs.getString("grasa"),
                            rs.getInt("porcion_proteina"),
                            rs.getInt("porcion_carbohidrato"),
                            rs.getInt("porcion_vitamina"),
                            rs.getInt("porcion_grasa"),
                            rs.getString("nombre_dieta"),
                            rs.getString("dia_comida"),
                            rs.getInt("id_usuario")
                        );
                        comidasDelDia.add(comida);
                    }
                }

                // Puedes almacenar el resultado para usarlo en JSP o JSON
                request.setAttribute("comidasDelDia", comidasDelDia);

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorComidas", "Error al consultar las comidas: " + e.getMessage());
            }


                // Guardas la lista en el request para la JSP
                request.setAttribute("comidasDelDia", comidasDelDia);
            
                DatosUsuario datosUsuario = obtenerDatosUsuario(conn, idUsuario);
                
                // 2. Obtener peso actual (último registro de IMC)
                double pesoActual = obtenerPesoActual(conn, idUsuario);
                
                // 3. Obtener peso objetivo final
                double pesoObjetivoFinal = obtenerPesoObjetivo(conn, idUsuario);
                
                // 4. Calcular peso objetivo para el próximo mes
                double pesoObjetivoMensual = calcularPesoObjetivoMensual(
                    pesoActual, pesoObjetivoFinal, 1.20);
                
                // 5. Obtener datos históricos de peso por mes
                List<DatosPeso> historialPeso = obtenerHistorialPeso(conn, idUsuario);
                
                // 6. Obtener datos históricos de medidas corporales
                List<DatosMedidas> historialMedidas = obtenerHistorialMedidas(conn, idUsuario);
                
                // 7. Convertir datos a formato JSON para los gráficos
                JSONArray mesesPeso = new JSONArray();
                JSONArray pesos = new JSONArray();
                
                EstadisticasProgreso estadisticas = calcularEstadisticas(
    datosUsuario.pesoInicial, pesoActual, pesoObjetivoFinal, pesoObjetivoMensual, datosUsuario.altura); 

            // También asegúrate de enviar el IMC al JSP:
            request.setAttribute("imcActual", estadisticas.imcActual);
                
                for (DatosPeso dato : historialPeso) {
                    mesesPeso.put(dato.mes);
                    pesos.put(dato.peso);
                }
                
                JSONArray cinturas = new JSONArray();
                JSONArray pechos = new JSONArray();
                
                for (DatosMedidas medida : historialMedidas) {
                    cinturas.put(medida.cintura);
                    pechos.put(medida.pecho);
                }

                
                // 9. Enviar todos los datos al JSP
                request.setAttribute("fromServlet", "true"); // Indicador de que viene del servlet
                
                request.setAttribute("altura", datosUsuario.altura);
                request.setAttribute("imcActual", estadisticas.imcActual);
                request.setAttribute("diferenciaPesoTotal", estadisticas.diferenciaPesoTotal);
                request.setAttribute("diferenciaPesoMensual", estadisticas.diferenciaPesoMensual);
                request.setAttribute("progresoPorcentaje", estadisticas.progresoPorcentaje);
                request.setAttribute("tiempoEstimadoMeses", estadisticas.tiempoEstimadoMeses);
                
                // Datos para gráficos en formato JSON
                request.setAttribute("pesoInicial", datosUsuario.pesoInicial);
                request.setAttribute("pesoActual", pesoActual);
                request.setAttribute("pesoObjetivo", pesoObjetivoFinal);
                request.setAttribute("pesoObjetivoMensual", pesoObjetivoMensual);
                
               request.setAttribute("mesesPeso", mesesPeso.toString());
               request.setAttribute("pesos", pesos.toString());
               request.setAttribute("cinturas", cinturas.toString());
               request.setAttribute("pechos", pechos.toString());
                
                // Información adicional
                request.setAttribute("statusPeso", estadisticas.statusPeso);
                request.setAttribute("recomendacion", estadisticas.recomendacion);

                request.setAttribute("fromServlet", "true"); // Indicador de que viene del servlet

                request.getRequestDispatcher("FitData").forward(request, response);
            }
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar el driver de base de datos: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al conectar con la base de datos: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error interno del servidor: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    

    private DatosUsuario obtenerDatosUsuario(Connection conn, int idUsuario) throws SQLException {
        String sql = "SELECT peso_inicial, altura_inicial FROM Usuario WHERE id_usuario = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new DatosUsuario(
                        rs.getDouble("peso_inicial"),
                        rs.getDouble("altura_inicial")
                    );
                }
            }
        }
        return new DatosUsuario(70.0, 1.70); // valores por defecto
    }

    private double obtenerPesoActual(Connection conn, int idUsuario) throws SQLException {
        String sql = "SELECT peso_usuario FROM IMC WHERE id_usuario = ? ORDER BY fecha DESC LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("peso_usuario");
                }
            }
        }
        return 70.0; // peso por defecto
    }
    
    private double obtenerPesoObjetivo(Connection conn, int idUsuario) throws SQLException {
        double pesoInicial = 0.0;
        String objetivo = "";

        // 1. Obtener el peso inicial del usuario
        String sqlPeso = "SELECT peso_inicial FROM Usuario WHERE id_usuario = ?";
        try (PreparedStatement ps = conn.prepareStatement(sqlPeso)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    pesoInicial = rs.getDouble("peso_inicial");
                }
            }
        }

        // 2. Obtener el objetivo del usuario
        String sqlObjetivo = "SELECT objetivo_usuario FROM Cuestionario WHERE id_usuario = ?";
        try (PreparedStatement ps = conn.prepareStatement(sqlObjetivo)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    objetivo = rs.getString("objetivo_usuario");
                }
            }
        }

        // 3. Calcular el peso objetivo en función del objetivo
        switch (objetivo.toLowerCase()) {
            case "bajar de peso":
                return Math.round((pesoInicial - (pesoInicial * 0.14)) * 10.0) / 10.0;
            case "subir masa muscular":
                return Math.round((pesoInicial + (pesoInicial * 0.045)) * 10.0) / 10.0;
            case "mantener peso":
            default:
                return Math.round(pesoInicial * 10.0) / 10.0;
        }

        
    }

    private List<DatosPeso> obtenerHistorialPeso(Connection conn, int idUsuario) throws SQLException {
        List<DatosPeso> historial = new ArrayList<>();
        String sql = "SELECT DATE_FORMAT(fecha, '%b') AS mes, peso_usuario, fecha " +
                    "FROM IMC WHERE id_usuario = ? ORDER BY fecha";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    historial.add(new DatosPeso(
                        rs.getString("mes"),
                        rs.getDouble("peso_usuario"),
                        rs.getDate("fecha")
                    ));
                }
            }
        }
        return historial;
    }
    
    private List<DatosMedidas> obtenerHistorialMedidas(Connection conn, int idUsuario) throws SQLException {
        List<DatosMedidas> historial = new ArrayList<>();
        String sql = "SELECT cintura, pecho, fecha FROM Medidas WHERE id_usuario = ? ORDER BY fecha";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    historial.add(new DatosMedidas(
                        rs.getInt("cintura"),
                        rs.getInt("pecho"),
                        rs.getDate("fecha")
                    ));
                }
            }
        }
        return historial;
    }

    private double calcularPesoObjetivoMensual(double pesoActual, double pesoObjetivoFinal, double altura) {
        
        double diferenciaPeso = pesoObjetivoFinal - pesoActual;
        if (Math.abs(diferenciaPeso) <= TOLERANCIA_PESO_OBJETIVO) {
            return pesoActual; // mantener peso actual
        }
        
        double pesoObjetivoMensual;
        
        if (diferenciaPeso < 0) {
            // CASO: Perder peso
            double perdidaDeseada = Math.abs(diferenciaPeso);
            double perdidaMensual = Math.min(perdidaDeseada, MAX_PERDIDA_MENSUAL_KG);
            
            // Ajuste según IMC actual para evitar bajo peso
            double imcActual = pesoActual / (altura * altura);
            if (imcActual < 20) {
                perdidaMensual = Math.min(perdidaMensual, 1.0);
            }
            
            pesoObjetivoMensual = pesoActual - perdidaMensual;
            
        } else {
            // CASO: Ganar peso
            double gananciaDeseada = diferenciaPeso;
            double gananciaMensual = Math.min(gananciaDeseada, MAX_GANANCIA_MENSUAL_KG);
            
            // Ajuste según IMC actual para evitar sobrepeso
            double imcActual = pesoActual / (altura * altura);
            if (imcActual > 27) {
                gananciaMensual = Math.min(gananciaMensual, 1.0);
            }
            
            pesoObjetivoMensual = pesoActual + gananciaMensual;
        }
        
        // Validación final: no exceder el objetivo final
        if (diferenciaPeso < 0) {
            pesoObjetivoMensual = Math.max(pesoObjetivoMensual, pesoObjetivoFinal);
        } else {
            pesoObjetivoMensual = Math.min(pesoObjetivoMensual, pesoObjetivoFinal);
        }
        
        // Redondear a 1 decimal
        return Math.round(pesoObjetivoMensual * 10.0) / 10.0;
    }
    
    private EstadisticasProgreso calcularEstadisticas(double pesoInicial, double pesoActual, 
        double pesoObjetivoFinal, double pesoObjetivoMensual, double altura) { // Agregamos altura como parámetro

        EstadisticasProgreso stats = new EstadisticasProgreso();

        // Calcular IMC actual usando la altura real del usuario
        stats.imcActual = pesoActual / (altura * altura);
        stats.imcActual = Math.round(stats.imcActual * 10.0) / 10.0; // Redondear a 1 decimal

        // Diferencias de peso
        stats.diferenciaPesoTotal = pesoObjetivoFinal - pesoInicial;
        stats.diferenciaPesoMensual = pesoObjetivoMensual - pesoActual;

        // Progreso actual en porcentaje
        double pesoProgreso = pesoInicial - pesoActual;
        double pesoTotalNecesario = pesoInicial - pesoObjetivoFinal;
        if (Math.abs(pesoTotalNecesario) > 0.1) {
            stats.progresoPorcentaje = Math.round((pesoProgreso / pesoTotalNecesario) * 100.0);
            // Asegurar que el porcentaje esté entre 0 y 100
            stats.progresoPorcentaje = Math.max(0, Math.min(100, stats.progresoPorcentaje));
        } else {
            stats.progresoPorcentaje = 100.0; // ya está en el objetivo
        }

        // Tiempo estimado para alcanzar el objetivo
        double pesoRestante = Math.abs(pesoObjetivoFinal - pesoActual);
        if (pesoRestante <= TOLERANCIA_PESO_OBJETIVO) {
            stats.tiempoEstimadoMeses = 0;
            stats.statusPeso = "¡Objetivo alcanzado!";
            stats.recomendacion = "Mantén tu peso actual con una alimentación equilibrada y ejercicio regular.";
        } else {
            double cambioMensualPromedio = (pesoObjetivoFinal > pesoActual) ? 
                MAX_GANANCIA_MENSUAL_KG : MAX_PERDIDA_MENSUAL_KG;
            stats.tiempoEstimadoMeses = (int) Math.ceil(pesoRestante / cambioMensualPromedio);

            if (pesoObjetivoFinal < pesoActual) {
                stats.statusPeso = "Perdiendo peso";
                stats.recomendacion = "Mantén un déficit calórico moderado y ejercicio cardiovascular regular.";
            } else {
                stats.statusPeso = "Ganando peso";
                stats.recomendacion = "Aumenta tu ingesta calórica con alimentos nutritivos y entrenamiento de fuerza.";
            }
        }

        return stats;
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    // Clases auxiliares para organizar los datos
    private static class DatosUsuario {
        double pesoInicial;
        double altura;
        
        DatosUsuario(double pesoInicial, double altura) {
            this.pesoInicial = pesoInicial;
            this.altura = altura;
        }
    }
    
    private static class DatosPeso {
        String mes;
        double peso;
        java.sql.Date fecha;
        
        DatosPeso(String mes, double peso, java.sql.Date fecha) {
            this.mes = mes;
            this.peso = peso;
            this.fecha = fecha;
        }
    }
    
    private static class DatosMedidas {
        int cintura;
        int pecho;
        java.sql.Date fecha;
        
        DatosMedidas(int cintura, int pecho, java.sql.Date fecha) {
            this.cintura = cintura;
            this.pecho = pecho;
            this.fecha = fecha;
        }
    }
    
    private static class EstadisticasProgreso {
        double imcActual;
        double diferenciaPesoTotal;
        double diferenciaPesoMensual;
        double progresoPorcentaje;
        int tiempoEstimadoMeses;
        String statusPeso;
        String recomendacion;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

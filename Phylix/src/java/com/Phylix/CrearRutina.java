package com.Phylix;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

@WebServlet(name = "CrearRutina", urlPatterns = {"/CrearRutina"})
public class CrearRutina extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Acceder?error=sesion");
            return;
        }

        String referer = request.getHeader("Referer");

    String url = "jdbc:mysql://localhost/FitData";
    String user = "root";
    String password = "AT10220906";

        String currentRoutine = "";
        List<String[]> nombres = new ArrayList<>();
        List<String[]> rutinasList = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(url, user, password)) {
            String query = "SELECT * FROM Rutinasper WHERE id_usuario = ?";
            try (PreparedStatement stmt = con.prepareStatement(query)) {
                stmt.setInt(1, idUsuario);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        String[] rutina = new String[16];
                        for (int i = 1; i <= 8; i++) {
                            rutina[(i - 1) * 2] = rs.getString("ejercicio" + i);
                            rutina[(i - 1) * 2 + 1] = rs.getString("reps" + i);
                        }
                        rutinasList.add(rutina);

                        String nombreRutina = rs.getString("nombre_rutina");

                        if (nombreRutina != null && !nombreRutina.equals(currentRoutine)) {
                            currentRoutine = nombreRutina;
                            nombres.add(new String[]{currentRoutine});
                        }
                    }
                }
            }

            if (referer.endsWith("Perfil")||referer.endsWith("EliminarDieta") || referer.endsWith("EliminarRutina")) {
                request.setAttribute("rutinas", rutinasList);
                request.setAttribute("nombres", nombres);
                request.setAttribute("idUsuario", idUsuario);
                request.getRequestDispatcher("MisRutinas.jsp").forward(request, response);
                return;
            }

            String nombreRutina = request.getParameter("nombreRutina");
            List<String> ejercicios1 = obtenerEjercicios(request, "ejercicio1");
            List<String> ejercicios2 = obtenerEjercicios(request, "ejercicio2");
            List<String> ejercicios3 = obtenerEjercicios(request, "ejercicio3");


            int edad = 0;
            String sexo = "desconocido";
            String frecuencia = "moderada";
            String objetivos = "mantener salud";
        
            try{
                Connection conn = DriverManager.getConnection(url, user, password);
                query = "SELECT u.edad_usuario AS edad, u.sexo_usuario AS sexo, " +
                               "c.frecuencia_usuario AS frecuencia, c.objetivo_usuario AS objetivos " +
                               "FROM Usuario u INNER JOIN Cuestionario c ON u.id_usuario = c.id_usuario " +
                               "WHERE u.id_usuario = ?";

                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, idUsuario);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            edad = rs.getInt("edad");
                            sexo = rs.getString("sexo");
                            frecuencia = rs.getString("frecuencia");
                            objetivos = rs.getString("objetivos");
                        } else {
                            response.getWriter().println("<script>alert('No se encontraron datos del usuario.');</script>");
                            response.sendRedirect("PerfilUsuario.jsp");
                            return;
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("<script>alert('Error al obtener los datos del usuario: " + e.getMessage() + "');</script>");
                response.sendRedirect("PerfilUsuario.jsp");
                return;
            }
            
            
            List<String> repeticionesYSeries = calcularRepeticionesYSeries(edad, sexo, frecuencia, objetivos);

            crearRegistroRutina(con, idUsuario, ejercicios1, ejercicios2, ejercicios3, repeticionesYSeries, nombreRutina);

            response.getWriter().println("<script>alert('Rutina creada exitosamente.');</script>");
            response.sendRedirect("FitData");

        } catch (Exception e) {
            response.getWriter().print("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private List<String> obtenerEjercicios(HttpServletRequest request, String prefix) {
        List<String> ejercicios = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            String ejercicio = request.getParameter(prefix + "_" + i);
            if (ejercicio != null) ejercicios.add(ejercicio);
        }
        return ejercicios;
    }

    private List<String> calcularRepeticionesYSeries(int edad, String sexo, String frecuencia, String objetivos) {
        List<String> resultados = new ArrayList<>();
        int baseReps = 12;
        int baseSeries = 3;
        
        switch (objetivos.toLowerCase()) {
            case "bajar de peso":
                baseReps = 15;
                break;
            case "ganar musculo":
                baseReps = 10;
                break;
            case "mejorar resistencia":
                baseReps = 12;
                break;
            case "mantener salud":
                baseReps = 12;
                break;
        }

        switch (frecuencia.toLowerCase()) {
            case "baja":
                baseSeries = 2;
                break;
            case "ninguna":
                baseSeries = 2;
                break;
            case "moderada":
                baseSeries = 3;
                break;
            case "alta":
                baseSeries = 4;
                break;
        }

        if (edad < 30) {
            baseSeries = Math.min(5, baseSeries + 1); 
        } else if (edad > 50) {
            baseSeries = Math.max(2, baseSeries - 1);
        }

        if (sexo.equalsIgnoreCase("femenino")) {
            baseReps = Math.min(15, baseReps - 2);
        }

        baseReps = Math.max(6, Math.min(baseReps, 15));
        baseSeries = Math.max(2, Math.min(baseSeries, 5));
        
        for (int i = 0; i < 9; i++) {
            resultados.add(baseSeries + "x" + baseReps);
        }

        return resultados;
    }

    public void crearRegistroRutina(Connection con, Integer idUsuario, List<String> ejercicios1, 
                                    List<String> ejercicios2, List<String> ejercicios3, 
                                    List<String> repeticionesYSeries, String nombreRutina) throws SQLException {
        String query = "INSERT INTO Rutinasper (ejercicio1, ejercicio2, ejercicio3, ejercicio4, ejercicio5, ejercicio6, ejercicio7, ejercicio8, ejercicio9," +
                       "reps1, reps2, reps3, reps4, reps5, reps6, reps7, reps8, reps9, nombre_rutina, id_usuario) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

        try (PreparedStatement stmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            List<String> todosEjercicios = new ArrayList<>();
            todosEjercicios.addAll(ejercicios1);
            todosEjercicios.addAll(ejercicios2);
            todosEjercicios.addAll(ejercicios3);

            for (int i = 0; i < 9; i++) {
                if (i < todosEjercicios.size()) {
                    stmt.setString(i + 1, todosEjercicios.get(i));
                } else {
                    stmt.setNull(i + 1, java.sql.Types.VARCHAR);
                }
            }

            for (int i = 0; i < 9; i++) {
                if (i < repeticionesYSeries.size()) {
                    stmt.setString(10 + i, repeticionesYSeries.get(i));
                } else {
                    stmt.setNull(10 + i, java.sql.Types.VARCHAR);
                }
            }

            stmt.setString(19, nombreRutina);
            stmt.setInt(20, idUsuario);

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("No se pudo insertar la rutina, no se afectaron filas.");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para crear rutinas personalizadas.";
    }
}

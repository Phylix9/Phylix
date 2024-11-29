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

        if (idUsuario == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No se ha encontrado el id del usuario en la sesión.");
            return;
        }

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        int edad = 0;
        String sexo = null;
        String objetivos = null;
        String frecuencia = null;

        List<String> ejercicios1 = new ArrayList<>();
        List<String> ejercicios2 = new ArrayList<>();
        List<String> ejercicios3 = new ArrayList<>();
        List<String> gruposEjercicios = new ArrayList<>();

        for (int i = 1; i <= 5; i++) {
            String ejercicio = request.getParameter("ejercicio1_" + i);
            if (ejercicio != null) ejercicios1.add(ejercicio);
        }
        for (int i = 1; i <= 5; i++) {
            String ejercicio = request.getParameter("ejercicio2_" + i);
            if (ejercicio != null) ejercicios2.add(ejercicio);
        }
        for (int i = 1; i <= 5; i++) {
            String ejercicio = request.getParameter("ejercicio3_" + i);
            if (ejercicio != null) ejercicios3.add(ejercicio);
        }
        for (int i = 0; i < 3; i++) {
            String grupo = request.getParameter("grupoEjercicio" + i);
            if (grupo != null) gruposEjercicios.add(grupo);
        }

        session.setAttribute("edad", edad);
        session.setAttribute("sexo", sexo);
        session.setAttribute("objetivos", objetivos);
        session.setAttribute("frecuencia", frecuencia);
        session.setAttribute("ejercicios1", ejercicios1.toArray(new String[0]));
        session.setAttribute("ejercicios2", ejercicios2.toArray(new String[0]));
        session.setAttribute("ejercicios3", ejercicios3.toArray(new String[0]));
        session.setAttribute("gruposEjercicios", gruposEjercicios.toArray(new String[0]));

        
        String referer = request.getHeader("Referer");

        try (Connection con = DriverManager.getConnection(url, user, password)) {
            String query = "SELECT * FROM Rutinasper WHERE id_usuario = ?";
            List<String[]> rutinasList = new ArrayList<>();
            try (PreparedStatement stmt = con.prepareStatement(query)) {
                stmt.setInt(1, idUsuario);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        String[] rutina = new String[16];
                        for (int i = 1; i <= 8; i++) {
                            rutina[(i - 1) * 2] = rs.getString("ejercicio" + i);
                            rutina[(i - 1) * 2 + 1] = String.valueOf(rs.getInt("reps" + i));
                        }
                        rutinasList.add(rutina);
                    }
                }
            }
            
            
            int[] repeticiones = {10, 12, 15, 8, 10, 12, 15, 8};
            crearRegistroRutina(con, idUsuario, ejercicios1, ejercicios2, ejercicios3, repeticiones);
            
            if (referer != null && referer.endsWith("Perfil.jsp")) {
                request.setAttribute("rutinas", rutinasList);
                request.getRequestDispatcher("MisRutinas.jsp").forward(request, response);
            } else {
                response.getWriter().println("<script>alert('No se puede acceder a MisRutinas.jsp desde la página anterior.');</script>");
                response.sendRedirect("Proyecto.jsp");
            }

        } catch (Exception e) {
            response.getWriter().print("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void crearRegistroRutina(Connection con, Integer idUsuario, List<String> ejercicios1, List<String> ejercicios2, List<String> ejercicios3, int[] repeticiones) throws SQLException {
    String query = "INSERT INTO Rutinasper (ejercicio1, ejercicio2, ejercicio3, ejercicio4, ejercicio5, ejercicio6, ejercicio7, ejercicio8, " +
                   "reps1, reps2, reps3, reps4, reps5, reps6, reps7, reps8, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try (PreparedStatement stmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
        // Asignación de ejercicios
        stmt.setString(1, ejercicios1.size() > 0 ? ejercicios1.get(0) : null);
        stmt.setString(2, ejercicios1.size() > 1 ? ejercicios1.get(1) : null);
        stmt.setString(3, ejercicios2.size() > 0 ? ejercicios2.get(0) : null);  // Cambié el índice a 0
        stmt.setString(4, ejercicios2.size() > 1 ? ejercicios2.get(1) : null);  // Cambié el índice a 1
        stmt.setString(5, ejercicios2.size() > 2 ? ejercicios2.get(2) : null);  // Cambié el índice a 2
        stmt.setString(6, ejercicios3.size() > 0 ? ejercicios3.get(0) : null);  // Cambié el índice a 0
        stmt.setString(7, ejercicios3.size() > 1 ? ejercicios3.get(1) : null);  // Cambié el índice a 1
        stmt.setString(8, ejercicios3.size() > 2 ? ejercicios3.get(2) : null);  // Cambié el índice a 2


        // Asignación de repeticiones
        for (int i = 0; i < 8; i++) {
            stmt.setInt(9 + i, repeticiones[i]);
        }

        // Asignación del ID del usuario
        stmt.setInt(17, idUsuario);

        int affectedRows = stmt.executeUpdate();

        if (affectedRows > 0) {
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int idRutina = generatedKeys.getInt(1);

                    String insertRutinapersoQuery = "INSERT INTO RutinapersoCreadas (id_rut, id_usuario) VALUES (?, ?)";
                    try (PreparedStatement insertStmt = con.prepareStatement(insertRutinapersoQuery)) {
                        insertStmt.setInt(1, idRutina); // ID de la rutina insertada
                        insertStmt.setInt(2, idUsuario); // ID del usuario
                        insertStmt.executeUpdate();
                    }
                    }
                }
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
        return "Servlet para crear rutinas personalizadas y almacenar datos en sesión";
    }
}

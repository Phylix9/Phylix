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
        response.sendRedirect("Login.html?error=sesion");
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
                    String nombreRutina = rs.getString("nombre_rutina");

                    if (!nombreRutina.equals(currentRoutine)) {
                        currentRoutine = nombreRutina;
                        nombres.add(new String[]{currentRoutine});
                    }

                    String[] rutina = new String[16];
                    for (int i = 1; i <= 8; i++) {
                        rutina[(i - 1) * 2] = rs.getString("ejercicio" + i);
                        rutina[(i - 1) * 2 + 1] = String.valueOf(rs.getInt("reps" + i));
                    }
                    rutinasList.add(rutina);
                }
            }
        }

        // Si el referer termina con "Perfil", solo realiza el forward al JSP
        if (referer != null && referer.endsWith("Perfil")) {
            request.setAttribute("rutinas", rutinasList);
            request.setAttribute("nombres", nombres);
            request.setAttribute("idUsuario", idUsuario);
            request.getRequestDispatcher("MisRutinas.jsp").forward(request, response);
            return; // Termina aquí para no continuar con la lógica de inserción
        }

        List<String> ejercicios1 = new ArrayList<>();
        List<String> ejercicios2 = new ArrayList<>();
        List<String> ejercicios3 = new ArrayList<>();
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

        String nombre_rutina = (String) request.getParameter("nombreRutina");
        int[] repeticiones = {10, 12, 15, 8, 10, 12, 15, 8};
        crearRegistroRutina(con, idUsuario, ejercicios1, ejercicios2, ejercicios3, repeticiones, nombre_rutina);

        response.getWriter().println("<script>alert('Rutina creada exitosamente.');</script>");
        response.sendRedirect("FitData");

    } catch (Exception e) {
        response.getWriter().print("Error: " + e.getMessage());
        e.printStackTrace();
    }
}


    public void crearRegistroRutina(Connection con, Integer idUsuario, 
                                List<String> ejercicios1, List<String> ejercicios2, 
                                List<String> ejercicios3, int[] repeticiones, 
                                String nombre_rutina) throws SQLException {
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
            if (i < repeticiones.length) {
                stmt.setInt(10 + i, repeticiones[i]);
            } else {
                stmt.setNull(10 + i, java.sql.Types.INTEGER);
            }
        }

        stmt.setString(19, nombre_rutina);
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
        return "Servlet para crear rutinas personalizadas y almacenar datos en sesión";
    }
}

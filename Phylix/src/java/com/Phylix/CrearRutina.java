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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

        // Variables para almacenar datos del cuestionario
        int edad = 0;
        String sexo = null;
        String objetivos = null;
        String frecuencia = null;
        
        // Listas para almacenar ejercicios y grupos de ejercicios
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

        // Guardar datos del cuestionario y ejercicios en la sesión
        session.setAttribute("edad", edad);
        session.setAttribute("sexo", sexo);
        session.setAttribute("objetivos", objetivos);
        session.setAttribute("frecuencia", frecuencia);
        session.setAttribute("ejercicios1", ejercicios1.toArray(new String[0]));
        session.setAttribute("ejercicios2", ejercicios2.toArray(new String[0]));
        session.setAttribute("ejercicios3", ejercicios3.toArray(new String[0]));
        session.setAttribute("gruposEjercicios", gruposEjercicios.toArray(new String[0]));

        // Array de repeticiones
        int[] repeticiones = {10, 10, 10, 10, 10, 10, 10, 10};

        
        try (Connection con = DriverManager.getConnection(url, user, password)) {
            crearRegistroRutina(con, idUsuario, ejercicios1, ejercicios2, ejercicios3, repeticiones);
            request.getRequestDispatcher("MisRutinas").forward(request, response);
        } catch (Exception e) {
            response.getWriter().print("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void crearRegistroRutina(Connection con, Integer idUsuario, List<String> ejercicios1, List<String> ejercicios2, List<String> ejercicios3, int[] repeticiones) throws SQLException {
        String query = "INSERT INTO Rutinasper (ejercicio1, ejercicio2, ejercicio3, ejercicio4, ejercicio5, ejercicio6, ejercicio7, ejercicio8, " +
                       "reps1, reps2, reps3, reps4, reps5, reps6, reps7, reps8, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = con.prepareStatement(query)) {
            // Asignación de ejercicios
            stmt.setString(1, ejercicios1.size() > 0 ? ejercicios1.get(0) : null);
            stmt.setString(2, ejercicios1.size() > 1 ? ejercicios1.get(1) : null);
            stmt.setString(3, ejercicios2.size() > 0 ? ejercicios2.get(0) : null);
            stmt.setString(4, ejercicios2.size() > 1 ? ejercicios2.get(1) : null);
            stmt.setString(5, ejercicios2.size() > 2 ? ejercicios2.get(2) : null);
            stmt.setString(6, ejercicios3.size() > 0 ? ejercicios3.get(0) : null);
            stmt.setString(7, ejercicios3.size() > 1 ? ejercicios3.get(1) : null);
            stmt.setString(8, ejercicios3.size() > 2 ? ejercicios3.get(2) : null);

            // Asignación de repeticiones
            for (int i = 0; i < 8; i++) {
                stmt.setInt(9 + i, repeticiones[i]);
            }

            // Asignación del ID del usuario
            stmt.setInt(17, idUsuario);

            // Ejecución de la consulta
            stmt.executeUpdate();
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
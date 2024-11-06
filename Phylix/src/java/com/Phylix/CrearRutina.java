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

/**
 *
 * @author Abraham
 */
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

        int edad = 0;
        String sexo = null;
        String objetivos = null;
        String frecuencia = null;

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);

            String sqlUsuario = "SELECT edad_usuario, sexo_usuario FROM Usuario WHERE id_usuario = ?";
            stmt = con.prepareStatement(sqlUsuario);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            if (rs.next()) {
                edad = rs.getInt("edad_usuario");
                sexo = rs.getString("sexo_usuario");
                System.out.println("Edad: " + edad + ", Sexo: " + sexo);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Usuario no encontrado.");
                return;
            }
            rs.close();
            stmt.close();

            String sqlCuestionario = "SELECT frecuencia_usuario, objetivo_usuario FROM Cuestionario WHERE id_usuario = ?";
            stmt = con.prepareStatement(sqlCuestionario);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            if (rs.next()) {
                frecuencia = rs.getString("frecuencia_usuario");
                objetivos = rs.getString("objetivo_usuario");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cuestionario no encontrado para el usuario.");
                return;
            }
        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().print("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        List<String> gruposEjercicios = new ArrayList<>();
        
        for (int i = 0; i < 3; i++) {
            String ejercicio = request.getParameter("grupoEjercicio" + (i));
            if (ejercicio != null) {
                gruposEjercicios.add(ejercicio);
            }
        }
        request.setAttribute("gruposEjercicios", gruposEjercicios.toArray(new String[0]));
        
        List<String> ejercicios1 = new ArrayList<>();
        List<String> ejercicios2 = new ArrayList<>();
        List<String> ejercicios3 = new ArrayList<>();

        // Captura de los ejercicios de abdomen
        for (int i = 1; i <= 5; i++) {
            String ejercicio = request.getParameter("ejercicio1_" + i);
            if (ejercicio != null) {
                ejercicios1.add(ejercicio);
            }
        }

        // Captura de los ejercicios de espalda baja
        for (int i = 1; i <= 5; i++) {
            String ejercicio = request.getParameter("ejercicio2_" + i);
            if (ejercicio != null) {
                ejercicios2.add(ejercicio);
            }
        }

        // Captura del ejercicio de cardio (solo uno)
        for (int i = 1; i <= 5; i++) {
            String ejercicio = request.getParameter("ejercicio3_" + i);
            if (ejercicio != null) {
                ejercicios3.add(ejercicio);
            }
        }

        request.setAttribute("ejercicios1", ejercicios1.toArray(new String[0]));
        request.setAttribute("ejercicios2", ejercicios2.toArray(new String[0]));
        request.setAttribute("ejercicios3", ejercicios3.toArray(new String[0]));
        
        request.setAttribute("edad", edad);
        request.setAttribute("sexo", sexo);
        request.setAttribute("objetivos", objetivos);
        request.setAttribute("frecuencia", frecuencia);

        request.getRequestDispatcher("RutinasCreadas.jsp").forward(request, response);
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
        return "Creador de Rutinas";
    }

}

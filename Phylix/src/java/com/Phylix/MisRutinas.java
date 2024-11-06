package com.Phylix;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "MisRutinas", urlPatterns = {"/MisRutinas"})
public class MisRutinas extends HttpServlet {

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
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        List<String[]> rutinasList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);

            String query = "SELECT * FROM Rutinasper WHERE id_usuario = ?";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String[] rutina = new String[16];
                rutina[0] = rs.getString("ejercicio1");
                rutina[1] = String.valueOf(rs.getInt("reps1"));
                rutina[2] = rs.getString("ejercicio2");
                rutina[3] = String.valueOf(rs.getInt("reps2"));
                rutina[4] = rs.getString("ejercicio3");
                rutina[5] = String.valueOf(rs.getInt("reps3"));
                rutina[6] = rs.getString("ejercicio4");
                rutina[7] = String.valueOf(rs.getInt("reps4"));
                rutina[8] = rs.getString("ejercicio5");
                rutina[9] = String.valueOf(rs.getInt("reps5"));
                rutina[10] = rs.getString("ejercicio6");
                rutina[11] = String.valueOf(rs.getInt("reps6"));
                rutina[12] = rs.getString("ejercicio7");
                rutina[13] = String.valueOf(rs.getInt("reps7"));
                rutina[14] = rs.getString("ejercicio8");
                rutina[15] = String.valueOf(rs.getInt("reps8"));
                
                rutinasList.add(rutina);
            }

            request.setAttribute("rutinas", rutinasList);

            request.getRequestDispatcher("MisRutinas.jsp").forward(request, response);

        } catch (Exception e) {
            response.getWriter().println("Error al consultar las rutinas: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                response.getWriter().println("Error al cerrar la conexión: " + e.getMessage());
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
        return "Servlet para obtener las rutinas del usuario y mostrarlas en una tabla.";
    }
}

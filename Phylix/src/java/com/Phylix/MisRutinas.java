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
            response.sendRedirect("Login.html?mensaje=sesionExpirada");
            return;
        }

        String plan = request.getParameter("plan");

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";
        
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String[]> rutinaspredList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            
            String queryUpdate = "UPDATE RutPrest SET id_usuario = ? WHERE id_plan = ?";
            stmt = con.prepareStatement(queryUpdate);
            stmt.setInt(1, idUsuario);
            stmt.setString(2, plan);
            stmt.executeUpdate();
            stmt.close();
            
            
            String queryInsert = "INSERT INTO Rutina (rutina_usuario, id_usuario) VALUES (?, ?)";
            stmt = con.prepareStatement(queryInsert);
            stmt.setString(1, plan);
            stmt.setInt(2, idUsuario);
            stmt.executeUpdate();
            stmt.close();
            
            String querySelect = "SELECT id_plan, rutina_prest FROM RutPrest WHERE id_usuario = ? AND id_plan = ?;";
            stmt = con.prepareStatement(querySelect);
            stmt.setInt(1, idUsuario);
            stmt.setString(2, plan);
            rs = stmt.executeQuery();

            while (rs.next()) {
                session.setAttribute("id_plan", plan);
                session.setAttribute("rutina",rs.getString("rutina_prest"));
                rutinaspredList.add(new String[]{"id_plan", "rutina_prest"});
            }
            
            String referer = request.getHeader("Referer");

            if (referer != null && referer.endsWith("Perfil.jsp")) {
                request.setAttribute("rutinasp", rutinaspredList);
                request.getRequestDispatcher("MisRutinas.jsp").forward(request, response);
            } else {
                response.getWriter().println("<script>alert('Rutina creada');</script>");
                response.sendRedirect("Proyecto.jsp");
            }

        } catch (Exception e) {
            response.getWriter().println("Error al procesar la rutina: " + e.getMessage());
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
        return "Servlet para gestionar y mostrar rutinas del usuario en la base de datos.";
    }
}

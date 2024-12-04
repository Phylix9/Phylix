/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Phylix;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Abraham
 */
@WebServlet(name = "GestionarPerfil", urlPatterns = {"/GestionarPerfil"})
public class GestionarPerfil extends HttpServlet {

    String url = "jdbc:mysql://localhost/FitData";
    String user = "root";
    String password = "n0m3l0";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Login.html?error=sesion");
            return;
        }

        try (Connection con = DriverManager.getConnection(url, user, password)) {
            con.setAutoCommit(false);

            try {
                eliminartodo(con, idUsuario);
                con.commit();
                session.invalidate();
                response.getWriter().print("Usuario eliminado correctamente.");
            } catch (SQLException e) {
                con.rollback();
                response.getWriter().print("Error al eliminar usuario: " + e.getMessage());
                e.printStackTrace();
            }
        } catch (SQLException e) {
            response.getWriter().print("Error de conexión a la base de datos: " + e.getMessage());
            e.printStackTrace();
        }
        request.getRequestDispatcher("FitData").forward(request, response);
    }

    private void eliminartodo(Connection conn, int idUsuario) throws SQLException {
        String[] tablas = {
            "Cuestionario", 
            "DietaPrestUsuarios", 
            "DietaPrest", 
            "RutPrestUsuarios", 
            "RutPrest", 
            "RutinapersoCreadas", 
            "Rutinasper", 
            "DietapersoCreadas", 
            "Comidas", 
            "Progreso", 
            "IMC", 
            "Dieta", 
            "Rutina", 
            "ImagenesPerfil", 
            "Usuario"
        };

        for (String tabla : tablas) {
            String query = "DELETE FROM " + tabla + " WHERE id_usuario = ?;";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, idUsuario);
                stmt.executeUpdate();
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
        return "Modificar o eliminar perfil";
    }

}

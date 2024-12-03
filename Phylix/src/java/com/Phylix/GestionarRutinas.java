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
@WebServlet(name = "GestionarRutinas", urlPatterns = {"/GestionarRutinas"})
public class GestionarRutinas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";
        
        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Login.html?error=sesion");
            return;
        }

        String idDietaPrest = request.getParameter("rutinaprestid");
        String idDietaPerso = request.getParameter("rutinapersoid");

        if (idDietaPrest == null && idDietaPerso == null) {
            response.getWriter().print("Error: No se proporcionó información de la dieta para eliminar.");
            return;
        }

        try (Connection con = DriverManager.getConnection(url, user, password)) {
            if (idDietaPrest != null) {
                String idDietaFinal = "plan" + idDietaPrest;
                String query = "DELETE FROM RutinaPrestUsuarios WHERE id_rutinaaselected = ? AND id_usuario = ?";
                try (PreparedStatement stmt = con.prepareStatement(query)) {
                    stmt.setString(1, idDietaFinal);
                    stmt.setInt(2, idUsuario);
                    int rowsAffected = stmt.executeUpdate();
                    response.getWriter().print("Rutina eliminada correctamente. Registros afectados: " + rowsAffected);
                }
            }
            
            if (idDietaPerso != null) {
                String query = "DELETE FROM Rutinasper WHERE nombre_rutina = ? AND id_usuario = ?";
                try (PreparedStatement stmt = con.prepareStatement(query)) {
                    stmt.setString(1, idDietaPerso);
                    stmt.setInt(2, idUsuario);
                    int rowsAffected = stmt.executeUpdate();
                    response.getWriter().print("Rutina personalizada eliminada correctamente. Registros afectados: " + rowsAffected);
                }
            }
            request.getRequestDispatcher("Perfil").forward(request, response);
        } catch (SQLException e) {
            response.getWriter().print("Error de conexión a la base de datos: " + e.getMessage());
            e.printStackTrace();
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
        return "Modificar o eliminar rutina";
    }

}

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
import java.sql.*;


/**
 *
 * @author Abraham
 */
@WebServlet(name = "ProgressBar", urlPatterns = {"/ProgressBar"})
public class ProgressBar extends HttpServlet {
    private final String URL = "jdbc:mysql://ballast.proxy.rlwy.net:25248/railway?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD = "YvAwfIKqPUtHThKEnCFTrKTgxZssaUIE";

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
            out.println("<title>Servlet ProgressBar</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProgressBar at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Usuario no autenticado");
            return;
        }

        int idUsuario = (Integer) session.getAttribute("id_usuario");
        int progreso = 0;

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            PreparedStatement stmt = conn.prepareStatement("SELECT progreso FROM usuario WHERE id_usuario = ?");
            stmt.setInt(1, idUsuario);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                progreso = rs.getInt("progreso");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"progreso\":" + progreso + "}");
        out.flush();
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Usuario no autenticado");
            return;
        }

        int idUsuario = (Integer) session.getAttribute("id_usuario");
        int progreso = 0;

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            // Obtener progreso actual
            PreparedStatement selectStmt = conn.prepareStatement("SELECT progreso FROM usuario WHERE id_usuario = ?");
            selectStmt.setInt(1, idUsuario);
            ResultSet rs = selectStmt.executeQuery();

            if (rs.next()) {
                progreso = rs.getInt("progreso");
                if (progreso < 100) {
                    progreso += 10;
                }
            }

            // Actualizar progreso
            PreparedStatement updateStmt = conn.prepareStatement("UPDATE usuario SET progreso = ? WHERE id_usuario = ?");
            updateStmt.setInt(1, progreso);
            updateStmt.setInt(2, idUsuario);
            updateStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"progreso\":" + progreso + "}");
        out.flush();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

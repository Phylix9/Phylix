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
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 *
 * @author Abraham
 */
@WebServlet(name = "Dietas", urlPatterns = {"/Dietas"})
public class Dietas extends HttpServlet {

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
        
        try {
            HttpSession session = request.getSession(false); // Usa false para no crear una sesión nueva

            if (session == null || session.getAttribute("id_usuario") == null || session.getAttribute("session_token") == null) {
                request.getRequestDispatcher("Proyecto.jsp").forward(request, response);
                return;
            }

            String tokenSesion = (String) session.getAttribute("session_token");
            int idUsuario = (int) session.getAttribute("id_usuario");

            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitdata", "root", "AT10220906")) {
                try (PreparedStatement psToken = con.prepareStatement(
                        "SELECT session_token FROM Usuario WHERE id_usuario = ?")) {
                    psToken.setInt(1, idUsuario);
                    ResultSet rs = psToken.executeQuery();

                    if (rs.next()) {
                        String tokenBD = rs.getString("session_token");

                        if (!tokenSesion.equals(tokenBD)) {
                            session.invalidate(); // Cierra la sesión actual
                            response.sendRedirect("Acceder?error=sesion_duplicada");
                            return;
                        }
                    } else {
                        session.invalidate();
                        response.sendRedirect("Acceder?error=usuario_no_encontrado");
                        return;
                    }
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                response.sendRedirect("login.jsp?error=conexion_bd");
                return;
            }
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.println("<h1>Error interno: " + e.getMessage() + "</h1>");
            e.printStackTrace(out);
        }
        request.getRequestDispatcher("Dietas.jsp").forward(request, response);
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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

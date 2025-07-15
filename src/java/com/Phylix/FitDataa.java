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
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;
/**
 *
 * @author Abraham
 */
@WebServlet(name = "FitDataa", urlPatterns = {"/FitDataa"})
public class FitDataa extends HttpServlet {

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
                request.getRequestDispatcher("FitData.jsp").forward(request, response);
                return;
            }

            String tokenSesion = (String) session.getAttribute("session_token");
            int idUsuario = (int) session.getAttribute("id_usuario");

            try (Connection con = DriverManager.getConnection("jdbc:mysql://ballast.proxy.rlwy.net:25248/railway?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC", "root", "YvAwfIKqPUtHThKEnCFTrKTgxZssaUIE")) {

                try (PreparedStatement psToken = con.prepareStatement(
                        "SELECT session_token FROM Usuario WHERE id_usuario = ?")) {
                    psToken.setInt(1, idUsuario);
                    ResultSet rs = psToken.executeQuery();

                    if (rs.next()) {
                        String tokenBD = rs.getString("session_token");

                        if (!tokenSesion.equals(tokenBD)) {
                            session.invalidate(); 
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
            request.getRequestDispatcher("RutinaDelDia").forward(request, response);

        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.println("<h1>Error interno: " + e.getMessage() + "</h1>");
            e.printStackTrace(out);
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
        return "Short description";
    }// </editor-fold>

}

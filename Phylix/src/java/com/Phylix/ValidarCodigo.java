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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



@WebServlet(name = "ValidarCodigo", urlPatterns = {"/ValidarCodigo"})
public class ValidarCodigo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        String userCode = request.getParameter("code");
        String sessionCodigo = (String) session.getAttribute("codigo");
        int id=  (int) session.getAttribute("id_usuario");

        if (userCode != null && userCode.equals(sessionCodigo)) {
            
            String correo = (String) session.getAttribute("correo_usuario");


            String url = "jdbc:mysql://localhost/FitData";
            String user = "root";
            String password = "AT10220906";

            Connection con = null;
            PreparedStatement sta = null;
            PreparedStatement sta2;
            ResultSet rs = null;
        
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                con = DriverManager.getConnection(url, user, password);

                sta = con.prepareStatement("SELECT * FROM Usuario WHERE correo_usuario = ?;");
                sta.setString(1, correo);
                rs = sta.executeQuery();

                if (rs.next()) {
                    sta2 = con.prepareStatement("UPDATE Usuario SET two_factor = ? WHERE id_usuario = ?;");
                    sta2.setBoolean(1, true);
                    sta2.setInt(2, id);
                    sta2.executeUpdate();
                    sta2.close();
                    session.removeAttribute("codigo");
                    response.sendRedirect("FitData");
                } 
                else {
                    response.sendRedirect("Acceder?error=true");
                }

            } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException  e) {
                response.getWriter().print("Error: " + e.getMessage());
            }finally {
                try {
                    if (rs != null) rs.close();
                    if (sta != null) sta.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }else {
            response.sendRedirect("Autenticacion.jsp?error=true");
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

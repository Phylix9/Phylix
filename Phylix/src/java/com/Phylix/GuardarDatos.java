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
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 *
 * @author Abraham
 */
@WebServlet(name = "GuardarDatos", urlPatterns = {"/GuardarDatos"})
public class GuardarDatos extends HttpServlet {

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
            out.println("<title>Servlet GuardarDatos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GuardarDatos at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Leer cuerpo JSON manualmente
        BufferedReader reader = request.getReader();
        StringBuilder jsonBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }

        // Parsear JSON
        JSONObject datos = new JSONObject(jsonBuilder.toString());
        Date fechaActual = new Date(System.currentTimeMillis());
        double peso = datos.getDouble("peso");
        int cintura = datos.getInt("cintura");
        int pecho = datos.getInt("pecho");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id_usuario") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int idUsuario = (int) session.getAttribute("id_usuario");

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitdata", "root", "AT10220906")) {
            con.setAutoCommit(false);
            double altura = obtenerAlturaUsuario(con, idUsuario);

            try (
                PreparedStatement psIMC = con.prepareStatement("INSERT INTO IMC (fecha, peso_usuario, altura_usuario, id_usuario) VALUES (?, ?, ?, ?);")) {
                    psIMC.setDate(1, fechaActual);
                    psIMC.setDouble(2, peso);
                    psIMC.setDouble(3, altura);
                    psIMC.setInt(4, idUsuario);
                psIMC.executeUpdate();
            }

            try ( 
                PreparedStatement psMedidas = con.prepareStatement("INSERT INTO Medidas (fecha, cintura, pecho, id_usuario) VALUES (?, ?, ?, ?);")) {
                    psMedidas.setDate(1, fechaActual);
                    psMedidas.setInt(2, cintura);
                    psMedidas.setInt(3, pecho);
                    psMedidas.setInt(4, idUsuario);
                psMedidas.executeUpdate();
            }

            con.commit();
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private double obtenerAlturaUsuario(Connection con, int idUsuario) throws SQLException {
        PreparedStatement ps = con.prepareStatement("SELECT altura_inicial FROM Usuario WHERE id_usuario = ?");
        ps.setInt(1, idUsuario);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getDouble(1);
        }
        return 1.0; // Valor por defecto
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

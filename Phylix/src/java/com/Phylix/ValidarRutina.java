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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
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
@WebServlet(name = "ValidarRutina", urlPatterns = {"/ValidarRutina"})
public class ValidarRutina extends HttpServlet {

    private final String url = "jdbc:mysql://localhost:3306/FitData";
    private final String user = "root";
    private final String pass = "AT10220906";
    
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
            out.println("<title>Servlet Abdomen</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Abdomen at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer id_usuario = (Integer) session.getAttribute("id_usuario");

        if (id_usuario == null) {
            response.sendRedirect("FitData");
            return;
        }

        String destino = request.getParameter("destino");

        String[] todosLosDias = {"lunes", "martes", "miercoles", "jueves", "viernes", "sabado", "domingo"};
        List<String> diasDisponibles = new ArrayList<>(Arrays.asList(todosLosDias));

        try (Connection con = DriverManager.getConnection(url, user, pass)) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT dia_rutina FROM Rutinasper WHERE id_usuario = ?"
            );
            ps.setInt(1, id_usuario);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                diasDisponibles.remove(rs.getString("dia_rutina").toLowerCase());
            }

            if (diasDisponibles.isEmpty()) {
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('Ya tienes rutinas asignadas a todos los días de la semana.');");
                out.println("window.location.href = 'Grupo_Muscular.jsp';</script>");
                return;
            }

            request.setAttribute("diasDisponibles", diasDisponibles);
            request.getRequestDispatcher(destino).forward(request, response);

        } catch (Exception e) {

            PrintWriter out = response.getWriter();
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
            e.printStackTrace(out);
        }
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

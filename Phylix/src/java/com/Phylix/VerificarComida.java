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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author Abraham
 */
@WebServlet(name = "VerificarComida", urlPatterns = {"/VerificarComida"})
public class VerificarComida extends HttpServlet {

    private final String url = "jdbc:mysql://localhost:3306/FitData";
    private final String user = "root";
    private final String pass = "n0m3l0";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerificarComida</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerificarComida at " + request.getContextPath() + "</h1>");
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

        String[] todosLosDias = {"lunes", "martes", "miercoles", "jueves", "viernes", "sabado", "domingo"};
        List<String> diasDisponibles = new ArrayList<>(Arrays.asList(todosLosDias));

        try (Connection con = DriverManager.getConnection(url, user, pass)) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT dia_comida FROM Comidas WHERE id_usuario = ?"
            );
            ps.setInt(1, id_usuario);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                diasDisponibles.remove(rs.getString("dia_comida").toLowerCase());
            }

            if (diasDisponibles.isEmpty()) {
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('Ya tienes comidas asignadas a todos los días de la semana.');");
                out.println("window.location.href = 'Grupo_Muscular.jsp';</script>");
                return;
            }

            request.setAttribute("diasDisponibles", diasDisponibles);
            request.getRequestDispatcher("creamenu.jsp").forward(request, response);

        } catch (Exception e) {

            PrintWriter out = response.getWriter();
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
            e.printStackTrace(out);
        }
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

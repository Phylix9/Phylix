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

/**
 *
 * @author Abraham
 */
@WebServlet(name = "IMC", urlPatterns = {"/IMC"})
public class IMC extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Acceder?error=sesion");
            return;
        }
        
        String estaturaStr = request.getParameter("estatura");
        String pesoStr = request.getParameter("peso");

        try {
            double estatura = Double.parseDouble(estaturaStr);
            double peso = Double.parseDouble(pesoStr);
            double imc = peso / (estatura * estatura);
            String imcFormatted = String.format("%.1f", imc); 
            imc = Double.parseDouble(imcFormatted);

            int idUsuario = (int) session.getAttribute("id_usuario");
            
            String url = "jdbc:mysql://localhost/FitData";
            String user = "root";
            String password = "AT10220906";

            try (Connection con = DriverManager.getConnection(url, user, password)) {
                PreparedStatement insertSta = con.prepareStatement("INSERT INTO IMC (fecha, peso_usuario, altura_usuario, id_usuario) VALUES (?, ?, ?, ?)");
                java.sql.Date fechaActual = new java.sql.Date(System.currentTimeMillis());

                insertSta.setDate(1, fechaActual);
                insertSta.setDouble(2, peso);
                insertSta.setDouble(3, estatura);
                insertSta.setInt(4, idUsuario);

                insertSta.executeUpdate();
                
                String categoria;
                if (imc < 18.5) {
                    categoria = "Bajo peso";
                } else if (imc < 25) {
                    categoria = "Peso normal";
                } else if (imc < 30) {
                    categoria = "Sobrepeso";
                } else {
                    categoria = "Obesidad";
                }

                session.setAttribute("IMC", imc);
                session.setAttribute("categoria", categoria);
                session.setAttribute("peso", peso);
                session.setAttribute("estatura", estatura);

                response.sendRedirect("Informacion.jsp");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Por favor ingresa valores válidos para peso y estatura.");
            response.sendRedirect("Informacion.jsp");
        } catch (SQLException e) {
            session.setAttribute("error", "Error en la base de datos: " + e.getMessage());
            response.sendRedirect("Informacion.jsp");
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
        return "Servlet para calcular y almacenar el IMC del usuario";
    }
}

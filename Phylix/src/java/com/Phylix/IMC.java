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
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Login.html?error=sesion");
            return;
        }
        
        String imcc = request.getParameter("imc");
        String estaturaa = request.getParameter("estatura");
        String pesoo = request.getParameter("peso");
        
        double imc = Double.parseDouble(imcc);
        double estatura = Double.parseDouble(estaturaa);
        double peso = Double.parseDouble(pesoo);
        
        
        int idUsuario = (int) session.getAttribute("id_usuario");
        int idImc = idUsuario;
        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";
        
        Connection con = null;
        PreparedStatement sta = null;
        ResultSet r = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);

            sta = con.prepareStatement("SELECT * FROM IMC WHERE id_usuario = ?;");
            sta.setInt(1, idUsuario);
            r = sta.executeQuery();

            if (r.next()) {
                session.setAttribute("IMC", imc);
                session.setAttribute("estatura", estatura);
                session.setAttribute("peso", peso);
                
                response.sendRedirect("Informacion.jsp?fromServlet=true");
            } else {
                sta = con.prepareStatement("INSERT INTO IMC(id_imc, imc_usuario, peso_usuario, altura_usuario, id_usuario) VALUES (?,?,?,?,?);");
                sta.setInt(1, idImc);
                sta.setDouble(2, imc);
                sta.setDouble(3, estatura);
                sta.setDouble(4, peso);
                sta.setInt(5, idUsuario);
                sta.executeUpdate();

                session.setAttribute("IMC", imc);
                session.setAttribute("estatura", estatura);
                session.setAttribute("peso", peso);

                response.sendRedirect("Informacion.jsp");
            }
        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().print("Error: " + e.getMessage());
        } finally {
            try {
                if (r != null) r.close();
                if (sta != null) sta.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
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
        return "Añadir IMC a la base";
    }

}

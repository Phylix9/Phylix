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
import java.sql.SQLException;

@WebServlet(name = "RutinaspersoCreadas", urlPatterns = {"/RutinaspersoCreadas"})
public class RutinaspersoCreadas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        if (idUsuario == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No se ha encontrado el id del usuario en la sesión.");
            return;
        }
        
        String[] ejercicios1 = (String[]) request.getAttribute("ejercicios1");
        String[] ejercicios2 = (String[]) request.getAttribute("ejercicios2");
        String[] ejercicios3 = (String[]) request.getAttribute("ejercicios3");
        String[] grupos = (String[]) request.getAttribute("gruposEjercicios");

        Integer edad = (Integer) request.getAttribute("edad");
        String sexo = (String) request.getAttribute("sexo");
        String objetivos = (String) request.getAttribute("objetivos");
        String frecuencia = (String) request.getAttribute("frecuencia");
        
        
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
        return "Rutinas personalizadas Creadas";
    }

}

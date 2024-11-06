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
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "RutinaspersoCreadas", urlPatterns = {"/RutinaspersoCreadas"})
public class RutinaspersoCreadas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        String[] ejercicios1 = (String[]) session.getAttribute("ejercicios1");
        String[] ejercicios2 = (String[]) session.getAttribute("ejercicios2");
        String[] ejercicios3 = (String[]) session.getAttribute("ejercicios3");
        int[] repeticiones = {10, 10, 10, 10, 10, 10, 10, 10};

        // Juntar todas las listas de ejercicios en una sola
        List<String[]> rutinasList = Arrays.asList(ejercicios1, ejercicios2, ejercicios3);
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
        return "Servlet para crear rutinas personalizadas almacenadas en la tabla Rutinasper";
    }
}

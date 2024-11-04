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
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CalculoComidas", urlPatterns = {"/CalculoComidas"})
public class CalculoComidas extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        Integer idUsuario = (Integer) session.getAttribute("id_usuario");
        int edad = 0;
        String sexo = null;
        String objetivos = null;
        String frecuencia = null;

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);

            String sqlUsuario = "SELECT edad_usuario, sexo_usuario FROM Usuario WHERE id_usuario = ?";
            stmt = con.prepareStatement(sqlUsuario);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            if (rs.next()) {
                edad = rs.getInt("edad_usuario");
                sexo = rs.getString("sexo_usuario");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Usuario no encontrado.");
                return;
            }
            rs.close();
            stmt.close();

            String sqlCuestionario = "SELECT frecuencia_usuario, objetivo_usuario FROM Cuestionario WHERE id_usuario = ?";
            stmt = con.prepareStatement(sqlCuestionario);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            if (rs.next()) {
                frecuencia = rs.getString("frecuencia_usuario");
                objetivos = rs.getString("objetivo_usuario");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cuestionario no encontrado para el usuario.");
                return;
            }
        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().print("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        
        
        List<String> proteinas = new ArrayList<>();
        List<String> carbohidratos = new ArrayList<>();
        List<String> vitaminasMinerales = new ArrayList<>();
        List<String> grasas = new ArrayList<>();


        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            String query = "SELECT nombre, categoria FROM Alimentos";
            PreparedStatement statement = conn.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String nombre = resultSet.getString("nombre");
                String categoria = resultSet.getString("categoria");
                
                switch (categoria) {
                    case "Proteína":
                        proteinas.add(nombre);
                        break;
                    case "Carbohidrato":
                        carbohidratos.add(nombre);
                        break;
                    case "Vitaminas/Minerales":
                        vitaminasMinerales.add(nombre);
                        break;
                    case "Grasas":
                        grasas.add(nombre);
                        break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
          }

        int porcionProteina = calcularPorcionProteina(edad, sexo, frecuencia, objetivos);
        int porcionCarbohidrato = calcularPorcionCarbohidrato(edad, sexo, frecuencia, objetivos);
        int porcionGrasas = calcularPorcionGrasas(edad, sexo, frecuencia, objetivos);

        request.setAttribute("proteinas", proteinas);
        request.setAttribute("carbohidratos", carbohidratos);
        request.setAttribute("vitaminasMinerales", vitaminasMinerales);
        request.setAttribute("grasas", grasas);

        request.setAttribute("porcionProteina", porcionProteina);
        request.setAttribute("porcionCarbohidrato", porcionCarbohidrato);
        request.setAttribute("porcionGrasas", porcionGrasas);

        request.getRequestDispatcher("Menuscreados.jsp").forward(request, response);
    }

    private int calcularPorcionProteina(int edad, String sexo, String frecuencia, String objetivos) {
        int porcion = 0;
        if (objetivos.equals("bajar_peso")) {
            porcion = (sexo.equals("masculino")) ? 100 : 80;
        } else if (objetivos.equals("ganar_musculo")) {
            porcion = (sexo.equals("masculino")) ? 150 : 120;
        }
        if (frecuencia.equals("alta")) {
            porcion += 20;
        }
        return porcion;
    }

    private int calcularPorcionCarbohidrato(int edad, String sexo, String frecuencia, String objetivos) {
        int porcion = 0;
        if (objetivos.equals("bajar de peso")) {
            porcion = (sexo.equals("masculino")) ? 70 : 60;
        } else if (objetivos.equals("ganar_musculo")) {
            porcion = (sexo.equals("masculino")) ? 120 : 100;
        }
        if (frecuencia.equals("alta")) {
            porcion += 10;
        }
        return porcion;
    }

    private int calcularPorcionGrasas(int edad, String sexo, String frecuencia, String objetivos) {
        int porcion = (sexo.equals("masculino")) ? 40 : 30;
        if (objetivos.equals("bajar de peso")) {
            porcion -= 10;
        } else if (objetivos.equals("ganar_musculo")) {
            porcion += 10;
        }
        return porcion;
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
        return "Calculocomidas";
    }// </editor-fold>

}

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

@WebServlet(name = "ModificarPerfil", urlPatterns = {"/ModificarPerfil"})
public class ModificarPerfil extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        Integer idUsuario = (Integer) session.getAttribute("id_usuario");
        
        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Login.html?error=sesion");
            return;
        }
        
        session.setAttribute("nombre", request.getParameter("nombre"));
        session.setAttribute("nombre_usuario", request.getParameter("nombre_usuario"));
        session.setAttribute("correo_usuario", request.getParameter("correo_usuario"));
        session.setAttribute("altura", request.getParameter("altura"));
        session.setAttribute("peso", request.getParameter("peso"));
        session.setAttribute("edad", request.getParameter("edad"));
        session.setAttribute("genero", request.getParameter("genero"));
        session.setAttribute("condiciones", request.getParameter("condiciones"));
        session.setAttribute("medicamentos", request.getParameter("medicamentos"));
        session.setAttribute("actividad", request.getParameter("actividad"));
        session.setAttribute("objetivos", request.getParameter("objetivos"));
        session.setAttribute("alergias", request.getParameter("alergias"));
        session.setAttribute("restricciones", request.getParameter("restricciones"));
        session.setAttribute("estres", request.getParameter("estres"));
        session.setAttribute("suenio", request.getParameter("suenio"));
        
        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";
        
        Connection connection = null;
        ResultSet rs = null;
        PreparedStatement statement = null;
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            connection = DriverManager.getConnection(url,user,password);
            
            statement = connection.prepareStatement("UPDATE Cuestionario SET nombre_completo= ?, condicion_usuario= ?, medicamento_usuario= ?, frecuencia_usuario= ?,"
                    + "objetivo_usuario= ?, alergias_usuario= ?, restriccion_usuario= ?, estres_usuario= ?, sueno_usuario= ? WHERE id_usuario = ?;");
            
                statement.setString(1, request.getParameter("nombre"));
                statement.setString(2, request.getParameter("condiciones"));
                statement.setString(3, request.getParameter("medicamentos"));
                statement.setString(4, request.getParameter("actividad"));
                statement.setString(5, request.getParameter("objetivos"));
                statement.setString(6, request.getParameter("alergias"));
                statement.setString(7, request.getParameter("restricciones"));
                statement.setString(8, request.getParameter("estres"));
                statement.setString(9, request.getParameter("suenio"));
                statement.setInt(10, idUsuario);
                
                statement.executeUpdate();
                statement.close();
                
                
                statement = connection.prepareStatement("UPDATE Usuario SET edad_usuario= ?, sexo_usuario= ? WHERE id_usuario = ?;");
           
                statement.setString(1, request.getParameter("edad"));
                statement.setString(2, request.getParameter("genero"));
                statement.setInt(3, idUsuario);
                
                statement.executeUpdate();
                statement.close();
                
                if (request.getParameter("altura") != null){
                    double altura = Double.parseDouble(request.getParameter("altura"));
                    double peso = Double.parseDouble(request.getParameter("peso"));
                    double imc = peso / (altura * altura); 
                    imc = Math.round(imc * 100.0) / 100.0;


                    if(altura>0){
                    statement = connection.prepareStatement("UPDATE IMC SET imc_usuario= ?, peso_usuario= ?, altura_usuario= ? WHERE id_usuario = ?;");

                        statement.setDouble(1, imc);
                        statement.setDouble(2, peso);
                        statement.setDouble(3, altura);
                        statement.setInt(4, idUsuario);

                    statement.executeUpdate();
                    statement.close();
                    }
                }
              request.getRequestDispatcher("Perfil").forward(request, response);
        } 
            catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().print("Error: " + e.getMessage());
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
        return "Modificar Perfil";
    }

}

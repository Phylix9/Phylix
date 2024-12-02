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
import java.sql.SQLException;


/**
 *
 * @author Abraham
 */
@WebServlet(name = "GestionarRutinas", urlPatterns = {"/GestionarRutinas"})
public class GestionarRutinas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");
    
        if (idUsuario == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No se ha encontrado el id del usuario en la sesión.");
            return;
        }

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";
        
        String idDieta = request.getParameter("dietaperso");
        String numDieta = request.getParameter("dietaperso");

        try (Connection con = DriverManager.getConnection(url, user, password)) {
            
            if(idDieta !=null){
                String query = "DELETE FROM DietaPrestUsuarios WHERE id_dietaselected= ? id_usuario = ?";
                try (PreparedStatement stmt = con.prepareStatement(query)) {
                    stmt.setString(1, idDieta);
                    stmt.setInt(2, idUsuario);
                    stmt.executeUpdate();
                }
                catch (SQLException e) {
                    response.getWriter().print("Error al eliminar rutina: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            else{
                String query = "DELETE FROM Comidas WHERE id_dietaselected= ? id_usuario = ?";
                try (PreparedStatement stmt = con.prepareStatement(query)) {
                    stmt.setString(1, numDieta);
                    stmt.setInt(2, idUsuario);
                    stmt.executeUpdate();
                }
                catch (SQLException e) {
                    response.getWriter().print("Error al eliminar rutina: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            response.getWriter().print("Error de conexión a la base de datos: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void eliminartodo(Connection conn, int idUsuario) throws SQLException {
        String[] tablas = {
            "Cuestionario", 
            "DietaPrestUsuarios", 
            "DietaPrest", 
            "RutPrestUsuarios", 
            "RutPrest", 
            "RutinapersoCreadas", 
            "Rutinasper", 
            "DietapersoCreadas", 
            "Comidas", 
            "Progreso", 
            "IMC", 
            "Dieta", 
            "Rutina", 
            "ImagenesPerfil", 
            "Usuarios"
        };

        for (String tabla : tablas) {
            
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
        return "Modificar o eliminar rutina";
    }

}

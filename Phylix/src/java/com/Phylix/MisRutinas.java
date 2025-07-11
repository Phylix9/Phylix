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

@WebServlet(name = "MisRutinas", urlPatterns = {"/MisRutinas"})
public class MisRutinas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Acceder?error=sesion");
            return;
        }

        String plan = request.getParameter("plan");
        
        String url = "jdbc:mysql://ballast.proxy.rlwy.net:25248/railway?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = "YvAwfIKqPUtHThKEnCFTrKTgxZssaUIE";
        
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String[]> rutinaspredList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);

            List<String> rutina = new ArrayList<>();
            String rutinaselected = null;
            
            String planSelect = "SELECT rutina_prest FROM RutPrest WHERE id_plan = ?;";
            stmt = con.prepareStatement(planSelect);
            stmt.setString(1, plan);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                if(rs.getString("rutina_prest") != null){
                rutinaselected = rs.getString("rutina_prest");
                rutina.add(rutinaselected);
                }
            }
            stmt.close();
            
            String queryInsert = "INSERT INTO RutPrestUsuarios (id_planselected, rutina_prestusers, id_usuario) VALUES (?,?,?); ";
            stmt = con.prepareStatement(queryInsert);
            stmt.setString(1, plan);
            stmt.setString(2, rutinaselected);
            stmt.setInt(3, idUsuario);
            stmt.executeUpdate();
            stmt.close();
            
            String querySelect = "SELECT id_planselected, rutina_prestusers FROM RutPrestUsuarios WHERE id_usuario = ?;";
            stmt = con.prepareStatement(querySelect);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            while (rs.next()) {
                if(rs.getString("rutina_prestusers")!=null){
                    session.setAttribute("id_plan", plan);
                    session.setAttribute("rutina",rs.getString("rutina_prestusers"));
                    rutinaspredList.add(new String[]{"id_plan", "rutina"});
                }
            }
            
            session.setAttribute("rutinaspredet", rutinaspredList); 
            String referer = request.getHeader("Referer");

            if (referer.endsWith("Perfil")||referer.endsWith("EliminarDieta") || referer.endsWith("EliminarRutina") || referer.endsWith("CrearRutina")){
                request.setAttribute("rutinasperso", rutinaspredList);
                request.setAttribute("idplanperso", plan);
                request.getRequestDispatcher("MisRutinas.jsp").forward(request, response);
            } else {
                response.getWriter().println("<script>alert('Rutina creada');</script>");
                response.sendRedirect("FitData");
            }

        } catch (Exception e) {
            response.getWriter().println("Error al procesar la rutina: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                response.getWriter().println("Error al cerrar la conexión: " + e.getMessage());
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
        return "Servlet para gestionar y mostrar rutinas del usuario en la base de datos.";
    }
}

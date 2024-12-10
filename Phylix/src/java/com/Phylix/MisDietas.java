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

@WebServlet(name = "MisDietas", urlPatterns = {"/MisDietas"})
public class MisDietas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Login.html?error=sesion");
            return;
        }

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "n0m3l0";
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        List<String[]> comidasList = new ArrayList<>();
        String currentDiet = "";
        List<String[]> nombres = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);

            String query = "SELECT * FROM Comidas WHERE id_usuario = ?";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            while (rs.next()) {
                
                String nombreDieta = rs.getString("nombre_dieta");

                if (!nombreDieta.equals(currentDiet)) {
                    currentDiet = nombreDieta;
                    nombres.add(new String[] {currentDiet});
                }
                
                String[] comida = new String[9];
                comida[0] = String.valueOf(rs.getInt("id_comida"));
                comida[1] = rs.getString("proteina");
                comida[3] = rs.getString("carbohidrato");
                comida[5] = rs.getString("vitamina");
                comida[7] = rs.getString("grasa");
                comida[2] = String.valueOf(rs.getDouble("porcion_proteina"));
                comida[4] = String.valueOf(rs.getDouble("porcion_carbohidrato"));
                comida[6] = String.valueOf(rs.getDouble("porcion_vitamina"));
                comida[8] = String.valueOf(rs.getDouble("porcion_grasa"));
                comidasList.add(comida);
            }

            rs.close();
            
            String plan = request.getParameter("plan");
            
            
            List<String[]> dietaspredList = new ArrayList<>();
            List<String> dietas = new ArrayList<>();
            String dietaselected = null;
            
            String planSelect = "SELECT dieta_prest FROM DietaPrest WHERE id_dieta = ?;";
            stmt = con.prepareStatement(planSelect);
            stmt.setString(1, plan);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                dietaselected = rs.getString("dieta_prest");
                dietas.add(dietaselected);
            }
            stmt.close();
            
            
            if(dietaselected != null){
                String queryInsert = "INSERT INTO DietaPrestUsuarios (id_dietaselected, dieta_prestusers, id_usuario) VALUES (?,?,?); ";
                stmt = con.prepareStatement(queryInsert);
                stmt.setString(1, plan);
                stmt.setString(2, dietaselected);
                stmt.setInt(3, idUsuario);
                stmt.executeUpdate();
                stmt.close();
            }
            
            String querySelect = "SELECT id_dietaselected, dieta_prestusers FROM DietaPrestUsuarios WHERE id_usuario = ?;";
            stmt = con.prepareStatement(querySelect);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            while (rs.next()) {
                session.setAttribute("id_plan", plan);
                session.setAttribute("dieta",rs.getString("dieta_prestusers"));
                dietaspredList.add(new String[]{"id_plan", "dieta"});
            }
            
            session.setAttribute("dietaspredet", dietaspredList); 
            request.setAttribute("comidas", comidasList);
            request.setAttribute("nombres", nombres);

            String referer = request.getHeader("Referer");

            if (referer.endsWith("Perfil")||referer.endsWith("EliminarDieta") || referer.endsWith("EliminarDieta")) {
                request.setAttribute("nombres", nombres);
                request.setAttribute("dietasprest", dietaspredList);
                request.setAttribute("iddietaprest", plan);
                request.getRequestDispatcher("MisDietas.jsp").forward(request, response);
            } else {
                response.getWriter().println("<script>alert('Rutina creada');</script>");
                response.sendRedirect("FitData");
            }

        } catch (Exception e) {
            response.getWriter().println("Error al consultar las comidas: " + e.getMessage());
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
        return "Servlet para obtener las dietas del usuario y mostrarlas en una tabla.";
    }
}

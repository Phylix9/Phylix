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

@WebServlet(name = "Menus", urlPatterns = {"/Menus"})
public class Menus extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer id_usuario = (Integer) session.getAttribute("id_usuario");

        if (id_usuario == null) {
            response.sendRedirect("Acceder?error=sesion");
            return;
        }

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        List<String> proteinas = new ArrayList<>();
        List<String> carbohidratos = new ArrayList<>();
        List<String> vitaminasMinerales = new ArrayList<>();
        List<String> grasas = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            cargarAlimentos(conn, "Proteína", proteinas);
            cargarAlimentos(conn, "Carbohidrato", carbohidratos);
            cargarAlimentos(conn, "Vitamina", vitaminasMinerales);
            cargarAlimentos(conn, "Grasa", grasas);

            request.setAttribute("proteinas", proteinas);
            request.setAttribute("carbohidratos", carbohidratos);
            request.setAttribute("vitaminasMinerales", vitaminasMinerales);
            request.setAttribute("grasas", grasas);

            request.getRequestDispatcher("creamenu.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error de conexión a la base de datos", e);
        }
        
        
    }

    private void cargarAlimentos(Connection conn, String categoria, List<String> lista) throws SQLException {
        String query = "SELECT nombre_alim FROM Alimentos WHERE categoria = ?;";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, categoria);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(rs.getString("nombre_alim"));
                }
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
}
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

        if (idUsuario == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No se ha encontrado el id del usuario en la sesión.");
            return;
        }

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        List<String[]> comidasList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);

            String query = "SELECT * FROM Comidas WHERE id_usuario = ?";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String[] comida = new String[9];
                comida[0] = String.valueOf(rs.getInt("id_comida"));
                comida[1] = rs.getString("proteina");
                comida[2] = rs.getString("carbohidrato");
                comida[3] = rs.getString("vitamina");
                comida[4] = rs.getString("grasa");
                comida[5] = String.valueOf(rs.getDouble("porcion_proteina"));
                comida[6] = String.valueOf(rs.getDouble("porcion_carbohidrato"));
                comida[7] = String.valueOf(rs.getDouble("porcion_vitamina"));
                comida[8] = String.valueOf(rs.getDouble("porcion_grasa"));
                comidasList.add(comida);
            }

            request.setAttribute("comidas", comidasList);

            request.getRequestDispatcher("MisDietas.jsp").forward(request, response);

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

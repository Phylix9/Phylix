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

@WebServlet(name = "GestionarDieta", urlPatterns = {"/GestionarDieta"})
public class GestionarDieta extends HttpServlet {

    String url = "jdbc:mysql://localhost/FitData";
    String user = "root";
    String password = "AT10220906";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        if (idUsuario == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No se ha encontrado el id del usuario en la sesión.");
            return;
        }

        try (Connection con = DriverManager.getConnection(url, user, password)) {
            con.setAutoCommit(false);

            try {
                eliminartodo(con, idUsuario);
                con.commit();
                response.getWriter().print("Usuario eliminado correctamente.");
            } catch (SQLException e) {
                con.rollback();
                response.getWriter().print("Error al eliminar usuario: " + e.getMessage());
                e.printStackTrace();
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
            String query = "DELETE FROM " + tabla + " WHERE id_usuario = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, idUsuario);
                stmt.executeUpdate();
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
        return "Gestiona la eliminación en cascada de un usuario y sus datos relacionados.";
    }
}

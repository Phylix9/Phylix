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
public class EliminarDieta extends HttpServlet {

    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "n0m3l0";
        
        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Login.html?error=sesion");
            return;
        }

        String idDietaPrest = request.getParameter("dietaprestid");
        String idDietaPerso = request.getParameter("dietapersoid");

        if (idDietaPrest == null && idDietaPerso == null) {
            response.getWriter().print("Error: No se proporcionó información de la dieta para eliminar.");
            return;
        }

        try (Connection con = DriverManager.getConnection(url, user, password)) {
            if (idDietaPrest != null) {
                String idDietaFinal = "Plan " + idDietaPrest;
                String query = "DELETE FROM DietaPrestUsuarios WHERE id_dietaselected = ? AND id_usuario = ?";
                try (PreparedStatement stmt = con.prepareStatement(query)) {
                    stmt.setString(1, idDietaFinal);
                    stmt.setInt(2, idUsuario);
                    int rowsAffected = stmt.executeUpdate();
                    response.getWriter().print("Dieta eliminada correctamente. Registros afectados: " + rowsAffected);
                }
            }
            
            if (idDietaPerso != null) {
                String query = "DELETE FROM Comidas WHERE nombre_dieta = ? AND id_usuario = ?";
                try (PreparedStatement stmt = con.prepareStatement(query)) {
                    stmt.setString(1, idDietaPerso);
                    stmt.setInt(2, idUsuario);
                    int rowsAffected = stmt.executeUpdate();
                    response.getWriter().print("Dieta personalizada eliminada correctamente. Registros afectados: " + rowsAffected);
                }
            }
            request.getRequestDispatcher("Perfil").forward(request, response);
        } catch (SQLException e) {
            response.getWriter().print("Error de conexión a la base de datos: " + e.getMessage());
            e.printStackTrace();
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
        return "Gestiona la eliminación de dietas prestadas o personalizadas.";
    }
}

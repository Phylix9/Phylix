package com.Phylix;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "ImagenPerfil", urlPatterns = {"/ImagenPerfil"})
public class ImagenPerfil extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        Integer idUsuario = (Integer) request.getSession().getAttribute("id_usuario");

        if (idUsuario == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No se ha encontrado el id del usuario en la sesión.");
            return;
        }

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        try (Connection con = DriverManager.getConnection(url, user, password)) {
            String sql = "SELECT imagen FROM ImagenesPerfil WHERE id_usuario = ?";
            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setInt(1, idUsuario);

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        byte[] imageData = rs.getBytes("imagen");

                        if (imageData != null && imageData.length > 0) {
                            response.setContentType("image/jpeg");
                            response.getOutputStream().write(imageData);
                        } else {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Imagen no encontrada.");
                        }
                    } else {
                        File defaultImageFile = new File("C:\\Users\\macur\\Documents\\Phylix\\Phylix\\web\\src\\perfil.png");
                        if (defaultImageFile.exists()) {
                            try (FileInputStream fis = new FileInputStream(defaultImageFile)) {
                                response.setContentType("image/png");
                                byte[] buffer = new byte[4096];
                                int bytesRead;
                                while ((bytesRead = fis.read(buffer)) != -1) {
                                    response.getOutputStream().write(buffer, 0, bytesRead);
                                }
                            }
                        } else {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Imagen por defecto no encontrada.");
                        }
                    }
                }
            } catch (SQLException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al recuperar la imagen de la base de datos.");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response); // Llamamos al método de procesamiento
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar la solicitud.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet que muestra la imagen de perfil del usuario.";
    }
}

package com.Phylix;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AnadirImagen", urlPatterns = {"/AnadirImagen"})
@MultipartConfig
public class AnadirImagen extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");

        String uploadDirectory = request.getServletContext().getRealPath("/Fotosperfil");

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        if (idUsuario == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No se ha encontrado el id del usuario en la sesión.");
            return;
        }

        Part filePart = request.getPart("archivo");

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();

            File uploadDir = new File(uploadDirectory);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File file = new File(uploadDir, fileName);
            filePart.write(file.getAbsolutePath());

            // Aquí puedes guardar la ruta relativa en la base de datos si quieres
            String rutaWeb = "Fotosperfil/" + fileName;

            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://root:YvAwfIKqPUtHThKEnCFTrKTgxZssaUIE@ballast.proxy.rlwy.net:25248/railway?useSSL=false&serverTimezone=UTC",
                    "root", "YvAwfIKqPUtHThKEnCFTrKTgxZssaUIE")) {

                // Guarda la ruta de la imagen en la base de datos (opcional)
                String sql = "UPDATE ImagenesPerfil SET ruta = ? WHERE id_usuario = ?";
                try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                    pstmt.setString(1, rutaWeb);
                    pstmt.setInt(2, idUsuario);
                    pstmt.executeUpdate();
                }

                // Recuperar medidas para el perfil
                PreparedStatement stmtMedidas = con.prepareStatement(
                    "SELECT imc_usuario, peso_usuario, altura_usuario FROM Imc WHERE id_usuario = ?");
                stmtMedidas.setInt(1, idUsuario);
                ResultSet rsMedidas = stmtMedidas.executeQuery();

                List<clases.Medidas> medidas = new ArrayList<>();
                while (rsMedidas.next()) {
                    clases.Medidas medida = new clases.Medidas();
                    medida.setImc(rsMedidas.getDouble("imc_usuario"));
                    medida.setPeso(rsMedidas.getDouble("peso_usuario"));
                    medida.setAltura(rsMedidas.getDouble("altura_usuario"));
                    medidas.add(medida);
                }

                request.setAttribute("medidas", medidas);
                request.setAttribute("fotoPerfil", rutaWeb); // Puedes mostrarla luego con <img src="${fotoPerfil}">
                request.getRequestDispatcher("Perfil.jsp").forward(request, response);

            } catch (SQLException e) {
                request.setAttribute("error", "Error en la base de datos: " + e.getMessage());
                request.getRequestDispatcher("Perfil.jsp").forward(request, response);
            }

        } else {
            request.setAttribute("error", "No se ha seleccionado ningún archivo.");
            request.getRequestDispatcher("Perfil.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Añadir Foto de Perfil";
    }
}

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

@WebServlet(name = "Registro", urlPatterns = {"/Registro"})
public class Registro extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String correo = request.getParameter("email");
        String nombre = request.getParameter("nombre");
        String contra = request.getParameter("pswd");

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        Connection con = null;
        PreparedStatement sta = null;
        ResultSet r = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);

            HttpSession session = request.getSession();

            // Verificar si el usuario ya existe
            sta = con.prepareStatement("SELECT * FROM Usuario WHERE correo_usuario = ?;");
            sta.setString(1, correo);
            r = sta.executeQuery();

            if (r.next()) {
                response.sendRedirect("Login.html?correoRegistrado=true");
            } else {
                // Registrar el nuevo usuario
                sta = con.prepareStatement("INSERT INTO Usuario (nombre_usuario, correo_usuario, contrasena_usuario) VALUES (?, ?, ?);");
                sta.setString(1, nombre);
                sta.setString(2, correo);
                sta.setString(3, contra);
                sta.executeUpdate();

                // Obtener el ID del usuario recién registrado
                sta = con.prepareStatement("SELECT id_usuario FROM Usuario WHERE correo_usuario = ?;");
                sta.setString(1, correo);
                r = sta.executeQuery();

                if (r.next()) {
                    int idUsuario = r.getInt("id_usuario");
                    session.setAttribute("id_usuario", idUsuario);
                    session.setAttribute("correo_usuario", correo);
                    session.setAttribute("nombre_usuario", nombre);
                    response.sendRedirect("Cuestionario.jsp");
                }
            }
        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().print("Error: " + e.getMessage());
        } finally {
            try {
                if (r != null) r.close();
                if (sta != null) sta.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
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
        return "Registro de nuevos usuarios";
    }
}

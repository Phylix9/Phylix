package com.Phylix;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
        String password = "n0m3l0";

        Connection con = null;
        PreparedStatement sta = null;
        ResultSet r = null;
        
        int idUsuario = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);

            if(nombre!=null && !nombre.isEmpty() && contra!=null && !contra.isEmpty()){
                try{
                    String contracifrada = hashPassword(contra);


                    sta = con.prepareStatement("SELECT * FROM Usuario WHERE correo_usuario = ?;");
                    sta.setString(1, correo);
                    r = sta.executeQuery();

                    if (r.next()) {
                        response.sendRedirect("Acceder?correoRegistrado=true");
                    } 
                    else {
                        sta = con.prepareStatement("INSERT INTO Usuario (nombre_usuario, correo_usuario, contrasena_usuario, two_factor) VALUES (?, ?, ?, ?);");
                        sta.setString(1, nombre);
                        sta.setString(2, correo);
                        sta.setString(3, contracifrada);
                        sta.setBoolean(4, false);
                        sta.executeUpdate();

                        sta = con.prepareStatement("SELECT id_usuario FROM Usuario WHERE correo_usuario = ?;");
                        sta.setString(1, correo);
                        r = sta.executeQuery();

                        if (r.next()) {
                            idUsuario = r.getInt("id_usuario");
                        }

                        HttpSession session = request.getSession();
                        session.setAttribute("id_usuario", idUsuario);
                        session.setAttribute("correo_usuario", correo);
                        session.setAttribute("nombre_usuario", nombre);
                        session.setAttribute("hashedpassword",contracifrada);

                        Cookie cookie = new Cookie("user", nombre);
                        cookie.setMaxAge(86400);
                        cookie.setHttpOnly(true);
                        cookie.setSecure(true);
                        response.addCookie(cookie);

                        response.sendRedirect("Cuestionario.jsp");
                    }
                }
                catch(NoSuchAlgorithmException exception){
                    exception.printStackTrace();
                    response.sendRedirect("login.html");
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
    
    private String hashPassword(String password) throws NoSuchAlgorithmException{
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        byte[] hash = messageDigest.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();
        for(byte byteaux : hash){
            String hexaux = Integer.toHexString(0xff & byteaux);
            if(hexaux.length()==1){
                hexString.append('0');
            }
            hexString.append(hexaux);
        }
        return hexString.toString();
    }

}



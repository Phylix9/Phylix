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


@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String correo = request.getParameter("email");
        String contra = request.getParameter("pswd");
        

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        Connection con = null;
        PreparedStatement sta = null;
        ResultSet rs = null;
        
        CuerpoCorreo cuerpo = new CuerpoCorreo();

        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);

            HttpSession session = request.getSession();
            String contraCifrada = hashPassword(contra);
            
            sta = con.prepareStatement("SELECT * FROM Usuario WHERE correo_usuario = ? AND contrasena_usuario = ?");
            sta.setString(1, correo);
            sta.setString(2, contraCifrada);
            rs = sta.executeQuery();

            if (rs.next()) {
                
                String contraGuardada = rs.getString("contrasena_usuario");
                boolean twoFactor = rs.getBoolean("two_factor");
                
                if(contraCifrada.equals(contraGuardada)){
                
                    session.setAttribute("correo_usuario", correo);
                    session.setAttribute("id_usuario", rs.getInt("id_usuario"));
                    session.setAttribute("nombre_usuario", rs.getString("nombre_usuario"));
                    session.setMaxInactiveInterval(2 * 60);
                    
                    Cookie cookie = new Cookie("user", rs.getString("nombre_usuario"));
                        cookie.setMaxAge(86400);
                        cookie.setHttpOnly(true);
                        cookie.setSecure(true);
                        response.addCookie(cookie);
                    
                    if (twoFactor==false) {
                                                
                        String codigo = GeneradorCodigo.generarCode(6);
                        session.setAttribute("codigo", codigo);
                        EnviaMail.enviaCorreo(correo, "Tu código de verificación", CuerpoCorreo.cuerpoMensaje(codigo));
                        response.sendRedirect("Autenticacion.jsp");
                        
                    } 
                    else {
                        session.setMaxInactiveInterval(2 * 60);
                        response.sendRedirect("FitData");
                    }
                    
                }
                else {
                    response.sendRedirect("Acceder?error=true");
                }   
            } 
            else {
                response.sendRedirect("Acceder?error=true");
            }

        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException | NoSuchAlgorithmException e) {
            response.getWriter().print("Error: " + e.getMessage());
        }finally {
            try {
                if (rs != null) rs.close();
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
        return "Servlet para manejo de inicio de sesión de usuarios";
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
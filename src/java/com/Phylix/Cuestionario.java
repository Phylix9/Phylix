package com.Phylix;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "Cuestionario", urlPatterns = {"/Cuestionario"})
public class Cuestionario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Integer id_usuario = (Integer) session.getAttribute("id_usuario");
        String correo = (String) session.getAttribute("correo_usuario");

        if (id_usuario == null || correo == null) {
            response.sendRedirect("Acceder?error=registro");
            return;
        }

        String nombre = request.getParameter("nombrecompleto");
        String edadStr = request.getParameter("edad");
        String sexo = request.getParameter("genero");
        String pesoStr = request.getParameter("peso");
        String alturaStr = request.getParameter("altura");
        String condicion = request.getParameter("condiciones");
        String medicamento = request.getParameter("medicamentos");
        String frecuencia = request.getParameter("actividad");
        String objetivos = request.getParameter("objetivos");
        String alergia = request.getParameter("alergias");
        String restriccion = request.getParameter("restricciones");
        String estres = request.getParameter("estres");
        String sueno = request.getParameter("suenio");

        int edad = Integer.parseInt(edadStr);
        double peso = Double.parseDouble(pesoStr);
        double altura = Double.parseDouble(alturaStr);
        
        int progreso_default = 0;
        
        Date fechaActual = new Date(System.currentTimeMillis());


        
        String url = "jdbc:mysql://ballast.proxy.rlwy.net:25248/railway?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = "YvAwfIKqPUtHThKEnCFTrKTgxZssaUIE";

        Connection con = null;
        PreparedStatement sta = null;
        PreparedStatement sta2 = null;
        ResultSet rs = null;
        
        CuerpoCorreo cuerpo = new CuerpoCorreo();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);

            sta2 = con.prepareStatement("UPDATE Usuario SET edad_usuario = ?, sexo_usuario = ?, progreso = ?, peso_inicial = ?, altura_inicial = ?, fecha_registro = ?, ultima_conexion = ? WHERE id_usuario = ?;");
            sta2.setInt(1, edad);
            sta2.setString(2, sexo);
            sta2.setInt(3,progreso_default);
            sta2.setDouble(4, peso);
            sta2.setDouble(5, altura);
            sta2.setDate(6, fechaActual); 
            sta2.setDate(7, fechaActual); 
            sta2.setInt(8, id_usuario);
            sta2.executeUpdate();
            sta2.close();
            
            sta2 = con.prepareStatement("INSERT INTO Imc(fecha, peso_usuario, altura_usuario, id_usuario) values (?,?,?,?);");
            sta2.setDate(1, fechaActual);
            sta2.setDouble(2, peso);
            sta2.setDouble(3, altura);
            sta2.setInt(4, id_usuario);
            sta2.executeUpdate();
            sta2.close();

            sta2 = con.prepareStatement("INSERT INTO IMC_Inicial(id_imcinicial, fecha_registro, peso_inicial, altura_inicial, id_usuario) values (?,?,?,?,?);");
            sta2.setInt(1, id_usuario);
            sta2.setDate(2, fechaActual);
            sta2.setDouble(3, peso);
            sta2.setDouble(4, altura);
            sta2.setInt(5, id_usuario);
            sta2.executeUpdate();
            sta2.close();
            
            sta2 = con.prepareStatement("INSERT INTO ImagenesPerfil(id_perfil, id_usuario) values (?,?);");
            sta2.setInt(1, id_usuario);
            sta2.setInt(2, id_usuario);
            sta2.executeUpdate();
            
            File defaultImageFile = new File("C:\\Users\\macur\\Documents\\Phylix\\Phylix\\web\\src\\perfil.png");
                            String sqlUpdateImagen = "UPDATE ImagenesPerfil SET imagen = ? WHERE id_usuario = ?";
                            try (FileInputStream fis = new FileInputStream(defaultImageFile);
                                 PreparedStatement stmtUpdateImagen = con.prepareStatement(sqlUpdateImagen)) {
                                stmtUpdateImagen.setBinaryStream(1, fis, (int) defaultImageFile.length());
                                stmtUpdateImagen.setInt(2, id_usuario);
                                stmtUpdateImagen.executeUpdate();
                            }
                            
            sta2.close();
            
            sta = con.prepareStatement("INSERT INTO Cuestionario (nombre_completo, condicion_usuario, "
                    + "medicamento_usuario, frecuencia_usuario, objetivo_usuario, alergias_usuario, restriccion_usuario, "
                    + "estres_usuario, sueno_usuario, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
            sta.setString(1, nombre);
            sta.setString(2, condicion);
            sta.setString(3, medicamento);
            sta.setString(4, frecuencia);
            sta.setString(5, objetivos);
            sta.setString(6, alergia);
            sta.setString(7, restriccion);
            sta.setString(8, estres);
            sta.setString(9, sueno);
            sta.setInt(10, id_usuario);

            sta.executeUpdate();


                                                
            String codigo = GeneradorCodigo.generarCode(6);
            session.setAttribute("codigo", codigo);
            
            EnviaMail.enviaCorreo(correo, "Tu código de verificación", CuerpoCorreo.cuerpoMensaje(codigo));

            session.setAttribute("edad", edad);
            session.setAttribute("sexo", sexo);
            session.setAttribute("frecuencia", frecuencia);
            session.setAttribute("objetivos", objetivos);
            session.setAttribute("alergias", alergia);
            session.setAttribute("restriccion", restriccion);
            session.setAttribute("nombre", nombre);
         
            response.sendRedirect("Autenticacion");

        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().print("Error: " + e.getMessage());
        } finally {
            try {
                if (sta != null) sta.close();
                if (sta2 != null) sta2.close();
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
        return "Registro cuestionario";
    }
}

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cuestionario</title>
    </head>
    <body>
        <%
        Integer id_usuario = (Integer) session.getAttribute("id_usuario");
        String correo = (String) session.getAttribute("correo_usuario");

        if (id_usuario == null || correo == null) {
            response.sendRedirect("Login.html");
            return;
        }
        String nombre = request.getParameter("nombre");
        String edad = request.getParameter("edad");
        String sexo = request.getParameter("genero");
        String condicion = request.getParameter("condiciones");
        String medicamento = request.getParameter("medicamentos");
        String frecuencia = request.getParameter("actividad");
        String objetivos = request.getParameter("objetivos");
        String alergia = request.getParameter("alergias");
        String restriccion = request.getParameter("restricciones");
        String estres = request.getParameter("estres");
        String sueno = request.getParameter("suenio");

        int edad = Integer.parseInt(edadStr);

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        Connection con = null;
        PreparedStatement sta = null;
        PreparedStatement sta2 = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);
            
            sta2 = con.prepareStatement("INSERT INTO Usuario (edad_usuario, sexo_usuario) VALUES (?, ?);");
            sta2.setInt(1, edad);
            sta2.setString(2, sexo);

            sta2.executeUpdate();

            sta = con.prepareStatement("INSERT INTO Cuestionario (nombre_completo, condicion_usuario, "
                    + "medicamento_usuario, frecuencia_usuario, objetivo_usuario, alergias_usuario, restriccion_usuario, "
                    + "estres_usuario, sueno_usuario, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
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
            
            out.println("<script>alert('Cuestionario enviado con éxito');</script>");
            response.sendRedirect("Proyecto.html");

        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().print("Error: " + e.getMessage());
        } finally {
            if (sta != null) sta.close();
            if (con != null) con.close();
        }
        %>
    </body>
</html>

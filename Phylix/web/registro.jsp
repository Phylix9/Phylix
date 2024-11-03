<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro</title>
    </head>
    <body>
        <%
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
            
            sta = con.prepareStatement("SELECT * FROM Usuario WHERE correo_usuario = ?;");
            sta.setString(1, correo);
            r = sta.executeQuery();
           
            if (r.next()) {
        %>
                <script>
                    alert("Correo ya registrado. Inicia sesión.");
                    window.location.href = "Login.html";
                </script>
        <%
            } else {
                sta = con.prepareStatement("INSERT INTO Usuario (nombre_usuario, correo_usuario, contrasena_usuario) VALUES (?, ?, ?);");
                sta.setString(1, nombre);
                sta.setString(2, correo);
                sta.setString(3, contra);
                sta.executeUpdate();
                sta = con.prepareStatement("SELECT id_usuario FROM Usuario WHERE correo_usuario = ?;");
                sta.setString(1, correo);
                r = sta.executeQuery();
                
                if (r.next()) {
                    session.setAttribute("id_usuario", r.getInt("id_usuario"));
                    session.setAttribute("correo", correo);
                    session.setAttribute("nombre_usuario", nombre);

                    out.println("<script>alert('Usuario registrado exitosamente');</script>");
                    response.sendRedirect("Cuestionario.html");
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
        %>
    </body>
</html>

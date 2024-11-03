<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login FitData</title>
    <link rel="stylesheet" href="Styles5.css">
</head>
<body>
    <%
    String correo = request.getParameter("email");
    String contra = request.getParameter("pswd");

    String url = "jdbc:mysql://localhost/FitData";
    String user = "root";
    String password = "AT10220906";

    Connection con = null;
    PreparedStatement sta = null;
    ResultSet r = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        sta = con.prepareStatement("SELECT * FROM Usuario WHERE correo_usuario = ? AND contrasena_usuario = ?");
        sta.setString(1, correo);
        sta.setString(2, contra);
        r = sta.executeQuery();

        if (r.next()) {
            // Utilizar la variable session disponible automáticamente
            session.setAttribute("correo_usuario", correo);
            session.setAttribute("id_usuario", r.getInt("id_usuario"));
            session.setAttribute("nombre_usuario", r.getString("nombre_usuario"));
            session.setAttribute("contrasena_usuario", contra);

            response.sendRedirect("Proyecto.html");
        } else {
    %>
        <script>
            alert("Usuario o contraseña incorrectos");
            window.location.href = "Login.html";
        </script>
    <%
        }

    } catch (Exception e) {
        response.getWriter().print("Error: " + e.getMessage());
    } finally {
        if (r != null) r.close();
        if (sta != null) sta.close();
        if (con != null) con.close();
    }
    %>
</body>
</html>

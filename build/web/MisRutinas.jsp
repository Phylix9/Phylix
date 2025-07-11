<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mis Rutinas Creadas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="image/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css">
    <link rel="stylesheet" href="Styles17.css">
</head>
<body>
    <button class="back-button" onclick="window.history.back();">
        <i class="ri-arrow-left-line"></i>
    </button>

    <h2>Mis Rutinas</h2>

<%
    Connection con = null;
    PreparedStatement stmt = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    String url = "jdbc:mysql://localhost/FitData";
    String user = "root";
    String password = "AT10220906";
    List<String[]> rutinaspredList = new ArrayList<>();
    boolean hayRutinas = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        Integer idUsuario = (Integer) session.getAttribute("id_usuario");
        if (idUsuario != null) {
            // --- Rutinas Preestablecidas ---
            String querySelect = "SELECT id_planselected, rutina_prestusers FROM RutPrestUsuarios WHERE id_usuario = ?";
            stmt = con.prepareStatement(querySelect);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            while (rs.next()) {
                if (rs.getString("id_planselected") != null) {
                    rutinaspredList.add(new String[]{rs.getString("id_planselected"), rs.getString("rutina_prestusers")});
                }
            }
 
            ps = con.prepareStatement("SELECT * FROM Rutinasper WHERE id_usuario = ?");
            ps.setInt(1, idUsuario);
            rs2 = ps.executeQuery();

            while (rs2.next()) {
                hayRutinas = true;
                String nombreRutina = rs2.getString("nombre_rutina");
%>
                <h3><%= nombreRutina %></h3>
                <table border="1">
                    <tr>
                        <th>Ejercicio</th>
                        <th>Repeticiones</th>
                    </tr>
<%
                for (int i = 1; i <= 9; i++) {
                    String ejercicio = rs2.getString("ejercicio" + i);
                    String reps = rs2.getString("reps" + i);

                    if (ejercicio != null && !ejercicio.trim().isEmpty()) {
%>
                    <tr>
                        <td><%= ejercicio %></td>
                        <td><%= (reps != null && !reps.trim().isEmpty()) ? reps : "N/A" %></td>
                    </tr>
<%
                    }
                }
%>
                </table>
                <br>
<%
            }

            if (!hayRutinas) {
%>
                <p>No se han encontrado rutinas personalizadas para este usuario.</p>
<%
            }
        } else {
%>
            <p>No se ha encontrado el usuario en sesión.</p>
<%
        }

    } catch (Exception e) {
%>
        <p>Error al obtener las rutinas: <%= e.getMessage() %></p>
<%
        e.printStackTrace();
    } finally {
        try {
            if (rs2 != null) rs2.close();
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
%>
            <p>Error al cerrar conexión: <%= e.getMessage() %></p>
<%
        }
    }
%>
</body>
</html>

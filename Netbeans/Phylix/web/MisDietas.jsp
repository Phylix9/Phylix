<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Mis Dietas</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css">
    <link rel="stylesheet" href="Styles17.css">
</head>
<body>

<button class="back-button" onclick="window.history.back();">
    <i class="ri-arrow-left-line"></i>
</button>

<h1>Mis Menús Creados</h1>

<%
    Connection con = null;
    PreparedStatement stmt = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    String url = "jdbc:mysql://localhost/FitData";
    String user = "root";
    String password = "AT10220906";
    List<String[]> dietaspredList = new ArrayList<>();
    Map<String, List<String[]>> comidasMap = new LinkedHashMap<>(); // nombre_dieta -> lista de comidas

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        if (idUsuario != null) {
            // Dietas preestablecidas
            String queryPre = "SELECT id_dietaselected, dieta_prestusers FROM DietaPrestUsuarios WHERE id_usuario = ?";
            stmt = con.prepareStatement(queryPre);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            while (rs.next()) {
                if (rs.getString("id_dietaselected") != null) {
                    dietaspredList.add(new String[]{rs.getString("id_dietaselected"), rs.getString("dieta_prestusers")});
                }
            }
            rs.close();
            stmt.close();

            // Comidas personalizadas
            String queryComidas = "SELECT * FROM Comidas WHERE id_usuario = ? ORDER BY nombre_dieta, id_comida";
            ps = con.prepareStatement(queryComidas);
            ps.setInt(1, idUsuario);
            rs2 = ps.executeQuery();

            while (rs2.next()) {
                String nombreDieta = rs2.getString("nombre_dieta");
                String[] comida = {
                    rs2.getString("proteina"),
                    String.valueOf(rs2.getInt("porcion_proteina")),
                    rs2.getString("carbohidrato"),
                    String.valueOf(rs2.getInt("porcion_carbohidrato")),
                    rs2.getString("grasa"),
                    String.valueOf(rs2.getInt("porcion_grasa")),
                    rs2.getString("vitamina"),
                    String.valueOf(rs2.getInt("porcion_vitamina"))
                };
                comidasMap.computeIfAbsent(nombreDieta, k -> new ArrayList<>()).add(comida);
            }
        }
    } catch (Exception e) {
%>
    <p>Error al obtener dietas: <%= e.getMessage() %></p>
<%
        e.printStackTrace();
    } finally {
        try {
            if (rs2 != null) rs2.close();
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
%>
    <p>Error al cerrar la base: <%= e.getMessage() %></p>
<%
        }
    }
%>


<% if (!comidasMap.isEmpty()) {
    for (Map.Entry<String, List<String[]>> entry : comidasMap.entrySet()) {
        String nombreDieta = entry.getKey();
        List<String[]> comidas = entry.getValue();
%>
    <h3><%= nombreDieta %></h3>
    <table border="1">
        <tr>
            <th>No. de Comida</th>
            <th>Proteína</th>
            <th>Porción Proteína</th>
            <th>Carbohidrato</th>
            <th>Porción Carbohidrato</th>
            <th>Grasa</th>
            <th>Porción Grasa</th>
            <th>Micronutriente</th>
            <th>Porción Vitamina</th>
        </tr>
    <%
        int comidaIndex = 1;
        for (String[] c : comidas) {
    %>
        <tr>
            <td><%= comidaIndex++ %></td>
            <td><%= c[0] %></td>
            <td><%= c[1] %></td>
            <td><%= c[2] %></td>
            <td><%= c[3] %></td>
            <td><%= c[4] %></td>
            <td><%= c[5] %></td>
            <td><%= c[6] %></td>
            <td><%= c[7] %></td>
        </tr>
    <%
        }
    %>
    </table><br>
<%
    }
} else {
%>
    <p>No se han encontrado comidas personalizadas para este usuario.</p>
<% } %>

</body>
</html>

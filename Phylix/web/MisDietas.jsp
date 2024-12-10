<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
        ResultSet rs = null;
        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "n0m3l0";
        List<String[]> dietaspredList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);

            Integer idUsuario = (Integer) session.getAttribute("id_usuario");
            if (idUsuario != null) {
                String querySelect = "SELECT id_dietaselected, dieta_prestusers FROM DietaPrestUsuarios WHERE id_usuario = ?;";
                stmt = con.prepareStatement(querySelect);
                stmt.setInt(1, idUsuario);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    if(rs.getString("id_dietaselected") != null){
                        dietaspredList.add(new String[]{rs.getString("id_dietaselected"), rs.getString("dieta_prestusers")});
                    }
                }
            }
        } catch (Exception e) {
            out.println("<p>Error al obtener dietas de la base: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                out.println("<p>Error en la base " + e.getMessage() + "</p>");
            }
        }
    %>

    <%
        if (dietaspredList != null && !dietaspredList.isEmpty()) {
    %>
        <h3>Dietas Preestablecidas</h3>
        <table border="1">
            <tr>
                <th>No. de Plan</th>
                <th>Dieta</th>
            </tr>

            <%
                for (String[] dieta : dietaspredList) {
                    String id = dieta[0];
                    String plan = dieta[1];

                    if (id != null && !id.isEmpty()) {
            %>
                <tr>
                    <td><%= id %></td>
                    <td><%= plan %></td>
                </tr>
            <%
                    }
                }
            %>
        </table>
    <% } else { %>
        <p>No se han encontrado dietas pre-establecidas seleccionadas para este usuario.</p>
    <% } %>
    
    <%
        List<String[]> comidasList = (List<String[]>) request.getAttribute("comidas");
        List<String[]> nombres = (List<String[]>) request.getAttribute("nombres");

        if (comidasList != null && !comidasList.isEmpty()) {
            int dietaIndex = 0;
            int comidaIndex = 1;
    %>

    <%
        for (int i = 0; i < comidasList.size(); i++) {
            if (i % 5 == 0) { 
                comidaIndex = 1; 
                if (i > 0) {
                    dietaIndex++;
    %>
                    </table>
    <%
                }
    %>
                <table border="1">
                    <h3><%=nombres.get(dietaIndex)[0]%></h3>
                    <tr>
                        <th>No. de Comida</th>
                        <th>Proteína</th>
                        <th>Porción Proteína </th>
                        <th>Carbohidrato</th>
                        <th>Porción Carbohidrato</th>
                        <th>Grasa</th>
                        <th>Porción Grasa</th>
                        <th>Vitamina</th>
                        <th>Porción Vitamina</th>
                    </tr>
    <%
            }
            String[] comida = comidasList.get(i);
    %>
            <tr>
                <td><%= comidaIndex++ %></td> 
                <td><%= comida[1] %></td>
                <td><%= comida[2] %></td>
                <td><%= comida[3] %></td>
                <td><%= comida[4] %></td>
                <td><%= comida[5] %></td>
                <td><%= comida[6] %></td>
                <td><%= (comida.length > 7 ? comida[7] : "") %></td>
                <td><%= (comida.length > 8 ? comida[8] : "") %></td>
            </tr>
    <%
        }
    %>
    </table>
    
    <%
        } else {
    %>
        <p>No se han encontrado comidas para este usuario.</p>
    <%
        }
    %>

</body>
</html>

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
        ResultSet rs = null;
        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";
        List<String[]> rutinaspredList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);

            Integer idUsuario = (Integer) session.getAttribute("id_usuario");
            if (idUsuario != null) {
                String querySelect = "SELECT id_planselected, rutina_prestusers FROM RutPrestUsuarios WHERE id_usuario = ?;";
                stmt = con.prepareStatement(querySelect);
                stmt.setInt(1, idUsuario);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    if(rs.getString("id_planselected")!=null){
                    rutinaspredList.add(new String[]{rs.getString("id_planselected"), rs.getString("rutina_prestusers")});
                    }else{
                        rutinaspredList.clear();
                     }
                }
            }
        } catch (Exception e) {
            out.println("<p>Error al obtener rutinas de la base: " + e.getMessage() + "</p>");
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

    <% if (!rutinaspredList.isEmpty()) { %>
        <h3>Rutinas Preestablecidas</h3>
        <table border="1">
            <tr>
                <th>ID Plan</th>
                <th>Plan</th>
            </tr>

            <%
                for (String[] rutina : rutinaspredList) {
                    String id = rutina[0];
                    String plan = rutina[1];

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
        <p>No se han encontrado rutinas pre-establecidas seleccionadas para este usuario.</p>
    <% } %>
    
    <%
    List<String[]> rutinasList = (List<String[]>) request.getAttribute("rutinas");
    List<String[]> nombres = (List<String[]>) request.getAttribute("nombres");

    if (rutinasList != null && !rutinasList.isEmpty()) {
        int rutinaIndex = -1;

        for (String[] rutina : rutinasList) {
            boolean rutinaVacia = true;
            
            for (int i = 0; i < rutina.length; i += 2) {
                if (rutina[i] != null && !rutina[i].isEmpty()) {
                    rutinaVacia = false;
                    break;
                }
            }
            if (rutinaVacia) {
                continue;
            }
            rutinaIndex++;

%>
            <h3><%=nombres.get(rutinaIndex)[0]%></h3>
            <table border="1">
                <tr>
                    <th>Ejercicio</th>
                    <th>Repeticiones</th>
                </tr>

                <%
                    for (int i = 0; i < rutina.length; i += 2) {
                        String ejercicio = rutina[i];
                        String repeticiones = i + 1 < rutina.length ? rutina[i + 1] : null;
                        
                        if (ejercicio != null && !ejercicio.isEmpty()) {
                %>
                    <tr>
                        <td><%= ejercicio %></td>
                        <td><%= (repeticiones != null && !repeticiones.isEmpty()) ? repeticiones : "N/A" %></td>
                    </tr>
                <%
                        }
                    }
                %>
            </table>
            <br>
<%
        }
    } else {
%>
    <p>No se han encontrado rutinas personalizadas para este usuario.</p>
<%
    }
%>

        
</body>
</html>

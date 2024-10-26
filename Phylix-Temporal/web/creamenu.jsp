<%-- 
    Document   : creamenu
    Created on : Oct 25, 2024, 9:53:21 PM
    Author     : Abraham
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear tu Menú</title>
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
    int id_usuario = 1;

    // Variables para almacenar alimentos por categoría
    List<String> proteinas = new ArrayList<>();
    List<String> carbohidratos = new ArrayList<>();
    List<String> vitaminasMinerales = new ArrayList<>();
    List<String> grasas = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        con = DriverManager.getConnection(url, user, password);

        sta = con.prepareStatement("SELECT * FROM Usuario WHERE id_usuario = ?;");
            sta.setInt(1, id_usuario);
            r = sta.executeQuery();
            
        if (r.next()) {
            id_usuario = r.getInt("id_usuario");
            String queryAlimentos = "SELECT nombre_alim, porcion_alim, categoria FROM Alimentos WHERE id_usuario = ?";
            sta = con.prepareStatement(queryAlimentos);
            sta.setInt(1, id_usuario);
            r = sta.executeQuery();
            
            while (r.next()) {
                String alimento = r.getString("nombre_alim") + " - " + r.getString("porcion_alim");
                String categoria = r.getString("categoria");
                switch (categoria) {
                    case "Proteína":
                        proteinas.add(alimento);
                        break;
                    case "Carbohidrato":
                        carbohidratos.add(alimento);
                        break;
                    case "Vitamina":
                        vitaminasMinerales.add(alimento);
                        break;
                    case "Grasa":
                        grasas.add(alimento);
                        break;
                }
            }
        } else {
            response.getWriter().print("Usuario no encontrado o credenciales incorrectas.");
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

    boolean enviado = request.getParameter("proteina1") != null;
%>

<% if (!enviado) { %>
    <!-- Formulario para Crear Menú -->
    <h1>Crear tu Menú</h1>
    <form action="" method="post">
        <!-- Comida 1 -->
        <h3>Comida 1</h3>
        <label for="proteina1">Elige tu Proteína:</label>
        <select name="proteina1" id="proteina1">
            <option value="">Selecciona una proteína</option> <!-- Opción por default -->
            <% for (String proteina : proteinas) { %>
                <option value="<%= proteina %>"><%= proteina %> g</option>
            <% } %>
        </select>

        <label for="carbohidrato1">Elige tu Carbohidrato:</label>
        <select name="carbohidrato1" id="carbohidrato1">
            <option value="">Selecciona un carbohidrato</option> <!-- Opción por default -->
            <% for (String carbohidrato : carbohidratos) { %>
                <option value="<%= carbohidrato %>"><%= carbohidrato %> g</option>
            <% } %>
        </select>

        <label for="vitaminasMinerales1">Elige tus micronutrientes:</label>
        <select name="vitaminasMinerales1" id="vitaminasMinerales1">
            <option value="">Selecciona un micronutriente</option> <!-- Opción por default -->
            <% for (String vitamina : vitaminasMinerales) { %>
                <option value="<%= vitamina %>"><%= vitamina %> g</option>
            <% } %>
        </select>

        <label for="grasa1">Elige tu grasa:</label>
        <select name="grasa1" id="grasa1">
            <option value="">Selecciona una grasa</option> <!-- Opción por default -->
            <% for (String grasa : grasas) { %>
                <option value="<%= grasa %>"><%= grasa %> g</option>
            <% } %>
        </select>

        <!-- Repetimos para las demás comidas -->
        <% for (int i = 2; i <= 5; i++) { %>
            <h3>Comida <%= i %></h3>
            <label for="proteina<%= i %>">Proteína:</label>
            <select name="proteina<%= i %>" id="proteina<%= i %>">
                <option value="">Selecciona una proteína</option> <!-- Opción por default -->
                <% for (String proteina : proteinas) { %>
                    <option value="<%= proteina %>"><%= proteina %> g</option>
                <% } %>
            </select>

            <label for="carbohidrato<%= i %>">Carbohidrato:</label>
            <select name="carbohidrato<%= i %>" id="carbohidrato<%= i %>">
                <option value="">Selecciona un carbohidrato</option> <!-- Opción por default -->
                <% for (String carbohidrato : carbohidratos) { %>
                    <option value="<%= carbohidrato %>"><%= carbohidrato %> g</option>
                <% } %>
            </select>

            <label for="vitaminasMinerales<%= i %>">Vitaminas y Minerales:</label>
            <select name="vitaminasMinerales<%= i %>" id="vitaminasMinerales<%= i %>">
                <option value="">Selecciona un micronutriente</option> <!-- Opción por default -->
                <% for (String vitamina : vitaminasMinerales) { %>
                    <option value="<%= vitamina %>"><%= vitamina %> g</option>
                <% } %>
            </select>

            <label for="grasa<%= i %>">Grasas:</label>
            <select name="grasa<%= i %>" id="grasa<%= i %>">
                <option value="">Selecciona una grasa</option> <!-- Opción por default -->
                <% for (String grasa : grasas) { %>
                    <option value="<%= grasa %>"><%= grasa %> g</option>
                <% } %>
            </select>
        <% } %>

        <br><br>
        <input type="submit" value="Crear Menú">
    </form>

<% } else { %>
    <!-- Mostrar el menú seleccionado -->
    <h1>Tu Menú</h1>
    <ul>
        <% for (int i = 1; i <= 5; i++) { %>
            <li>Comida <%= i %>:
                <ul>
                    <li>Proteína: <%= request.getParameter("proteina" + i) %> g</li>
                    <li>Carbohidrato: <%= request.getParameter("carbohidrato" + i) %> g</li>
                    <li>Vitaminas y Minerales: <%= request.getParameter("vitaminasMinerales" + i) %> g</li>
                    <li>Grasas: <%= request.getParameter("grasa" + i) %> g</li>
                </ul>
            </li>
        <% } %>
    </ul>
    <br>
    <a href="">Volver a crear menú</a>
<% } %>

</body>
</html>

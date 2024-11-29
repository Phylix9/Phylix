<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <title>Crear tu Menú</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css">
    <link rel="stylesheet" href="Styles15.css">
</head>
<body>

    <h1>Crear tu Menú <%=session.getAttribute("id_usuario")%></h1>
<form action="CalculoComidas" method="post">

    <% 
        List<String> proteinas = (List<String>) request.getAttribute("proteinas");
        List<String> carbohidratos = (List<String>) request.getAttribute("carbohidratos");
        List<String> vitaminasMinerales = (List<String>) request.getAttribute("vitaminasMinerales");
        List<String> grasas = (List<String>) request.getAttribute("grasas");

        int numComidas = 5;
    %>

    <% if (proteinas != null && carbohidratos != null && vitaminasMinerales != null && grasas != null) { %>
        <% for (int i = 1; i <= numComidas; i++) { %>
            <h3>Comida <%= i %></h3>

            <label for="proteina<%= i %>">Elige tu Proteína:</label>
            <select name="proteina<%= i %>" id="proteina<%= i %>">
                <option value="">Selecciona una proteína</option>
                <% for (String proteina : proteinas) { %>
                    <option value="<%= proteina %>"><%= proteina %></option>
                <% } %>
            </select>

            <label for="carbohidrato<%= i %>">Elige tu Carbohidrato:</label>
            <select name="carbohidrato<%= i %>" id="carbohidrato<%= i %>">
                <option value="">Selecciona un carbohidrato</option>
                <% for (String carbohidrato : carbohidratos) { %>
                    <option value="<%= carbohidrato %>"><%= carbohidrato %></option>
                <% } %>
            </select>

            <label for="vitaminasMinerales<%= i %>">Elige tus micronutrientes:</label>
            <select name="vitaminasMinerales<%= i %>" id="vitaminasMinerales<%= i %>">
                <option value="">Selecciona un micronutriente</option>
                <% for (String vitamina : vitaminasMinerales) { %>
                    <option value="<%= vitamina %>"><%= vitamina %></option>
                <% } %>
            </select>

            <label for="grasa<%= i %>">Elige tu grasa:</label>
            <select name="grasa<%= i %>" id="grasa<%= i %>">
                <option value="">Selecciona una grasa</option>
                <% for (String grasa : grasas) { %>
                    <option value="<%= grasa %>"><%= grasa %></option>
                <% } %>
            </select>

            <br><br>
        <% } %>
    <% } else { %>
        <p>No se encontraron alimentos para este usuario.</p>
    <% } %>

    <input type="submit" value="Crear Menú">
</form>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <title>Crear tu Menú</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.4.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="Styles15M.css">
</head>
<body>

    <button class="back-button" onclick="location.href='Dietas'">
        <i class="ri-arrow-left-line"></i>
    </button>
    
    <h1>Crea tu Menú <%=session.getAttribute("nombre_usuario")%></h1>
    <form action="CalculoComidas" method="post">
    
    <h3>Asigna nombre a tu dieta</h3>
    <input type="text" name="nombreDieta" id="nombreDieta">

    <% 
        List<String> proteinas = (List<String>) request.getAttribute("proteinas");
        List<String> carbohidratos = (List<String>) request.getAttribute("carbohidratos");
        List<String> vitaminasMinerales = (List<String>) request.getAttribute("vitaminasMinerales");
        List<String> grasas = (List<String>) request.getAttribute("grasas");

        int numComidas = 5;
    %>

    <% if (proteinas != null && carbohidratos != null && vitaminasMinerales != null && grasas != null) { %>
        <% for (int i = 1; i <= numComidas; i++) { %>
            <h3><i class="ri-restaurant-2-fill">Comida <%= i %></i></h3>

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

    <div class="center-container">
            <h3>Selecciona el día de la semana</h3>
            <div class="styled-select">
                <select name="diaComida" required>
                    <%
                        List<String> diasDisponibles = (List<String>) request.getAttribute("diasDisponibles");

                        if (diasDisponibles != null && !diasDisponibles.isEmpty()) {
                            for (String dia : diasDisponibles) {
                    %>
                                <option value="<%= dia %>">
                                    <%= dia.substring(0,1).toUpperCase() + dia.substring(1).toLowerCase() %>
                                </option>
                    <%
                            }
                        } else {
                    %>
                        <option disabled selected>No hay días disponibles</option>
                    <%
                        }
                    %>
                </select>
            </div>
        </div>
    <input type="submit" value="Crear Menú">
</form>

</body>
</html>

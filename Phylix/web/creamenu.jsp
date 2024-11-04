<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear tu Menú</title>
</head>
<body>

<h1>Crear tu Menú</h1>
<form action="CalculoComidas" method="post">

    <% 
        List<String> proteinas = (List<String>) request.getAttribute("proteinas");
        List<String> carbohidratos = (List<String>) request.getAttribute("carbohidratos");
        List<String> vitaminasMinerales = (List<String>) request.getAttribute("vitaminasMinerales");
        List<String> grasas = (List<String>) request.getAttribute("grasas");
    %>

    <% if (proteinas != null && carbohidratos != null && vitaminasMinerales != null && grasas != null) { %>
        <h3>Comida 1</h3>
        <label for="proteina1">Elige tu Proteína:</label>
        <select name="proteina1" id="proteina1">
            <option value="">Selecciona una proteína</option>
            <% for (String proteina : proteinas) { %>
                <option value="<%= proteina %>"><%= proteina %></option>
            <% } %>
        </select>

        <label for="carbohidrato1">Elige tu Carbohidrato:</label>
        <select name="carbohidrato1" id="carbohidrato1">
            <option value="">Selecciona un carbohidrato</option>
            <% for (String carbohidrato : carbohidratos) { %>
                <option value="<%= carbohidrato %>"><%= carbohidrato %></option>
            <% } %>
        </select>

        <label for="vitaminasMinerales1">Elige tus micronutrientes:</label>
        <select name="vitaminasMinerales1" id="vitaminasMinerales1">
            <option value="">Selecciona un micronutriente</option>
            <% for (String vitamina : vitaminasMinerales) { %>
                <option value="<%= vitamina %>"><%= vitamina %></option>
            <% } %>
        </select>

        <label for="grasa1">Elige tu grasa:</label>
        <select name="grasa1" id="grasa1">
            <option value="">Selecciona una grasa</option>
            <% for (String grasa : grasas) { %>
                <option value="<%= grasa %>"><%= grasa %></option>
            <% } %>
        </select>

    <% } else { %>
        <p>No se encontraron alimentos para este usuario.</p>
    <% } %>

    <% if (proteinas != null && carbohidratos != null && vitaminasMinerales != null && grasas != null) { %>
        <h3>Comida 2</h3>
        <label for="proteina2">Elige tu Proteína:</label>
        <select name="proteina2" id="proteina2">
            <option value="">Selecciona una proteína</option>
            <% for (String proteina : proteinas) { %>
                <option value="<%= proteina %>"><%= proteina %></option>
            <% } %>
        </select>

        <label for="carbohidrato2">Elige tu Carbohidrato:</label>
        <select name="carbohidrato2" id="carbohidrato2">
            <option value="">Selecciona un carbohidrato</option>
            <% for (String carbohidrato : carbohidratos) { %>
                <option value="<%= carbohidrato %>"><%= carbohidrato %></option>
            <% } %>
        </select>

        <label for="vitaminasMinerales2">Elige tus micronutrientes:</label>
        <select name="vitaminasMinerales2" id="vitaminasMinerales2">
            <option value="">Selecciona un micronutriente</option>
            <% for (String vitamina : vitaminasMinerales) { %>
                <option value="<%= vitamina %>"><%= vitamina %></option>
            <% } %>
        </select>

        <label for="grasa2">Elige tu grasa:</label>
        <select name="grasa2" id="grasa2">
            <option value="">Selecciona una grasa</option>
            <% for (String grasa : grasas) { %>
                <option value="<%= grasa %>"><%= grasa %></option>
            <% } %>
        </select>

    <% } else { %>
        <p>No se encontraron alimentos para este usuario.</p>
    <% } %>
    
    <% if (proteinas != null && carbohidratos != null && vitaminasMinerales != null && grasas != null) { %>
        <h3>Comida 3</h3>
        <label for="proteina3">Elige tu Proteína:</label>
        <select name="proteina3" id="proteina3">
            <option value="">Selecciona una proteína</option>
            <% for (String proteina : proteinas) { %>
                <option value="<%= proteina %>"><%= proteina %></option>
            <% } %>
        </select>

        <label for="carbohidrato3">Elige tu Carbohidrato:</label>
        <select name="carbohidrato3" id="carbohidrato3">
            <option value="">Selecciona un carbohidrato</option>
            <% for (String carbohidrato : carbohidratos) { %>
                <option value="<%= carbohidrato %>"><%= carbohidrato %></option>
            <% } %>
        </select>

        <label for="vitaminasMinerales3">Elige tus micronutrientes:</label>
        <select name="vitaminasMinerales3" id="vitaminasMinerales3">
            <option value="">Selecciona un micronutriente</option>
            <% for (String vitamina : vitaminasMinerales) { %>
                <option value="<%= vitamina %>"><%= vitamina %></option>
            <% } %>
        </select>

        <label for="grasa3">Elige tu grasa:</label>
        <select name="grasa3" id="grasa3">
            <option value="">Selecciona una grasa</option>
            <% for (String grasa : grasas) { %>
                <option value="<%= grasa %>"><%= grasa %></option>
            <% } %>
        </select>

    <% } else { %>
        <p>No se encontraron alimentos para este usuario.</p>
    <% } %>
    
    <% if (proteinas != null && carbohidratos != null && vitaminasMinerales != null && grasas != null) { %>
        <h3>Comida 4</h3>
        <label for="proteina4">Elige tu Proteína:</label>
        <select name="proteina4" id="proteina4">
            <option value="">Selecciona una proteína</option>
            <% for (String proteina : proteinas) { %>
                <option value="<%= proteina %>"><%= proteina %></option>
            <% } %>
        </select>

        <label for="carbohidrato4">Elige tu Carbohidrato:</label>
        <select name="carbohidrato4" id="carbohidrato4">
            <option value="">Selecciona un carbohidrato</option>
            <% for (String carbohidrato : carbohidratos) { %>
                <option value="<%= carbohidrato %>"><%= carbohidrato %></option>
            <% } %>
        </select>

        <label for="vitaminasMinerales4">Elige tus micronutrientes:</label>
        <select name="vitaminasMinerales4" id="vitaminasMinerales4">
            <option value="">Selecciona un micronutriente</option>
            <% for (String vitamina : vitaminasMinerales) { %>
                <option value="<%= vitamina %>"><%= vitamina %></option>
            <% } %>
        </select>

        <label for="grasa4">Elige tu grasa:</label>
        <select name="grasa4" id="grasa4">
            <option value="">Selecciona una grasa</option>
            <% for (String grasa : grasas) { %>
                <option value="<%= grasa %>"><%= grasa %></option>
            <% } %>
        </select>

    <% } else { %>
        <p>No se encontraron alimentos para este usuario.</p>
    <% } %>
    
    <% if (proteinas != null && carbohidratos != null && vitaminasMinerales != null && grasas != null) { %>
        <h3>Comida 5</h3>
        <label for="proteina5">Elige tu Proteína:</label>
        <select name="proteina5" id="proteina5">
            <option value="">Selecciona una proteína</option>
            <% for (String proteina : proteinas) { %>
                <option value="<%= proteina %>"><%= proteina %></option>
            <% } %>
        </select>

        <label for="carbohidrato5">Elige tu Carbohidrato:</label>
        <select name="carbohidrato5" id="carbohidrato5">
            <option value="">Selecciona un carbohidrato</option>
            <% for (String carbohidrato : carbohidratos) { %>
                <option value="<%= carbohidrato %>"><%= carbohidrato %></option>
            <% } %>
        </select>

        <label for="vitaminasMinerales5">Elige tus micronutrientes:</label>
        <select name="vitaminasMinerales5" id="vitaminasMinerales5">
            <option value="">Selecciona un micronutriente</option>
            <% for (String vitamina : vitaminasMinerales) { %>
                <option value="<%= vitamina %>"><%= vitamina %></option>
            <% } %>
        </select>

        <label for="grasa5">Elige tu grasa:</label>
        <select name="grasa5" id="grasa5">
            <option value="">Selecciona una grasa</option>
            <% for (String grasa : grasas) { %>
                <option value="<%= grasa %>"><%= grasa %></option>
            <% } %>
        </select>

    <% } else { %>
        <p>No se encontraron alimentos para este usuario.</p>
    <% } %>
    <br><br>
    <input type="submit" value="Crear Menú">
</form>

</body>
</html>

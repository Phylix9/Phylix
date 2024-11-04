<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Menú Personalizado</title>
</head>
<body>

<h1>Menú Personalizado</h1>

<h2>Alimentos Seleccionados</h2>

<% 
    List<String> proteinas = (List<String>) request.getAttribute("proteinas");
    List<String> carbohidratos = (List<String>) request.getAttribute("carbohidratos");
    List<String> vitaminasMinerales = (List<String>) request.getAttribute("vitaminasMinerales");
    List<String> grasas = (List<String>) request.getAttribute("grasas");
    
    int porcionProteina = (int) request.getAttribute("porcionProteina");
    int porcionCarbohidrato = (int) request.getAttribute("porcionCarbohidrato");
    int porcionGrasas = (int) request.getAttribute("porcionGrasas");
%>

<h3>Proteínas</h3>
<ul>
    <% for (String proteina : proteinas) { %>
        <li><%= proteina %> - <%= porcionProteina %> gramos</li>
    <% } %>
</ul>

<h3>Carbohidratos</h3>
<ul>
    <% for (String carbohidrato : carbohidratos) { %>
        <li><%= carbohidrato %> - <%= porcionCarbohidrato %> gramos</li>
    <% } %>
</ul>

<h3>Vitaminas y Minerales</h3>
<ul>
    <% for (String vitamina : vitaminasMinerales) { %>
        <li><%= vitamina %></li>
    <% } %>
</ul>

<h3>Grasas</h3>
<ul>
    <% for (String grasa : grasas) { %>
        <li><%= grasa %> - <%= porcionGrasas %> gramos</li>
    <% } %>
</ul>

</body>
</html>

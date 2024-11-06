<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
<head>
        <title>Menu Personalizado</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css">
    <link rel="stylesheet" href="Styles16.css">
</head>
<body>

<h1>Menú Personalizado</h1>

<h2>Alimentos Seleccionados</h2>

<% 
    String[] proteinasSeleccionadas = (String[]) request.getAttribute("proteinasComida");
    Integer porcionProteina = (Integer) request.getAttribute("porcionProteinaComida");
    
    String[] carbohidratosSeleccionados = (String[]) request.getAttribute("carbohidratosComida");
    Integer porcionCarbohidrato = (Integer) request.getAttribute("porcionCarbohidratoComida");
    
    String[] vitaminasSeleccionadas = (String[]) request.getAttribute("vitaminasComida");
    Integer porcionVitamina = (Integer) request.getAttribute("porcionVitaminasComida");
    
    String[] grasasSeleccionadas = (String[]) request.getAttribute("grasasComida");
    Integer porcionGrasa = (Integer) request.getAttribute("porcionGrasasComida");
    
    int numComidas = 5;  // Ajusta según la cantidad de comidas que deseas mostrar
%>

<% for (int i = 0; i < numComidas; i++) { %>
    <h3>Comida <%= (i + 1) %></h3>
    <ul>
        <% 
            if (proteinasSeleccionadas != null && i < proteinasSeleccionadas.length) { 
                String proteina = proteinasSeleccionadas[i];
        %>
                <li><%= proteina != null ? proteina : "No seleccionada" %> - <%= porcionProteina %> gramos</li>
        <% 
            } else { 
        %>
            <p>No se seleccionó una proteína para esta comida.</p>
        <% } %>

        <% 
            if (carbohidratosSeleccionados != null && i < carbohidratosSeleccionados.length) { 
                String carbohidrato = carbohidratosSeleccionados[i];
        %>
                <li><%= carbohidrato != null ? carbohidrato : "No seleccionada" %> - <%= porcionCarbohidrato %> gramos</li>
        <% 
            } else { 
        %>
            <p>No se seleccionó un carbohidrato para esta comida.</p>
        <% } %>
        <% 
            if (vitaminasSeleccionadas != null && i < vitaminasSeleccionadas.length) { 
                String vitamina = vitaminasSeleccionadas[i];
        %>
                <li><%= vitamina != null ? vitamina : "No seleccionada" %> - <%= porcionVitamina %> gramos</li>
        <% 
            } else { 
        %>
            <p>No se seleccionó una vitamina/mineral para esta comida.</p>
        <% } %>
        
        <% 
            if (grasasSeleccionadas != null && i < grasasSeleccionadas.length) { 
                String grasa = grasasSeleccionadas[i];
        %>
                <li><%= grasa != null ? grasa : "No seleccionada" %> - <%= porcionGrasa %> gramos</li>
        <% 
            } else { 
        %>
            <p>No se seleccionó una grasa para esta comida.</p>
        <% } %>
    </ul>
    <br>
<% } %>

</body>
</html>

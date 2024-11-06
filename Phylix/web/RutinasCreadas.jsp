<%-- 
    Document   : RutinasCreadas
    Created on : Nov 4, 2024, 5:54:55 PM
    Author     : Abraham
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Rutina Personalizada</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css">
    <link rel="stylesheet" href="Styles16.css">
</head>
<body>

    <%
        String[] ejercicios1 = (String[]) request.getAttribute("ejercicios1");
        String[] ejercicios2 = (String[]) request.getAttribute("ejercicios2");
        String[] ejercicios3 = (String[]) request.getAttribute("ejercicios3");
        String[] grupos = (String[]) request.getAttribute("gruposEjercicios");

        Integer edad = (Integer) request.getAttribute("edad");
        String sexo = (String) request.getAttribute("sexo");
        String objetivos = (String) request.getAttribute("objetivos");
        String frecuencia = (String) request.getAttribute("frecuencia");
    %>

    <h1>Rutina Personalizada</h1>
    
    <h2>Información del Usuario</h2>
    <p><strong>Edad:</strong> <%= edad %></p>
    <p><strong>Sexo:</strong> <%= sexo %></p>
    <p><strong>Objetivo:</strong> <%= objetivos %></p>
    <p><strong>Frecuencia:</strong> <%= frecuencia %></p>

    <h2>Ejercicios Seleccionados para <%= grupos[0]%></h2>
    <ul>
        <% 
            for (String ejercicio : ejercicios1) { 
                if (ejercicio != null) { 
        %>
            <li><%= ejercicio %></li>
        <% 
                } 
            } 
        %>
    </ul>

    <h2>Ejercicios Seleccionados para <%= grupos[1]%></h2>
    <ul>
        <% 
            for (String ejercicio : ejercicios2) { 
                if (ejercicio != null) { 
        %>
            <li><%= ejercicio %></li>
        <% 
                } 
            } 
        %>
    </ul>

    <h2>Ejercicio Seleccionado para <%= grupos[2]%></h2>
    <ul>
        <% 
            for (String ejercicio : ejercicios3) { 
                if (ejercicio != null) { 
        %>
            <li><%= ejercicio %></li>
        <% 
                } 
            } 
        %>
    </ul>

</body>
</html>

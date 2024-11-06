<%-- 
    Document   : RutinasCreadas
    Created on : Nov 4, 2024, 5:54:55 PM
    Author     : Abraham
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rutina Creada</title>
</head>
<body>

    <%
        String[] ejercicios1 = (String[]) request.getAttribute("ejercicios1");
        String[] ejercicios2 = (String[]) request.getAttribute("ejercicios2");
        String[] ejercicios3 = (String[]) request.getAttribute("ejercicios3");
        String[] grupos = (String[]) request.getAttribute("gruposEjercicios");

        Integer edad = (Integer) request.getAttribute("edad");
        String sexo = (String) session.getAttribute("sexo");
        String objetivos = (String) session.getAttribute("objetivos");
        String frecuencia = (String) session.getAttribute("frecuencia");
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

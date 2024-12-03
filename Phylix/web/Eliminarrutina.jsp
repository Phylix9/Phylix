<%-- 
    Document   : Eliminardieta
    Created on : Dec 2, 2024, 9:15:25 AM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="EliminarRutina" method="post">
            <h2> Ingresa el número de plan de ejercicio que quieres eliminar </h2>
            <input type="text"  name="rutinaprestid">
            <button type="submit">Enviar</button>
        </form>
        
        <form action="EliminarRutina" method="post">
            <h2> Ingresa el nombre de la dieta personalizada que quieres eliminar </h2>
            <input type="text"  name="rutinapersoid">
            <button type="submit">Enviar</button>
        </form>
    </body>
</html>

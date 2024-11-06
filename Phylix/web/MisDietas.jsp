<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mis Menús Creados</title>
</head>
<body>
    <h1>Mis Menús Creados</h1>

    <%
        // Obtener la lista de comidas desde el request
        List<String[]> comidasList = (List<String[]>) request.getAttribute("comidas");

        if (comidasList != null && !comidasList.isEmpty()) {
            int dietaIndex = 1;  // Índice para "Dieta i"
    %>

    <%
        // Comienza la primera tabla
        // Recorremos la lista de comidas e imprimimos los elementos
        for (int i = 0; i < comidasList.size(); i++) {
            if (i % 5 == 0) {
                // Si el índice es múltiplo de 5, cerramos la tabla anterior y comenzamos una nueva
                if (i > 0) {
    %>
                    </table>  <!-- Cerrar la tabla anterior -->
                <%
                }

    %>
                <h2>Dieta <%= dietaIndex++ %></h2>
                <table border="1">
                    <tr>
                        <th>ID Comida</th>
                        <th>Proteína</th>
                        <th>Carbohidrato</th>
                        <th>Vitamina</th>
                        <th>Grasa</th>
                        <th>Porción Proteína</th>
                        <th>Porción Carbophidrato</th>
                        <th>Porción Vitamina</th>
                        <th>Porción Grasa</th>
                    </tr>
    <%
            }

            String[] comida = comidasList.get(i);  // Obtener el array de cada comida
    %>
            <tr>
                <td><%= comida[0] %></td>
                <td><%= comida[1] %></td>
                <td><%= comida[2] %></td>
                <td><%= comida[3] %></td>
                <td><%= comida[4] %></td>
                <td><%= comida[5] %></td>
                <!-- Mostrar solo las columnas disponibles -->
                <td><%= (comida.length > 6 ? comida[6] : "") %></td>
                <td><%= (comida.length > 7 ? comida[7] : "") %></td>
                <td><%= (comida.length > 8 ? comida[8] : "") %></td>
            </tr>
    <%
        }
    %>

    </table>  <!-- Cerrar la última tabla -->
    
    <%
        } else {
    %>
        <p>No se han encontrado comidas para este usuario.</p>
    <%
        }
    %>

</body>
</html>

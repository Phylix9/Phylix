<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mis Rutinas</title>
</head>
<body>
    <h2>Mis Rutinas</h2>

    <table border="1">
        <tr>
            <th>Ejercicio 1</th>
            <th>Reps 1</th>
            <th>Ejercicio 2</th>
            <th>Reps 2</th>
            <th>Ejercicio 3</th>
            <th>Reps 3</th>
            <th>Ejercicio 4</th>
            <th>Reps 4</th>
            <th>Ejercicio 5</th>
            <th>Reps 5</th>
            <th>Ejercicio 6</th>
            <th>Reps 6</th>
            <th>Ejercicio 7</th>
            <th>Reps 7</th>
            <th>Ejercicio 8</th>
            <th>Reps 8</th>
        </tr>

        <%
            List<String[]> rutinas = (List<String[]>) request.getAttribute("rutinas");
            if (rutinas != null && !rutinas.isEmpty()) {
                for (String[] rutina : rutinas) {
        %>
                    <tr>
                        <% for (int j = 0; j < rutina.length; j++) { %>
                            <td><%= rutina[j] %></td>
                        <% } %>
                    </tr>
        <%
                }
            } else {
        %>
                <tr>
                    <td colspan="16">No se encontraron rutinas.</td>
                </tr>
        <%
            }
        %>
    </table>
</body>
</html>

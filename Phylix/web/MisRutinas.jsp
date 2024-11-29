<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mis Rutinas Creadas</title>
</head>
<body>
    
   <h1>Mis Rutinas Creadas</h1>

    <%
        List<String[]> rutinasList = (List<String[]>) request.getAttribute("rutinas");

        if (rutinasList != null && !rutinasList.isEmpty()) {
            int rutinaIndex = 1;

            for (String[] rutina : rutinasList) {
                boolean rutinaVacia = true;
                for (int i = 0; i < rutina.length; i += 2) {
                    if (rutina[i] != null) {
                        rutinaVacia = false;
                        break;
                    }
                }
                if (rutinaVacia) {
                    continue;
                }

    %>
                <h2>Rutina  Personalizada <%= rutinaIndex++ %></h2>
                <table border="1">
                    <tr>
                        <th>Ejercicio</th>
                        <th>Repeticiones</th>
                    </tr>

                    <%
                        for (int i = 0; i < rutina.length; i += 2) {
                            String ejercicio = rutina[i];
                            String repeticiones = rutina[i + 1];

                            if (ejercicio != null && !ejercicio.isEmpty()) {
                    %>
                        <tr>
                            <td><%= ejercicio %></td>
                            <td><%= repeticiones %></td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </table>
                <br>
    <%
            }
        } else {
    %>
        <p>No se han encontrado rutinas para este usuario.</p>
    <%
        }
    %>
        
</body>
</html>

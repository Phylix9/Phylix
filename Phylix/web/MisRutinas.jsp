<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<<<<<<< HEAD
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mis Rutinas Creadas</title>
</head>
<body>
    
   <h1>Mis Rutinas Creadas</h1>
=======
    <title>Mis Rutinas</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css">
    <link rel="stylesheet" href="Styles17.css">
</head>
<body>
    
    <button class="back-button" onclick="window.history.back();">
        <i class="ri-arrow-left-line"></i>
    </button>
    
    <h2>Mis Rutinas</h2>
>>>>>>> 1f652d3dd0ba185b49e3c7b9d103ecdea8489160

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

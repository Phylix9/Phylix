<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Resultado desde Python</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            padding: 20px;
            max-width: 800px;
            margin: 0 auto;
        }
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
        }
        pre {
            background: #f5f5f5;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 3px;
            white-space: pre-wrap;
            word-wrap: break-word;
            overflow-x: auto;
        }
        .error {
            color: #d9534f;
            font-weight: bold;
        }
        .debug-info {
            margin-top: 30px;
            border-top: 1px solid #ddd;
            padding-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Resultado del Modelo de Machine Learning</h1>
        
        <%
        String resultado = (String) request.getAttribute("resultadoPython");
        String idUsuario = request.getParameter("id_usuario");
        %>
        
        <h2>Datos procesados:</h2>
        <p><strong>ID de usuario:</strong> <%= idUsuario != null ? idUsuario : "No especificado" %></p>
        
        <h2>Respuesta del modelo:</h2>
        <% if (resultado != null && !resultado.trim().isEmpty()) { %>
            <% if (resultado.contains("error") || resultado.contains("Error") || resultado.contains("Excepción")) { %>
                <div class="error">
                    <pre><%= resultado %></pre>
                </div>
            <% } else { %>
                <pre><%= resultado %></pre>
            <% } %>
        <% } else { %>
            <p class="error">No se recibió ningún resultado del script Python.</p>
        <% } %>
        
        <div class="debug-info">
            <h3>Información de depuración:</h3>
            <p>Fecha y hora de ejecución: <%= new java.util.Date() %></p>
            <p>Servidor: <%= application.getServerInfo() %></p>
        </div>
    </div>
</body>
</html>
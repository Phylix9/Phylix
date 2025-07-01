
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Verificación de Seguridad - FitData</title>
        <link rel="stylesheet" href="Style20.css">
    </head>
    <body>
        <div class="container">
            <img src="src/logoFitData.png" alt="FitData" class="logo">
            <h2>Verificación en dos pasos</h2>
            <p class="subtitle">SALUD EN UN SOLO CLICK</p>
            
            <form action="ValidarCodigo" method="post">
                <label>Ingresa el código de verificación enviado a tu correo:</label>
                <input type="text" name="code" maxlength="6" autocomplete="off" required placeholder="······" />
                
                <button type="submit">Verificar</button>
            </form>
            
            <p style="margin-top: 20px; font-size: 14px; color: #a0a0a0;">
                ¿No recibiste el código? <a href="Autenticacion.jsp" style="color: #5295df; text-decoration: none;">Reenviar</a>
            </p>
        </div>
        
        <script>
            // Optional: Add focus to the input field when page loads
            document.addEventListener('DOMContentLoaded', function() {
                document.querySelector('input[name="code"]').focus();
            });
        </script>
    </body>
</html>
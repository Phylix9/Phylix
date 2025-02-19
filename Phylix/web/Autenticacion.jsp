
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Autenticación 2FA</title>
    </head>
    <body>
        <h2>Verificación en dos pasos</h2>
        <form action="ValidarCodigo" method="post">
            <label>Ingresa el código de verificación enviado a tu correo:</label>
            <input type="text" name="code" required />
            <button type="submit">Verificar</button>
        </form>
    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Ejecutar Modelo de Machine Learning</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            padding: 20px;
            max-width: 600px;
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
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Ejecutar Modelo de Machine Learning</h1>
        <p>Ingrese el ID de usuario para calcular porciones y repeticiones:</p>
        
        <form action="EjecutarPhyton" method="post">
            <div class="form-group">
                <label for="id_usuario">ID de Usuario:</label>
                <input type="text" id="id_usuario" name="id_usuario" required>
            </div>
            
            <button type="submit">Calcular</button>
        </form>
    </div>
</body>
</html>
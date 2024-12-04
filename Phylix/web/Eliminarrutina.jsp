<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Rutina - FitData</title>
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/Styles18.css">
</head>
<body>
    <div class="container">
        <a href="FitData" class="back-button">
            <i class="ri-arrow-left-line"></i>
            Volver
        </a>
        
        <div class="content">
            <h1>Eliminar Rutina</h1>
            
            <div class="form-container">
                <form action="EliminarRutina" method="post" class="delete-form">
                    <div class="form-group">
                        <h2>Eliminar por Número de Rutina</h2>
                        <p class="form-description">Ingresa el número identificador de la Rutina que deseas eliminar</p>
                        <div class="input-group">
                            <input type="text" name="rutinaprestid" placeholder="Ej: 12345" required>
                            <button type="submit" class="btn-delete">Eliminar Rutina</button>
                        </div>
                    </div>
                </form>

                <div class="divider">
                    <span>O</span>
                </div>
                
                <form action="EliminarRutina" method="post" class="delete-form">
                    <div class="form-group">
                        <h2>Eliminar por Nombre</h2>
                        <p class="form-description">Ingresa el nombre de la dieta que deseas eliminar</p>
                        <div class="input-group">
                            <input type="text" name="rutinapersoid" placeholder="Ej:  Rutina Mediterránea" required>
                            <button type="submit" class="btn-delete">Eliminar Rutina</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

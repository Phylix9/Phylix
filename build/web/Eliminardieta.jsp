<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Dieta - FitData</title>
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="Styles18.css">
</head>
<body>
    <div class="container">
        <a href="Perfil" class="back-button">
            <i class="ri-arrow-left-line"></i>
            Volver
        </a>
        
        <div class="content">
            <h1>Eliminar Dieta</h1>
            
            <div class="form-container">
                <form action="EliminarDieta" method="post" class="delete-form">
                    <div class="form-group">
                        <h2>Eliminar por Número de Plan</h2>
                        <p class="form-description">Ingresa el número identificador del plan que deseas eliminar</p>
                        <div class="input-group">
                            <input type="text" name="dietaprestid" placeholder="Ej: 12345" required>
                            <button type="submit" class="btn-delete">Eliminar Plan</button>
                        </div>
                    </div>
                </form>

                <div class="divider">
                    <span>O</span>
                </div>
                
                <form action="EliminarDieta" method="post" class="delete-form">
                    <div class="form-group">
                        <h2>Eliminar por Nombre</h2>
                        <p class="form-description">Ingresa el nombre de la dieta que deseas eliminar</p>
                        <div class="input-group">
                            <input type="text" name="dietapersoid" placeholder="Ej: Dieta Mediterránea" >
                            <button type="submit" class="btn-delete">Eliminar Dieta</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

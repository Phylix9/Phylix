<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
    <title>Progreso - FitData</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f5f7fa;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            padding: 30px 40px;
            text-align: center;
            width: 350px;
        }

        h2 {
            margin-bottom: 20px;
            color: #2c3e50;
        }

        .progress-container {
            width: 100%;
            background-color: #ecf0f1;
            border-radius: 30px;
            overflow: hidden;
            height: 30px;
            margin-bottom: 25px;
        }

        .progress-bar {
            height: 100%;
            width: 0%;
            background: linear-gradient(to right, #00b894, #00cec9);
            border-radius: 30px;
            text-align: center;
            color: white;
            font-weight: bold;
            line-height: 30px;
            transition: width 0.5s ease-in-out;
        }

        .btn-avanzar {
            background-color: #00b894;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s ease;
        }

        .btn-avanzar:hover {
            background-color: #019874;
        }
    </style>
</head>
<body>
    <button class="back-button" onclick="window.history.back();">
        <i class="ri-arrow-left-line"></i>
    </button> 
    <div class="card">
        <h2>Tu progreso</h2>
        <div class="progress-container">
            <div id="barra" class="progress-bar">0%</div>
        </div>
        <button class="btn-avanzar" onclick="avanzar()">Avanzar</button>
    </div>

    <script>
        function cargarProgreso() {
            fetch("ProgressBar")
                .then(res => res.json())
                .then(data => actualizarBarra(data.progreso));
        }

        function avanzar() {
            fetch("ProgressBar", {
                method: "POST"
            })
            .then(res => res.json())
            .then(data => actualizarBarra(data.progreso));
        }

        function actualizarBarra(valor) {
            const barra = document.getElementById("barra");
            barra.style.width = valor + "%";
            barra.textContent = valor + "%";
            if (valor >= 100) {
                alert("¡Progreso completado!");
            }
        }

        window.onload = cargarProgreso;
    </script>
</body>
</html>

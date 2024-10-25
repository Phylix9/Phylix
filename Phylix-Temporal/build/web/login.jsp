<%-- 
    Document   : login
    Created on : Oct 24, 2024, 7:15:54 PM
    Author     : Abraham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <%
        String correo = request.getParameter("email");
        String contra = request.getParameter("pswd");

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";
        
        Connection con = null;
        PreparedStatement sta = null;
        ResultSet r = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);
            
                sta = con.prepareStatement("SELECT * FROM Usuario WHERE correo_usuario = ? AND contrasena_usuario = ?;");
                sta.setString(1, correo);
                sta.setString(2, contra);
                r = sta.executeQuery();
           

            if (r.next()) 
            {
                session.setAttribute("correo_usuario", correo);
                session.setAttribute("id_usuario", r.getInt("id_usuario"));
                session.setAttribute("nombre_usuario", r.getString("nombre_usuario"));
                session.setAttribute("contrasena_usuario", contra);
                response.sendRedirect("index.html");
            }

        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().print("Error: " + e.getMessage());
        } finally {
            try {
                if (r != null) r.close();
                if (sta != null) sta.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        %>
        
        <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="icono.png" type="img/png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="Styles5.css">
    <title>Login</title>
</head>
<body>
    <div class="titulo">
        <h2 id="TituloE">FitData</h2>
    </div>
        <button onclick="history.back()" class="back-button">Regresar</button>
    <div class="container" id="main">
        <div class="sign-up">
            <form action="registro.jsp">
                <h1>Crear Cuenta</h1>
                <div class="social-container">
                    <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                    <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                </div>
                <p>Usa tu email para poder registrarte</p>
                <input type="text" name="nombre" placeholder="Nombre" required="">
                <input type="email" name="email" placeholder="Email" required="">
                <input type="password" name="pswd" placeholder="Contraseña" required
                       pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^\s]+" minlength="8">
              <button>Registrarse</button>
            </form>

        </div>
        <div class="sign-in">
            <form action="login.jsp">
                <h1>Inicia Sesion</h1>
                <div class="social-container">
                  
                </div>
                <p>O usa alguna de tus cuenta</p>
                <input type="email" name="email" id="email" placeholder="Email" required="">
                <input type="password" name="pswd" id="pswd" placeholder="Contraseña" required="">
                <a href="#">Olvidaste tu contraseña?</a>
                <button>Iniciar Sesion</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-left">
                    <h1>Bienvenido!</h1>
                    <p>Ingresa tu cuenta en el Login</p>
                    <button id="SignIn">Inicia Sesion</button>
                </div>
                <div class="overlay-right">
                    <h1>Eres Nuevo?</h1>
                    <p>Ingresa tu informacion y empieza tu vida saludable con nosotros</p>
                    <button id="SignUp">Registrate</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        let btn = document.querySelector('#btn');
        let sidebar = document.querySelector('.sidebar');
        
        btn.onclick = function () {
            sidebar.classList.toggle('active');
        };
        </script>
    <script type="text/javascript">
        const signUpButton = document.getElementById('SignUp');
        const signInButton = document.getElementById('SignIn');
        const main = document.getElementById('main');

        signUpButton.addEventListener('click', () => {
            main.classList.add("right-panel-active");
        });
        signInButton.addEventListener('click', () => {
            main.classList.remove("right-panel-active");
        });
    </script>
</body>
</html>
    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login FitData</title>
        <link rel="icon" href="src/logoFitData.png" type="img/png">
        <link rel="stylesheet" href="Styles5.css">
        <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
           
            if (r.next()) {
                session.setAttribute("correo_usuario", correo);
                session.setAttribute("id_usuario", r.getInt("id_usuario"));
                session.setAttribute("nombre_usuario", r.getString("nombre_usuario"));
                session.setAttribute("contrasena_usuario", contra);
                response.sendRedirect("index.html");
            } else {
                out.println("<script>alert('Usuario o contraseña incorrectos');</script>");
                response.sendRedirect("login.jsp");
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
        
    <div class="auth-container">
        <button onclick="history.back()" class="back-button">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m12 19-7-7 7-7"/><path d="M19 12H5"/></svg>
            Volver
        </button>

        <div class="container" id="container">
            <div class="form-container sign-up-container">
                <form action="registro.jsp">
                    <h1>Crea Una Cuenta</h1>
                    <div class="social-container">
                        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social"><i class="fab fa-google"></i></a>
                        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                    <span>O usa tu email para registrarte</span>
                    <input type="text" name="nombre" placeholder="Nombre" required />
                    <input type="email" name="email" placeholder="Email" required />
                    <input type="password" name="pswd" placeholder="Contraseña" required 
                    pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^\s]+" minlength="8"/>
                    <button type="submit">Registrarse</button>
                </form>
            </div>

            <div class="form-container sign-in-container">
                <form action="login.jsp" method="post">
                    <h1>Iniciar Sesion</h1>
                    <div class="social-container">
                        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social"><i class="fab fa-google"></i></a>
                        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                    <span>O usa tu cuenta</span>
                    <input type="email" name="email" placeholder="Email" required />
                    <input type="password" name="pswd" placeholder="Contraseña" required />
                    <button type="submit">Inicia Sesion</button>
                </form>
            </div>

            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>Bienvenido </h1>
                        <p>Para seguir conectado con nosotros por favor ingresa con tus datos personales</p>
                        <button class="ghost" id="signIn">Iniciar Sesion</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>Hola, Nuevo Aqui?</h1>
                        <p>Ingresa tus datos personales para iniciar una vida saludable con nosotros </p>
                        <button class="ghost" id="signUp">Registrarse</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const signUpButton = document.getElementById('signUp');
        const signInButton = document.getElementById('signIn');
        const container = document.getElementById('container');

        signUpButton.addEventListener('click', () => {
            container.classList.add('right-panel-active');
        });

        signInButton.addEventListener('click', () => {
            container.classList.remove('right-panel-active');
        });
    </script>
</body>
</html>

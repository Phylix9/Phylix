<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login FitData</title>
    <link rel="icon" href="src/logoFitData.png" type="img/png">
    <link rel="stylesheet" href="Styles5.css">
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/es_ES/sdk.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jwt-decode/build/jwt-decode.min.js"></script>
</head>

<body>
    <div class="auth-container">
        <button onclick="history.back()" class="back-button">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="m12 19-7-7 7-7"/><path d="M19 12H5"/>
            </svg>
            Volver
        </button>
        
        <div class="container" id="container">
            <div class="form-container sign-up-container">
                <form action="Registro" method="post" id="signupForm">
                    <h1>Crea Una Cuenta</h1>
                    <div class="social-container">
                        <a href="#" class="social" onclick="handleFacebookLogin();"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social" id="google-login-button"><i class="fab fa-google"></i></a> <!-- Modificado -->
                    </div>
                    <span>O usa tu email para registrarte</span>
                    <input type="text" id="nombre" name="nombre" placeholder="Nombre" required />
                    <input type="email" id="signup-email" name="email" placeholder="Email" required />
                    <span class="email-error" id="signup-email-error" style="display: none; color: #f5f5f5; font-size: 0.8rem;"></span>
                    <input type="password" id="pswd" name="pswd" placeholder="Contraseña" required 
                        pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^\s]+" minlength="8"/>
                    <div class="password-requirements" id="password-requirements">
                        <ul>
                            <li>Mínimo 8 caracteres, sin espacios. Al menos una letra mayúscula, una minúscula y un número.</li>
                        </ul>
                    </div>
                    <button type="submit">Registrarse</button>
                </form>
            </div>

            <div class="form-container sign-in-container">
                <form action="Login" method="post" id="signinForm">
                    <h1>Iniciar Sesión</h1>
                    <%
                        HttpSession sesion = request.getSession(false);
                        String error = request.getParameter("error");
                        boolean maxIntentos = "max".equals(error);
                        int intentosRestantes = 3;
                        if (sesion != null && sesion.getAttribute("intentos") != null) {
                            intentosRestantes = 3 - (Integer) sesion.getAttribute("intentos");
                            if (intentosRestantes < 0) intentosRestantes = 0;
                        }

                        if ("true".equals(error)) {
                    %>
                        <p style="color: red; font-size: 14px;">Correo o contraseña incorrectos. Te quedan <%= intentosRestantes %> intento<%= intentosRestantes == 1 ? "" : "s" %>.</p>
                    <%
                        } else if ("max".equals(error)) {
                    %>
                        <p style="color: red; font-size: 14px;">Has superado el número máximo de intentos. Intenta más tarde.</p>
                    <%
                        }
                    %>
                    <div class="social-container">
                        <a class="social" onclick="handleFacebookLogin();"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social" id="google-login-button"><i class="fab fa-google"></i></a>
                    </div>
                    <span>O usa tu cuenta</span>
                    <input type="email" id="email" name="email" placeholder="Email" required <%= maxIntentos ? "disabled" : "" %> />
                    <input type="password" id="pswd" name="pswd" placeholder="Contraseña" required <%= maxIntentos ? "disabled" : "" %> />
                    <button type="submit" <%= maxIntentos ? "disabled style='background-color: gray; cursor: not-allowed;'" : "" %>>Inicia Sesión</button>
                </form>
            </div>


            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>Bienvenido</h1>
                        <p>Para seguir conectado con nosotros por favor ingresa con tus datos personales</p>
                        <button class="ghost" id="signIn">Iniciar Sesión</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>Hola, ¿Nuevo Aquí?</h1>
                        <p>Ingresa tus datos personales para iniciar una vida saludable con nosotros</p>
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
        
        const VALID_DOMAINS = [
            'gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com', 'icloud.com', 'proton.me', 'zoho.com'
        ];

        function validateEmail(email) {
            const basicEmailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!basicEmailRegex.test(email)) {
                return { isValid: false, error: 'Por favor ingrese un email válido' };
            }

            const domain = email.split('@')[1];
            if (!VALID_DOMAINS.includes(domain.toLowerCase())) {
                return { isValid: false, error: 'Por favor use un proveedor de correo válido' };
            }

            return { isValid: true };
        }

        function setupEmailValidation(formId, emailId, errorId) {
    const form = document.getElementById(formId);
    const emailInput = document.getElementById(emailId);
    const errorSpan = document.getElementById(errorId);

    form.addEventListener('submit', function(e) {
        const validation = validateEmail(emailInput.value);
        if (!validation.isValid) {
            e.preventDefault();
            errorSpan.textContent = validation.error;
            errorSpan.style.display = 'block';
            emailInput.style.borderColor = 'red';
        } else {
            errorSpan.style.display = 'none';
            emailInput.style.borderColor = '';
        }
    });

    emailInput.addEventListener('blur', function() {
        const validation = validateEmail(this.value);
        if (!validation.isValid) {
            errorSpan.textContent = validation.error;
            errorSpan.style.display = 'block';
            emailInput.style.borderColor = 'red';
        } else {
            errorSpan.style.display = 'none';
            emailInput.style.borderColor = '';
        }
    });
}


        setupEmailValidation('signupForm', 'signup-email', 'signup-email-error');

        window.onload = function() {
            google.accounts.id.initialize({
                client_id: "25888454819-c4oc54e9nhi19ngdginimgrhjj0m4fu6.apps.googleusercontent.com",
                callback: handleGoogleResponse
            });

            const googleButton = document.getElementById("google-login-button");
            googleButton.addEventListener("click", function (event) {
                event.preventDefault();
                google.accounts.id.prompt();
            });
        };

        function handleGoogleResponse(response) {
            try {
                const userData = jwt_decode(response.credential);
                console.log("Usuario conectado:", userData);
                alert(`¡Hola, ${userData.name}! Redirigiéndote...`);
                window.location.href = "FitData";
            } catch (error) {
                console.error("Error en Google:", error);
            }
        }

        window.fbAsyncInit = function() {
            FB.init({
                appId: '1255977565718063',
                cookie: true,
                xfbml: true,
                version: 'v21.0',
            });
        };

        function handleFacebookLogin() {
            FB.login(function(response) {
                if (response.authResponse) {
                    FB.api('/me', { fields: 'name,email' }, function(user) {
                        alert(`Hola ${user.name}! Redirigiéndote...`);
                        window.location.href = "FitData";
                    });
                }
            }, { scope: 'public_profile,email' });
        }
    </script>
</body>
</html>

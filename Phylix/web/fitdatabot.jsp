<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Chatbot FitData</title>

  <style>
    :root {
      --primary-color: #111317;
      --primary-color-light: #1f2125;
      --primary-color-extra-light: #35373b;
      --secondary-color: #539EE9;
      --secondary-color-dark: #145799;
      --text-light: #d1d5db;
      --white: #ffffff;
      --max-width: 1200px;
    }

    body {
      font-family: "Poppins", sans-serif;
      background-color: var(--primary-color);
      color: var(--text-light);
      max-width: 800px;
      margin: 0 auto;
      padding: 12px;
    }

    #chatbox {
      border: 1px solid var(--primary-color-extra-light);
      border-radius: 8px;
      padding: 15px;
      height: 250px;
      overflow-y: scroll;
      margin-bottom: 15px;
      background-color: var(--primary-color-light);
    }

    .message {
      margin: 10px 0;
      padding: 8px 12px;
      border-radius: 15px;
      max-width: 80%;
      word-wrap: break-word;
    }

    .user-message {
      background-color: var(--secondary-color);
      margin-left: auto;
      text-align: right;
      color: var(--white);
    }

    .bot-message {
      background-color: var(--primary-color-extra-light);
      margin-right: auto;
      color: var(--text-light);
    }

    .error-message {
      background-color: #ffebee;
      color: #d32f2f;
      margin-right: auto;
    }

    .input-container {
      display: flex;
      gap: 10px;
    }

    #userInput {
      flex: 1;
      padding: 10px;
      border: 1px solid var(--primary-color-extra-light);
      border-radius: 20px;
      background-color: var(--primary-color-light);
      color: var(--text-light);
    }

    #userInput::placeholder {
      color: #aaa;
    }

    #sendBtn {
      padding: 10px 20px;
      border: none;
      border-radius: 20px;
      background-color: var(--secondary-color);
      color: var(--white);
      cursor: pointer;
    }

    #sendBtn:disabled {
      background-color: #444;
      cursor: not-allowed;
    }

    .loading {
      text-align: center;
      margin: 10px 0;
      font-style: italic;
      color: var(--text-light);
    }

    #status-bar {
      font-size: 12px;
      color: var(--text-light);
      margin-top: 10px;
      text-align: center;
    }
  </style>
</head>

<body>
  <h2>Chatbot FitData 🤖</h2>
  <div id="chatbox"></div>
  <div class="input-container">
    <input type="text" id="userInput" placeholder="Escribe tu pregunta..." />
    <button id="sendBtn">Enviar</button>
  </div>
  <div id="status-bar"></div>

  <%
    Integer userId = (Integer) session.getAttribute("id_usuario");
    String nombreUsuario = (String) session.getAttribute("nombre_usuario");
  %>

  <script type="module">
    import { initializeApp } from "https://www.gstatic.com/firebasejs/9.22.0/firebase-app.js";
    import {
      getFirestore, collection, addDoc, onSnapshot, query,
      orderBy, limit, serverTimestamp, getDocs, where
    } from "https://www.gstatic.com/firebasejs/9.22.0/firebase-firestore.js";

    const firebaseConfig = {
      apiKey: "AIzaSyCE2LFKlNQBaUxPksXG7ZhXlH8_0akeq84",
      authDomain: "fitdatabot.firebaseapp.com",
      projectId: "fitdatabot",
      storageBucket: "fitdatabot.appspot.com",
      messagingSenderId: "7033323341",
      appId: "1:7033323341:web:8ee310de80d630bcc28104"
    };

    const app = initializeApp(firebaseConfig);
    const db = getFirestore(app);

    const userId = "<%= userId %>";
    const nombreUsuario = "<%= nombreUsuario %>";

    const chatbox = document.getElementById("chatbox");
    const sendBtn = document.getElementById("sendBtn");
    const userInput = document.getElementById("userInput");
    const statusBar = document.getElementById("status-bar");

    const rateLimitControl = {
      isWaiting: false,
      retryCount: 0,
      maxRetries: 3,
      baseDelay: 2000,
      getRetryDelay() {
        return this.baseDelay * Math.pow(2, this.retryCount);
      },
      reset() {
        this.isWaiting = false;
        this.retryCount = 0;
        sendBtn.disabled = false;
        statusBar.textContent = "";
      },
      startWaiting() {
        this.isWaiting = true;
        sendBtn.disabled = true;
        const delay = this.getRetryDelay();
        let remainingSeconds = Math.ceil(delay / 1000);
        statusBar.textContent = `Límite de solicitudes alcanzado. Reintentando en ${remainingSeconds} segundos...`;
        const countdownInterval = setInterval(() => {
          remainingSeconds--;
          if (remainingSeconds <= 0) clearInterval(countdownInterval);
          else statusBar.textContent = `Límite de solicitudes alcanzado. Reintentando en ${remainingSeconds} segundos...`;
        }, 1000);

        setTimeout(() => {
          this.isWaiting = false;
          sendBtn.disabled = false;
          sendMessage(true);
        }, delay);
        this.retryCount++;
      }
    };

    async function showErrorInChat(errorMessage) {
        await addDoc(collection(db, "chats",  "Usuario " + userId + ": " + nombreUsuario, "Mensajes"), {
          sender: "error",
          text: errorMessage,
          timestamp: serverTimestamp()
        });
      }

      function showLoading() {
        const loadingDiv = document.createElement("div");
        loadingDiv.className = "loading";
        loadingDiv.id = "loading-indicator";
        loadingDiv.innerText = "El bot está escribiendo...";
        chatbox.appendChild(loadingDiv);
        chatbox.scrollTop = chatbox.scrollHeight;
      }

      function hideLoading() {
        const loadingDiv = document.getElementById("loading-indicator");
        if (loadingDiv) loadingDiv.remove();
      }

      async function handleBotResponse(respuestaIA) {
        hideLoading();
        await addDoc(collection(db, "chats", "Usuario " + userId + ": " + nombreUsuario, "Mensajes"), {
          sender: "bot",
          text: respuestaIA,
          timestamp: serverTimestamp()
        });
        rateLimitControl.reset();
      }

      window.sendMessage = async function(isRetry = false) {
        if (rateLimitControl.isWaiting) return;

        let text;
        if (!isRetry) {
          text = userInput.value.trim();
          if (!text) return;
          userInput.value = "";
          sessionStorage.setItem("lastMessage", text);
          await addDoc(collection(db, "chats",  "Usuario " + userId + ": " + nombreUsuario, "Mensajes"), {
            sender: "user",
            text,
            timestamp: serverTimestamp()
          });
        } else {
          text = sessionStorage.getItem("lastMessage");
          if (!text) return;
        }

        if (!isRetry) showLoading();

        try {
          const response = await fetch("/Phylix/IAChatbot", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              contents: [{ parts: [{ text }] }]
            })
          });

          if (response.status === 429) {
            hideLoading();
            if (rateLimitControl.retryCount < rateLimitControl.maxRetries) {
              rateLimitControl.startWaiting();
            } else {
              rateLimitControl.reset();
              await showErrorInChat("❌ No se pudo completar la solicitud debido a límites de la API.");
            }
            return;
          }

          if (response.status === 401) {
            hideLoading();
            await showErrorInChat("❌ Error de autorización con la API de Gemini.");
            rateLimitControl.reset();
            return;
          }

          if (response.status === 400) {
            hideLoading();
            const errorText = await response.text();
            await showErrorInChat(`❌ Error de solicitud: ${errorText}`);
            rateLimitControl.reset();
            return;
          }

          if (!response.ok) throw new Error(`Error: ${response.status} ${response.statusText}`);

          const respuestaIA = await response.text();
          await handleBotResponse(respuestaIA);

        } catch (error) {
          hideLoading();
          await showErrorInChat("❌ Ocurrió un error: " + error.message);
          rateLimitControl.reset();
        }
      };

      // Mostrar mensaje de bienvenida si hay mensaje antes o vacío
      (async function () {
        try {
            if (typeof userId === "string" && userId.trim() !== "") {
                const mensajesRef = collection(db, "chats",  "Usuario " + userId + ": " + nombreUsuario, "Mensajes");

                const emptyCheckQuery = query(mensajesRef, limit(1));
                const emptyCheckSnapshot = await getDocs(emptyCheckQuery);

                let shouldSendGreeting = false;

                if (emptyCheckSnapshot.empty) {
                  shouldSendGreeting = true;
                } else {
                  const lastMessagesQuery = query(
                    mensajesRef,
                    orderBy("timestamp", "desc"),
                    limit(2)
                  );
                  const lastMessagesSnapshot = await getDocs(lastMessagesQuery);
                  lastMessagesSnapshot.forEach(doc => {
                    const msg = doc.data();
                    if (msg.sender === "user") {
                      shouldSendGreeting = true;
                    }
                  });
                }

                if (shouldSendGreeting) {
                  console.log("Enviando mensaje de bienvenida...");
                  await addDoc(mensajesRef, {
                    sender: "bot",
                    text: "👋 ¡Hola! Soy FitData, tu asistente virtual de fitness y nutrición. ¿En qué puedo ayudarte hoy?",
                    timestamp: serverTimestamp()
                  });
                } else {
                  console.log("No es necesario enviar mensaje de bienvenida");
                }
            }
        } catch (error) {
          console.error("Error al verificar y enviar mensaje de bienvenida:", error);
        }
      })();

      // Escuchar cambios en la subcolección de mensajes del usuario
      const mensajesQuery = query(
        collection(db, "chats",  "Usuario " + userId + ": " + nombreUsuario, "Mensajes"),
        orderBy("timestamp", "asc"),
        limit(50)
      );

      onSnapshot(mensajesQuery, (snapshot) => {
        let changes = false;

        snapshot.docChanges().forEach((change) => {
          if (change.type === "added") {
            changes = true;
            const msg = change.doc.data();
            if (msg && msg.sender && msg.text) {
              const div = document.createElement("div");

              if (msg.sender === "user") {
                div.className = "message user-message";
              } else if (msg.sender === "bot") {
                div.className = "message bot-message";
              } else if (msg.sender === "error") {
                div.className = "message error-message";
              } else {
                div.className = "message";
              }

              div.innerHTML = msg.text.replace(/\n/g, "<br>");
              chatbox.appendChild(div);
            }
          }
        });

        if (changes) {
          chatbox.scrollTop = chatbox.scrollHeight;
        }
      });

      // Event listeners
      sendBtn.addEventListener("click", () => sendMessage(false));
      userInput.addEventListener("keypress", function(event) {
        if (event.key === "Enter") {
          event.preventDefault();
          sendMessage(false);
        }
      });

    
    // Estado inicial
    statusBar.textContent = "";
    userInput.focus();
    
    const INACTIVITY_TIMEOUT = 2 * 60 * 1000;
    let inactivityTimer;


    let wasInactive = false; // 👈 Bandera para saber si ya estaba inactivo

    function handleInactivity() {
      wasInactive = true; // 👈 Marca que entró en inactividad
      sendBtn.disabled = true;
      userInput.disabled = true;
      statusBar.textContent = "⏳ Inactivo por mucho tiempo. Redirigiendo...";
    }

    function resetInactivityTimer() {
      clearTimeout(inactivityTimer);

      if (wasInactive) {
        window.location.href = "LoginBot.html";
        return; 
      }

      inactivityTimer = setTimeout(handleInactivity, INACTIVITY_TIMEOUT);
    }

    ["mousemove", "keydown", "mousedown", "touchstart"].forEach(event => {
      document.addEventListener(event, resetInactivityTimer);
    });

    resetInactivityTimer();

  </script>
</body>
</html>
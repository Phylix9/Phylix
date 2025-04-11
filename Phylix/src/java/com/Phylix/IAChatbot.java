package com.Phylix;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Enumeration;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "IAChatbot", urlPatterns = {"/IAChatbot"})
public class IAChatbot extends HttpServlet {

    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";
    private static final Logger LOGGER = Logger.getLogger(IAChatbot.class.getName());

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject inputJson = new JSONObject(sb.toString());
            JSONArray contents = inputJson.getJSONArray("contents");
            JSONObject firstContent = contents.getJSONObject(0);
            JSONArray parts = firstContent.getJSONArray("parts");
            JSONObject firstPart = parts.getJSONObject(0);
            String userText = firstPart.getString("text");

            String apiKey = "AIzaSyCtuJDHZvKehcgGuej7oNFjTK0Teda_5FE"; 
            String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + apiKey;

            JSONObject payload = new JSONObject();
            JSONArray contentsArray = new JSONArray();
            JSONObject contentObject = new JSONObject();
            JSONArray partsArray = new JSONArray();
            JSONObject part = new JSONObject();
            int maxTokens = 512; 
            userText = "Responde de forma concisa en " + maxTokens +" o menos tokens. Sin dejar tu idea a la mitad,"
                    + " terminala siempre sin exceder el numero de tokens" + userText;
            String instruccion = "Solo responde si la pregunta está relacionada con los temas "
                    + "salud, nutricion, fitness, ejercicio o algo relacionado, o bien si te preguntan como te llamas,"
                    + "como estas o preguntas así; de lo contrario"
                    + "di que no puedes responder porque eres un asistente sobre temas relacionados a salud y fitness."
                    + "Si te llegan a pedir que les des una rutina o dietas, di que usen el apartado correspondiente en la aplicación."
                    + "Si vas a hablar sobre IMC, no olvides mencionar que tenemos una calculadora de IMC.";
            part.put("text", instruccion + userText);
            partsArray.put(part);
            
            JSONObject tokens = new JSONObject();
            tokens.put("maxOutputTokens", maxTokens);
            
            payload.put("generationConfig", tokens);
            
            contentObject.put("parts", partsArray);
            contentsArray.put(contentObject);
            payload.put("contents", contentsArray);

            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            OutputStream os = conn.getOutputStream();
            os.write(payload.toString().getBytes("UTF-8"));
            os.close();

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder responseBuilder = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                responseBuilder.append(inputLine);
            }
            in.close();

            String jsonResponse = responseBuilder.toString();
            JSONObject responseJson = new JSONObject(jsonResponse);
            JSONArray returnedContents = responseJson.getJSONArray("candidates");
            JSONObject firstCandidate = returnedContents.getJSONObject(0);
            JSONObject returnedContent = firstCandidate.getJSONObject("content");
            JSONArray returnedParts = returnedContent.getJSONArray("parts");
            String respuestaIA = returnedParts.getJSONObject(0).getString("text");
            
            String htmlResponse = respuestaIA
                .replaceAll("\\*\\*(.*?)\\*\\*", "<strong>$1</strong>")
                .replaceAll("\\n", "<br>")
                .replaceAll("\\* (.*?)\\n", "• $1<br>");

            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(htmlResponse);

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("text/plain");
            response.getWriter().write("Error al procesar la solicitud: " + e.getMessage());
        }

    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private String getApiKey() {
        String apiKey = System.getenv("GEMINI_API_KEY");
        if (apiKey == null || apiKey.isEmpty()) {
            apiKey = System.getProperty("gemini.api.key");
        }
        if (apiKey == null || apiKey.isEmpty()) {
            apiKey = getServletContext().getInitParameter("gemini.api.key");
        }
        LOGGER.info("Intentando obtener API key. Variable de entorno: " + (System.getenv("GEMINI_API_KEY") != null ? "presente" : "ausente") + 
                   ", Propiedad del sistema: " + (System.getProperty("gemini.api.key") != null ? "presente" : "ausente") + 
                   ", Parámetro de contexto: " + (getServletContext().getInitParameter("gemini.api.key") != null ? "presente" : "ausente"));
        return apiKey;
    }

    @Override
    public String getServletInfo() {
        return "IA Chatbot con Gemini para FitData";
    }
}
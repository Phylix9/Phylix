package com.Phylix;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

public class CuerpoCorreo {

    public static String cuerpoMensaje(String codigo) {
        try (InputStream inputStream = CuerpoCorreo.class.getResourceAsStream("/com/Phylix/Correo.html")) {
            if (inputStream == null) {
                throw new IOException("No se pudo encontrar el archivo Correo.html");
            }

            String contenido = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8)).lines().collect(Collectors.joining("\n"));

            return contenido.replace("{{codigo}}", codigo);
        } catch (IOException e) {
            e.printStackTrace();
            return "Error al cargar la plantilla de correo.";
        }
    }
}

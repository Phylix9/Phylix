package com.Phylix;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringWriter;

@WebServlet(name = "EjecutarPhyton", urlPatterns = {"/EjecutarPhyton"})
public class EjecutarPhyton extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            response.sendRedirect("formulario.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String usuarioId = request.getParameter("id_usuario");
        System.out.println("ID recibido: " + usuarioId);
        
        // Validar que usuarioId no sea null o vacío
        if (usuarioId == null || usuarioId.trim().isEmpty()) {
            String error = "Error: ID de usuario no proporcionado o inválido";
            System.out.println(error);
            request.setAttribute("resultadoPython", error);
            request.getRequestDispatcher("ML.jsp").forward(request, response);
            return;
        }
        
        String jsonResultado = ejecutarPython(usuarioId);
        System.out.println("Resultado recibido del script:\n" + jsonResultado);
        
        // Verificar si hay resultado
        if (jsonResultado == null || jsonResultado.trim().isEmpty()) {
            request.setAttribute("resultadoPython", "No se recibió respuesta del script Python.");
        } else {
            // Eliminar caracteres de nueva línea adicionales al final
            jsonResultado = jsonResultado.trim();
            request.setAttribute("resultadoPython", jsonResultado);
        }
        
        request.getRequestDispatcher("ML.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para ejecutar scripts Python";
    }
    
    public String ejecutarPython(String usuarioId) {
        String output = "";
        try {
            // Usar una ruta más accesible para logs
            java.io.File logFile = new java.io.File(System.getProperty("java.io.tmpdir"), "python_execution.log");
            System.out.println("Creando archivo de log en: " + logFile.getAbsolutePath());
            
            // Verificar que el ejecutable de Python existe
            String rutaPython = "C:\\Users\\macur\\AppData\\Local\\Programs\\Python\\Python311\\python.exe";
            java.io.File pythonExe = new java.io.File(rutaPython);
            if (!pythonExe.exists() || !pythonExe.canExecute()) {
                System.out.println("ERROR: Python no encontrado o no ejecutable en: " + rutaPython);
                return "Error: El ejecutable de Python no se encontró o no tiene permisos. Ruta: " + rutaPython;
            }
            
            // Verificar que el script existe
            String rutaScript = "C:\\Users\\macur\\Documents\\Phylix\\Phylix\\scripts\\prueba_bd.py";
            java.io.File scriptFile = new java.io.File(rutaScript);
            if (!scriptFile.exists() || !scriptFile.canRead()) {
                System.out.println("ERROR: Script Python no encontrado o no legible en: " + rutaScript);
                return "Error: El script Python no se encontró o no tiene permisos. Ruta: " + rutaScript;
            }
            
            // Intentar primero con un script de prueba simple
            ProcessBuilder pbTest = new ProcessBuilder(rutaPython, "-c", 
                "import sys; import json; print(json.dumps({'test': True, 'args': sys.argv[1:]}))");
            pbTest.redirectErrorStream(true);
            
            System.out.println("Ejecutando prueba de Python...");
            Process processTest = pbTest.start();
            
            BufferedReader readerTest = new BufferedReader(new InputStreamReader(processTest.getInputStream()));
            StringBuilder resultadoTest = new StringBuilder();
            String lineTest;
            while ((lineTest = readerTest.readLine()) != null) {
                resultadoTest.append(lineTest);
            }
            
            int exitCodeTest = processTest.waitFor();
            String testOutput = resultadoTest.toString();
            System.out.println("Test de Python terminó con código: " + exitCodeTest + ", salida: " + testOutput);
            
            if (testOutput.isEmpty()) {
                return "Error: La prueba básica de Python no generó salida. Posible problema con el intérprete.";
            }
            
            // Ahora ejecutar el script real
            // Crear un Process Builder con argumentos correctos
            ProcessBuilder pb = new ProcessBuilder(
                rutaPython, 
                "-u",  // Modo unbuffered para mejor salida en tiempo real
                rutaScript, 
                "calcular", 
                usuarioId
            );
            
            // Configurar entorno
            java.util.Map<String, String> env = pb.environment();
            env.put("PYTHONIOENCODING", "utf-8");  // Forzar codificación UTF-8
            
            // Configurar directorio de trabajo
            java.io.File scriptDir = scriptFile.getParentFile();
            pb.directory(scriptDir);
            
            // Redirigir errores a la salida estándar
            pb.redirectErrorStream(true);
            
            // Redirigir a un archivo de log también
            pb.redirectOutput(ProcessBuilder.Redirect.to(logFile));
            
            System.out.println("Ejecutando comando real: " + String.join(" ", pb.command()));
            System.out.println("Directorio de trabajo: " + pb.directory().getAbsolutePath());
            
            // Iniciar el proceso
            Process process = pb.start();
            
            // Esperar a que termine el proceso
            int exitCode = process.waitFor();
            System.out.println("Python script terminó con código: " + exitCode);
            
            // Leer la salida desde el archivo de log
            StringBuilder resultado = new StringBuilder();
            BufferedReader fileReader = new BufferedReader(new java.io.FileReader(logFile));
            String line;
            while ((line = fileReader.readLine()) != null) {
                resultado.append(line);
            }
            fileReader.close();
            
            output = resultado.toString();
            
            // Verificar si la salida está vacía
            if (output.trim().isEmpty()) {
                System.out.println("¡Advertencia! La salida del script Python está vacía");
                
                // Ejecutar el script en modo verboso para debug
                ProcessBuilder pbDebug = new ProcessBuilder(
                    rutaPython, 
                    "-v",  // Modo verbose
                    rutaScript, 
                    "calcular", 
                    usuarioId
                );
                pbDebug.redirectErrorStream(true);
                java.io.File debugLogFile = new java.io.File(System.getProperty("java.io.tmpdir"), "python_debug.log");
                pbDebug.redirectOutput(ProcessBuilder.Redirect.to(debugLogFile));
                
                System.out.println("Ejecutando en modo debug: " + String.join(" ", pbDebug.command()));
                Process processDebug = pbDebug.start();
                processDebug.waitFor();
                
                System.out.println("Log de debug creado en: " + debugLogFile.getAbsolutePath());
                
                return "Error: No se recibió salida del script Python. Verifique el log en: " + logFile.getAbsolutePath();
            }
            
            System.out.println("Salida de Python (raw): " + output);
            
        } catch (Exception e) {
            e.printStackTrace();
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            output = "Error en la ejecución: " + e.getMessage() + "\n" + sw.toString();
            System.out.println(output);
        }
        return output;
    }
}
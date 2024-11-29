package com.Phylix;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CalculoComidas", urlPatterns = {"/CalculoComidas"})
public class CalculoComidas extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        Integer idUsuario = (Integer) session.getAttribute("id_usuario");

        if (idUsuario == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "No se ha encontrado el id del usuario en la sesión.");
            return;
        }

        int edad = 0;
        String sexo = null;
        String objetivos = null;
        String frecuencia = null;
        double peso = 0.0;  // Agregado para almacenar el peso

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);

            // Modificamos la consulta para incluir el peso_usuario
            String sqlUsuario = "SELECT edad_usuario, sexo_usuario, peso_usuario FROM Usuario WHERE id_usuario = ?";
            stmt = con.prepareStatement(sqlUsuario);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            if (rs.next()) {
                edad = rs.getInt("edad_usuario");
                sexo = rs.getString("sexo_usuario");
                peso = rs.getDouble("peso_usuario");  // Obtenemos el peso
                System.out.println("Edad: " + edad + ", Sexo: " + sexo + ", Peso: " + peso);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Usuario no encontrado.");
                return;
            }
            rs.close();
            stmt.close();

            String sqlCuestionario = "SELECT frecuencia_usuario, objetivo_usuario FROM Cuestionario WHERE id_usuario = ?";
            stmt = con.prepareStatement(sqlCuestionario);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            if (rs.next()) {
                frecuencia = rs.getString("frecuencia_usuario");
                objetivos = rs.getString("objetivo_usuario");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cuestionario no encontrado para el usuario.");
                return;
            }
        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().print("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Listas para los alimentos (sin cambios)
        List<String> proteinas = new ArrayList<>();
        List<String> carbohidratos = new ArrayList<>();
        List<String> vitaminasMinerales = new ArrayList<>();
        List<String> grasas = new ArrayList<>();

        try {
            con = DriverManager.getConnection(url, user, password);

            String query = "SELECT nombre_alim, categoria FROM Alimentos";
            stmt = con.prepareStatement(query);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String nombre = rs.getString("nombre_alim");
                String categoria = rs.getString("categoria");

                switch (categoria) {
                    case "Proteína":
                        proteinas.add(nombre);
                        break;
                    case "Carbohidrato":
                        carbohidratos.add(nombre);
                        break;
                    case "Vitamina":
                        vitaminasMinerales.add(nombre);
                        break;
                    case "Grasa":
                        grasas.add(nombre);
                        break;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Recogemos los alimentos seleccionados por el usuario (sin cambios)
        String[] proteinasSeleccionadas = new String[5];
        String[] carbohidratosSeleccionados = new String[5];
        String[] vitaminasSeleccionadas = new String[5];
        String[] grasasSeleccionadas = new String[5];

        for (int i = 0; i < 5; i++) {
            proteinasSeleccionadas[i] = request.getParameter("proteina" + (i + 1));
            carbohidratosSeleccionados[i] = request.getParameter("carbohidrato" + (i + 1));
            vitaminasSeleccionadas[i] = request.getParameter("vitaminasMinerales" + (i + 1));
            grasasSeleccionadas[i] = request.getParameter("grasa" + (i + 1));
        }

        // Calculamos las porciones, pasando el peso como parámetro
        int porcionProteina = calcularPorcionProteina(edad, sexo, frecuencia, objetivos, peso);
        int porcionCarbohidrato = calcularPorcionCarbohidrato(edad, sexo, frecuencia, objetivos, peso);
        int porcionGrasas = calcularPorcionGrasas(edad, sexo, frecuencia, objetivos, peso);
        int porcionVitaminas = calcularPorcionVitaminas(edad, sexo, frecuencia, objetivos, peso);

        // Seteamos los atributos para la vista (sin cambios)
        request.setAttribute("proteinasComida", proteinasSeleccionadas);
        request.setAttribute("carbohidratosComida", carbohidratosSeleccionados);
        request.setAttribute("vitaminasComida", vitaminasSeleccionadas);
        request.setAttribute("grasasComida", grasasSeleccionadas);

        request.setAttribute("porcionProteinaComida", porcionProteina);
        request.setAttribute("porcionCarbohidratoComida", porcionCarbohidrato);
        request.setAttribute("porcionGrasasComida", porcionGrasas);
        request.setAttribute("porcionVitaminasComida", porcionVitaminas);

        // Almacenamos los alimentos en la sesión (sin cambios)
        session.setAttribute("proteinas", proteinas);
        session.setAttribute("carbohidratos", carbohidratos);
        session.setAttribute("vitaminasMinerales", vitaminasMinerales);
        session.setAttribute("grasas", grasas);

        // Redirigimos a la página de dietas personalizadas (sin cambios)
        request.getRequestDispatcher("DietaspersoCreadas").forward(request, response);
    }

    // Métodos para calcular las porciones (sin cambios, utilizan el peso obtenido desde la base de datos)

    private int calcularPorcionProteina(int edad, String sexo, String frecuencia, String objetivos, double peso) {
        int porcionProteina = 0;
        
        if (objetivos.equals("bajar_peso")) {
            porcionProteina = (int) (peso * 1.6); 
        } else if (objetivos.equals("ganar_musculo")) {
            porcionProteina = (int) (peso * 2.2); 
        } else if (objetivos.equals("mejorar_resistencia")) {
            porcionProteina = (int) (peso * 1.8); 
        } else {
            return porcionProteina; 
        }

        if ("mujer".equals(sexo)) {
            porcionProteina = (int) (porcionProteina * 0.9); 
        }

        if ("baja".equals(frecuencia)) {
            porcionProteina = (int) (porcionProteina * 1.2);
        } else if ("moderada".equals(frecuencia)) {
            porcionProteina = (int) (porcionProteina * 1.4);
        } else if ("alta".equals(frecuencia)) {
            porcionProteina = (int) (porcionProteina * 1.6);
        }

        return porcionProteina;
    }

    private int calcularPorcionCarbohidrato(int edad, String sexo, String frecuencia, String objetivos, double peso) {
        int porcionCarbohidratos = 0;

        if (objetivos.equals("bajar_peso")) {
            porcionCarbohidratos = (int) (peso * 2.0);
        } else if (objetivos.equals("ganar_musculo")) {
            porcionCarbohidratos = (int) (peso * 3.0);
        } else if (objetivos.equals("mejorar_resistencia")) {
            porcionCarbohidratos = (int) (peso * 2.5);
        } else {
            return porcionCarbohidratos;
        }

        if ("mujer".equals(sexo)) {
            porcionCarbohidratos = (int) (porcionCarbohidratos * 0.9);
        }

        if ("baja".equals(frecuencia)) {
            porcionCarbohidratos = (int) (porcionCarbohidratos * 1.2);
        } else if ("moderada".equals(frecuencia)) {
            porcionCarbohidratos = (int) (porcionCarbohidratos * 1.4);
        } else if ("alta".equals(frecuencia)) {
            porcionCarbohidratos = (int) (porcionCarbohidratos * 1.6);
        }

        return porcionCarbohidratos;
    }

    private int calcularPorcionGrasas(int edad, String sexo, String frecuencia, String objetivos, double peso) {
        int porcionGrasas = 0;

        if (objetivos.equals("bajar_peso")) {
            porcionGrasas = (int) (peso * 0.8);
        } else if (objetivos.equals("ganar_musculo")) {
            porcionGrasas = (int) (peso * 1.0);
        } else if (objetivos.equals("mejorar_resistencia")) {
            porcionGrasas = (int) (peso * 0.9);
        } else {
            return porcionGrasas;
        }

        if (edad < 18) {
            porcionGrasas = (int) (porcionGrasas * 1.2);
        } else if (edad > 50) {
            porcionGrasas = (int) (porcionGrasas * 0.9);
        }

        if ("mujer".equals(sexo)) {
            porcionGrasas = (int) (porcionGrasas * 0.9);
        }

        if ("baja".equals(frecuencia)) {
            porcionGrasas = (int) (porcionGrasas * 1.2);
        } else if ("moderada".equals(frecuencia)) {
            porcionGrasas = (int) (porcionGrasas * 1.4);
        } else if ("alta".equals(frecuencia)) {
            porcionGrasas = (int) (porcionGrasas * 1.6);
        }

        return porcionGrasas;
    }

    private int calcularPorcionVitaminas(int edad, String sexo, String frecuencia, String objetivos, double peso) {
        int porcionVitaminas = 0;

        if (objetivos.equals("bajar_peso")) {
            porcionVitaminas = (int) (peso * 0.8);
        } else if (objetivos.equals("ganar_musculo")) {
            porcionVitaminas = (int) (peso * 1.0);
        } else if (objetivos.equals("mejorar_resistencia")) {
            porcionVitaminas = (int) (peso * 0.9);
        } else {
            return porcionVitaminas;
        }

        if (edad < 18) {
            porcionVitaminas = (int) (porcionVitaminas * 1.2);
        } else if (edad > 50) {
            porcionVitaminas = (int) (porcionVitaminas * 0.9);
        }

        if ("mujer".equals(sexo)) {
            porcionVitaminas = (int) (porcionVitaminas * 0.9);
        }

        if ("baja".equals(frecuencia)) {
            porcionVitaminas = (int) (porcionVitaminas * 1.2);
        } else if ("moderada".equals(frecuencia)) {
            porcionVitaminas = (int) (porcionVitaminas * 1.4);
        } else if ("alta".equals(frecuencia)) {
            porcionVitaminas = (int) (porcionVitaminas * 1.6);
        }

        return porcionVitaminas;
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
    public String getServletInfo() {
        return "Calculocomidas";
    }
}

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

@WebServlet(name = "DietaspersoCreadas", urlPatterns = {"/DietaspersoCreadas"})
public class DietaspersoCreadas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        Integer idUsuario = (Integer) session.getAttribute("id_usuario");
        String nombredieta = (String) request.getParameter("nombreDieta");

        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Login.html?error=sesion");
            return;
        }

        String url = "jdbc:mysql://localhost/FitData";
        String user = "root";
        String password = "AT10220906";

        String[] proteinasSeleccionadas = (String[]) request.getAttribute("proteinasComida");
        Integer porcionProteina = (Integer) request.getAttribute("porcionProteinaComida");

        String[] carbohidratosSeleccionados = (String[]) request.getAttribute("carbohidratosComida");
        Integer porcionCarbohidrato = (Integer) request.getAttribute("porcionCarbohidratoComida");

        String[] vitaminasSeleccionadas = (String[]) request.getAttribute("vitaminasComida");
        Integer porcionVitamina = (Integer) request.getAttribute("porcionVitaminasComida");

        String[] grasasSeleccionadas = (String[]) request.getAttribute("grasasComida");
        Integer porcionGrasa = (Integer) request.getAttribute("porcionGrasasComida");

        
        try (Connection con = DriverManager.getConnection(url, user, password)) {
    Class.forName("com.mysql.cj.jdbc.Driver").newInstance();

    int[] idComidas = crearRegistroComidas(con, idUsuario, proteinasSeleccionadas, carbohidratosSeleccionados,
                    vitaminasSeleccionadas, grasasSeleccionadas, porcionProteina, porcionCarbohidrato, porcionVitamina, porcionGrasa, nombredieta);

    ArrayList<ArrayList<Object>> listaComidas = new ArrayList<>();
    
    for (int i = 0; i < idComidas.length; i++) {
        if (idComidas[i] > 0) {

            ArrayList<Object> comida = new ArrayList<>();
            comida.add(idComidas[i]);
            comida.add(proteinasSeleccionadas[i]);
            comida.add(carbohidratosSeleccionados[i]);
            comida.add(vitaminasSeleccionadas[i]);
            comida.add(grasasSeleccionadas[i]);
            comida.add(porcionProteina);
            comida.add(porcionCarbohidrato);
            comida.add(porcionVitamina);
            comida.add(porcionGrasa);

            listaComidas.add(comida);
        } else {
            response.getWriter().print("Error: No se pudo crear el registro de una de las comidas.");
            return;
        }
    }

    session.setAttribute("comidas", listaComidas);
    request.getRequestDispatcher("Menuscreados.jsp").forward(request, response);

} catch (Exception e) {
    response.getWriter().print("Error: " + e.getMessage());
    e.printStackTrace();
}
    }
    

    private int[] crearRegistroComidas(Connection con, int idUsuario, String[] proteinas, String[] carbohidratos,
                                    String[] vitaminas, String[] grasas, int porcionProteina, int porcionCarbohidrato,
                                    int porcionVitamina, int porcionGrasa, String nombreDieta) throws SQLException {
        String query = "INSERT INTO Comidas (id_usuario, proteina, carbohidrato, vitamina, grasa, porcion_proteina, porcion_carbohidrato, porcion_vitamina, porcion_grasa, nombre_dieta) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        int[] idComidas = new int[5];
        try (PreparedStatement sta = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            for (int i = 0; i < 5; i++) {
                sta.setInt(1, idUsuario);
                sta.setString(2, proteinas[i]);
                sta.setString(3, carbohidratos[i]);
                sta.setString(4, vitaminas[i]);
                sta.setString(5, grasas[i]);
                sta.setInt(6, porcionProteina);
                sta.setInt(7, porcionCarbohidrato);
                sta.setInt(8, porcionVitamina);
                sta.setInt(9, porcionGrasa);
                sta.setString(10, nombreDieta);
                sta.executeUpdate();

                try (ResultSet rs = sta.getGeneratedKeys()) {
                    if (rs.next()) {
                        idComidas[i] = rs.getInt(1);
                    }
                }
            }
        }
        return idComidas;
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
        return "Dietas personalizadas creadas";
    }
}

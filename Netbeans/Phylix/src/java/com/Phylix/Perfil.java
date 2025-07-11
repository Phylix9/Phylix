package com.Phylix;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "Perfil", urlPatterns = {"/Perfil"})
public class Perfil extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id_usuario") == null) {
            response.sendRedirect("Acceder?error=sesion");
            return;
        }

        int idUsuario = (int) session.getAttribute("id_usuario");
        String url = "jdbc:mysql://ballast.proxy.rlwy.net:25248/railway?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = "YvAwfIKqPUtHThKEnCFTrKTgxZssaUIE";

        Connection con = null;
        PreparedStatement Cuestionario = null;
        PreparedStatement Usuario = null;
        ResultSet rsCuestionario = null;
        ResultSet rsUsuario = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);

            Cuestionario = con.prepareStatement("SELECT * FROM Cuestionario WHERE id_usuario = ?");
            Cuestionario.setInt(1, idUsuario);
            rsCuestionario = Cuestionario.executeQuery();
            

            if (rsCuestionario.next()) {
                session.setAttribute("nombre", rsCuestionario.getString("nombre_completo"));
                session.setAttribute("condiciones", rsCuestionario.getString("condicion_usuario"));
                session.setAttribute("medicamentos", rsCuestionario.getString("medicamento_usuario"));
                session.setAttribute("actividad", rsCuestionario.getString("frecuencia_usuario"));
                session.setAttribute("objetivos", rsCuestionario.getString("objetivo_usuario"));
                session.setAttribute("alergias", rsCuestionario.getString("alergias_usuario"));
                session.setAttribute("restricciones", rsCuestionario.getString("restriccion_usuario"));
                session.setAttribute("estres", rsCuestionario.getString("estres_usuario"));
                session.setAttribute("suenio", rsCuestionario.getString("sueno_usuario"));
            }

            Usuario = con.prepareStatement("SELECT * FROM Usuario WHERE id_usuario = ?");
            Usuario.setInt(1, idUsuario);
            rsUsuario = Usuario.executeQuery();
            
            if (rsUsuario.next()) {
                session.setAttribute("edad", rsUsuario.getString("edad_usuario"));
                session.setAttribute("genero", rsUsuario.getString("sexo_usuario"));
            }
            
            PreparedStatement stmtMedidas = con.prepareStatement("SELECT imc_usuario, peso_usuario, altura_usuario FROM Imc WHERE id_usuario = ?");
            stmtMedidas.setInt(1, idUsuario);
            ResultSet rsMedidas = stmtMedidas.executeQuery();
            
            List<clases.Medidas> medidas = new ArrayList<>();
            while (rsMedidas.next()) {
                clases.Medidas medida = new clases.Medidas();
                medida.setImc(rsMedidas.getDouble("imc_usuario"));
                medida.setPeso(rsMedidas.getDouble("peso_usuario"));
                medida.setAltura(rsMedidas.getDouble("altura_usuario"));
                medidas.add(medida);
            }
            
            request.setAttribute("medidas", medidas);
            
            request.getRequestDispatcher("Perfil.jsp").forward(request, response);


        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().print("Error: " + e.getMessage());
        } finally {
            try {
                if (rsCuestionario != null) rsCuestionario.close();
                if (Cuestionario != null) Cuestionario.close();
                if (Usuario != null) Usuario.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
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
    public String getServletInfo() {
        return "Servlet para mostrar perfil del usuario";
    }
}

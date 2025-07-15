package com.Phylix;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "RutinaDelDia", urlPatterns = {"/RutinaDelDia"})
public class RutinaDelDia extends HttpServlet {

    private final String url = "jdbc:mysql://ballast.proxy.rlwy.net:25248/railway?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
    private final String user = "root";
    private final String pass = "YvAwfIKqPUtHThKEnCFTrKTgxZssaUIE";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer id_usuario = (Integer) session.getAttribute("id_usuario");

        try (Connection con = DriverManager.getConnection(url, user, pass)) {
            // Obtener día de la semana en español
            String diaActual = "";
            switch (java.time.LocalDate.now().getDayOfWeek()) {
                case MONDAY: diaActual = "Lunes"; break;
                case TUESDAY: diaActual = "Martes"; break;
                case WEDNESDAY: diaActual = "Miercoles"; break;
                case THURSDAY: diaActual = "Jueves"; break;
                case FRIDAY: diaActual = "Viernes"; break;
                case SATURDAY: diaActual = "Sabado"; break;
                case SUNDAY: diaActual = "Domingo"; break;
            }
            
            request.setAttribute("nombre_dia", diaActual);

            // Obtener estado de la rutina para hoy
            String estado = "pendiente"; // default
            PreparedStatement estadoStmt = con.prepareStatement("SELECT estado FROM Rutinasper WHERE id_usuario = ? AND dia_rutina = ? ORDER BY id_rut DESC LIMIT 1");
            estadoStmt.setInt(1, id_usuario);
            estadoStmt.setString(2, diaActual);
            ResultSet estadoRs = estadoStmt.executeQuery();
            if (estadoRs.next()) {
                estado = estadoRs.getString("estado");
            }
            request.setAttribute("estado_rutina", estado);

            if (!estado.equals("descanso")) {
                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM Rutinasper WHERE id_usuario = ? AND dia_rutina = ? ORDER BY id_rut DESC LIMIT 1"
                );
                ps.setInt(1, id_usuario);
                ps.setString(2, diaActual);
                ResultSet rs = ps.executeQuery();

                List<Ejercicio> ejercicios = new ArrayList<>();

                if (rs.next()) {
                    for (int i = 1; i <= 9; i++) {
                        String ejercicio = rs.getString("ejercicio" + i);
                        String reps = rs.getString("reps" + i);
                        if (ejercicio != null && !ejercicio.trim().isEmpty()) {
                            ejercicios.add(new Ejercicio(ejercicio, reps));
                        }
                    }
                    request.setAttribute("nombre_rutina", rs.getString("nombre_rutina"));
                    request.setAttribute("ejercicios", ejercicios);
                }
            }

            request.getRequestDispatcher("DashboardServlet").forward(request, response);

        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
            e.printStackTrace(out);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer id_usuario = (Integer) session.getAttribute("id_usuario");
        String accion = request.getParameter("accion"); // "hecho" o "descanso"
        double progreso = 0;


        try (Connection con = DriverManager.getConnection(url, user, pass)) {
            // Obtener el día actual
            String diaActual = "";
            switch (java.time.LocalDate.now().getDayOfWeek()) {
                case MONDAY: diaActual = "Lunes"; break;
                case TUESDAY: diaActual = "Martes"; break;
                case WEDNESDAY: diaActual = "Miercoles"; break;
                case THURSDAY: diaActual = "Jueves"; break;
                case FRIDAY: diaActual = "Viernes"; break;
                case SATURDAY: diaActual = "Sabado"; break;
                case SUNDAY: diaActual = "Domingo"; break;
            }

            // Actualizar el estado en la tabla Rutinasper para el usuario y el día actual
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Rutinasper SET estado = ? " +
                "WHERE id_usuario = ? AND dia_rutina = ?"
            );
            ps.setString(1, accion);
            ps.setInt(2, id_usuario);
            ps.setString(3, diaActual);
            ps.executeUpdate();
            
            String estado = "pendiente"; // default
            PreparedStatement estadoStmt = con.prepareStatement("SELECT estado FROM Rutinasper WHERE id_usuario = ? AND dia_rutina = ? ORDER BY id_rut DESC LIMIT 1");
            estadoStmt.setInt(1, id_usuario);
            estadoStmt.setString(2, diaActual);
            ResultSet estadoRs = estadoStmt.executeQuery();
            if (estadoRs.next()) {
                estado = estadoRs.getString("estado");
            }
            
            if (estado.equals("hecho")) {
                PreparedStatement selectStmt = con.prepareStatement("SELECT progreso FROM usuario WHERE id_usuario = ?");
                selectStmt.setInt(1, id_usuario);
                ResultSet rs = selectStmt.executeQuery();

                if (rs.next()) {
                    progreso = rs.getDouble("progreso");
                    if (progreso < 85) {
                        progreso += (14.28);
                    }
                    else if (progreso < 100){
                        progreso += 14.32;
                    }
                }

                // Actualizar progreso
                PreparedStatement updateStmt = con.prepareStatement("UPDATE usuario SET progreso = ? WHERE id_usuario = ?");
                updateStmt.setDouble(1, progreso);
                updateStmt.setInt(2, id_usuario);
                updateStmt.executeUpdate();
            }

            response.sendRedirect("RutinaDelDia");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error interno del servidor: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Rutina del día con control de estado";
    }
}

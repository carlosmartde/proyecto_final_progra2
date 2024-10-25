/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author carlo
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener los datos del formulario de login
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Conectar a la base de datos y validar el usuario
        try (Connection con = DatabaseConnection.getConnection()) {
            String query = "SELECT id_rol, nombre FROM Usuario WHERE email = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int id_rol = rs.getInt("id_rol");
                String nombre = rs.getString("nombre");

                // Crear sesión para el usuario
                HttpSession session = request.getSession();
                session.setAttribute("nombre", nombre);
                session.setAttribute("email", email);
                session.setAttribute("id_rol", id_rol);

                // Redirigir según el rol
                switch (id_rol) {
                    case 1:
                        response.sendRedirect("vistaLider.jsp"); // Redirigir a la vista del líder
                        break;
                    case 2:
                        response.sendRedirect("vistaDeveloper.jsp"); // Redirigir a la vista del developer
                        break;
                    case 3:
                        response.sendRedirect("vistaCliente.jsp"); // Redirigir a la vista del cliente
                        break;
                    default:
                        request.setAttribute("error", "Rol no identificado.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                // Usuario no encontrado o contraseña incorrecta
                request.setAttribute("error", "Credenciales incorrectas.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en la base de datos."+e);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
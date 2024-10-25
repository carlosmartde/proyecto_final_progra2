/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
/**
 *
 * @author carlo
 */
@WebServlet(urlPatterns = {"/AgregarUsuarioServlet"})
public class AgregarUsuarioServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String genero = request.getParameter("genero"); 
        int rol = Integer.parseInt(request.getParameter("rol"));
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            String url = "jdbc:mysql://localhost:3306/mydb";
            String usuario = "root";
            String clave = "";
            conn = DriverManager.getConnection(url, usuario, clave);
            
            String sql = "INSERT INTO usuario (nombre, email, password, fechaNacimiento, genero, id_rol) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombre);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, fechaNacimiento);
            stmt.setString(5, genero);
            stmt.setInt(6, rol);
            
            int filasAfectadas = stmt.executeUpdate();
            
            if (filasAfectadas > 0) {
                response.sendRedirect("agregarUsuario.jsp?mensaje=Usuario agregado correctamente&status=success");
            } else {
                response.sendRedirect("agregarUsuario.jsp?mensaje=Error al agregar usuario");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("agregarUsuario.jsp?mensaje=Error en la base de datos: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
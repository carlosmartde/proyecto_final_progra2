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
        String fechaNacimiento = request.getParameter("fechaNacimiento"); // Nueva variable para fecha de nacimiento
        String genero = request.getParameter("genero"); // Nueva variable para género
        int rol = Integer.parseInt(request.getParameter("rol"));
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            // 1. Cargar el driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 2. Establecer la conexión con la base de datos
            String url = "jdbc:mysql://localhost:3306/mydb";
            String usuario = "root"; // Asegúrate de que sea el usuario correcto
            String clave = ""; // Asegúrate de que sea la contraseña correcta
            conn = DriverManager.getConnection(url, usuario, clave);
            
            // 3. Crear la consulta SQL para insertar un nuevo usuario
            String sql = "INSERT INTO usuario (nombre, email, password, fechaNacimiento, genero, id_rol) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombre);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, fechaNacimiento); // Insertar fecha de nacimiento
            stmt.setString(5, genero); // Insertar género
            stmt.setInt(6, rol);
            
            // 4. Ejecutar la consulta
            int filasAfectadas = stmt.executeUpdate();
            
            if (filasAfectadas > 0) {
                // Usuario agregado exitosamente
                response.sendRedirect("agregarUsuario.jsp?mensaje=Usuario agregado correctamente&status=success");
            } else {
                // Error al agregar usuario
                response.sendRedirect("agregarUsuario.jsp?mensaje=Error al agregar usuario");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Error en la base de datos
            response.sendRedirect("agregarUsuario.jsp?mensaje=Error en la base de datos: " + e.getMessage());
        } finally {
            // 5. Cerrar recursos
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
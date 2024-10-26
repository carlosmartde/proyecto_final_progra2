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
import java.sql.ResultSet;
import java.sql.Statement;
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
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            String url = "jdbc:mysql://localhost:3306/mydb";
            String usuario = "root";
            String clave = "";
            conn = DriverManager.getConnection(url, usuario, clave);
            
            // Inserta el nuevo usuario en la tabla `usuario`
            String sqlUsuario = "INSERT INTO usuario (nombre, email, password, fechaNacimiento, genero, id_rol) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sqlUsuario, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, nombre);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, fechaNacimiento);
            stmt.setString(5, genero);
            stmt.setInt(6, rol);
            
            int filasAfectadas = stmt.executeUpdate();
            
            // Obtiene el `id_usuario` generado
            int idUsuario = -1;
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                idUsuario = rs.getInt(1);
            }

            if (idUsuario > 0) {
                String sqlRol;
                
                if (rol == 1) {  // Rol Lider
                    sqlRol = "INSERT INTO lider (id_usuario, nombre, email, password, fechaNacimiento, genero) VALUES (?, ?, ?, ?, ?, ?)";
                } else if (rol == 2) {  // Rol Developer
                    sqlRol = "INSERT INTO developer (id_usuario, nombre, email, password, fechaNacimiento, genero) VALUES (?, ?, ?, ?, ?, ?)";
                } else if (rol == 3) {  // Rol Cliente
                    sqlRol = "INSERT INTO cliente (id_usuario, nombre, email, password, fechaNacimiento, genero) VALUES (?, ?, ?, ?, ?, ?)";
                } else {
                    throw new IllegalArgumentException("Rol no reconocido");
                }
                
                // Inserta en la tabla correspondiente según el rol
                stmt = conn.prepareStatement(sqlRol);
                stmt.setInt(1, idUsuario);
                stmt.setString(2, nombre);
                stmt.setString(3, email);
                stmt.setString(4, password);
                stmt.setString(5, fechaNacimiento);
                stmt.setString(6, genero);
                
                stmt.executeUpdate();
                
                response.sendRedirect("agregarUsuario.jsp?mensaje=Usuario agregado correctamente&status=success");
            } else {
                response.sendRedirect("agregarUsuario.jsp?mensaje=Error al agregar usuario");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("agregarUsuario.jsp?mensaje=Error en la base de datos: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
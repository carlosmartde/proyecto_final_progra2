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
import java.util.Date;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author carlo
 */
@WebServlet("/CrearProyectoServlet")
public class CrearProyectoServlet extends HttpServlet {
    
    // Configuración de conexión a la base de datos
    private final String DB_URL = "jdbc:mysql://localhost:3306/mydb";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Parámetros del formulario
        String nombreProyecto = request.getParameter("nombreProyecto");
        String fechaCreacion = request.getParameter("fechaCreacion");
        String fechaFinalizacion = request.getParameter("fechaFinalizacion");
        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        int idDeveloper = Integer.parseInt(request.getParameter("idDeveloper"));
        
        // Obtener la lista de tareas desde el formulario
        String[] tareas = request.getParameterValues("tareas");
        
        Connection conn = null;
        PreparedStatement stmtProyecto = null;
        PreparedStatement stmtTarea = null;
        ResultSet generatedKeys = null;
        
        try {
            // Conexión a la base de datos
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // Insertar el nuevo proyecto en la tabla "proyecto"
            String sqlProyecto = "INSERT INTO proyecto (nombre_proyecto, fechaCreacion, fechaFinalizacion, id_cliente, id_developer) VALUES (?, ?, ?, ?, ?)";
            stmtProyecto = conn.prepareStatement(sqlProyecto, PreparedStatement.RETURN_GENERATED_KEYS);
            stmtProyecto.setString(1, nombreProyecto);
            stmtProyecto.setString(2, fechaCreacion);
            stmtProyecto.setString(3, fechaFinalizacion.isEmpty() ? null : fechaFinalizacion);
            stmtProyecto.setInt(4, idCliente);
            stmtProyecto.setInt(5, idDeveloper);
            stmtProyecto.executeUpdate();
            
            // Obtener el ID del proyecto recién creado
            generatedKeys = stmtProyecto.getGeneratedKeys();
            int idProyecto = 0;
            if (generatedKeys.next()) {
                idProyecto = generatedKeys.getInt(1);
            }
            
            // Insertar las tareas en la tabla "tarea"
            if (tareas != null && idProyecto != 0) {
                String sqlTarea = "INSERT INTO tarea (descripcion, id_proyecto) VALUES (?, ?)";
                stmtTarea = conn.prepareStatement(sqlTarea);
                for (String descripcion : tareas) {
                    stmtTarea.setString(1, descripcion);
                    stmtTarea.setInt(2, idProyecto);
                    stmtTarea.executeUpdate();
                }
            }
            
            // Redireccionar o mostrar mensaje de éxito
            response.sendRedirect("vistaLider.jsp");
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Manejo de errores
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al crear el proyecto");
        } finally {
            // Cerrar recursos
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (stmtProyecto != null) stmtProyecto.close();
                if (stmtTarea != null) stmtTarea.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
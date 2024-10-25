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
/**
 *
 * @author carlo
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Obtener los parámetros del formulario
    String nombre = request.getParameter("nombre");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String fechaNacimiento = request.getParameter("fechaNacimiento");
    String genero = request.getParameter("genero");
    int idRol = Integer.parseInt(request.getParameter("id_rol"));

    // Crear el objeto Usuario y asignar los valores
    Usuario nuevoUsuario = new Usuario();
    nuevoUsuario.setNombre(nombre);
    nuevoUsuario.setEmail(email);
    nuevoUsuario.setPassword(password);
    nuevoUsuario.setFechaNacimiento(fechaNacimiento);
    nuevoUsuario.setGenero(genero);
    nuevoUsuario.setIdRol(idRol);

    // Insertar el usuario en la base de datos
    UsuarioDAO usuarioDAO = new UsuarioDAO();
    try {
        boolean registroExitoso = usuarioDAO.registrarUsuario(nuevoUsuario);

        // Redirigir según el resultado del registro
        if (registroExitoso) {
            response.sendRedirect("login.jsp?mensaje=Registro exitoso, inicia sesión");
        } else {
            response.sendRedirect("register.jsp?error=Error en el registro, inténtalo de nuevo");
        }
    } catch (Exception e) {
        // Capturar cualquier excepción y mostrarla en la consola
        e.printStackTrace();
        response.sendRedirect("register.jsp?error=Error inesperado: " + e.getMessage());
    }
}
}
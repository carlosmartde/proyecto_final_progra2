/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

    
/**
 *
 * @author carlo
 */
public class UsuarioDAO {
    public Usuario validarUsuario(String email, String password) {
        String sql = "SELECT * FROM Usuario WHERE email = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setIdRol(rs.getInt("id_rol"));
                return usuario; // Usuario encontrado
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Usuario no encontrado
    }
    public boolean registrarUsuario(Usuario usuario) {
    String sql = "INSERT INTO Usuario (nombre, fechaNacimiento, email, password, genero, id_rol) VALUES (?, ?, ?, ?, ?, ?)";

    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
         
        stmt.setString(1, usuario.getNombre());
        stmt.setString(2, usuario.getFechaNacimiento());
        stmt.setString(3, usuario.getEmail());
        stmt.setString(4, usuario.getPassword());
        stmt.setString(5, usuario.getGenero());
        stmt.setInt(6, usuario.getIdRol());

        int filasInsertadas = stmt.executeUpdate();
        return filasInsertadas > 0;
    } catch (SQLException e) {
        // Imprimir la excepción para depurar
        e.printStackTrace();
        return false;
    }
}
}

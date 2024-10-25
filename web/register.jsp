<%-- 
    Document   : register
    Created on : 23/10/2024, 4:36:37 p. m.
    Author     : carlo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
</head>
<body>
    <h2>Registro de Usuario</h2>
    <form action="RegisterServlet" method="POST">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <label for="password">Contraseña:</label>
        <input type="password" id="password" name="password" required><br>

        <label for="fechaNacimiento">Fecha de Nacimiento:</label>
        <input type="date" id="fechaNacimiento" name="fechaNacimiento" required><br>

        <label for="genero">Género:</label>
        <input type="text" id="genero" name="genero" required><br>

        <label for="id_rol">Rol:</label>
        <select id="id_rol" name="id_rol" required>
            <option value="1">Líder</option>
            <option value="2">Developer</option>
            <option value="3">Cliente</option>
        </select><br>

        <input type="submit" value="Registrarse">
    </form>
</body>
</html>

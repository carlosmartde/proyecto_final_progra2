<%-- 
    Document   : agregarUsuario
    Created on : 24/10/2024, 3:47:59 p. m.
    Author     : carlo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Usuario - Dev Portal</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: 'Fira Code', monospace;
            background-color: #0d1117;
            color: #c9d1d9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: #161b22;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .form-container h1 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #58a6ff;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-container form {
            display: flex;
            flex-direction: column;
        }

        .form-container input, .form-container select {
            background-color: #0d1117;
            border: 1px solid #30363d;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 6px;
            color: #c9d1d9;
            font-size: 1rem;
        }

        .form-container input::placeholder {
            color: #8b949e;
        }

        .form-container input:focus, .form-container select:focus {
            border-color: #58a6ff;
            outline: none;
        }

        .form-container button {
            background-color: #238636;
            border: none;
            padding: 15px;
            border-radius: 6px;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .form-container button:hover {
            background-color: #2ea043;
        }

        .form-container .message {
            margin-top: 15px;
            font-size: 0.9rem;
            color: #f85149;
        }

        .form-container .success {
            color: #28a745;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Agregar Usuario</h1>
        <form action="AgregarUsuarioServlet" method="POST">
            <input type="text" name="nombre" placeholder="Nombre completo" required>
            <input type="email" name="email" placeholder="Correo electrónico" required>
            <input type="password" name="password" placeholder="Contraseña" required>
            <select name="rol" required>
                <option value="" disabled selected>Seleccionar Rol</option>
                <option value="1">Líder</option>
                <option value="2">Developer</option>
                <option value="3">Cliente</option>
            </select>
            <button type="submit">Agregar Usuario</button>
        </form>

        <% 
            String mensaje = request.getParameter("mensaje");
            if (mensaje != null) { 
        %>
            <div class="message <%= "success".equals(request.getParameter("status")) ? "success" : "" %>">
                <%= mensaje %>
            </div>
        <% } %>
    </div>
</body>
</html>
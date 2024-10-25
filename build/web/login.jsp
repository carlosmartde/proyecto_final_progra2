<%-- 
    Document   : login
    Created on : 23/10/2024, 4:20:06 p. m.
    Author     : carlo
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Dev Portal</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;600&display=swap');
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

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

        .login-container {
            background-color: #161b22;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .login-container h1 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #58a6ff;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .login-container form {
            display: flex;
            flex-direction: column;
        }

        .login-container input {
            background-color: #0d1117;
            border: 1px solid #30363d;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 6px;
            color: #c9d1d9;
            font-size: 1rem;
        }

        .login-container input::placeholder {
            color: #8b949e;
        }

        .login-container input:focus {
            border-color: #58a6ff;
            outline: none;
        }

        .login-container button {
            background-color: #238636;
            border: none;
            padding: 15px;
            border-radius: 6px;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .login-container button:hover {
            background-color: #2ea043;
        }

        .login-container a {
            color: #58a6ff;
            text-decoration: none;
            font-size: 0.9rem;
            margin-top: 10px;
        }

        .login-container a:hover {
            text-decoration: underline;
        }

        .message {
            margin-bottom: 15px;
            font-size: 0.9rem;
            color: #f85149;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form action="LoginServlet" method="POST">
            <input type="email" name="email" placeholder="Correo electrónico" required>
            <input type="password" name="password" placeholder="Contraseña" required>
            <button type="submit">Entrar</button>
        </form>

        <% 
            String error = (String) request.getAttribute("error");
            if (error != null) { 
        %>
            <div class="message"><%= error %></div>
        <% } %>
    </div>
</body>
</html>
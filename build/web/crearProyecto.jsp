<%-- 
    Document   : crearProyecto
    Created on : 24/10/2024, 11:27:10 p. m.
    Author     : carlo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Proyecto</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #1e1e1e;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: #2b2b2b;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 100%;
        }

        .form-container h1 {
            color: #4caf50;
            margin-bottom: 20px;
        }

        .form-container label, .form-container select, .form-container input, .form-container button {
            display: block;
            width: 100%;
            margin-bottom: 15px;
        }

        .form-container button {
            background-color: #4caf50;
            border: none;
            padding: 10px;
            border-radius: 6px;
            cursor: pointer;
            color: #fff;
        }

        .form-container button:hover {
            background-color: #388e3c;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Crear Nuevo Proyecto</h1>
        <form action="CrearProyectoServlet" method="POST">
            <label for="nombre">Nombre del Proyecto:</label>
            <input type="text" name="nombre" id="nombre" required>

            <label for="cliente">Cliente:</label>
            <input type="text" name="cliente" id="cliente" required>

            <label for="developer">Developer a Cargo:</label>
            <select name="developer" id="developer">
                <%-- Aquí obtendremos los developers de la base de datos --%>
                <% 
                    List<Developer> developers = (List<Developer>) request.getAttribute("developers");
                    if (developers != null) {
                        for (Developer dev : developers) {
                %>
                            <option value="<%= dev.getId() %>"><%= dev.getNombre() %></option>
                <% 
                        }
                    }
                %>
            </select>

            <button type="submit">Crear Proyecto</button>
        </form>
    </div>
</body>
</html>

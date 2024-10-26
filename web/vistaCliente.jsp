<%-- 
    Document   : vistaCliente
    Created on : 23/10/2024, 4:19:37 p. m.
    Author     : carlo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
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
            margin: 0;
            padding: 20px;
        }
        form {
            max-width: 600px;
            margin: 0 auto;
            background-color: #2b2b2b;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
        }
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }
        input, select, button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: none;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="date"] {
            color: #333;
        }
        button {
            background-color: #4caf50;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #388e3c;
        }
        #task-container {
            margin-bottom: 20px;
        }
        .task-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .task-item input {
            flex: 1;
            margin-right: 10px;
            min-width: 250px; /* Aumenta el tamaño mínimo del campo */
        }
    </style>
</head>
<body>
    <h1>Crear Proyecto</h1>

    <form action="CrearProyectoServlet" method="post">
        <label for="nombreProyecto">Nombre del Proyecto:</label>
        <input type="text" id="nombreProyecto" name="nombreProyecto" required>

        <label for="idCliente">Asignar Cliente:</label>
        <select id="idCliente" name="idCliente" required>
            <option value="">Selecciona un cliente</option>
            <% 
                Connection conn = null;
                try {
                    // Conectar una sola vez a la base de datos
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "");

                    // Obtener la lista de clientes
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT id_cliente, nombre FROM cliente");
                    while (rs.next()) {
                        out.println("<option value=\"" + rs.getInt("id_cliente") + "\">" + rs.getString("nombre") + "</option>");
                    }
                    rs.close();
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </select>

        <label for="idDeveloper">Asignar Developer:</label>
        <select id="idDeveloper" name="idDeveloper" required>
            <option value="">Selecciona un developer</option>
            <% 
                try {
                    // Obtener la lista de developers
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT id_developer, nombre FROM developer");
                    while (rs.next()) {
                        out.println("<option value=\"" + rs.getInt("id_developer") + "\">" + rs.getString("nombre") + "</option>");
                    }
                    rs.close();
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (conn != null) {
                        try {
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </select>

        <label for="fechaCreacion">Fecha de Creación:</label>
        <input type="date" id="fechaCreacion" name="fechaCreacion" required>

        <label for="fechaFinalizacion">Fecha de Finalización:</label>
        <input type="date" id="fechaFinalizacion" name="fechaFinalizacion">

        <div id="task-container">
            <label>Tareas:</label>
            <!-- Tareas individuales -->
            <div class="task-item">
                <input type="text" name="tareas[]" placeholder="Descripción de la tarea">
                <button type="button" onclick="addTask()">Agregar otra tarea</button>
            </div>
        </div>

        <button type="submit">Guardar Proyecto</button>
    </form>

    <script>
        function addTask() {
            const taskContainer = document.getElementById('task-container');
            const newTask = document.createElement('div');
            newTask.classList.add('task-item');
            newTask.innerHTML = '<input type="text" name="tareas[]" placeholder="Descripción de la tarea" style="min-width: 250px;"><button type="button" onclick="removeTask(this)">Eliminar</button>';
            taskContainer.appendChild(newTask);
        }

        function removeTask(button) {
            const taskItem = button.parentElement;
            taskItem.remove();
        }
    </script>
</body>
</html>
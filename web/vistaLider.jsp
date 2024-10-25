<%-- 
    Document   : vistaLider
    Created on : 23/10/2024, 4:18:59 p. m.
    Author     : carlo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vista Líder - Proyectos</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #1e1e1e;
            color: #fff;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #4caf50;
            margin-bottom: 40px;
            font-weight: 300;
        }

        .project-card {
            background-color: #2b2b2b;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
            padding: 20px;
            max-width: 400px;
            margin: 20px auto;
            transition: transform 0.3s ease;
        }

        .project-card:hover {
            transform: translateY(-10px);
        }

        .project-header {
            font-size: 1.8rem;
            color: #ff9800;
            margin-bottom: 15px;
            font-weight: 400;
        }

        .progress-bar-container {
            background-color: #444;
            border-radius: 16px;
            height: 12px;
            margin-bottom: 20px;
            overflow: hidden;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.5);
        }

        .progress-bar {
            background: linear-gradient(90deg, #76c7c0, #34eb83);
            height: 100%;
            width: 0%;
            border-radius: 16px;
        }
        .create-user-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .create-user-button:hover {
            background-color: #388e3c;
        }

        .project-info {
            font-size: 1rem;
            color: #aaa;
            margin-bottom: 20px;
        }

        .tasks-list {
            list-style-type: none;
            padding: 0;
        }

        .tasks-list li {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .tasks-list input[type="checkbox"] {
            appearance: none;
            background-color: #3e3e3e;
            border: 2px solid #ff9800;
            border-radius: 4px;
            width: 20px;
            height: 20px;
            margin-right: 10px;
            transition: background-color 0.2s ease;
        }

        .tasks-list input[type="checkbox"]:checked {
            background-color: #ff9800;
        }

        .tasks-list label {
            font-size: 1.1rem;
            color: #ddd;
        }
    </style>
</head>
<body>
    
    <a href="agregarUsuario.jsp" class="create-user-button">Crear Usuario</a>
    
    <h1>Proyectos de Desarrollo</h1>

    <div class="project-card">
        <div class="project-header">Proyecto Alpha</div>
        
        <div class="progress-bar-container">
            <div class="progress-bar" id="progress-bar"></div>
        </div>
        
        <div class="project-info">Encargado: Developer 1</div>
        
        <ul class="tasks-list" id="tasks-list">
            <li><input type="checkbox" class="task-checkbox" id="task-1"><label for="task-1">Tarea 1</label></li>
            <li><input type="checkbox" class="task-checkbox" id="task-2"><label for="task-2">Tarea 2</label></li>
            <li><input type="checkbox" class="task-checkbox" id="task-3"><label for="task-3">Tarea 3</label></li>
            <li><input type="checkbox" class="task-checkbox" id="task-4"><label for="task-4">Tarea 4</label></li>
            <li><input type="checkbox" class="task-checkbox" id="task-5"><label for="task-5">Tarea 5</label></li>
        </ul>
    </div>

    <script>
        const checkboxes = document.querySelectorAll('.task-checkbox');
        const progressBar = document.getElementById('progress-bar');
        const totalTasks = checkboxes.length;

        function updateProgress() {
            let completedTasks = 0;
            checkboxes.forEach(checkbox => {
                if (checkbox.checked) {
                    completedTasks++;
                }
            });
            const progressPercentage = (completedTasks / totalTasks) * 100;
            progressBar.style.width = progressPercentage + '%';
        }

        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', updateProgress);
        });
    </script>
</body>
</html>

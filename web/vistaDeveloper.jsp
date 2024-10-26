<%-- 
    Document   : vistaDeveloper
    Created on : 23/10/2024, 4:19:19 p. m.
    Author     : carlo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vista Desarrollador - Tareas</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body { 
            font-family: 'Roboto', sans-serif;
               background-color: #1e1e1e; 
               color: #fff; 
               padding: 20px;
        }
        h1 { 
            text-align: center; 
            color: #4caf50; 
            margin-bottom: 40px;
        }
        .task-card {
            background-color: #2b2b2b;
            border-radius: 16px; 
            padding: 20px; 
            max-width: 400px; 
            margin: 0 auto; 
        }
        .task-header { 
            font-size: 1.8rem; 
            color: #ff9800; 
            margin-bottom: 15px;
        }
.progress-bar-container { 
            background-color: #444; 
            border-radius: 16px; 
            height: 12px; 
            margin-bottom: 20px;
        }
        .progress-bar { 
            background: linear-gradient(90deg, #76c7c0, #34eb83);
            height: 100%;
            width: 0%;
            border-radius: 16px;
        }
        .complete-task-button { 
            background-color: #4caf50; 
            color: #fff;
            padding: 10px 20px; 
            border: none; border-radius: 6px; 
            cursor: pointer; 
            margin-top: 10px; 
        }
        .complete-task-button:hover {
            background-color: #388e3c; 
        }
        .completion-message { 
            display: none; 
            color: #4caf50; 
            text-align: center;
        }
        .completed-tasks { 
            margin-top: 40px; 
        }
    </style>
</head>
<body>

    <h1>Tareas Asignadas</h1>

    <div class="task-card">
        <div class="task-header">Tarea: <span id="task-title">N/A</span></div>

        <div class="progress-bar-container">
            <div class="progress-bar" id="progress-bar"></div>
        </div>

        <button class="complete-task-button" id="complete-task">Marcar como Completada</button>
        <div id="completion-message" class="completion-message">Has realizado todas tus tareas, es hora de descansar!</div>
    </div>

    <div class="completed-tasks">
        <h2>Tareas Realizadas</h2>
        <div id="completed-tasks"></div>
    </div>

    <script>
        const taskTitle = document.getElementById('task-title');
        const progressBar = document.getElementById('progress-bar');
        const completeTaskButton = document.getElementById('complete-task');
        const completionMessage = document.getElementById('completion-message');

        let tareasCompletadas = 0;
        const totalTareas = 5; // Ajusta esto según el total de tareas

        const tareaAsignada = localStorage.getItem('tareaAsignada');
        if (tareaAsignada) {
taskTitle.textContent = tareaAsignada;
        } else {
            taskTitle.textContent = "N/A";
        }

        completeTaskButton.addEventListener('click', () => {
            if (tareasCompletadas < totalTareas) {
                tareasCompletadas++;
                progressBar.style.width = '100%';

                localStorage.setItem('tareasCompletadas', tareasCompletadas);
                localStorage.setItem('tareaCompletada', tareaAsignada);

                localStorage.setItem('tareaCompletadaNombre', tareaAsignada);

                const completedItem = document.createElement('div');
                completedItem.textContent = tareaAsignada;
                document.getElementById('completed-tasks').appendChild(completedItem);

                if (tareasCompletadas === totalTareas) {
                    completionMessage.style.display = 'block';
                }
            }
        });
    </script>
</body>
</html>
<%-- 
    Document   : crearTarea
    Created on : 25/10/2024, 7:43:24 p. m.
    Author     : carlo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vista Líder - Asignar Tarea</title>
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
        .task-form { 
            max-width: 400px;
            margin: 0 auto;
            background-color: #2b2b2b; 
            padding: 20px; 
            border-radius: 16px; 
        }
 .task-input { 
            width: 100%; 
            padding: 10px; 
            margin-bottom: 20px;
            border: none;
            border-radius: 6px; 
            background-color: #444;
            color: #fff; }
        .submit-button { 
            background-color: #4caf50;
            color: #fff; 
            padding: 10px 20px; 
            border: none; 
            border-radius: 6px; 
            cursor: pointer; 
            width: 100%; }
        .submit-button:hover {
            background-color: #388e3c; 
        }
        .task-list { 
            margin-top: 40px;
        }
        .task-item { 
            background-color: #2b2b2b;
            padding: 15px; 
            margin-bottom: 15px; 
            border-radius: 8px; 
        }
        .progress-bar-container { 
            background-color: #444;
            border-radius: 16px; 
            height: 12px; 
            margin-bottom: 10px; 
            position: relative;
}
        .progress-bar { 
            background: linear-gradient(90deg, #76c7c0, #34eb83);
            height: 100%; 
            width: 0%; 
            border-radius: 16px;
            position: relative;
        }
        .task-name-progress {
            position: absolute;
            width: 100%; 
            text-align: center;
            line-height: 12px;
            color: #fff; 
            font-size: 10px; 
        }
        .status-message { 
            color: #ff9800; 
        }
        .completed-tasks {
            margin-top: 40px; 
        }
    </style>
</head>
<body>

    <h1>Asignar Tarea</h1>

    <div class="task-form">
        <input type="text" id="task-name" class="task-input" placeholder="Nombre de la tarea" required>
        <button class="submit-button" id="assign-task">Enviar Tarea</button>
    </div>
<div id="feedback-message" style="text-align: center; color: #4caf50; display:none;"></div>

    <div class="task-list">
        <h2>Tareas Enviadas</h2>
        <div id="sent-tasks"></div>
    </div>

    <div class="completed-tasks">
        <h2>Tareas Realizadas</h2>
        <div id="completed-tasks"></div>
    </div>

    <script>
        document.getElementById('assign-task').addEventListener('click', () => {
            const taskName = document.getElementById('task-name').value;
            if (taskName) {
                localStorage.setItem('tareaAsignada', taskName);

                const taskItem = document.createElement('div');
                taskItem.className = 'task-item';
                taskItem.innerHTML = `
                    <div>${taskName}</div>
                    <div class="progress-bar-container">
                        <div class="progress-bar" style="width: 0%;"></div>
                        <div class="task-name-progress">${taskName}</div>
                    </div>
                    <div class="status-message">Esta tarea no se ha entregado.</div>
                `;
                document.getElementById('sent-tasks').appendChild(taskItem);

                document.getElementById('feedback-message').style.display = 'block';
                document.getElementById('task-name').value = ''; // Limpiar el input
            }
});

        window.addEventListener('storage', (event) => {
            if (event.key === 'tareasCompletadas') {
                const progressBars = document.querySelectorAll('.progress-bar');
                const completedTasksCount = Number(event.newValue);
                const tareaCompletadaNombre = localStorage.getItem('tareaCompletadaNombre');

                progressBars.forEach((bar, index) => {
                    if (index < completedTasksCount) {
                        bar.style.width = '100%';
                        bar.parentNode.nextElementSibling.textContent = 'Tarea completada.';
                    }
                });

                // Agregar el nombre de la tarea completada al apartado de tareas realizadas
                if (tareaCompletadaNombre) {
                    const completedItem = document.createElement('div');
                    completedItem.textContent = tareaCompletadaNombre;
                    document.getElementById('completed-tasks').appendChild(completedItem);
                }
            }
        });
    </script>
</body>
</html>
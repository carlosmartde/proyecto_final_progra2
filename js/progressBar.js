/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */
function progressBar(rol) {
    const progressBar = document.getElementById('progress-bar');

    if (rol === 1) {
        const checkboxes = document.querySelectorAll('.task-checkbox');
        try {
            checkboxes.forEach(checkbox => {
                checkbox.checked = localStorage.getItem(checkbox.id) ? true : false;
            });
        } catch (e) {
            console.log(e.message);
        }

        updateProgress(checkboxes, progressBar);
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function () {
                saveTask(checkbox);
                updateProgress(checkboxes, progressBar);

            });
        });
        console.log(progressBar);
    } else {
        const progressPercentage = (localStorage.getItem("completedTasks") / localStorage.getItem("totalTask")) * 100;
        progressBar.style.width = progressPercentage + '%';
        console.log(progressPercentage);
        console.log(progressBar);
        console.log(localStorage);
    }

}

function updateProgress(checkboxes, progressBar) {
    let completedTasks = 0;
    localStorage.setItem("totalTask", checkboxes.length);
    const totalTasks = checkboxes.length;
    checkboxes.forEach(checkbox => {
        if (localStorage.getItem(checkbox.id)) {
            completedTasks++;
        }
    });
    const progressPercentage = (completedTasks / totalTasks) * 100;
    localStorage.setItem("completedTasks", completedTasks);
    progressBar.style.width = progressPercentage + '%';
    console.log("updateProgress_terminar");
}

function saveTask(checkbox) {
    if (checkbox.checked) {
        localStorage.setItem(checkbox.id, "1");
    } else {
        localStorage.removeItem(checkbox.id);
    }
    ;
}

function update(){
    
    const progressPercentage = (localStorage.getItem("completedTasks") / localStorage.getItem("totalTask")) * 100;
        document.getElementById('progress-bar').style.width = progressPercentage + '%';
        console.log(progressPercentage);
}
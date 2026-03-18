// Кнопка "Генерировать/Очистить"
document.getElementById('gen-scene').onclick = function() {
    const widthInput = document.getElementById('map_width');
    const heightInput = document.getElementById('map_height');
    const width = widthInput ? parseInt(widthInput.value, 10) : scene.rows;
    const height = heightInput ? parseInt(heightInput.value, 10) : scene.cols;

    scene.generate(width, height);  // Сбрасываем массив в 1 с текущим размером
    screen.draw();  // Рисуем заново    
    document.getElementById('create-map').innerText = 'Создание карты';          // Меняем заголовок
    document.getElementById('info-coords').innerText = 'Выберите клетку';  // Стираем данные информации
    document.getElementById('info-type').innerText = '';                   // 
    document.getElementById('info-desc').innerText = '';                   // 
    document.getElementById('map-size-form').classList.remove("none");     // Показываем форму для ввода размера карты

    if (widthInput) widthInput.value = scene.rows;
    if (heightInput) heightInput.value = scene.cols;

    document.getElementById('terrain-select').value = '';                  // Сбрасываем селект
    document.getElementById('unit-select').value = '';                     //  
    document.getElementById('terrain-select').classList.remove("none");    // Показываем выбор территории
    document.getElementById('unit-select').classList.remove("none");       // Показываем выбор юнитов
    document.getElementById('end').classList.remove("none");               // Показываем кнопку "Завершить"
    flags = true;  // Разрешаем редактирование
};

// Кнопка "Завершить"
document.getElementById('end').onclick = function() {
    document.getElementById('create-map').innerText = 'Карта';        // Меняем заголовок
    document.getElementById('map-size-form').classList.add("none");   // Прячем форму для ввода размера карты
    document.getElementById('terrain-select').classList.add("none");  // Прячем выбор территории
    document.getElementById('unit-select').classList.add("none");     // Прячем выбор юнитов
    document.getElementById('end').classList.add("none");             // Прячем кнопку "Завершить"
    flags = false;  // Запрещаем редактирование 
};
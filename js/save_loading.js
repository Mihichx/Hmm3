// Сохранение карты
document.getElementById('save').onclick = function() {
    // Превращаем матрицу в строку JSON
    let mapData = JSON.stringify(scene.matrix);
    // Скачиваем файл
    system.save(mapData, 'my_strategy_map.json');
};

// Загрузка из файла
if (document.getElementById('fileLoad')) {
    // Вызываем функцию загрузки из внешней системы
    system.load('#fileLoad', loadedData);
}

// Выполнится, когда файл будет выбран и прочитан
function loadedData(content) {
    let loadedMatrix = JSON.parse(content.result);
    
    // Получаем количество доступных типов из справочника
    const terrainList = (typeList.list.terrain?.getList?.() || []);
    const availableTypes = Object.fromEntries(terrainList.map(item => [item.type, true]));

    for (let i = 0; i < loadedMatrix.length; i++) {
        for (let j = 0; j < loadedMatrix[i].length; j++) {
            let cell = loadedMatrix[i][j];

            if (!cell || !availableTypes[cell.terrain]) {
                cell = { terrain: 1, unit: null };
            }

            // Нормализуем отсутствие поля unit
            if (cell.unit === undefined) {
                cell.unit = null;
            }

            loadedMatrix[i][j] = cell;
        }
    }
    scene.matrix = loadedMatrix;
    scene.rows = loadedMatrix.length;
    scene.cols = loadedMatrix[0]?.length || 0;

    // Синхронизируем поля для размера карты
    const widthInput = document.getElementById('map_width');
    const heightInput = document.getElementById('map_height');
    if (widthInput) widthInput.value = scene.rows;
    if (heightInput) heightInput.value = scene.cols;

    // Обновляем URL без перезагрузки (чтобы новая ширина/высота сохранились)
    const url = new URL(window.location);
    url.searchParams.set('map_width', scene.rows);
    url.searchParams.set('map_height', scene.cols);
    window.history.replaceState(null, '', url);

    screen.draw();
}
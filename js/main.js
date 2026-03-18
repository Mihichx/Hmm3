const urlParams = new URLSearchParams(window.location.search);

// Добавляем значение по умолчанию (например, 10), если в URL пусто
let mapData = {
    width: parseInt(urlParams.get('map_width')) || 10,
    height: parseInt(urlParams.get('map_height')) || 10,
};

let flags = true;                                 // Разрешено ли редактирование прямо сейчас
let scene = new Scene(mapData);                   // Создаем логику
let screen = new Screen(scene, 'map-container');  // Создаем экран

// Настройка списка типов
window.unitMap = {}; // глобальный справочник юнитов (id -> объект из БД)

typeList
    .setPath('answer.php') 
    .addType({code: 'terrain', name: "Ландшафт", column: "name"})  // Указываем колонку с именем
    .addType({code: 'units', name: "Юниты", column: "name"})
    .load(() => {
        // Данные загружены! Заполняем selects
        const terrainSelector = document.getElementById('terrain-select');
        const terrains = typeList.list.terrain.getList();  // Получаем кэшированный список

        if (terrains) {
            terrains.forEach(item => {
                let option = document.createElement('option');
                option.value = item.type;  // Это ID или код из БД
                option.textContent = item.name;
                terrainSelector.appendChild(option);
            });
        }

        const unitSelector = document.getElementById('unit-select');
        const units = typeList.list.units.getList();

        if (units) {
            units.forEach(item => {
                let option = document.createElement('option');
                option.value = item.type;
                option.textContent = item.name;
                unitSelector.appendChild(option);

                const fullUnit = typeList.list.units.getOne(item.type);
                const normalizedUnit = {
                    id: fullUnit?.id ?? Number(item.type),
                    name: fullUnit?.name ?? item.name,
                    type: fullUnit?.name ?? item.name,
                    icon: fullUnit?.icon || fullUnit?.img || './img/icon.png',
                    health: fullUnit?.Health ?? null,
                    speed: fullUnit?.speed ?? null,
                    attack: fullUnit?.Attack ?? null,
                    protection: fullUnit?.Protection ?? null,
                    min_damage: fullUnit?.min_damage ?? null,
                    max_damage: fullUnit?.max_damage ?? null,
                    ammunition: fullUnit?.ammunition ?? null,
                };

                window.unitMap[item.type] = normalizedUnit;
            });
        }

        console.log("Редактор готов. Данные ландшафтов:", terrains);
        console.log("Редактор готов. Данные юнитов:", unitMap);

        // Синхронизация селектов: при выборе одного - сбрасываем второй
        const terrainSelect = document.getElementById('terrain-select');
        const unitSelect = document.getElementById('unit-select');

        if (terrainSelect && unitSelect) {
            terrainSelect.addEventListener('change', () => {
                if (terrainSelect.value) {
                    unitSelect.value = '';
                }
            });
            unitSelect.addEventListener('change', () => {
                if (unitSelect.value) {
                    terrainSelect.value = '';
                }
            });
        }
    });

// Первый запуск отрисовки
screen.draw();
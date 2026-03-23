const urlParams = new URLSearchParams(window.location.search);

// Валидация размера карты (мин 5, макс 100)
function validateMapSize(size, defaultSize = 10) {
    const parsed = parseInt(size);
    if (isNaN(parsed) || parsed < 5) return defaultSize;
    if (parsed > 100) return 100;
    return parsed;
}

// Добавляем значение по умолчанию (например, 10), если в URL пусто
let mapData = {
    width: validateMapSize(urlParams.get('map_width')),
    height: validateMapSize(urlParams.get('map_height')),
};

let flags = true;                                 // Разрешено ли редактирование прямо сейчас
let end_step = false;
let unit_real_mas = [];
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
                const unitSpeed = fullUnit?.speed ?? 5;
                const normalizedUnit = {
                    id: fullUnit?.id ?? Number(item.type),
                    name: fullUnit?.name ?? item.name,
                    type: fullUnit?.name ?? item.name,
                    icon: `./img/${fullUnit?.icon}`,
                    health: fullUnit?.Health ?? null,
                    speed: unitSpeed,
                    stamina: {
                        current: unitSpeed,
                        max: unitSpeed
                    },
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

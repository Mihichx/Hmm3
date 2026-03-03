/**
 * КЛАСС SCENE: Отвечает только за данные (логику)
 * Хранит информацию о том, где какая плитка находится.
 */
const urlParams = new URLSearchParams(window.location.search);

// Добавляем значение по умолчанию (например, 10), если в URL пусто
let mapData = {
    width: parseInt(urlParams.get('map_width')),
    height: parseInt(urlParams.get('map_height')),
};
console.log(mapData);

class Scene {
  constructor(data) {
    // Проверка: если data вдруг придет пустой, берем дефолты
    const config = data;
    
    this.rows = config.width;
    this.cols = config.height;
    this.matrix = []; // Двумерный массив (сетка координат)
    this.generate();  // Сразу создаем пустую сетку
  }

  // Заполняет матрицу значением "1" (например, трава)
  generate() {
    for (let i = 0; i < this.rows; i++) {
      this.matrix[i] = []; // Создаем строку
      for (let j = 0; j < this.cols; j++) {
        this.matrix[i][j] = 0; // В каждый столбец пишем 0 (Вода)
      }
    }
  }

  // Получает значение ячейки (тип территории) по координатам
  getCell(i, j) {
    return this.matrix[i][j];
  }

  // Меняет тип территории и сохраняет всю карту в текстовое поле для экспорта
  setCell(i, j, value) {
    this.matrix[i][j] = value;
  }
}

/**
 * КЛАСС SCREEN: Отвечает за визуализацию (HTML/DOM)
 * Рисует таблицу и обрабатывает клики пользователя.
 */
class Screen {
  constructor(scene, containerId) {
    this.scene = scene; // Связываем экран с данными сцены
    this.container = document.getElementById(containerId); // Где рисовать таблицу
    this.b = false;
  }

  // Рисует всю таблицу с нуля (вызывается при старте или загрузке файла)
  draw() {
    let table = document.createElement('table');
    table.className = 'map-table';
    table.onclick = (e) => this.delegateHandler(e);

    for (let i = 0; i < this.scene.matrix.length; i++) {
      let tr = document.createElement('tr');
      for (let j = 0; j < this.scene.matrix[i].length; j++) {
        let td = document.createElement('td');

        const cellValue = this.scene.matrix[i][j];
        td.className = 'terrain-' + cellValue;
        td.dataset.coord = `${i}_${j}`; // Теперь сохраняются числа
        tr.appendChild(td);
      }
      table.appendChild(tr);
    }
    this.container.innerHTML = '';
    this.container.appendChild(table);
  }
  displayInfo(i, j, value) {
    const coordsElement = document.getElementById('info-coords');
    const typeElement = document.getElementById('info-type');
    const descElement = document.getElementById('info-desc');
    const data = terrainNames[value] || terrainNames[String(value)];
    if (coordsElement) coordsElement.innerText = `${i}, ${j}`;
    if (typeElement) typeElement.innerText = data.name;
    if (descElement) descElement.innerText = data.description;
    console.log(`координаты клетки: [${i}, ${j}]. Тип: ${data.name}`);
  }

  // Обработчик клика по таблице
  delegateHandler(event) {
    const target = event.target; // Элемент, по которому реально попал клик
    
    // Если кликнули не по ячейке (а, например, по рамке таблицы), выходим
    if (target.tagName !== 'TD') return;

    // Извлекаем координаты из data-coord (превращаем "5_10" в числа 5 и 10)
    const [i, j] = target.dataset.coord.split('_').map(Number);
    const currentValue = this.scene.getCell(i, j);
    this.displayInfo(i, j, currentValue);
    
    if (flags == true) {
      this.updateCell(target, i, j);
    } else {
      if (this.b == false) {
        this.updateCell1(target, i, j);
      } else {
        this.updateCell2(target, i, j);
        this.b = false;
      }
    }
  }

  // МЕНЯЕМ ТОЛЬКО ОДНУ ЯЧЕЙКУ (без перерисовки всей таблицы)
  updateCell(tdElement, i, j) {
    console.log(0);
    // Берем выбранный ID ландшафта из выпадающего списка
    let selected = parseInt(document.getElementById('terrain-select').value);
    
    // 1. Обновляем "мозг" программы (массив в Scene)
    this.scene.setCell(i, j, selected);
    
    // 2. Обновляем внешний вид (просто меняем класс у конкретного TD)
    tdElement.className = 'terrain-' + selected;   
  }
  updateCell1(tdElement, i, j) {
    console.log(tdElement.className);
    this.a = tdElement.className;
    if (this.a !== "terrain-6") {return}
    // 1. Обновляем "мозг" программы (массив в Scene)
    this.scene.setCell(i, j, 0);
    
    // 2. Обновляем внешний вид (просто меняем класс у конкретного TD)
    tdElement.className = 'terrain-0';
    this.b = true;
    console.log(1);
  }
  updateCell2(tdElement, i, j) {
    console.log(2);
    let f = Number(this.a.at(-1));
    // 1. Обновляем "мозг" программы (массив в Scene)
    this.scene.setCell(i, j, f);
    
    // 2. Обновляем внешний вид (просто меняем класс у конкретного TD)
    tdElement.className = this.a;   
  }
}

/**
 * ГЛОБАЛЬНЫЙ ЗАПУСК И КНОПКИ
 */
let flags = true; // Разрешено ли редактирование прямо сейчас
let scene = new Scene(mapData); // Создаем логику
let screen = new Screen(scene, 'map-container'); // Создаем экран

// Первый запуск отрисовки
screen.draw();

// Кнопка "Генерировать/Очистить"
document.getElementById('gen-scene').onclick = function() {
  scene.generate(); // Сбрасываем массив в 1
  screen.draw();    // Перерисовываем таблицу
  document.getElementById('terrain-select').classList.remove("none"); // Показываем выбор блоков
  document.getElementById('end').classList.remove("none"); // Показываем кнопку "Завершить"
  flags = true; // Разрешаем клики
};

// Кнопка "Завершить"
document.getElementById('end').onclick = function() {
  document.getElementById('terrain-select').classList.add("none"); // Прячем выбор
  document.getElementById('end').classList.add("none"); // Прячем саму кнопку
  flags = false; // ЗАПРЕЩАЕМ редактирование 
};

// Находим вашу кнопку и вешаем действие
document.getElementById('save').onclick = function() {
    // Превращаем матрицу в строку JSON
    let mapData = JSON.stringify(scene.matrix);
    // Скачиваем файл
    system.save(mapData, 'my_strategy_map.json');
};


/**
 * ЗАГРУЗКА ИЗ ФАЙЛА (если есть система загрузки)
 */
if (document.getElementById('fileLoad')) {
  // Вызываем функцию загрузки из внешней системы
  system.load('#fileLoad', loadedData);
}

// Выполнится, когда файл будет выбран и прочитан
function loadedData(content) {
  // 1. Превращаем строку из файла в настоящий массив
  let loadedMatrix = JSON.parse(content.result);

  // 2. Ищем и меняем значение (проходим по двумерному массиву)
  for (let i = 0; i < loadedMatrix.length; i++) {
    for (let j = 0; j < loadedMatrix[i].length; j++) {
      if (loadedMatrix[i][j] > 6  || loadedMatrix[i][j] < 0) {
        loadedMatrix[i][j] = 1;
      }
    }
  }

  // 3. Сохраняем результат в "мозг" программы и рисуем
  scene.matrix = loadedMatrix;
  screen.draw();
}

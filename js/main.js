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

class Scene {
  constructor(data) {
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
        this.matrix[i][j] = 1;
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
    this.units = [];
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
    const data = terrainNames[value];
    if (coordsElement) coordsElement.innerText = `${i}, ${j}`;
    // Проверяем, нашлись ли данные в terrainNames
    if (data) {
        if (typeElement) typeElement.innerText = data.name;
        if (descElement) descElement.innerText = data.description;
    } else {
        // Опционально: обработка случая, когда данные не найдены
        if (typeElement) typeElement.innerText = "Неизвестно";
        if (descElement) descElement.innerText = "Описание отсутствует";
        console.warn(`Данные для значения "${value}" не найдены в terrainNames`);
    }
  }

  // Обработчик клика по таблице
  delegateHandler(event) {
    const td = event.target.closest('td');
    if (!td) return; // Если кликнули мимо ячейки — выходим

    const [i, j] = td.dataset.coord.split('_').map(Number);

    if (flags == true) {
      this.updateCell(td, i, j);
      this.displayInfo(i, j, this.scene.getCell(i, j));
    } else {
      // Если в руках ничего нет (this.b == false) И в клетке есть юнит
      if (this.b === false) {
          this.updateCell1(td, i, j); // Забираем из ячейки
          this.displayInfo(i, j, this.scene.getCell(i, j));
      } 
      // Если в руках УЖЕ есть юнит (this.b == true)
      else if (this.b === true) {
          this.updateCell2(td, i, j); // Кладем в новую ячейку
          this.displayInfo(i, j, this.scene.getCell(i, j));
      }
    }
}

  // МЕНЯЕМ ТОЛЬКО ОДНУ ЯЧЕЙКУ (без перерисовки всей таблицы)
  updateCell(tdElement, i, j) {
    // Берем выбранный ID ландшафта из выпадающего списка
    let selected = parseInt(document.getElementById('terrain-select').value);
    if (selected == 5) {
      let img = document.createElement('img');
      img.src = './img/deadlock.png';
      img.classList.add('img-size');
      tdElement.appendChild(img);
      this.units.push(`${i}_${j}`);
      return;
    }
    
    // 1. Обновляем "мозг" программы (массив в Scene)
    this.scene.setCell(i, j, selected);
    
    // 2. Обновляем внешний вид (просто меняем класс у конкретного TD)
    tdElement.className = 'terrain-' + selected;   
  }
  updateCell1(tdElement, i, j) {
    const img = tdElement.querySelector('img');
    if (img) {
      this.a = img;    // Сохраняем КАРТИНКУ в переменную "a"
      img.remove();    // Удаляем КАРТИНКУ из HTML
      this.b = true;   // Теперь юнит "в руках"
    }
  }

  updateCell2(tdElement, i, j) {
    if (this.a) {
      // Если в целевой ячейке уже кто-то есть, можно либо запретить, 
      // либо очистить её перед вставкой:
      tdElement.innerHTML = ''; 
      
      tdElement.appendChild(this.a); // Вставляем сохраненную картинку
      this.a = null;                 // Руки пусты
      this.b = false;                // Сбрасываем флаг
    }
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
      if (loadedMatrix[i][j] > totalIds  || loadedMatrix[i][j] < 0) {
        loadedMatrix[i][j] = 1;
      }
    }
  }

  // 3. Сохраняем результат в "мозг" программы и рисуем
  scene.matrix = loadedMatrix;
  screen.draw();
}

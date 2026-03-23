/*
  SCREEN: Отвечает за визуализацию (HTML/DOM)
  Рисует таблицу и обрабатывает клики пользователя.
*/
class Screen {
  constructor(scene, containerId) {
    this.scene = scene;                                        // Связываем экран с данными сцены
    this.container = document.getElementById(containerId);    // Где рисовать таблицу
    this.taken = false;                                      // Отслеживание взятия юнита
    this.units = [];                                        // Массив с юнитами
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

        const cell = this.scene.getCell(i, j);
        td.className = 'terrain-' + cell.terrain;
        td.dataset.coord = `${i}_${j}`;
        if (cell.unit) {
          let img = document.createElement('img');
          img.src = cell.unit.icon;
          img.classList.add('img-size');
          td.appendChild(img);
        }
        tr.appendChild(td);  // Добавление ячейки(td) в строку(tr)
      }
      table.appendChild(tr);  // Добавление строки(tr) в таблицу
    }
    this.container.innerHTML = '';  // Очищает контейнер
    this.container.appendChild(table);  // Добавляем таблицу в контейнер
  }
  

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  // Отвечает за отображения информации о территории
  displayInfo(i, j) {
    const coordsElement = document.getElementById('info-coords');
    const typeElement = document.getElementById('info-type');
    const descElement = document.getElementById('info-desc');

    if (coordsElement) coordsElement.innerText = `${i}, ${j}`;
    const cell = this.scene.getCell(i, j);
    const terrainData = typeList.list.terrain.getOne(cell.terrain);

    if (terrainData) {
      if (typeElement) typeElement.innerText = terrainData?.name || 'Неизвестно';
      if (descElement) descElement.innerText = '\n Территория: ' + terrainData.description || "Описание отсутствует";
    }

    if (cell.unit) {
      const unitName = cell.unit.name || cell.unit.type || 'без имени';
      const unitStats = [];
      if (cell.unit.health != null) unitStats.push(`HP:${cell.unit.health}`);
      if (cell.unit.speed != null) unitStats.push(`SPD:${cell.unit.speed}`);
      if (cell.unit.attack != null) unitStats.push(`ATK:${cell.unit.attack}`);
      if (cell.unit.protection != null) unitStats.push(`DEF:${cell.unit.protection}`);

      if (typeElement) typeElement.innerText += ` + юнит ${unitName}`;
      if (descElement) descElement.innerText += `\n Юнит: ${unitName} ${unitStats.join(', ')}`;
    }
  }


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  // Обработчик клика по таблице
  delegateHandler(event) {
    const td = event.target.closest('td');
    if (!td) return;  // Если кликнули мимо ячейки — выходим

    const [i, j] = td.dataset.coord.split('_').map(Number);  // Достаём координаты из тега(td)

    if (flags == true) {  // Если редактирование разрешено
      this.updateCell(td, i, j);
      this.displayInfo(i, j);
    } else {
      // Если в руках ничего нет И если редактирование запрещено
      if (this.taken === false) {
          this.displayInfo(i, j);
          this.updateCell1(td);  // Забираем из ячейки
      } 
      // Если в руках есть юнит
      else if (this.taken === true) {
          this.updateCell2(td);  // Кладем в новую ячейку
          this.displayInfo(i, j);
      }
    }
  }


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////|


  // Изменение ячейки
  updateCell(tdElement, i, j) {
    const terrainSelectValue = parseInt(document.getElementById('terrain-select').value, 10);
    const unitSelectValue = parseInt(document.getElementById('unit-select').value, 10);

    // Если выбран terrain, ставим его в первую очередь (чтобы terrain можно было всегда менять)
    if (!isNaN(terrainSelectValue) && terrainSelectValue) {
      this.scene.setCell(i, j, terrainSelectValue, 'terrain');

      tdElement.className = 'terrain-' + terrainSelectValue;
      return;
    }

    // Если выбран юнит, ставим его на клетку
    if (!isNaN(unitSelectValue) && unitSelectValue) {
      const unit = window.unitMap && window.unitMap[unitSelectValue];
      if (!unit) {
        console.warn('Юнит не найден в справочнике:', unitSelectValue);
        return;
      }

      // сохраняем в модель
      this.scene.setCell(i, j, { ...unit }, 'unit');
      unit_real_mas.push({
          id: this.scene.getCell(i, j).unit.id,
          unit: this.scene.getCell(i, j).unit,
          coord: { i, j },  // Используем объект вместо строки
          stamina: {
            current: unit.stamina.max,
            max: unit.stamina.max
          }
      });
      console.table(unit_real_mas);

      // Обновляем DOM (рисуем иконку юнита)
      tdElement.innerHTML = '';
      tdElement.className = 'terrain-' + (this.scene.getCell(i, j).terrain || 1);
      const img = document.createElement('img');
      img.src = unit.icon;
      img.classList.add('img-size');
      tdElement.appendChild(img);

      return;
    }
    // Если ничего не выбрано, ничего не делаем
  }

  updateCell1(tdElement) {
    const img = tdElement.querySelector('img');
    if (img) {
      const [i, j] = tdElement.dataset.coord.split('_').map(Number);
      
      this.taken_unit = this.scene.getCell(i, j).unit;
      this.startCoords = { i, j }; // ПУНКТ 9: Запоминаем откуда идем
      for (const current_unit of unit_real_mas) {
        if (current_unit.coord.i === i && current_unit.coord.j === j) {
          this.unit = current_unit;
          break; // Оптимизация: выходим после первого совпадения
        }
      }
      
      img.classList.add('border');
      this.taken = true;
      this.taken_img = img;
    }
  }

  updateCell2(tdElement) {
    if (this.taken_unit && this.taken_img) {
      const [i, j] = tdElement.dataset.coord.split('_').map(Number);
      const targetCell = this.scene.getCell(i, j);

      if (targetCell && targetCell.unit) {
          alert('Клетка занята!');
          return;
      }

      // Проверяем линейность и выносливость через Scene
      if (this.scene.checkMove(this.startCoords, { i, j })) {
        // Если всё ок, перемещаем в модели
        this.scene.setCell(this.startCoords.i, this.startCoords.j, null, 'unit'); // Удаляем со старой
        this.scene.setCell(i, j, this.taken_unit, 'unit'); // Ставим на новую

        // Обновляем DOM
        tdElement.appendChild(this.taken_img);
        this.taken_img.classList.remove('border');
        
        // Сброс состояния
        this.taken = false;
        this.taken_unit = null;
        this.taken_img = null;
        this.startCoords = null;

        // Обновляем координаты юнита
        if (this.unit) {
          this.unit.coord = { i, j };
        }
        console.table(unit_real_mas);
      }
    }
  }
}
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Homm3</title>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" type="text/css" href="./css/terraincss.php">
    <link rel="icon" href="./img/icon.png">
    <script defer src="js/system.js"></script>
    <script defer src="./js/save_loading.js"></script>
    <script defer src="js/type.js"></script>
    <script defer src="./js/button.js"></script>
    <script defer src="./js/scene.js"></script>
    <script defer src="./js/screen.js"></script>
    <script defer src="./js/main.js"></script>
</head>
<body>
    <main class="map-main"> 
        <h2 id="create-map">Создание карты</h2>
        <div class="controls">
            <?php
                $width = isset($_GET['map_width']) ? (int)$_GET['map_width'] : 10;
                $height = isset($_GET['map_height']) ? (int)$_GET['map_height'] : 10;
            ?>
            <form method="GET" id="map-size-form">
                <input name="map_width" id="map_width" value="<?= $width ?>">
                <input name="map_height" id="map_height" value="<?= $height ?>">
                <button type="submit" style="width: 40px; height: 20px;">OK</button>
            </form>

            <button id="gen-scene" class="poly-btn">Стереть карту</button>
            <button id="save" onclick="system.save(document.getElementById('data').value);">Сохранить</button>
            <input type="file" id="fileLoad">

            <select id="terrain-select" class="poly-btn"><option value="">Выберите ландшафт</option></select>
            <select id="unit-select" class="poly-btn"><option value="">Выберите юнита</option></select>

            <button id="end">Закончить редактирование</button>

            <div id="inspector" class="inspector-panel">
                <h3>Информация о клетке</h3>
                <p>Координаты: <span id="info-coords">Выберите клетку</span></p>
                <p>Содержание клетки: <span id="info-type"></span></p>
                <p>Описание: <span id="info-desc"></span></p>
            </div>
        </div>
        <div id="map-container"></div>
    </main>
</body>
</html>

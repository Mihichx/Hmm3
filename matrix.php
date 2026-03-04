<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Anno Online</title>
    <link rel="stylesheet" type="text/css" href="./css/style.css">
    <script>
        const terrainNames = <?php 
            include './db.php';
            $link = mysqli_connect($host, $user, $password, $name);
            mysqli_set_charset($link, "utf8");
            $res = mysqli_query($link, 'SELECT id, name, description FROM terrain_homm');
            $terraindata = [];
            while ($row = mysqli_fetch_assoc($res)) {
                $terraindata[$row['id']] = [
                    'name' => $row['name'],
                    'description' => $row['description']
                    ];
            }
            echo json_encode($terraindata, JSON_UNESCAPED_UNICODE);
        ?>;
    </script>
    <script defer src="./js/system.js"></script>
    <script defer src="./js/main.js"></script>
    <style>
        <?include_once './css/terraincss.php'?>
    </style>
</head>
<body>
    <main class="map-main">
        <h2>Карта</h2>
        <div class="controls">
            <?
                $width = isset($_GET['map_width']) ? (int)$_GET['map_width'] : 10;
                $height = isset($_GET['map_height']) ? (int)$_GET['map_height'] : 10;
            ?>
            <form method="GET">
                <input name="map_width" id="map_width" value="<?= $width ?>"></input>
                <input name="map_height" id="map_height" value="<?= $height ?>"></input>
                <button type="submit" style="width: 40px; height: 20px;"></button>
            </form>
            <button id="gen-scene" class="poly-btn">Стереть карту</button>
            <button type="submit" id="save" onclick="let data = document.getElementById('data').value; system.save(data);">Сохранить</button>
            <input type="file" id="fileLoad"></input>
            <select id="terrain-select" class="poly-btn">
                <?foreach($terrain as $item):?>
                    <option value="<?=$item["id"];?>"><?=$item["name"]?></option>
                <?endforeach;?>
            </select>
            <button id="end">Закончить редактирование</button>
            <div id="inspector" class="inspector-panel">
                <h3>Информация о клетке</h3>
                <p>Координаты: <span id="info-coords">Выберите клетку</span></p>
                <p>Тип ландшафта: <span id="info-type"></span></p>
                <p>Описание: <span id="info-desc"></span></p>
            </div>
        </div>
        <div id="map-container"></div>
    </main>
</body>
</html>

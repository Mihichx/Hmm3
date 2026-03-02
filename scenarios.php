<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Сценарии Герои 3</title>
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>

<?php
// 1. НАСТРОЙКИ ПОДКЛЮЧЕНИЯ
    include_once './db.php';

// 2. ПОДКЛЮЧЕНИЕ К БАЗЕ
$conn = new mysqli($servername, $username, $password, $dbname);



// 3. SQL ЗАПРОС
// Берем данные из таблицы scenarios_hmm
$sql = "SELECT * FROM scenarios_hmm";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<table class='homm-table'>";
    echo "<thead>
            <tr>
                <th width='50'>#</th>
                <th width='80'>Игроки</th>
                <th width='60'>Размер</th>
                <th>Название сценария</th>
                <th width='150'>Условие победы</th>
            </tr>
          </thead>";
    echo "<tbody>";

    // 4. ЦИКЛ ВЫВОДА СТРОК
    while($row = $result->fetch_assoc()) {
        echo "<tr>";
        // Выводим ID
        echo "<td>" . $row["id"] . "</td>";
        
        // Формируем формат "4/4" (Всего / Людей)
        echo "<td>" . $row["players_total"] . "/" . $row["players_human"] . "</td>";
        
        // Размер карты
        echo "<td class='map-size'>" . $row["map_size"] . "</td>";
        
        // Название
        echo "<td class='title-col'>" . $row["title"] . "</td>";
        
        // Условие победы
        echo "<td>" . $row["victory_condition"] . "</td>";
        echo "</tr>";
    }
    echo "</tbody>";
    echo "</table>";
} 


?>

</body>
</html>
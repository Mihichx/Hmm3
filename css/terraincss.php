<?php
header("Content-type: text/css; charset: UTF-8");

session_start();
include __DIR__ . '/../setting.php'; 

$dsn = "mysql:host=localhost;dbname=" . $dbAuth['base'] . ";charset=utf8mb4";
$opt = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $db = new PDO($dsn, $dbAuth['user'], $dbAuth['password'], $opt);

    $query = "SELECT id, img_link FROM terrain";
    $stmt = $db->query($query);

    while ($row = $stmt->fetch()) {
        $id = (int)$row['id'];
        $img = preg_replace('/[^a-zA-Z0-9._\/-]/', '', $row['img_link']); // Санитизация пути
        echo ".terrain-$id {\n";
        echo "    background-image: url('../img/$img') !important;\n";
        echo "    background-size: cover !important;\n";
        echo "}\n";
    }
    
} catch (PDOException $e) {
    error_log('Terrain CSS Error: ' . $e->getMessage());
    echo "/* DB Error - Check logs */";
} catch (Exception $e) {
    error_log('Terrain CSS Error: ' . $e->getMessage());
    echo "/* Error - Check logs */";
}
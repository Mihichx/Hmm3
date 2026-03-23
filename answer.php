<?php
session_start();
include __DIR__ . '/setting.php';

// Whitelist для защиты от SQL-инъекций
$allowedTables = ['terrain', 'units'];
$table = isset($_POST['table']) ? $_POST['table'] : '';

// Валидация таблицы
if (!in_array($table, $allowedTables)) {
    header('Content-Type: application/json');
    http_response_code(400);
    echo json_encode(['error' => 'Invalid table']);
    exit();
}

$dbname = 'dbname=' . $dbAuth['base'] . ';';
$host = 'host=localhost';
$mdh = 'mysql:' . $dbname . $host;
$user = $dbAuth['user'];
$pass = $dbAuth['password'];
$opt = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => true,
    PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => true,
];

$db = null;

try {
    $db = new PDO($mdh, $user, $pass, $opt);
    
    // Безопасный запрос
    $query = "SELECT * FROM `" . $table . "`";
    $dbResult = $db->query($query);
    
    header('Content-Type: application/json');
    echo json_encode($dbResult->fetchAll());
    $dbResult->closeCursor();
    
} catch (PDOException $e) {
    header('Content-Type: application/json');
    http_response_code(500);
    error_log('DB Error: ' . $e->getMessage());
    echo json_encode(['error' => 'Database error. Check logs.']);
} catch (Exception $e) {
    header('Content-Type: application/json');
    http_response_code(500);
    error_log('Error: ' . $e->getMessage());
    echo json_encode(['error' => 'Server error. Check logs.']);
}
?>
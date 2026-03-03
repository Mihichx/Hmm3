<?
include_once './db.php';


$link = mysqli_connect($host, $user, $password, $name);
$query = 'SELECT * FROM terrain_homm';
$res = mysqli_query($link, $query);

$terrain = [];

while ($row = mysqli_fetch_assoc($res)) {
    $terrain[] = $row;    
}
?>
<?foreach($terrain as $item):
    echo ".terrain" ."-". $item["id"] . " {\n";
    echo "  background-image: url('" . $item["img_link"] . "');\n";
    echo "  background-size: cover;\n";
    echo "}\n";
?>
<?endforeach;?>
<?php
 include_once './db.php';


$link = mysqli_connect($host, $user, $password, $name);
?>

<?$query = 'SELECT * FROM building_hmm';
$res = mysqli_query($link, $query);

$data = [];

while ($row = mysqli_fetch_assoc($res)) {
    $data[] = $row;
}

?>

<h2>building hmm</h2>
<table>
    <?php foreach ($data as $item) {?>
        <tr>
            <td><?= $item['id'] ?></td>
            <td><?= $item['name'] ?></td>
            <td><?= $item['construction cost'] ?></td>
            <td><?= $item['Requirements'] ?></td>
            <td><?= $item['purpose'] ?></td>
            <td><?= $item['towns_id'] ?></td>
        </tr>
    <?php
    }?>
</table>

<?$query = 'SELECT * FROM fractions_hmm';
$res = mysqli_query($link, $query);

$data = [];

while ($row = mysqli_fetch_assoc($res)) {
    $data[] = $row;
}

?>

<h2>fractions hmm</h2>
<table>
    <?php foreach ($data as $item) {?>
        <tr>
            <td><?= $item['id'] ?></td>
            <td><?= $item['name'] ?></td>
            <td><?= $item['territory_id'] ?></td>
        </tr>
    <?php
    }?>
</table>

<?$query = 'SELECT * FROM hmm_magic_schools';
$res = mysqli_query($link, $query);

$data = [];

while ($row = mysqli_fetch_assoc($res)) {
    $data[] = $row;
}

?>

<h2>hmm magic schools</h2>
<table>
    <?php foreach ($data as $item) {?>
        <tr>
            <td><?= $item['id'] ?></td>
            <td><?= $item['name'] ?></td>
            <td><?= $item['icon'] ?></td>
            <td><?= $item['book_tab_icon'] ?></td>
        </tr>
    <?php
    }?>
</table>

<?$query = 'SELECT * FROM hmm_spells';
$res = mysqli_query($link, $query);

$data = [];

while ($row = mysqli_fetch_assoc($res)) {
    $data[] = $row;
}

?>

<h2>hmm spells</h2>
<table>
    <?php foreach ($data as $item) {?>
        <tr>
            <td><?= $item['id'] ?></td>
            <td><?= $item['name'] ?></td>
            <td><?= $item['level'] ?></td>
            <td><?= $item['school_id'] ?></td>
            <td><?= $item['mana_cost'] ?></td>
        </tr>
    <?php
    }?>
</table>

<?$query = 'SELECT * FROM territory_hmm';
$res = mysqli_query($link, $query);

$data = [];

while ($row = mysqli_fetch_assoc($res)) {
    $data[] = $row;
}

?>

<h2>territory hmm</h2>
<table>
    <?php foreach ($data as $item) {?>
        <tr>
            <td><?= $item['id'] ?></td>
            <td><?= $item['name'] ?></td>
            <td><?= $item['fine'] ?></td>
        </tr>
    <?php
    }?>
</table>
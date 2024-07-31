<?php

include('connect_db.php');

$rut = $_GET['rut'];

$query = 'SELECT * FROM vote WHERE rut = $1';

//Se prepara la consulta
$result = pg_prepare($conn, "get_rut", $query);

if (!$result) {
    echo "Error al preparar la consulta.";
    pg_close($conn);
    exit;
}

//Se ejecuta la consulta
$result = pg_execute($conn, "get_rut", array($rut));

if (!$result) {
    echo "Error al ejecutar la consulta de RUT duplicado.";
    pg_close($conn);
    exit;
}

$response = 'not duplicated';

$num_rows = pg_num_rows($result);

if ($num_rows > 0) {
    $response = 'duplicated';
}

//Se devuelven los datos
echo json_encode($response);

//Se cierra la conexión
pg_close($conn);

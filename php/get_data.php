<?php

include('connect_db.php');

//Se definen las queries
$queries = [
    'candidates' => 'SELECT * FROM candidate',
    'regions' => 'SELECT * FROM region',
    'communes' => 'SELECT * FROM commune'
];

$response = [];

//Se ejecuta cada query
foreach ($queries as $key => $query) {
    $result = pg_query($conn, $query);

    if (!$result) {
        echo json_encode(['error' => 'Error en la consulta: ' . pg_last_error($conn)]);
        pg_close($conn);
        exit();
    }

    //Se obtiene los datos de la query
    $response[$key] = pg_fetch_all($result);
}

//Se devuelven los datos
echo json_encode($response);

//Se cierra la conexión
pg_close($conn);

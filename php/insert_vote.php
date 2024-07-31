<?php

include('connect_db.php');

// Recoger los datos del formulario
$name = $_POST['name'];
$alias = $_POST['alias'];
$rut = $_POST['rut'];
$email = $_POST['email'];
//$region = $_POST['region'];
$commune = $_POST['commune'];
$candidate = $_POST['candidate'];
$check_web = isset($_POST['check_web']) ? 't' : 'f';
$check_tv = isset($_POST['check_tv']) ? 't' : 'f';
$check_rrss = isset($_POST['check_rrss']) ? 't' : 'f';
$check_friend = isset($_POST['check_friend']) ? 't' : 'f';

//Se ingresa los datos a social
$querySocial = 'INSERT INTO social (web, tv, rrss, friend) VALUES ($1, $2, $3, $4) RETURNING id';

$resultSocial = pg_prepare($conn, "insert_social", $querySocial);

if (!$resultSocial) {
    echo "Error al preparar consulta social";
    pg_close($conn);
    exit;
}

// Ejecutar la consulta con los datos
$resultSocial = pg_execute($conn, "insert_social", array($check_web, $check_tv, $check_rrss, $check_friend));

if ($resultSocial) {
    $social_id = pg_fetch_result($resultSocial, 0, 'id');

    //Se ingresa el voto
    $queryVote = 'INSERT INTO vote (name, alias, rut, email, candidate_id, social_id, commune_id) 
    VALUES ($1, $2, $3, $4, $5, $6, $7)';

    $resultVote = pg_prepare($conn, "insert_vote", $queryVote);

    if (!$resultVote) {
        echo "Error al preparar consulta vote";
        pg_close($conn);
        exit;
    }

    // Ejecutar la consulta con los datos
    $resultVote = pg_execute($conn, "insert_vote", array($name, $alias, $rut, $email, $candidate, $social_id, $commune));

    if ($resultVote) {
        echo "Voto ingresado correctamente.";
    } else {
        echo "Error al ingresar el voto.";
    }
} else {
    echo "Error al insertar los datos social.";
}

// Cerrar la conexión
pg_close($conn);
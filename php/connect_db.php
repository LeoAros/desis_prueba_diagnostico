<?php
//Se definen las variables de la BD
$host = "localhost";
$port = "5432";
$dbname= "desis_db";
$user= "postgres";
$password = "root";

//Se hace la conexión a BD
$conn = pg_connect("host=$host dbname=$dbname user=$user password=$password");

if (!$conn) {
    echo json_encode(['error' => 'No se pudo conectar a la base de datos.']);
    exit();
}
<?php
session_start();

include_once("conexiones.php");

// Verificar si se ha enviado el formulario de eliminación
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['id'])) {
    // Obtener el ID del registro a eliminar
    $id = $_POST['id'];

    // Realizar la eliminación en la base de datos
    $conexion = conexion::conexionADMIN1(); // Asegúrate de usar la conexión adecuada
    $query = "DELETE FROM ventas WHERE ID = ?";
    $statement = $conexion->prepare($query);
    $statement->bindParam(1, $id);

    if ($statement->execute()) {
        // La eliminación fue exitosa
        header("Location: proteccionFC.php"); // Redirige de nuevo a tu página principal
        exit();
    } else {
        // Hubo un error en la eliminación
        echo "Error al eliminar el registro.";
    }
}
?>

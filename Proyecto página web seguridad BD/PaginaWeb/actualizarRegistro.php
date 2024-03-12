<?php
session_start();

include_once("conexiones.php");

// Verificar si se ha enviado el formulario de actualización
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['id'])) {
    // Obtener los valores del formulario
    $id = $_POST['id'];
    $nombreProducto = $_POST['nombreProducto'];
    $montoVenta = $_POST['montoVenta'];
    $vendedor = $_POST['vendedor'];
    $fechaPedido = $_POST['fechaPedido'];
    $sucursal = $_POST['sucursal'];

    // Realizar la actualización en la base de datos
    $conexion = conexion::conexionADMIN1(); // Asegúrate de usar la conexión adecuada
    $query = "UPDATE ventas SET nombre_producto = ?, monto_venta = ?, vendedor = ?, fecha_pedido = ?, sucursal = ? WHERE ID = ?";
    $statement = $conexion->prepare($query);
    $statement->bindParam(1, $nombreProducto);
    $statement->bindParam(2, $montoVenta);
    $statement->bindParam(3, $vendedor);
    $statement->bindParam(4, $fechaPedido);
    $statement->bindParam(5, $sucursal);
    $statement->bindParam(6, $id);

    if ($statement->execute()) {
        // La actualización fue exitosa
        header("Location: proteccionFC.php"); 
        exit();
    } else {
        // Hubo un error en la actualización
        echo "Error al actualizar el registro.";
    }
}
?>

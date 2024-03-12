<?php
session_start();
include_once("conexiones.php");

if (isset($_POST['seleccion'])) {
    $seleccion = $_POST['seleccion'];
    $nombreUsuarioActual = $_SESSION['nombreUsuarioActual']; // Obtén el nombre de usuario de la sesión

    // Verifica si el usuario es 'sa (Administrador)' antes de realizar acciones
    if ($nombreUsuarioActual === 'sa (Administrador)') {
        switch ($seleccion) {
            case "opcion1":
                // Desactivar protección de filas y columnas
                $_SESSION['proteccion_columna_activada'] = false;
                try {
                    $conexion = conexion::conexionADMIN1();
                    $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                    // Apagar política de seguridad
                    $consulta = "ALTER SECURITY POLICY SeguridadFilas WITH (STATE = OFF)";
                    $conexion->exec($consulta);

                    // Quitar los permisos de SELECT, UPDATE y DELETE para los usuarios 001 y 002
                    $consultaPermisos = "REVOKE SELECT, UPDATE, DELETE ON ventas TO [001],[002]";
                    $conexion->exec($consultaPermisos);

                    $mensaje = "Se desactivó la protección de filas y columnas.";
                } catch (PDOException $e) {
                    $mensaje = "Error al desactivar la protección de filas y columnas: " . $e->getMessage();
                }
                break;

            case "opcion2":
                // Activar protección de filas
                try {
                    $conexion = conexion::conexionADMIN1();
                    $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                    $consulta = "ALTER SECURITY POLICY SeguridadFilas WITH (STATE = ON)";
                    $conexion->exec($consulta);

                    // Asignar los permisos adicionales para SELECT, UPDATE y DELETE a los usuarios 001 y 002
                    $consultaPermisos = "GRANT SELECT, UPDATE, DELETE ON ventas TO [001],[002]";
                    $conexion->exec($consultaPermisos);

                    $mensaje = "Se activó la protección de filas.";
                } catch (PDOException $e) {
                    $mensaje = "Error al activar la protección de filas: " . $e->getMessage();
                }
                break;

            case "opcion3":
                // Activar protección de columnas
                $_SESSION['proteccion_columna_activada'] = true;
                try {
                    $conexion = conexion::conexionADMIN1();
                    $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                    // Asignar los permisos adicionales para SELECT, UPDATE y DELETE al usuario actual (001 o 002)
                    $consultaPermisos = "GRANT SELECT, UPDATE, DELETE ON ventas TO [001],[002]";
                    $conexion->exec($consultaPermisos);

                    // Denegar el acceso a la columna 'vendedor' al usuario actual (001 o 002)
                    $consultaDenegarColumna = "DENY SELECT ON ventas(vendedor) TO [001],[002] ";
                    $conexion->exec($consultaDenegarColumna);

                    $mensaje = "Se activó la protección de columna";
                } catch (PDOException $e) {
                    $mensaje = "Error al activar la protección de columna: " . $e->getMessage();
                }
                break;
        }
    } else {
        $mensaje = "Solo el usuario 'sa (Administrador)' puede realizar esta acción.";
    }

    echo $mensaje;
} else {
    echo "No se recibió ninguna selección.";
}
?>


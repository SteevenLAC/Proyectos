<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Procedimientos de seguridad</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="header">
    <h1>DEMOSTRACIÓN DE APLICACION DE PROCEDIMIENTOS DE SEGURIDAD EN SQL SERVER 2022</h1>
    <nav class="nav">
        <ul class="nav-list">
            <li><a href="index.php">Inicio</a></li>

        </ul>
    </nav>
</header>

<section class="Contenido"  >
    <section class="Titulo" >
        <div>
            <h1>Protección de Filas y Columnas</h1>
        </div>
    </section>

    <form id="seguridadForm" method="post" action="proteccionFC.php">

        <label for="opcionesFC" class="ProteccionFC">Seleccione el tipo de seguridad:</label>
        <select id="opcionesFC" name="opcionesFC">
            <option value="opcion0" disabled selected>Seleccione una opción..</option>
            <option value="opcion1">Desactivar protección de filas y columnas</option>
            <option value="opcion2">Activar protección de filas</option>
            <option value="opcion3">Activar protección de columnas</option>
        </select>
        <input type="submit" value="Aplicar Seguridad">
 
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('seguridadForm').addEventListener('submit', function (e) {
                e.preventDefault(); 

                var seleccion = document.getElementById('opcionesFC').value;

                // Llama a la función cambiarOpcion para procesar la selección
                cambiarOpcion(seleccion);
            });
        });

        function cambiarOpcion(seleccion) {
            // Esta función se ejecuta cuando se hace clic en el botón "Enviar" del formulario.

            // Crea una nueva solicitud AJAX para enviar la selección al servidor
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "tipoSeguridad.php", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var mensaje = xhr.responseText;

                    // Muestra un mensaje de alerta con la respuesta del servidor
                    alert(mensaje);

                }
            };
            xhr.send("seleccion=" + seleccion); // Envía la selección al servidor
        }
    </script>

    



    <?php
    session_start();

        include_once("conexiones.php");

        // Define el nombre de usuario actual
        $nombreUsuarioActual = 'sa (Administrador)';
        $_SESSION['nombreUsuarioActual'] = $nombreUsuarioActual;
        // Establece una conexión predeterminada
        $conexion = conexion::conexionADMIN1();

        // Verifica si se ha enviado el formulario para cambiar de usuario
        if (isset($_POST['cambioUsuario'])) {
            $seleccion = $_POST['cambioUsuario'];

            // Lógica para cambiar la conexión y el nombre de usuario según la selección
            switch ($seleccion) {
                case "sa":
                    $conexion = conexion::conexionADMIN1();
                    $nombreUsuarioActual = 'sa (Administrador)';
                    break;
                case "001":
                    $conexion = conexion::conexion001();
                    $nombreUsuarioActual = 'Usuario 001';
                    break;
                case "002":
                    $conexion = conexion::conexion002();
                    $nombreUsuarioActual = 'Usuario 002';
                    break;
            }

            // Almacena el nombre de usuario en la variable de sesión
            $_SESSION['nombreUsuarioActual'] = $nombreUsuarioActual;

      
        }



        /* Obtener nombre de la base de datos*/
        $databaseNameQuery = "SELECT DB_NAME()"; 
        $databaseName = $conexion->query($databaseNameQuery)->fetchColumn();


        $tablaNombre = "ventas"; 

        if (isset($_SESSION['proteccion_columna_activada']) &&
        $_SESSION['proteccion_columna_activada'] === true &&
        $nombreUsuarioActual !== 'sa (Administrador)') {
            // Si la protección de columna está activada, ejecuta el query sin la columna 'vendedor'
            $query = "SELECT ID, numero_orden, nombre_producto, monto_venta, fecha_pedido, sucursal, CodigoJefe FROM $tablaNombre";
        } else {
            // Si no está activada, ejecuta el query original
            $query = "SELECT * FROM $tablaNombre";
        }


        echo "<div class='infoTablas'>";
        echo "<h3>Nombre de la Base de datos: $databaseName</h3>";
        echo "<h3>Nombre de la Tabla: $tablaNombre</h3>"; 
        echo "</div>";


        echo "<h3 class='usuario'>Nombre de usuario: $nombreUsuarioActual</h3>";
        echo "<div id='contenedorTablaProteccionFC' class='contenedorTablas'>";
        
        try {
            $resultados = $conexion->query($query);

            
            echo "<table class='tablasProcedimientos'>";
            // Encabezado de tabla
            for ($i = 0; $i < $resultados->columnCount(); $i++) {
                $columnMeta = $resultados->getColumnMeta($i);
                echo "<th>" . $columnMeta['name'] . "</th>";
            }

            // Verifica si el usuario es administrador
            $esAdmin = ($nombreUsuarioActual === 'sa (Administrador)');
            $proteccionColumnaDesactivada = (!isset($_SESSION['proteccion_columna_activada']) || ($_SESSION['proteccion_columna_activada'] !== true));

           // Agrega encabezados para actualización y eliminación
            if ($esAdmin || $proteccionColumnaDesactivada) {
                echo "<th>Actualizar</th>";
                echo "<th>Eliminar</th>";
            }
                echo "</tr>";
        
            // Datos de la tabla
            while ($row = $resultados->fetch(PDO::FETCH_ASSOC)) {
                echo "<tr>";
                foreach ($row as $value) {
                    echo "<td>" . $value . "</td>";
                }
               // Agrega formulario con botones de actualización y eliminación
            if ($esAdmin || $proteccionColumnaDesactivada) {
                echo "<td>";
                echo "<form method='post' action='actualizarRegistro.php'>";
                echo "<input type='hidden' name='id' value='" . $row['ID'] . "'>";
                echo "<input type='text' name='nombreProducto' value='" . $row['nombre_producto'] . "'>";
                echo "<input type='text' name='montoVenta' value='" . $row['monto_venta'] . "'>";
                echo "<input type='text' name='vendedor' value='" . $row['vendedor'] . "'>";
                echo "<input type='text' name='fechaPedido' value='" . $row['fecha_pedido'] . "'>";
                echo "<input type='text' name='sucursal' value='" . $row['sucursal'] . "'>";
                echo "<input type='submit' value='Actualizar'>";
                echo "</form>";
                echo "</td>";
                echo "<td>";
                echo "<form method='post' action='eliminarRegistro.php'>";
                echo "<input type='hidden' name='id' value='" . $row['ID'] . "'>";
                echo "<input type='submit' value='Eliminar'>";
                echo "</form>";
                echo "</td>";
            }
            echo "</tr>";
            }
        
            echo "</table>";
            
        echo "</div>";
        } catch (PDOException $e) {
            // Error al cargar los datos, muestra un mensaje de falta de permisos
            echo "<p>No tiene permisos para acceder a la tabla 'ventas'.</p>";
        }


    ?>

    <form method="post" action="proteccionFC.php">
        <label for="cambioUsuario" class="LabelcambioUsuario">Cambio de usuario:</label>
        <select id="cambioUsuario" name="cambioUsuario" onchange="this.form.submit()">
            <option value="opcion0" disabled selected>Seleccione un usuario..</option>
            <option value="sa">sa</option>
            <option value="001">001</option>
            <option value="002">002</option>
        </select>
    </form>

</section>

<footer>
    <p> © 2023 Todos los derechos reservados.</p>
</footer>

</body>

</html>
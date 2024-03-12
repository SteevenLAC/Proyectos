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
            <h1>Cidrado de Datos</h1>
        </div>
    </section>

    <?php

        include_once("conexiones.php");
        $conexion = conexion::conexionADMIN1();

        /* Obtener nombre de la base de datos*/
        $databaseNameQuery = "SELECT DB_NAME()"; 
        $databaseName = $conexion->query($databaseNameQuery)->fetchColumn();

        $query = "SELECT ID, nombreUsuario, contraseña, email FROM Usuario";


        echo "<div class='infoTablas'>";
        echo "<h3>Nombre de la Base de datos: $databaseName</h3>";
        echo "</div>";

        $resultados = $conexion->query($query);
        echo "<div id='contenedorTablaAC' class='contenedorTablas'>";

        if ($resultados) {
            echo "<table class='tablasProcedimientos'>";

            /* Encabezado de tabla */
            for ($i = 0; $i < $resultados->columnCount(); $i++) {
                $columnMeta = $resultados->getColumnMeta($i);
                echo "<th>" . $columnMeta['name'] . "</th>";
            }

            /* Datos de la tabla */

            while ($row = $resultados->fetch(PDO::FETCH_ASSOC)) {
                echo "<tr>";
                foreach ($row as $value) {
                    echo "<td>" . $value . "</td>";
                }
                echo "</tr>";
            }
            
            echo "</table>";

        } else {
            echo "Error al cargar los datos.";
        }

        echo "</div>";

 

    ?>

    <div class='botones-container'>
    <!-- Botones para cambiar el método de encriptación con JavaScript -->
    <button id='encriptarBK' class='cifrarBtn' onclick="cambiarMetodo(1)">Encriptar BY KEY</button>
    <button id='encriptarBP' class='cifrarBtn' onclick="cambiarMetodo(2)">Encriptar BY PASSPHRASE</button>
    <button id='DesencriptarBK' class='cifrarBtn' onclick="cambiarMetodo(3)">Desencriptar BY KEY</button>
    <button id='DesencriptarBP' class='cifrarBtn' onclick="cambiarMetodo(4)">Desencriptar BY PASSPHRASE</button>
    </div>


    <script>
        // Variable para almacenar el método actual seleccionado
        var metodoActual = 0;

        function cambiarMetodo(nuevoMetodo) {
            // Verificar las condiciones antes de cambiar el método
            if (nuevoMetodo == 1 && metodoActual == 2) {
                alert("No puedes encriptar la tabla porque ya está encriptada.");
                return;
            }
            if (nuevoMetodo == 2 && metodoActual == 1) {
                alert("No puedes encriptar la tabla porque ya está encriptada.");
                return;
            }
            if (nuevoMetodo == 3 && metodoActual != 1) {
                alert("Debes encriptar la tabla primero o debes usar el mismo método para desencriptar.");
                return;
            }
            if (nuevoMetodo == 4 && metodoActual != 2) {
                alert("Debes encriptar la tabla primero o debes usar el mismo método para desencriptar.");
                return;
            }

            // Realizar una solicitud AJAX para obtener los datos según el nuevo método
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "tablaActualizarCifrado.php", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    // Actualizar solo el contenido de la tabla con los datos recibidos en la respuesta AJAX
                    document.getElementById('contenedorTablaAC').innerHTML = xhr.responseText;
                    // Actualizar el método actual seleccionado
                    metodoActual = nuevoMetodo;
                }
            };
            xhr.send("metodo=" + nuevoMetodo);
        }
    </script>



</section>

<footer>
    <p> © 2023 Todos los derechos reservados.</p>
</footer>



</body>


</html>
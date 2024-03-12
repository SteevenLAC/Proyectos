<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Enmascaramiento</title>
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
            <h1>Enmascaramiento</h1>
        </div>

    </section>

        <form method="post" action="" id="OpcionesTabla">
            <label for="nombreTabla" class="LabelNombreTabla">Seleccionar tabla:</label>
            <select name="nombreTabla" id="nombreTabla">
                <?php
                include_once("conexiones.php");
                $nombresTablas = conexion::mostrarNombresTablas();

                echo "<option value='' disabled selected>Seleccione una tabla..</option>"; // Primera opción deshabilitada y seleccionada
                foreach ($nombresTablas as $nombreTabla) {
                    echo "<option value='$nombreTabla'>$nombreTabla</option>";
                }
                ?>
            </select>
        </form>
        <script>
            document.getElementById('nombreTabla').addEventListener('change', function() {
            var select = document.getElementById('nombreTabla');
            var selectedValue = select.options[select.selectedIndex].value;
            if (selectedValue !== '') {
                document.getElementById('OpcionesTabla').submit();
            }
            });
        </script>

        <?php
            include_once("conexiones.php");
            $conexionAdmin = conexion::conexionADMIN();
            $conexion1 = conexion::conexionSteeven();
        
            /* Obtener nombre de la base de datos*/
            $databaseNameQuery = "SELECT DB_NAME()"; 
            $databaseName = $conexionAdmin->query($databaseNameQuery)->fetchColumn();
            /* Obtener nombre del usuario actual*/
            $usuarioQuery = "SELECT CURRENT_USER;";
            $nombreUsuario = $conexionAdmin->query($usuarioQuery)->fetchColumn();
            if ($nombreUsuario === 'dbo') {
                $nombreUsuario = 'sa (Administrador)';
            }
        
            $usuario1Query = "SELECT CURRENT_USER;";
            $nombreUsuario1 = $conexion1->query($usuario1Query)->fetchColumn();
        
            if (isset($_POST['nombreTabla'])) {
            $nombresT = $_POST['nombreTabla'];
            } else {
                $nombresTablas = conexion::mostrarNombresTablas();
                $nombresT = $nombresTablas[0]; // Seleccionar la segunda tabla 
            }
            $columnasTabla = conexion::obtenerNombresColumnas($nombresT);
            
        
            $resultados = conexion::obtenerDatos($conexionAdmin, $nombresT);
            $resultados1 = conexion::obtenerDatos($conexion1, $nombresT);
        
            echo "<div class='infoTablas'>";
            echo "<h3>Nombre de la Base de datos: $databaseName</h3>";
            echo "<h3>Nombre de la tabla: $nombresT</h3>";
            echo "</div>";

            echo "<h3 class='usuario'>Nombre de usuario: $nombreUsuario</h3>";
            
            echo "<div class='contenedorTablas'>";
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
                echo "No se encontraron usuarios.";
            }
        
            echo "<h3 class='usuario1'>Nombre de usuario: $nombreUsuario1 (Permisos Limitados) </h3>";
     
            if ($resultados1) {
                echo "<table class='tablasProcedimientos'>";
        
                /* Encabezado de tabla */
                for ($i = 0; $i < $resultados1->columnCount(); $i++) {
                    $columnMeta = $resultados1->getColumnMeta($i);
                    echo "<th>" . $columnMeta['name'] . "</th>";
                }
        
                /* Datos de la tabla */
        
                while ($row = $resultados1->fetch(PDO::FETCH_ASSOC)) {
                    echo "<tr>";
                    foreach ($row as $value) {
                        echo "<td>" . $value . "</td>";
                    }
                    echo "</tr>";
                }
                
                echo "</table>";

            echo "</div>";  

                

                // Mostrar el formulario de selección de columna
                echo "<form method='post' action='' id='OpcionesColumna'>";
                echo "<label for='nombreColumna' class='LabelNombreColumna'>Seleccione columna a enmascarar:</label>";
                echo "<select name='nombreColumna' id='nombreColumna'>";
                echo "<option value='' disabled selected>Seleccione una columna..</option>"; // Primera opción deshabilitada y seleccionada

                foreach ($columnasTabla as $columna) {
                    echo "<option value='$columna'>$columna</option>";
                }
                echo "</select>";
                echo "</form>";

                // Mostrar el mensaje de la columna seleccionada
                echo "<h3 class='usuario'>Columna seleccionada: <span id='nombreColumnaSeleccionada'></span></h3>";

                echo "<div class='botones-container'>";
                echo "<button type='button' class='enmascararBtn' data-opcion='1'>Enmascarar (Default)</button>";
                echo "<button type='button' class='enmascararBtn' data-opcion='2'>Enmascarar (Email)</button>";
                echo "<button type='button' class='enmascararBtn' data-opcion='3'>Enmascarar (Random)</button>";
                echo "<button type='button' class='enmascararBtn' data-opcion='4'>Enmascarar (Partial)</button>";
                echo "<button type='button' class='enmascararBtn' data-opcion='6'>Enmascarar (DateTime)</button>";
                echo "<button type='button' class='enmascararBtn' data-opcion='5'>Desenmascarar</button>";
                echo "</div>";
                
                // Repite para más botones de enmascaramiento

                echo "<script>
                    document.addEventListener('DOMContentLoaded', function() {
                        const formColumna = document.getElementById('OpcionesColumna');
                        const columnaSeleccionada = document.getElementById('nombreColumnaSeleccionada');
                        const enmascararBtns = document.querySelectorAll('.enmascararBtn'); 

                        const nombreTabla = '" . $nombresT . "';
                        let nombreColumnaSeleccionada = ''; // Variable para almacenar el nombre de columna seleccionada

                        formColumna.addEventListener('change', function(event) {
                            const selectedValue = event.target.value;
                            columnaSeleccionada.textContent = selectedValue;
                            nombreColumnaSeleccionada = selectedValue; // Actualizar la variable
                        });

                        enmascararBtns.forEach(function(btn) {
                            btn.addEventListener('click', function() {
                                const opcionEnmascaramiento = btn.getAttribute('data-opcion');
                                if (nombreTabla && nombreColumnaSeleccionada && opcionEnmascaramiento) {
                                    const formData = new FormData();
                                    formData.append('enmascararColumna', 'true');
                                    formData.append('nombreTabla', nombreTabla);
                                    formData.append('nombreColumnaSeleccionada', nombreColumnaSeleccionada);
                                    formData.append('opcionEnmascaramiento', opcionEnmascaramiento); 

                                    // Realizar la llamada AJAX para enmascarar la columna
                                    const xhr = new XMLHttpRequest();
                                    xhr.open('POST', 'enmascaramiento.php'); 
                                    xhr.onload = function() {
                                        if (xhr.status === 200) {
                                            // Recargar la página después de realizar la enmascaración
                                            window.location.reload();
                                        } else {
                                            console.error('Error en la solicitud AJAX');
                                        }
                                    };
                                    xhr.send(formData);
                                } else {
                                    alert('Por favor, selecciona una columna y una opción de enmascaramiento.');
                                }
                            });
                        });
                    });
                </script>";

                if (isset($_POST['enmascararColumna'])) {
                    $nombreTabla = $_POST['nombreTabla'];
                    $nombreColumnaSeleccionada = $_POST['nombreColumnaSeleccionada'];
                    $opcionEnmascaramiento = $_POST['opcionEnmascaramiento']; // Recuperar la opción de enmascaramiento

                    // Llamar a la función enmascararColumna con los parámetros adecuados
                    conexion::enmascararColumna($nombreTabla, $nombreColumnaSeleccionada, $opcionEnmascaramiento);
                }


            } else {
                echo "No se encontraron usuarios.";
            }
        
        ?>
</section >

<footer>
    <p> © 2023 Todos los derechos reservados.</p>
</footer>
 
</body>
</html>

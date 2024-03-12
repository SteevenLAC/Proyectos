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
            <h1>Auditoría de Base Datos</h1>
        </div>
    </section>

    <?php

        include_once("conexiones.php");
        $conexion = conexion::conexionADMIN();

        /* Obtener nombre de la base de datos*/
        $databaseNameQuery = "SELECT DB_NAME()"; 
        $databaseName = $conexion->query($databaseNameQuery)->fetchColumn();

        $query = "SELECT 
            ROW_NUMBER() OVER (ORDER BY event_time) AS ID,
            DATEADD(HOUR, -5, event_time) AS event_time,
            CASE action_id 
                WHEN 'SL' THEN 'SELECT'
                WHEN 'DL' THEN 'DELETE'
                WHEN 'UP' THEN 'UPDATE'
            END AS action_id, 
            server_instance_name,
            session_server_principal_name,
            database_name,
            object_name,
            statement,
            file_name,
            application_name
            FROM sys.fn_get_audit_file('C:\\AUDITORIAS SQL\\AUDIT_PRACTICA*', DEFAULT, DEFAULT)
            WHERE 
            statement NOT LIKE 'FETCH API_CURSOR%' 
            AND statement NOT LIKE 'PREPARED QUERY'
	        AND statement NOT LIKE 'DECLARE CURSOR'
	        AND additional_information NOT LIKE '<tsql_stack>%'
            AND action_id IN ('SL', 'DL', 'UP')";

        echo "<div class='infoTablas'>";
        echo "<h3>Nombre de la Base de datos: $databaseName</h3>";
        echo "</div>";

        $resultados = $conexion->query($query);
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
            echo "Error al cargar los datos.";
        }

        echo "</div>";


    ?>



</section>

<footer>
    <p> © 2023 Todos los derechos reservados.</p>
</footer>

</body>


</html>


<?php

    include_once("conexiones.php");
    $conexion = conexion::conexionADMIN1();


    // Obtener el método actual (0 por defecto si no se ha seleccionado)
    $metodoEncriptacion = isset($_POST['metodo']) ? $_POST['metodo'] : 0;



    if ($metodoEncriptacion == 1) {
            // Método 1: Encriptar BY KEY
            // Abrir clave simétrica
            $openKeyQuery = "OPEN SYMMETRIC KEY Clave1 DECRYPTION BY CERTIFICATE Certificado";
            $conexion->exec($openKeyQuery);

            $query = "SELECT ID, nombreUsuario, EncryptByKey(Key_GUID('Clave1'), contraseña) AS contraseñaEncriptByKey, email FROM Usuario";
    } elseif ($metodoEncriptacion == 2) {
        // Método 2: Encriptar BY PASSPHRASE
            $query = "SELECT ID, nombreUsuario, ENCRYPTBYPASSPHRASE('clave12345678912', contraseña) AS contraseñaEncriptByPassphrase, email FROM Usuario";
    }elseif ($metodoEncriptacion == 3) {
            // Método 3: Desencriptar BY KEY
            $openKeyQuery = "OPEN SYMMETRIC KEY Clave1 DECRYPTION BY CERTIFICATE Certificado";
            $conexion->exec($openKeyQuery);

            $query = "SELECT ID, nombreUsuario, CONVERT(varchar, DECRYPTBYKEY(contraseñaEncriptByKey)) AS Contraseña, email FROM Usuario";
    }elseif ($metodoEncriptacion == 4) {
            // Método 4: Desencriptar BY PASSPHRASE
            $query = "SELECT ID, nombreUsuario, CONVERT(varchar, DECRYPTBYPASSPHRASE('clave12345678912', contraseñaEncriptByPassphrase)) AS Contraseña, email FROM Usuario";
    }



    $resultados = $conexion->query($query);
    echo "<div id='contenedorTablaAC' >";

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


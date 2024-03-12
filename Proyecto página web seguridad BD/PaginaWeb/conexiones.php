<?php

class conexion{

    //Conexion administrador a la base de datos Practica1
    public static function conexionADMIN(){
    $host= 'localhost';
    $dbname= 'Practica1';
    $username='sa';
    $password='12345';
    $puerto='1433';

    try {
        $con = new PDO("sqlsrv:Server=$host,$puerto;Database=$dbname",$username,$password);
        echo "<!-- Conexión exitosa a la base de datos: $dbname -->";
    }
    catch(PDOException $exp){
        echo "<!--No se logró conectar a la base de datos: $dbname, error: $exp-->";

    }
    return $con;
    }

    //Conexion administrador a la base de datos Practica
    public static function conexionADMIN1(){
        $host= 'localhost';
        $dbname= 'Practica';
        $username='sa';
        $password='12345';
        $puerto='1433';
    
        try {
            $con = new PDO("sqlsrv:Server=$host,$puerto;Database=$dbname",$username,$password);
            echo "<!-- Conexión exitosa a la base de datos: $dbname -->";
        }
        catch(PDOException $exp){
            echo "<!--No se logró conectar a la base de datos: $dbname, error: $exp-->";
    
        }
        return $con;
        }

    //Conexion a la base de datos Practica

    public static function conexion001(){
        $host= 'localhost';
        $dbname= 'Practica';
        $username='001';
        $password='12345';
        $puerto='1433';
    
        try {
            $con = new PDO("sqlsrv:Server=$host,$puerto;Database=$dbname",$username,$password);
            echo "<!-- Conexión exitosa a la base de datos: $dbname -->";
        }
        catch(PDOException $exp){
            echo "<!--No se logró conectar a la base de datos: $dbname, error: $exp-->";
    
        }
        return $con;
        }  

    //Conexion a la base de datos Practica

    public static function conexion002(){
        $host= 'localhost';
        $dbname= 'Practica';
        $username='002';
        $password='12345';
        $puerto='1433';
    
        try {
            $con = new PDO("sqlsrv:Server=$host,$puerto;Database=$dbname",$username,$password);
            echo "<!-- Conexión exitosa a la base de datos: $dbname -->";
        }
        catch(PDOException $exp){
            echo "<!--No se logró conectar a la base de datos: $dbname, error: $exp-->";
    
        }
        return $con;
        }  

    //Conexion a la base de datos Practica1    

    public static function conexionSteeven(){
        $host= 'localhost';
        $dbname= 'Practica1';
        $username='steeven';
        $password='12345';
        $puerto='1433';
    
        try {
            $con = new PDO("sqlsrv:Server=$host,$puerto;Database=$dbname",$username,$password);
            echo "<!-- Conexión exitosa a la base de datos: $dbname -->";
        }
        catch(PDOException $exp){
            echo "<!--No se logró conectar a la base de datos: $dbname, error: $exp-->";
    
        }
        return $con;
        }


    public static function obtenerDatos($conexion, $nombreTabla) {
        if ($conexion) {
            try {
                $query = "SELECT * FROM $nombreTabla";
                $resultados = $conexion->query($query);
                return $resultados;
            } catch (PDOException $exp) {
                echo "<!--Error al obtener usuarios de la tabla: $nombreTabla: $exp-->";
                return null;
            }
        } else {
            return null;
        }
    }

    public static function mostrarNombresTablas(){
        $conexion = self::conexionADMIN();

        // Obtener los nombres de las tablas de la base de datos
        $query = "SELECT name FROM sys.tables WHERE type = 'U'";
        $statement = $conexion->query($query);

        // Generar un array con los nombres de las tablas
        $nombresTablas = array();
        while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
            $nombreTabla = $row["name"];
            $nombresTablas[] = $nombreTabla;
        }

        return $nombresTablas;
    }

    public static function obtenerNombresColumnas( $nombreTabla) {
        $conexion = self::conexionADMIN();
        $query = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ?";
        $statement = $conexion->prepare($query);
        $statement->execute([$nombreTabla]);
        $nombresColumnas = $statement->fetchAll(PDO::FETCH_COLUMN);
        return $nombresColumnas;
    }

    public static function enmascararColumna($nombreTabla, $nombreColumna, $opcionEnmascaramiento) {
        $conexion = self::conexionADMIN();
        try {
            // Llamar al procedimiento almacenado
            $storedProcedure = "{CALL EnmascararColumna(?, ?, ?)}";
            $statement = $conexion->prepare($storedProcedure);

            // Establecer los parámetros del procedimiento almacenado
            $statement->bindParam(1, $nombreTabla, PDO::PARAM_STR);
            $statement->bindParam(2, $nombreColumna, PDO::PARAM_STR);
            $statement->bindParam(3, $opcionEnmascaramiento, PDO::PARAM_INT);

            // Ejecutar el procedimiento almacenado
            $statement->execute();

        
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }

    


}
   

?>
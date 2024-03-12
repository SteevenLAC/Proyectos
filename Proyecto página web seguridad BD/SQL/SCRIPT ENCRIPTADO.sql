------------ MÉTODO ENCRYPTBYKEY -----------------

--1. Seleccionar Base de datos del usuario o la Base Master del Sql Server
USE Practica;

--2. Crear Clave Maestra
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'ClaveSegura';

--3. Crear Certificado
CREATE CERTIFICATE Certificado WITH SUBJECT = 'Proteccion Datos';

--4. Consultar certificado creado
SELECT * FROM sys.certificates;

--5. Crear clave simétrica usando el certificado
CREATE SYMMETRIC KEY Clave1 WITH ALGORITHM = AES_128 ENCRYPTION BY CERTIFICATE Certificado;

--6. Consultar clave simétrica
SELECT * FROM sys.symmetric_keys;

--7. Abrir Clave Simétrica
OPEN SYMMETRIC KEY Clave1 DECRYPTION BY CERTIFICATE Certificado;

--8. Encriptar el campo deseado
SELECT ID, nombreUsuario, EncryptByKey(Key_GUID('Clave1'), contraseña) AS Contraseña, email FROM Usuario

--9. Cerrar clave simétrica
CLOSE SYMMETRIC KEY Clave1;

------------ MÉTODO ENCRYPTBYPASSPHRASE  -----------------

SELECT ID, nombreUsuario, ENCRYPTBYPASSPHRASE('clave12345678912', contraseña) AS Contraseña, email FROM Usuario




------------ MÉTODO DECRYPTBYKEY -----------------

--1. Abrir Clave Simétrica
OPEN SYMMETRIC KEY Clave1 DECRYPTION BY CERTIFICATE Certificado;

--2. Desencriptar el campo deseado
SELECT ID, nombreUsuario, CONVERT(varchar, DECRYPTBYKEY(contraseñaEncriptByKey)) AS Contraseña, email FROM Usuario

--3. Cerrar clave simétrica
CLOSE SYMMETRIC KEY Clave1;



------------ MÉTODO DECRYPTBYPASSPHRASE -----------------

SELECT ID, nombreUsuario, CONVERT(varchar, DECRYPTBYPASSPHRASE('clave12345678912', contraseñaEncriptByPassphrase)) AS Contraseña, email FROM Usuario;


-- Creacion de la base de datos
CREATE DATABASE SoporteSprintM5;
-- Creacion y asignacion de usuario con todos los privilegios:
CREATE USER 'adminSoporte'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON SoporteSprintM5.* TO 'adminSoporte'@'localhost';

USE SoporteSprintM5;

drop table if exists Usuario, Operario, Soporte;

-- Se contruyen las tablas para Usuario, Operario y Soporte
CREATE TABLE Usuario (
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50),
apellido VARCHAR(50),
edad INT,
correo_electronico VARCHAR(50),
num_usos INT DEFAULT 1
);

CREATE TABLE Operario (
id_operario INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50),
apellido VARCHAR(50),
edad INT,
correo_electronico VARCHAR(50),
num_usos INT DEFAULT 1
);

CREATE TABLE Soporte (
id_soporte INT PRIMARY KEY AUTO_INCREMENT,
id_usuario INT,
id_operario INT,
fecha DATE,
evaluacion INT,
comentario VARCHAR(200),
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
FOREIGN KEY (id_operario) REFERENCES Operario(id_operario)
);

-- Se crean las inserciones a las tablas creadas
-- Agregar 5 usuarios
INSERT INTO Usuario (nombre, apellido, edad, correo_electronico, num_usos) VALUES
('Juan', 'Pérez', 30, 'juan@mail.com', 9),
('María', 'González', 25, 'maria@mail.com', 24),
('Pedro', 'López', 28, 'pedro@mail.com', 2),
('Laura', 'Rodríguez', 35, 'laura@mail.com', 1),
('Carlos', 'Martínez', 32, 'carlos@mail.com', 30);
SELECT * FROM Usuario;

-- Agregar 5 operarios
INSERT INTO Operario (nombre, apellido, edad, correo_electronico, num_usos) VALUES
('Ana', 'Sánchez', 27, 'ana@mail.com', 32),
('José', 'Fernández', 18, 'jose@mail.com', 6),
('Marta', 'Vargas', 31, 'marta@mail.com', 51),
('Roberto', 'Silva', 26, 'roberto@mail.com', 10),
('Sofía', 'Ramírez', 19, 'sofia@mail.com', 22);
SELECT * FROM Operario;

-- Agregar 10 operaciones de soporte
INSERT INTO Soporte (id_usuario, id_operario, fecha, evaluacion, comentario) VALUES
(1, 1, '2023-07-01', 6, 'Buen servicio'),
(2, 3, '2023-07-01', 5, 'Atención rápida'),
(3, 2, '2023-07-01', 7, 'Excelente ayuda'),
(4, 4, '2023-07-02', 4, 'Podría mejorar'),
(5, 5, '2023-07-02', 7, 'Muy amable'),
(1, 3, '2023-07-03', 5, 'Correcto'),
(2, 4, '2023-07-04', 3, 'No cumplió expectativas'),
(3, 5, '2023-07-04', 6, 'Satisfecho'),
(4, 1, '2023-07-04', 7, 'Muy profesional'),
(5, 2, '2023-07-04', 2, 'Descontento');
SELECT * FROM Soporte;

-- Seleccionar las 3 operaciones con mejor evaluación
SELECT *
FROM Soporte
ORDER BY evaluacion DESC
LIMIT 3;

-- Seleccionar las 3 operaciones con menos evaluación.
SELECT *
FROM Soporte
ORDER BY evaluacion ASC
LIMIT 3;

-- Seleccionar al operario que más soportes ha realizado.
SELECT *
FROM Operario 
WHERE num_usos = (SELECT MAX(num_usos) FROM Operario);

-- Seleccionar al cliente que menos veces ha utilizado la aplicación.
SELECT *
FROM Usuario
WHERE num_usos = (SELECT MIN(num_usos) FROM Usuario);

-- Agregar 10 años a los tres primeros usuarios registrados
UPDATE Usuario
SET edad = edad + 10
WHERE id_usuario IN (1, 2, 3);
SELECT * FROM Usuario;

-- Renombrar todas las columnas 'correo electronico' a 'email'
ALTER TABLE Usuario
CHANGE COLUMN `correo_electronico` email VARCHAR(50);

ALTER TABLE Operario
CHANGE COLUMN `correo_electronico` email VARCHAR(50);

-- Selección de los operarios mayores de 20 años
SELECT *
FROM Operario
WHERE edad > 20;

CREATE TABLE PERS (
    Correo VARCHAR(255),
    NomU VARCHAR(255),
    Nom VARCHAR(255)
);

CREATE TABLE CURSO (
    Nom VARCHAR(255),
    Ch INTEGER
);

CREATE TABLE INSC (
    Correo VARCHAR(255),
    Nom VARCHAR(255),
    Correod VARCHAR(255),
    Nota INTEGER
);

CREATE TABLE DICTA (
    Correo VARCHAR(255),
    Nom VARCHAR(255)
);

CREATE TABLE TEMAS (
    Nom VARCHAR(255),
    Tema VARCHAR(255)
);
-- Insertar datos en la tabla PERS
INSERT INTO PERS (Correo, NomU, Nom)
VALUES
    ('anagarcia32@gmail.com','AnaGarcia131','Ana Garcia'),
    ('pablogomes45@gmail.com','Pablito45','Pablo Gomes'),
    ('rubengonzales104@gmail.com','RubenG10','Ruben Gonzales'),
    ('estefaniaperalta@gmail.com','Estefania22','Estefania Peralta'),
    ('gonzaloramos1978@yahoo.com.ar','GonzaloR78','Gonzalo Ramos');

-- Insertar datos en la tabla CURSO
INSERT INTO CURSO (Nom, Ch)
VALUES
    ('Javascript I', 50),
    ('Javascript II', 38),
    ('SQL', 25);

-- Insertar datos en la tabla INSC
INSERT INTO INSC (Correo, Nom, Correod, Nota)
VALUES
    ('anagarcia56@gmail.com', 'Javascript I', 'pablogomes45@gmail.com', 7),
    ('gisellevasquez201@yahoo.com.ar', 'Javascript I', 'pablogomes45@gmail.com', 8),
    ('gisellevasquez201@yahoo.com.ar', 'Javascript II', 'pablogomes45@gmail.com', 7),
    ('giselleV146@gmail.com', 'Javascript II', 'pablogomes45@gmail.com', 7);

-- Insertar datos en la tabla DICTA
INSERT INTO DICTA (Correo, Nom)
VALUES
    ('pedroibañez@yahoo.com.ar', 'Kotlin I'),
    ('gonzaloramos1978@yahoo.com.ar', 'Python I'),
    ('gonzaloramos1978@yahoo.com.ar', 'SQL'),
    ('pablogomes45@gmail.com', 'Javascript I'),
    ('pablogomes45@gmail.com', 'Javascript II');

-- Insertar datos en la tabla TEMAS
INSERT INTO TEMAS (Nom, Tema)
VALUES
    ('Python I', 'Estructuras de datos'),
    ('Python I', 'Caracteristicas'),
    ('Python II', 'Aplicacion'),
    ('Python II', 'Caracteristicas'),
    ('Javascript I', 'Estructuras de datos'),
    ('Javascript I', 'Estructuras de control'),
    ('Javascript I', 'Aplicacion'),
    ('Javascript I', 'Caracteristicas'),
    ('Javascript II', 'Estructuras de datos'),
    ('Javascript II', 'Estructuras de control'),
    ('Javascript II', 'Aplicacion'),
    ('Javascript II', 'Caracteristicas'),
    ('Kotlin I', 'Estructuras de control'),
    ('Kotlin I', 'Caracteristicas'),
    ('Kotlin II', 'Estructuras de datos'),
    ('Kotlin II', 'Estructuras de control'),
    ('Kotlin II', 'Aplicacion'),
    ('Kotlin II', 'Caracteristicas');

-- 2. Inserte nuevas Personas con los siguientes datos
INSERT INTO pers(Correo, NomU, nom)
	VALUES 
	('anagarcia56@gmail.com', 'AnaG56','Ana Garcia'),
	('franciscopeña52@yahoo.com.ar','FranPeña865','Gonzalo Ramos'),
	('pedroibañez@yahoo.com.ar','PedroIbañez223','Pedro Ibañez'),
	('gisellevasquez201@yahoo.com.ar','Giselle201','Giselle Vasquez'),
	('giselleV146@gmail.com','GVasquez24','Giselle Vasquez');

-- 3. Inserte el nuevo curso con los siguientes datos
INSERT INTO CURSO(Nom, Ch)
	VALUES
	('Python I', 29),
	('Python II', 28),
	('Kotlin I', 45),
	('Kotlin II', 42);

-- 4. Inserte los temas para el curso con los siguientes datos
INSERT INTO TEMAS(Nom, Tema)
	VALUES
	('Python I', 'Estructuras de control'),
	('Python I', 'Aplicacion'),
	('Python II', 'Estructuras de datos'),
	('Python II', 'Estructuras de control'),
	('Kotlin I', 'Estructuras de datos'),
	('Kotlin I', 'Aplicacion');
-- 5.Inserte la nueva tupla para DICTA con los siguientes datos
INSERT INTO DICTA(Correo, Nom)
	VALUES
	('estefaniaperalta@gmail.com', 'Python I'),
	('estefaniaperalta@gmail.com', 'Python II'),
	('gonzaloramos1978@yahoo.com.ar', 'Kotlin I'),
	('gonzaloramos1978@yahoo.com.ar', 'Kotlin II');

-- 6.Inserte la nueva tupla para INSCRIPCION con los siguientes datos
INSERT INTO INSC (Correo, Nom, Correod, Nota)
VALUES
	('anagarcia32@gmail.com', 'Python I', 'estefaniaperalta@gmail.com', 7),
	('franciscopeña52@yahoo.com.ar', 'Python I', 'estefaniaperalta@gmail.com', 9),
	('anagarcia32@gmail.com', 'Python II', 'pedroibañez@yahoo.com.ar', 8),
	('anagarcia56@gmail.com', 'Python II', 'estefaniaperalta@gmail.com', 6),
	('pedroibañez@yahoo.com.ar', 'Python I', 'estefaniaperalta@gmail.com', 9),
	('rubengonzales104@gmail.com', 'Kotlin I', 'gonzaloramos1978@yahoo.com.ar', 8),
	('rubengonzales104@gmail.com', 'Kotlin II', 'gonzaloramos1978@yahoo.com.ar', 6);

-- INSERT CURSO RUBY
INSERT INTO CURSO(Nom, Ch) VALUES ('Ruby', 30);

-- 7. Actualice la carga horaria del curso Ruby por 60.
UPDATE CURSO SET Ch=60 WHERE Nom='Ruby';

-- 8. Elimine el curso Ruby I.
DELETE FROM CURSO WHERE Nom='Ruby';

SELECT * FROM CURSO
-- 9. Correo y nombre de todas las personas.
SELECT Correo, Nom FROM pers;

--10. Cantidad de cursos.
SELECT count(distinct nom) FROM CURSO;

-- 11. Cantidad de docentes.
SELECT count(distinct correo) FROM DICTA;

-- 12. Nota máxima obtenida en el curso ‘’Python I‘’
SELECT Max(nota)FROM INSC WHERE Nom= 'Python I';

-- 13.Nombre de los cursos ordenados por nombre.
SELECT nom FROM CURSO ORDER BY nom ASC;

-- 14. Nombre del curso que tiene una carga horaria superior a la de todos los 
-- cursos que dicta “pedroibañez@yahoo.com.ar”.
SELECT nom FROM CURSO WHERE ch>(SELECT ch FROM CURSO WHERE nom IN (SELECT nom FROM DICTA WHERE correo='pedroibañez@yahoo.com.ar'))

-- 15. Personas, docentes o alumnos(todos sus datos) que se llama Rosa
SELECT correo, nomu,nom FROM pers WHERE nom='Rosa';

-- 16.Cursos que tienen una carga horaria superior a la del curso “Kotlin I”, 
-- ordenados descendentemente por cantidad de horas
SELECT nom FROM CURSO WHERE ch>(SELECT ch FROM CURSO WHERE nom='Kotlin I') ORDER BY ch DESC;

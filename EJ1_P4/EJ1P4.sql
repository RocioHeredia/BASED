-- CASO A
CREATE TABLE PERS(
	id bigint NOT NULL,
	nom varchar(30),
	ciudad_idc bigint NOT NULL,
	edad integer,
	PRIMARY KEY (id),
	FOREIGN KEY (ciudad_id) REFERENCES Ciu(ciudad_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

CREATE TABLE Ciu(
	ciudad_id bigint NOT NULL,
	ciudad_nom varchar(30),
	PRIMARY KEY (ciudad_id)
);

-- CASO B
CREATE TABLE PERS(
	id bigint NOT NULL,
	nom varchar(30),
	ciudad_idc bigint NOT NULL,
	edad integer,
	PRIMARY KEY (id),
	FOREIGN KEY (ciudad_id) REFERENCES Ciu(ciudad_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE
);

CREATE TABLE Ciu(
	ciudad_id bigint NOT NULL,
	ciudad_nom varchar(30),
	PRIMARY KEY (ciudad_id )
);

-- INSERCIONES PERSONAS
INSERT INTO PERS (id,nom, ciudad_idc, edad) VALUES (1,'Pedro Cortes',1,16);
INSERT INTO PERS (id,nom, ciudad_idc, edad) VALUES (2,'Santiago Mas',2, 25);
INSERT INTO PERS (id,nom, ciudad_idc, edad) VALUES (3,'Juan Basti',5, 50);
INSERT INTO PERS (id,nom, ciudad_idc,edad)VALUES (4,'Andrea Hernández',1,30);
INSERT INTO PERS (id, nom, ciudad_idc,edad)VALUES (5,'Ana Perez',1,30);

-- INSERCIONES CIUDADES
INSERT INTO Ciu(ciudad_id, ciudad_nom)VALUES (1, 'Galilea');
INSERT INTO Ciu(ciudad_id, ciudad_nom)VALUES (2,'Betsaida');
INSERT INTO Ciu(ciudad_id, ciudad_nom)VALUES (3,'Patmos');
INSERT INTO Ciu(ciudad_id, ciudad_nom)VALUES (4,'Jerusalén');

--ELIMINAR
DELETE FROM Ciu WHERE ciudad_id=1;
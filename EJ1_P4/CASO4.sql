create table Persona (
    nom varchar(30) not null constraint pers_pk primary key,
    fechanac date
);
create table Pelicula (
    titulo varchar(40) not null constraint pel_pk primary key,
    estreno date,
	lema varchar(60)
);

CREATE TABLE Actua
    (
        nom varchar(30) NOT NULL,
        titulo varchar(40)  NOT NULL,
        primary key(nom,titulo),
        foreign key(nom) references Persona(nom) on delete cascade,
        foreign key(titulo) references Pelicula(titulo) on delete cascade      
    );
CREATE TABLE Dirige
    (
        nom varchar(30) NOT NULL,
        titulo varchar(40)  NOT NULL,
        primary key(nom,titulo),
        foreign key(nom) references Persona(nom) on delete cascade,
        foreign key(titulo) references Pelicula(titulo) on delete cascade      
    );

create table Sigue (
    seguido varchar(30) not null,
    seguidor varchar(30) not null,
	primary key(seguido,seguidor),
	foreign key(seguido) references Persona(nom) on delete cascade,
    foreign key(seguidor) references Persona(nom) on delete cascade
);

insert into Persona values
        ('Keanu Reeves','1964-03-23'),
        ('Carrie-Anne Moss','1967-03-29'),
        ('Hugo Weaving','1960-03-30'),
        ('Emil Eifrem','1978-10-20'),
		('Al Pacino','1940-10-20'),
		('Charlize Theron','1975-10-20'),
		('Lilly Wachowski','1967-05-27'),
		('Taylor Hackford','1944-08-13'),
		('Paul Blythe','2009-12-13');
insert into Pelicula values
        ('The Matrix','1990-09-13','Welcome to the Real World'),
        ('The Matrix Revolutions','2003-04-19','Everything that has a beginning has an end'),
        ('The Devils Advocate','1997-08-30','Evil has its winning ways');
		
Insert into Actua values
     ('Keanu Reeves','The Matrix'),
     ('Hugo Weaving','The Matrix'),
	 ('Emil Eifrem','The Matrix'),
	 ('Al Pacino','The Matrix'),
	 ('Keanu Reeves','The Matrix Revolutions'),
	 ('Lilly Wachowski','The Matrix Revolutions'),
	 ('Al Pacino','The Matrix Revolutions'),
	 ('Keanu Reeves','The Devils Advocate'),
	 ('Al Pacino','The Devils Advocate');

Insert into Dirige values
     ('Carrie-Anne Moss','The Matrix'),
     ('Hugo Weaving','The Matrix'),
	 ('Keanu Reeves','The Matrix Revolutions'),
	 ('Carrie-Anne Moss','The Matrix Revolutions'),
	 ('Carrie-Anne Moss','The Devils Advocate'),
	 ('Taylor Hackford','The Devils Advocate');
Insert into Sigue values
     ('Keanu Reeves','Hugo Weaving'),
     ('Keanu Reeves','Al Pacino'),
	 ('Emil Eifrem','Lilly Wachowski'),
	 ('Keanu Reeves','Paul Blythe'),
	 ('Al Pacino','Keanu Reeves');
--CONSULTA 1
insert into Pelicula values ('The MatrixII','1990-07-13','Welcome to the Real World');
insert into Actua values ('Keanu Reeves','The MatrixII');
delete from pelicula where titulo='The MatrixII'
--1.Personas (nombre) que han actuado en más de una película estrenada en el año 1990.
(SELECT nom 
		FROM actua 
		NATURAL JOIN pelicula
		WHERE extract (year from estreno)=1990 --pelicula.estreno>=date('1990-01-01') and pelicula.estreno<=date('1990-12-31')
		GROUP BY nom
		HAVING COUNT(*)>1)
--natural join solo deben tener en común las tablas un solo atributo.  
	--Si se repite el atributo no se puede
	
--2.Películas (título y lema) en las que han actuado solamente 
--personas que nacieron antes del 1970
SELECT titulo, lema 
FROM pelicula 
WHERE titulo NOT IN(
	SELECT titulo
	FROM actua a
	JOIN persona pe ON a.nom=pe.nom
	WHERE pe.fechanac>=date('1970-01-01') --(year from fechanac)>1970
	)
	
--3. Personas (todos los datos) que han actuado en todas las 
--películas dirigidas por Carrie-Anne Moss.
SELECT * 
	FROM Persona p
	WHERE NOT EXISTS
	(SELECT * 
		FROM dirige d
		WHERE d.nom='Carrie-Anne Moss' and NOT EXISTS
		(SELECT * 
			FROM actua a
			WHERE  a.titulo=d.titulo
			and a.nom=p.nom))

--4.Obtener el título y fecha de estreno de las películas dirigidas por Keanu Reeves.
SELECT p.titulo, p.estreno
	FROM Pelicula p 
	NATURAL JOIN (SELECT d.titulo 
					FROM dirige d
					WHERE d.nom='Keanu Reeves')

--5.Personas (todos los datos) que han actuado y/o 
--dirigido en las mismas Películas en las que actuó Keanu Reeves.
SELECT *
	FROM persona
	NATURAL JOIN ((SELECT distinct ac.nom 
					FROM actua ac
					JOIN (SELECT actua.titulo 
							FROM actua 
							WHERE actua.nom='Keanu Reeves') a 
					ON ac.titulo=a.titulo and ac.nom!='Keanu Reeves') UNION
					(SELECT distinct di.nom
						FROM dirige di
						JOIN (SELECT actua.titulo 
								FROM actua 
								WHERE actua.nom='Keanu Reeves') d
						ON di.titulo=d.titulo and di.nom!='Keanu Reeves'))
--FORMA MÁS FÁCIL	
SELECT distinct nom
	FROM
		(SELECT * FROM actua UNION SELECT * FROM dirige)
		NATURAL JOIN (SELECT titulo FROM actua WHERE nom='Keanu Reeves')
	WHERE nom!='Keanu Reeves'

--6. Personas (nombre) que han actuado en las películas 
--The Matrix y The Matrix Revolutions.
SELECT nom
	FROM
	((SELECT nom 
	FROM actua a
	WHERE a.titulo='The Matrix') INTERSECT
	(SELECT nom
		FROM actua a
		WHERE a.titulo='The Matrix Revolutions'))

--7. Persona/s (todos los datos) que ha/n dirigido más películas.
SELECT persona.* 
	FROM persona 
	NATURAL JOIN (SELECT dirige.nom 
	FROM dirige 
	GROUP BY dirige.nom ORDER BY COUNT(dirige.nom) DESC LIMIT 1)

--8.Nombre de la persona junto a la cantidad de películas que ha dirigido
SELECT dirige.nom, COUNT(*) 
FROM dirige
GROUP BY dirige.nom

--9.Personas (todos sus datos) que han participado actuando y 
--dirigiendo la misma película.
SELECT p.* 
FROM persona p 
WHERE p.nom IN (SELECT a.nom 
					FROM actua a 
					JOIN dirige d ON a.titulo=d.titulo and a.nom=d.nom)

--10.Título de la película junto a la cantidad de 
--personas que participaron actuando y/o dirigiendo. (consultar)


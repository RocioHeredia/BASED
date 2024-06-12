CREATE table Sucursal (
    num integer not null constraint pers_pk primary key,
    direcc varchar(30),
    tel varchar(30),
    provincia varchar(30)
);

CREATE table Producto (
    cod integer not null,
    num integer not null,
    nombre varchar(30),
    precio float,
    stock integer,
    primary key(cod,num),
    foreign key(num) references Sucursal(num) on delete cascade
);

CREATE table Ingrediente (
    cod integer not null,
    num integer not null,
    nombre varchar(40) not null,
    kcal float,
    primary key(cod,num,nombre),
    foreign key(cod,num) references Producto(cod,num) on delete cascade
);

CREATE TABLE Factura
(
    num integer not null primary key,
    fecha date,
    calif float
);









CREATE TABLE Detalle
(
    numf integer not null,
    cod integer not null,
    num integer not null,
    precio float,
    cantidad integer,
    primary key(numf,cod,num),
    foreign key(cod,num) references Producto(cod,num) on delete cascade   
);


insert into Sucursal values
    (100,'San Luis 104(E)','264-6555000','San Juan'),
    (101,'Av Libertador 450(O)','264-6345022','San Juan'),
    (200,'Salta 3109(E)','261-6555002','Mendoza'),
    (201,'Caseros 45(S)','261-6555000','Mendoza'),
    (300,'Victoria 489(N)','2652-6555000','San Luis'),
    (301,'Rioja 104(E)','2652-5644001','San Luis'),
    (400,'Estado de Israel(E)','351-5644351','Córdoba');

insert into Producto values
    (1000,100,'Pizza napolitana',560,202),
    (1001,100,'Pizza napolitana especial',660,103),
    (1000,101,'Pizza napolitana',460,89),
    (1001,101,'Pizza napolitana especial',560,67),
    (1000,200,'Pizza napolitana',560,76),
    (1001,200,'Pizza napolitana especial',480,56),
    (1002,201,'Pizza con jamón',680,45),
    (1003,201,'Pizza muzzarella',680,0),
    (1000,300,'Pizza napolitana',569,20),
    (1001,300,'Pizza napolitana especial',669,10),
    (1001,201,'Pizza napolitana especial',669,10),
    (1000,301,'Pizza napolitana',360,9),
    (1001,301,'Pizza especial',660,10),
    (1000,400,'Pizza napolitana',560,14),
    (1001,400,'Pizza napolitana especial',660,13);
   	 
Insert into Ingrediente values
    (1000,100,'Harina',578),
    (1000,100,'Sal',8),
    (1000,100,'Queso napolitano',1009),
    (1001,100,'Harina',578),
    (1001,100,'Sal',8),
    (1001,100,'Queso napolitano',1009),
    (1001,100,'Aceitunas',57),
    (1000,101,'Harina',589),
    (1000,101,'Sal',5),
    (1000,101,'Queso napolitano',1012),
    (1001,101,'Harina',589),
    (1001,101,'Sal',12),
    (1001,101,'Queso napolitano',1022),
    (1000,200,'Harina',589),
    (1000,200,'Sal',5),
    (1000,200,'Queso napolitano',1012),
    (1001,200,'Harina',589),
    (1001,200,'Sal',12),
    (1001,200,'Queso napolitano',2500),
    (1000,300,'Harina',589),
    (1000,300,'Sal',5),
    (1000,300,'Queso napolitano',1012),
    (1001,300,'Harina',799),
    (1001,300,'Sal',7),
    (1001,300,'Queso napolitano',1022),
    (1000,301,'Harina',589),
    (1000,301,'Sal',5),
    (1000,301,'Queso napolitano',1012),
    (1001,301,'Harina',799),
    (1001,301,'Sal',7),
    (1001,301,'Queso napolitano',1008),
    (1000,400,'Harina',492),
    (1000,400,'Sal',7),
    (1000,400,'Queso napolitano',1056),
    (1001,400,'Harina',799),
    (1001,400,'Sal',7),
    (1001,400,'Queso napolitano',1008),
    (1002,201,'Harina',678),
    (1002,201,'Sal',5),
    (1002,201,'Queso muzzarella',1012),
    (1002,201,'Jamó',2096),
    (1003,201,'Harina',799),
    (1003,201,'Sal',6),
    (1003,201,'Queso muzarrella',1008),
    (1003,201,'Aceitunas',1008);

Insert into Detalle values
    (3000,1000,100,560,2),
    (3001,1000,100,560,1),
    (3001,1001,100,660,2),
    (3002,1000,101,560,1),
    (3003,1000,100,560,5),
    (3004,1000,200,560,3),
    (3008,1002,201,680,2),
    (3005,1001,300,669,1),
    (3006,1000,301,569,3),
    (3007,1000,400,560,2);
    
Insert into Factura values
    (3000,'2020-02-14',5),
    (3001,'2020-02-14',4.5),
    (3002,'2020-03-23',6),
    (3003,'2020-05-01',4),
    (3004,'2020-05-01',5),
    (3005,'2020-05-25',6),
    (3006,'2020-06-09',4),
    (3007,'2020-02-14',3),
    (3008,'2020-02-14',7);

--1.Sucursales (todos los datos) que vendieron
--todos los productos que se comercializan en San Luis.


--2. Provincias donde se venden más de un producto.
SELECT s.provincia
	FROM sucursal s 
	JOIN detalle d ON s.num=d.num
	JOIN producto p ON d.cod=p.cod
	GROUP BY s.provincia
	HAVING COUNT(DISTINCT p.cod)>1

--3.Sucursales (todos los datos) que venden tanto Pizza napolitana 
--como Pizza napolitana especial.
SELECT distinct s.* 
	FROM sucursal s
	JOIN detalle d ON s.num=d.num
	WHERE d.cod IN (SELECT distinct p.cod 
						FROM producto p 
						WHERE p.nombre='Pizza napolitana')
	AND d.cod IN (SELECT distinct p.cod
						FROM producto p 
						WHERE p.nombre='Pizza napolitana especial')

--4. Productos (nombre y stock) comercializados en las provincias de 
--Cuyo (San Juan, Mendoza y San Luis).
SELECT distinct p.nombre, p.stock
	FROM producto p
	JOIN detalle d ON p.cod=d.cod
	JOIN sucursal s ON d.num=s.num
	WHERE s.provincia IN ('San Juan', 'Mendoza', 'San Luis')

--5.Provincias que no venden Pizza muzzarella.
SELECT distinct s.provincia 
	FROM sucursal s
	JOIN detalle d ON d.num=s.num
	WHERE d.cod !=(SELECT p.cod 
							FROM producto p 
							WHERE p.nombre='Pizza muzzarella')

--6.Sucursales que no venden el producto ‘Pizza con jamón’.
SELECT distinct s.*
	FROM sucursal s
	JOIN detalle d ON d.num=s.num
	WHERE d.cod !=(SELECT p.cod 
							FROM producto p 
							WHERE p.nombre='Pizza con jamón')

--7.Nombre de productos vendidos en San Juan.
SELECT distinct p.nombre
	FROM producto p
	JOIN detalle d ON d.cod=p.cod
	WHERE d.num IN (SELECT s.num 
						FROM sucursal s
						WHERE s.provincia='San Juan')

--8.Para cada sucursal de la provincia de San Luis, 
--obtener número e importe total facturado.
SELECT s.num, sum(d.precio*d.cantidad) imp_tot 
	FROM sucursal s
	JOIN detalle d ON s.num=d.num
	WHERE s.provincia='San Luis'
	GROUP BY s.num

--10. Provincia/s que más facturó durante el 2020.
SELECT s2.provincia
	FROM sucursal s2
	JOIN detalle d2 ON s2.num=d2.num
	JOIN factura f2 ON d2.numf=f2.num
	WHERE f2.fecha<= date('2020-12-31') AND f2.fecha>= date('2020-01-01')
	GROUP BY s2.provincia
	HAVING sum(d2.precio*d2.cantidad)= (SELECT max(total.fac_tot) 
			FROM(SELECT s.provincia, sum(d.precio * d.cantidad) fac_tot
					FROM detalle d
					JOIN sucursal s ON d.num=s.num
					JOIN factura f ON d.numf=f.num
					WHERE f.fecha<= date('2020-12-31') AND f.fecha>= date('2020-01-01')
					GROUP BY s.provincia) total)
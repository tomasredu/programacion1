/*Entrega 1
SCRIPT CREAR BD
*/
create database rotiseria_cuatro_estaciones_GUI
go
use rotiseria_cuatro_estaciones_GUI
go
set dateformat dmy
go

create table provincias(
	id_provincia int identity(1, 1),
	nombre varchar(50) not null
	constraint pk_provincia primary key (id_provincia)
);

create table ciudades(
	id_ciudad int identity(1, 1),
	nombre varchar(50) not null,
	id_provincia int  not null
	constraint pk_ciudad primary key (id_ciudad),
	constraint fk_ciudad_provincia foreign key(id_provincia)
		references provincias(id_provincia)
);

create table barrios(
	id_barrio int identity(1, 1),
	nombre varchar(50),
	id_ciudad int  not null
	constraint pk_barrio primary key (id_barrio),
	constraint fk_barrio_ciudad foreign key(id_ciudad)
		references ciudades(id_ciudad)
);

create table tipos_contacto(
	id_tipo_contacto int identity(1, 1),
	descripcion varchar(25) not null
	constraint pk_tipo_contacto primary key (id_tipo_contacto)
);

create table tipos_documento(
	id_tipo_documento int identity(1, 1), 
	descripcion varchar(25) not null
	constraint pk_tipo_documento primary key (id_tipo_documento)
);

create table estados_pedido( 
	id_estado_pedido int identity(1, 1),
	descripcion varchar(25) not null
	constraint pk_estado_pedido primary key (id_estado_pedido)
);

create table formas_pago(
	id_forma_pago int identity(1, 1),
	descripcion varchar(25) not null
	constraint pk_forma_pago primary key (id_forma_pago)
);

create table unidades_medida(
	id_unidad_medida int identity(1, 1),
	descripcion varchar(25)  not null
	constraint pk_unidad_medida primary key (id_unidad_medida)
);
 

create table encargados(
	id_encargado int identity(1, 1),
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	documento varchar(25) not null,
	id_tipo_documento int not null,
	fecha_nac datetime not null

	constraint pk_encargado primary key (id_encargado),
	constraint fk_encargado_tipo_doc foreign key(id_tipo_documento)
		references tipos_documento(id_tipo_documento),
);

create table repartidores(
	id_repartidor int identity(1, 1),
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	documento int not null,
	id_tipo_documento int not null,
	fecha_nac datetime not null,

	direccion varchar(50) not null,
	id_barrio int not null


	constraint pk_repartidor primary key (id_repartidor),
	constraint fk_repartidor_tipo_doc foreign key(id_tipo_documento)
		references tipos_documento(id_tipo_documento),
	
	constraint fk_repartidor_barrio foreign key(id_barrio)
		references barrios(id_barrio)
);

create table clientes(
	id_cliente int identity(1, 1),
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	documento varchar(25) not null,
	id_tipo_documento int  not null,
	fecha_nac datetime not null

	constraint pk_cliente primary key (id_cliente),
	constraint fk_cliente_tipo_doc foreign key(id_tipo_documento)
		references tipos_documento(id_tipo_documento),

);

create table sucursales(
	id_sucursal int identity(1, 1),
	descripcion varchar(50) not null,

	constraint pk_sucursal primary key (id_sucursal),
);

create table direcciones (
	id_direccion int identity(1, 1),
	direccion varchar(50) not null,
	id_barrio int not null,
	id_cliente int,
	id_encargado int,
	id_sucursal int


	constraint pk_direccion primary key (id_direccion),
	constraint fk_direccion_barrio foreign key(id_barrio)
		references barrios(id_barrio),
	constraint fk_direccion_cliente foreign key(id_cliente)
		references clientes(id_cliente),
	constraint fk_direccion_encargado foreign key(id_encargado)
		references encargados(id_encargado),
	constraint fk_direccion_sucursal foreign key(id_sucursal)
		references sucursales(id_sucursal)

);

create table contactos(
	id_contacto int identity(1, 1),
	contacto varchar(50) not null,
	id_tipo_contacto int not null,
	id_cliente int,
	id_repartidor int,
	id_encargado int,
	id_sucursal int

	constraint pk_contacto primary key (id_contacto),
	constraint fk_contacto_tipo_contacto foreign key(id_tipo_contacto)
		references tipos_contacto(id_tipo_contacto),
	constraint fk_contacto_cliente foreign key(id_cliente)
		references clientes(id_cliente),
	constraint fk_contacto_repartidor foreign key(id_repartidor)
		references repartidores(id_repartidor),
	constraint fk_contacto_encargado foreign key(id_encargado)
		references encargados(id_encargado),
	constraint fk_contacto_sucursal foreign key(id_sucursal)
		references sucursales(id_sucursal),

);

create table viajes(
	id_viaje int identity(1, 1),
	id_repartidor int

	constraint pk_viaje primary key (id_viaje),
	constraint fk_viaje_repartidor foreign key(id_repartidor)
		references repartidores(id_repartidor)
);

create table insumos(
	id_insumo int identity(1, 1),
	nombre varchar(80) not null,
	stock decimal(7,3) not null,
	id_unidad_medida int not null

	constraint pk_insumo primary key (id_insumo),
	constraint fk_insumo_unidad foreign key(id_unidad_medida)
		references unidades_medida(id_unidad_medida)
);

create table productos(
	id_producto int identity(1, 1),
	nombre varchar(50) not null,
	precio decimal(8,3) not null,
	descripcion varchar(200)

	constraint pk_producto primary key (id_producto)
);

create table promociones(
	id_promocion int identity(1, 1),
	nombre varchar(50) not null,
	descripcion varchar(100),
	descuento decimal(4,3) not null, 

	constraint pk_promocion primary key (id_promocion)
);

create table movimientos_stock(
	id_movimiento int identity(1,1),
	cantidad decimal(7,3) not null,
	fecha datetime not null,
	id_insumo int not null

	constraint pk_movimiento primary key(id_movimiento),
	constraint fk_movimiento_insumo foreign key(id_insumo)
		references insumos(id_insumo)
);



create table pedidos(
	id_pedido int identity(1, 1),
	id_cliente int not null,
	id_forma_pago int not null,
	id_sucursal int not null,
	id_encargado int not null,
	id_viaje int,
	id_direccion int,
	id_estado int,
	hora_emision datetime not null,
	hora_partida datetime,
	hora_entrega datetime

	constraint pk_pedido primary key (id_pedido),
	constraint fk_pedido_cliente foreign key(id_cliente)
		references clientes(id_cliente),
	constraint fk_pedido_forma_pago foreign key(id_forma_pago)
		references formas_pago(id_forma_pago),
	constraint fk_pedido_sucursal foreign key(id_sucursal)
		references sucursales(id_sucursal),
	constraint fk_pedido_encargado foreign key(id_encargado)
		references encargados(id_encargado),
	constraint fk_pedido_viaje foreign key(id_viaje)
		references viajes(id_viaje),
	constraint fk_pedido_direccion foreign key(id_direccion)
		references direcciones(id_direccion),
	constraint fk_pedidos_estado foreign key(id_estado)
		references estados_pedido(id_estado_pedido),
);


create table det_pedidos(
	id_det_pedido int identity(1, 1),
	id_pedido int not null,
	id_producto int not null,
	precio_venta decimal(8,3) not null,
	cantidad int not null,
	id_promocion int,
	descuento decimal(4,3)

	constraint pk_det_pedido primary key (id_det_pedido),
	constraint fk_det_pedido_pedido foreign key(id_pedido)
		references pedidos(id_pedido),
	constraint fk_det_pedido_producto foreign key(id_producto)
		references productos(id_producto),
	constraint fk_det_pedido_promocion foreign key(id_promocion)
		references promociones(id_promocion),
);

create table productos_promociones(
	id_prod_prom int identity(1, 1),
	id_promocion int not null,
	id_producto int,
	cantidad int

	constraint pk_prod_prom primary key (id_prod_prom),
	constraint fk_prod_prom_promocion foreign key(id_promocion)
		references promociones(id_promocion),
	constraint fk_prod_prom_producto foreign key(id_producto)
		references productos(id_producto),
);

create table productos_insumos(
	id_prod_insumo int identity(1, 1),
	id_insumo int not null,
	id_producto int not null,
	cantidad_insumo decimal(5,3)  not null

	constraint pk_prod_insumo primary key (id_prod_insumo),
	constraint fk_prod_insumo_insumo foreign key(id_insumo)
		references insumos(id_insumo),
	constraint fk_prod_insumo_producto foreign key(id_producto)
		references productos(id_producto),
);


--FIN SCRIPT CREAR BD


--Entrega 2

/*
Formato de comentarios

INICIO NOMBRE DE TABLA
nombre_tabla (campos a insertar)
	subdivision de sentencias para mejor lectura
sentencias insert
FIN NOMBRE DE TABLA

*/

--INICIO SCRIPT INSERCI�N DATOS

--provincias
insert into provincias
	values
		('C�rdoba'),
		('Santa Fe')

--ciudades (nombre, id_provincia)
insert into ciudades
	values
		('C�rdoba',1), 
		('Rosario',2),
		('R�o Ceballos', 1),
		('Alta Gracia', 1),
		('Carlos Paz', 1),
		('Villa La Bolsa',1),
		('Capit�n Berm�dez', 2),
		('Santa Fe', 2),
		('Villa Constituci�n', 2),
		('San Lorenzo', 2)

--INICIO BARRIOS
--barrios (nombre, id_ciudad)
--		barrios Cordoba
insert into barrios
	values
		('G�emes',1),
		('Alta C�rdoba',1),
		('Alberdi',1),
		('Alto Alberdi',1),
		('Centro',1),
		('Villa El Libertador',1),
		('Nueva C�rdoba',1),
		('Arg�ello',1),
		('General Pueyrred�n',1),
		('San vicente',1),
		('General Bustos',1),
		('General Paz',1),
		('Jard�n',1),
		('Cerro de las Rosas',1)

--		barrios Rosario
insert into barrios
	values
		('Centro',2),
		('Alberdi',2),
		('Lisandro de la Torre',2),
		('Ludue�a Norte',2),
		('Abasto',2),
		('Fisherton',2),
		('Azcu�naga',2),
		('Las Malvinas',2),
		('Belgrano',2),
		('Espa�a y Hospitales',2)


--		barrios ciudades menores de C�rdoba
insert into barrios
	values
		('Bella Vista',3),
		('Don Bosco',3),
		('El Caracol',3),
		('Sur',4),
		('El Crucero',4),
		('C�mara',4),
		('Centro',5),
		('Los Manantiales',5),
		('Sarmiento',5),
		('Altos',6),
		('Los Cerritos',6)

--		barrios ciudades menores de Santa Fe
insert into barrios
	values
		('Argumedo',7),
		('Batall�n',7),
		('Las Quintas',7),
		('Centro',8),
		('La Costa',8),
		('Suroeste',8),
		('San Jos�',9),
		('Congreve',9),
		('Evita',9),
		('3 de Febrero',10),
		('Rivadavia',10),
		('Bouchard',10)

--FIN BARRIOS

--tipos de contacto
insert into tipos_contacto
	values
		('Tel�fono Celular'),
		('Tel�fono Fijo'),
		('Correo Electr�nico'),
		('Instagram'),
		('Facebook'),
		('TikTok'),
		('Twitter')


--tipos documento
insert into tipos_documento
	values
		('DNI'),
		('Libreta C�vica'),
		('Libreta de Enrolamiento'),
		('C�dula'),
		('Pasaporte')

--estados pedido
insert into estados_pedido
	values
		('Atendido'),
		('Preparando'),
		('Listo'),
		('Repartiendo'),
		('Entregado'),
		('Cancelado')

--formas de pago
insert into formas_pago
	values
		('Efectivo'),
		('D�bito'),
		('Cr�dito'),
		('Transferencia'),
		('Vale')

--unidades de medida
insert into unidades_medida
	values
		('l'),
		('kg'),
		('ud.')

--encargados (nombre,apellido,documento,id_tipo_documento,fecha_nac)
insert into encargados
	values
		('Martina', 'Gonz�lez', 31087654, 3, '15/07/1998'),
		('Facundo', 'L�pez', 28543216, 1, '03/11/1995'),
		('Camila', 'Mart�nez', 29387461, 4, '22/09/1996'),
		('Lucas', 'Rodr�guez', 32784569, 2, '10/04/1993'),
		('Valentina', 'G�mez', 29567843, 5, '28/06/1997'),
		('Tom�s', 'Quiroga', 30219876, 3, '17/10/1992'),
		('Sof�a', 'P�rez', 31245698, 1, '05/12/1994'),
		('Santiago', 'D�az', 31478532, 4, '12/08/1999'),
		('Julieta', 'S�nchez', 33126987, 2, '19/03/1991'),
		('Mat�as', 'Romero', 34058712, 5, '07/05/1990')

--repartidores (nombre,apellido,documento,id_tipo_documento,fecha_nac)
insert into repartidores
	values
		('Luis', 'Acosta', 27895423, 4, '15/08/1990','De�n Funes 450',1),
		('Mar�a', 'Fern�ndez', 29354687, 1, '03/06/1985','V�lez Sarsfield 2902',3),
		('Carlos', 'Ram�rez', 30217896, 3, '22/10/1980','Sucre 814',8),
		('Laura', 'Fuentes', 28136452, 5, '10/04/1982','Los granaderos 1744',7),
		('Diego', 'Alvarez', 29987541, 2, '28/12/1975','General Paz 3412',12),
		('Silvia', 'Hern�ndez', 28563479, 1, '17/09/1978','San Lorenzo 911',17),
		('Fernando', 'Torres', 30987456, 3, '05/03/1995','Entre R�os 212',20),
		('Ana', 'Santos', 29674532, 2, '12/07/2000','Oro�o 340',21),
		('Tom�s', 'Rago', 43770902, 1, '30/04/2002','Sarmiento 15',34),
		('Juli�n', 'Rago', 45345008, 1, '25/04/2006','Rafael Lozada 314',28)

		/*
		('De�n Funes 450',1,NULL,1,NULL,NULL),
		('V�lez Sarsfield 2902',3,NULL,2,NULL,NULL),
		('Sucre 814',8,NULL,3,NULL,NULL),
		('Los granaderos 1744',7,NULL,4,NULL,NULL),
		('General Paz 3412',12,NULL,5,NULL,NULL),
		('San Lorenzo 911',17,NULL,6,NULL,NULL),
		('Entre R�os 212',20,NULL,7,NULL,NULL),
		('Oro�o 340',21,NULL,8,NULL,NULL),
		('Sarmiento 15',34,NULL,9,NULL,NULL),
		('Sarmiento 15',34,NULL,10,NULL,NULL),
		('Rafael Lozada 314',28,NULL,10,NULL,NULL)
		*/
		
--clientes (nombre,apellido,documento,id_tipo_documento,fecha_nac)
insert into clientes
	values
		('Luciana', 'Castillo', 30249876, 4, '15/08/1990'),
		('Facundo', 'Luna', 29453768, 1, '03/06/1985'),
		('Valentina', 'Sosa', 28761983, 3, '22/10/1980'),
		('Maximiliano', 'Gim�nez', 29973456, 5, '10/04/1982'),
		('Marcela', 'R�os', 27684539, 2, '28/12/1975'),
		('Gonzalo', 'Vargas', 28874621, 1, '17/09/1978'),
		('Camila', 'Molina', 30987564, 3, '05/03/1995'),
		('Ezequiel', 'Moreno', 29386574, 2, '12/07/2000'),
		('Julieta', 'Ferrari', 30754986, 5, '19/11/1972'),
		('Mat�as', 'Peralta', 28469573, 4, '07/01/1993'),
		('Agust�n', 'Soria', 29874651, 4, '15/08/1990'),
		('Sof�a', 'Vega', 29487563, 1, '03/06/1985'),
		('Joaqu�n', 'Herrera', 28795468, 3, '22/10/1980'),
		('Camila', 'Fern�ndez', 29984756, 5, '10/04/1982'),
		('Lucas', 'Pereyra', 27659874, 2, '28/12/1975'),
		('Valentina', 'Bustos', 28876543, 1, '17/09/1978'),
		('Mateo', 'Ferreyra', 30987465, 3, '05/03/1995'),
		('Martina', 'Sosa', 29387654, 2, '12/07/2000'),
		('Gabriela', 'L�pez', 28875649, 5, '19/11/1972'),
		('Pablo', 'Rojas', 30784563, 4, '07/01/1993')
		



--sucursales (descripcion)
insert into sucursales
	values
		('Alto Alberdi'),
		('Cerro'),
		('Nueva C�rdoba'),
		('Jard�n'),
		('Centro'),
		('Fisherton'),
		('Abasto'),
		('Belgrano'),
		('Alberdi'),
		('Azcu�naga')


--INICIO DIRECCIONES
--direcciones (direccion, id_barrio, id_cliente, id_repartidor, id_encargado, id_sucursal)
--		direcciones encargados
insert into direcciones
	values
		('Col�n 3052',4,NULL,1,NULL),
		('Chacabuco 132',5,NULL,2,NULL),
		('Duarte Quir�s 2814',4,NULL,3,NULL),
		('General Paz 120',5,NULL,4,NULL),
		('Hip�lito Yrigoyen 2670',7,NULL,5,NULL),
		('C�rdoba 1910',18,NULL,6,NULL),
		('Francia 2246',15,NULL,7,NULL),
		('Avellaneda 2820',23,NULL,8,NULL),
		('Maip� 1634',23,NULL,9,NULL),
		('Alberdi 3100',20,NULL,10,NULL),
		('Pellegrini 1714',19,NULL,8,NULL),
		('Acosta 322',14,NULL,3,NULL)

--		direcciones repartidores
/*
insert into direcciones
	values
		('De�n Funes 450',1,NULL,1,NULL,NULL),
		('V�lez Sarsfield 2902',3,NULL,2,NULL,NULL),
		('Sucre 814',8,NULL,3,NULL,NULL),
		('Los granaderos 1744',7,NULL,4,NULL,NULL),
		('General Paz 3412',12,NULL,5,NULL,NULL),
		('San Lorenzo 911',17,NULL,6,NULL,NULL),
		('Entre R�os 212',20,NULL,7,NULL,NULL),
		('Oro�o 340',21,NULL,8,NULL,NULL),
		('Sarmiento 15',34,NULL,9,NULL,NULL),
		('Sarmiento 15',34,NULL,10,NULL,NULL),
		('Rafael Lozada 314',28,NULL,10,NULL,NULL)
	*/	

--		direcciones clientes
insert into direcciones
	values
		('Buenos Aires 1436',1,1,NULL,NULL),
		('Col�n 1520',13,2,NULL,NULL),
		('San Jer�nimo 520',5,3,NULL,NULL),
		('Chacabuco 1254',4,4,NULL,NULL),
		('Laprida 993',7,5,NULL,NULL),
		('Avellaneda 2002',21,6,NULL,NULL),
		('Presidente Per�n 3145',24,7,NULL,NULL),
		('Oro�o 1510',18,8,NULL,NULL),
		('Catamarca 3100 ',22,9,NULL,NULL),
		('27 de Febrero 440',19,9,NULL,NULL),
		('Pellegrini 150',12,10,NULL,NULL),
		('San Juan 527',7,5,NULL,NULL)

--		direcciones sucursales
insert into direcciones
	values
		('Col�n 2855',4,NULL,NULL,1),
		('Rafael N��ez 256',14,NULL,NULL,2),
		('Rondeau 165',7,NULL,NULL,3),
		('Esperanza 3075',13,NULL,NULL,4),
		('Maip� 320',5,NULL,NULL,5),
		('Eva Per�n 8201',20,NULL,NULL,6),
		('Riobamba 1301 ',19,NULL,NULL,7),
		('San Lorenzo 6750',23,NULL,NULL,8),
		('Rondeau 2802',16,NULL,NULL,9),
		('Pellegrini 5045',21,NULL,NULL,10)

--FIN DIRECCIONES
		
		
--INICIO CONTACTOS
--contactos (contacto, id tipo_contacto, id_cliente, id_repartidor, id_encargado, id_sucursal)
--		contactos encargados
insert into contactos
	values
		('452367',2,NULL,NULL,1,NULL),
		('camila.martinez',5,NULL,NULL,3,NULL),
		('+54 9 341 987654',1,NULL,NULL,4,NULL),
		('dsantiago@ejemplo.com',3,NULL,NULL,8,NULL),
		('+54 9 297 123456',1,NULL,NULL,9,NULL)

--		contactos repartidores
insert into contactos
	values
		('+54 9 351 876543',1,NULL,1,NULL,NULL),
		('+54 9 381 234567',1,NULL,2,NULL,NULL),
		('carlos.ramirez',4,NULL,3,NULL,NULL),
		('+54 9 261 765432',1,NULL,4,NULL,NULL),
		('+54 9 291 543210',1,NULL,5,NULL,NULL),
		('+54 9 223 890123',1,NULL,6,NULL,NULL),
		('sil.hernandez',6,NULL,6,NULL,NULL),
		('+54 9 388 456789',1,NULL,7,NULL,NULL),
		('+54 9 294 678901',1,NULL,8,NULL,NULL),
		('+54 9 299 345678',1,NULL,9,NULL,NULL),
		('ju.rago123',4,NULL,10,NULL,NULL)

--		contactos clientes
insert into contactos
	values
		('+54 9 376 012345',1,1,NULL,NULL,NULL),
		('+54 9 362 567890',1,2,NULL,NULL,NULL),
		('+54 9 370 234567',1,3,NULL,NULL,NULL),
		('lu.cast',4,1,NULL,NULL,NULL),
		('maxi.gimenez',4,4,NULL,NULL,NULL),
		('marce.rios',6,5,NULL,NULL,NULL),
		('+54 9 296 890123',1,5,NULL,NULL,NULL),
		('469851',2,6,NULL,NULL,NULL),
		('cami.molina',5,7,NULL,NULL,NULL),
		('+54 9 364 456789',1,8,NULL,NULL,NULL),
		('juli.ferra',4,9,NULL,NULL,NULL),
		('matt.peralta',6,10,NULL,NULL,NULL)

--		contactos sucursales
insert into contactos
	values
		('41256',2,NULL,NULL,NULL,1),
		('alto.alberdi4estaciones@ejemplo.com',3,NULL,NULL,NULL,1),
		('cerro4estaciones',6,NULL,NULL,NULL,2),
		('+54 9 341 789012',1,NULL,NULL,NULL,3),
		('+54 9 379 890123',1,NULL,NULL,NULL,4),
		('centro.cba4estaciones',4,NULL,NULL,NULL,5),
		('fisherton.tw4estaciones',7,NULL,NULL,NULL,6),
		('abasto4estaciones@ejemplo.com',3,NULL,NULL,NULL,7),
		('+54 9 296 456789',1,NULL,NULL,NULL,8),
		('498723',2,NULL,NULL,NULL,9),
		('alberdi4estaciones@ejemplo.com',3,NULL,NULL,NULL,9)

--FIN CONTACTOS


--viajes (id_repartidor)
insert into viajes
	values
		(3),
		(1),
		(5),

		(7),
		(10),

		(2),
		(3),
		(8),
		(5),
		(6),
		(4),
		
		(6),
		(1)

--insumos (nombre, stock, id_unidad_medida)
insert into insumos
	values
		('Lomo',50,2),
		('Carne molida',15.46,2),
		('Harina',45.38,2),
		('Levadura',1.4,2),
		('Tapa de empanada',300,3),
		('Queso azul',23.11,2),
		('Ricotta',20.76,2),
		('Parmesano',19.43,2),
		('Muzarella',15.33,2),
		('Cebolla',112,3),
		('Tomate',234,3),
		('Salsa de tomate',9.21,1),
		('Mayonesa',12.49,1),
		('Ajo',321,3),
		('Lechuga',60.22,3),
		('Papas',58.76,2),
		('Pan lomito',110,3),
		('Pan Hamburguesa',98,3),
		('Jam�n',24.77,2),
		('Aceite',21.54,1),
		('Pepinos',30,3),
		('Cheddar',8.65,2),
		('Pollo',25,3),
		('Gaseosas chicas',36,3),
		('Cervezas chicas',72,3)



--productos (nombre, precio, descripcion)
insert into productos
	values
		('Lomito',12000,'Lomito completo con lechuga, tomate y aderezos.'),
		('Empanada de carne',950,'Empanada al horno hecha con lomo cortado a cuchillo.'),
		('Pizza 4 quesos',9800,'Pizza casera con queso azul, muzarella, parmesano y ricotta.'),
		('Empanada de jam�n y queso',850,'Empanada al horno rellena con queso y trozos de jam�n.'),
		('Pizza Fugazzeta',8500,'Pizza casera con cebollas.'),
		('Papas fritas chicas',3800,'Porci�n peque�a de papas fritas.'),
		('Papas fritas grandes',5600,'Porci�n grande de papas fritas.'),
		('Hamburguesa',10000,'Hamburguesa con medall�n, lechuga, tomate, pickles y cheddar.'),
		('Pollo asado',16000,'Pollo asado completo con aderezos y salsas a elecci�n.'),
		('Cerveza rubia 0.47L ',2500,'Lata de cerveza Imperial'),
		('Gaseosa 0.5L',2800,'Botella de gaseosa l�nea Coca-cola de 0.5L ')

--promociones (nombre, descripcion, descuento)
insert into promociones
	values
		('2x1 Lomitos','�Pag� 1 lomito, llev� 2!',0.5),
		('Super Combo','Llev� un lomito o una hamburguesa junto a una gaseosa.',0.85),
		('Happy Hour','Descuento a cerveza.',0.7),
		('Familiar','2 pizzas + 1 docena de empanadas.',0.75),
		('Cl�sico','Lomito o Hamburguesa + Porcion de papas',0.9),
		('Familiar Extra','2 pizzas + 2 docenas de empanadas',0.66),
		('Docena de empanadas','12 empanadas',0.8),
		('Llenador', '2 hamburguesas', 0.75),
		('Ticket 15 mil', 'Descuento a compra de m�s de 15 mil pesos',0.9),
		('Ticket 30 mil','Descuento a compra de m�s de 30 mil pesos',0.8),
		('Vale Gratis','Te llevas un Super combo gratis!',0)

--movimientos stock (cantidad, fecha, id_insumo)
insert into movimientos_stock
	values
		(30,'05/01/2024',1),
		(45,'11/03/2024',1),
		(19,'02/04/2024',1),
		(32,'9/02/2024',2),
		(37,'01/05/2024',2),
		(28,'02/04/2024',2),
		(150,'19/01/2024',3),
		(120,'21/03/2024',3),
		(28,'02/04/2024',23),
		(40,'19/04/2024',23),
		(15,'15/05/2024',23)


--pedidos (id_cliente, id_forma_pago, id_sucursal, id_encargado,
--			id_viaje, id_direccion, id_estado
--			hora_emision, hora_partida, hora_entrega)

insert into pedidos
	values
	--dia de hoy
		(1,2,1,1,1,1,5,'23/05/2024 20:21:14', '23/05/2024 20:51:14', '23/05/2024 21:11:14'),
		(10,1,1,1,1,11,5,'23/05/2024 20:42:21', '23/05/2024 21:10:01', '23/05/2024 21:15:20'),
		(4,2,1,1,NULL,NULL,6,'23/05/2024 20:28:41', NULL, NULL),
		(2,4,1,1,NULL,NULL,5,'23/05/2024 21:21:44', '23/05/2024 21:41:54', '23/05/2024 22:01:13'),
		(3,4,1,1,2,3,4,'23/05/2024 21:55:36', '23/05/2024 22:11:32', NULL),
		(5,2,1,1,2,5,4,'23/05/2024 22:01:02', '23/05/2024 22:17:08', NULL),
		(4,5,1,1,NULL,4,2,'23/05/2024 22:31:33', NULL, NULL),
	--ayer
		(10,2,2,1,NULL,11,6,'22/05/2024 20:21:51', NULL, NULL),
		(8,1,9,9,4,8,5,'22/05/2024 20:53:51', '22/05/2024 21:19:46', '22/05/2024 21:33:01'),
		(9,4,8,8,NULL,NULL,5,'22/05/2024 21:22:32', '22/05/2024 21:44:12', '22/05/2024 21:54:32'),
		(3,3,4,4,5,3,5,'22/05/2024 22:17:22', '22/05/2024 22:37:52', '22/05/2024 23:07:25'),
	--hasta 16/05
		(5,1,3,3,6,5,5,'21/05/2024 20:12:25', '21/05/2024 20:32:43', '21/05/2024 21:47:19'),
		(7,2,10,10,NULL,NULL,5,'21/05/2024 22:15:26', '21/05/2024 22:35:16', '21/05/2024 22:36:56'),
		(2,4,1,1,7,2,5,'20/05/2024 20:41:16', '20/05/2024 21:01:08', '20/05/2024 21:14:23'),
		(1,4,3,3,NULL,1,6,'20/05/2024 21:33:31', NULL, NULL),
		(9,2,6,6,8,9,5,'20/05/2024 22:10:53', '20/05/2024 22:32:53', '20/05/2024 22:43:17'),
		(10,2,1,1,NULL,11,6,'20/05/2024 23:15:16', NULL, NULL),
		(4,1,3,3,NULL,NULL,5,'19/05/2024 20:17:25', '19/05/2024 20:30:11', '19/05/2024 20:35:35'),
		(5,1,2,2,9,12,5,'19/05/2024 22:35:18', '19/05/2024 22:50:24', '19/05/2024 23:10:25'),
		(9,4,8,8,10,10,5,'18/05/2024 21:17:59', '18/05/2024 21:40:24', '18/05/2024 21:49:11'),
		(1,4,5,5,NULL,1,6,'18/05/2024 22:33:11', NULL, NULL),
		(3,3,4,4,11,3,5,'17/05/2024 21:45:51', '17/05/2024 22:01:41', '17/05/2024 22:18:20'),
		(6,5,10,10,NULL,NULL,5,'16/05/2024 22:05:01', '16/05/2024 22:26:21', '16/05/2024 22:28:19'),
	--abril
		(6,1,9,9,12,6,5,'30/04/2024 22:12:33', '30/04/2024 22:35:12', '30/04/2024 22:43:09'),
		(10,1,4,4,13,11,5,'26/04/2024 21:46:17', '26/04/2024 22:05:22', '26/04/2024 22:12:51'),
		(7,2,7,7,NULL,NULL,5,'10/04/2024 22:15:12', '10/04/2024 22:31:06', '10/04/2024 22:36:56'),
		(2,4,1,1,NULL,2,6,'05/04/2024 20:51:37', NULL, NULL)
		
		

--detalles pedidos (id_pedido, id_producto, precio_venta, cantidad, id_promocion, descuento)
insert into det_pedidos
	values 
		(1,3,9800.00,3,9,0.900),
		(2,9,16000.00,1,9,0.900),
		(3,1,12000.00,2,1,0.500),
		(4,6,3800.00,3,null,1),
		(5,5,8500.00,1,null,1),
		(6,7,5600.00,4,9,0.900),
		(7,10,2500.00,2,3,0.700),
		(8,2,950.00,12,4,0.750),
		(8,5,8500.00,2,4,0.750),
		(9,8,10000.00,2,8,0.750),
		(10,9,16000,3,10,0.800),
		(11,1,12000.00,1,2,0.850),
		(11,11,2800.00,1,2,0.850),
		(12,3,9800.00,2,6,0.660),
		(12,4,850.00,24,6,0.660),
		(13,8,10000.00,1,5,0.900),
		(13,7,5600.00,1,5,0.900)


--productos promociones (id_promocion, id_producto, cantidad)
insert into productos_promociones
	values
		(1,1,2),
		(2,1,1),
		(2,8,1),
		(2,11,1),
		(3,10,1),
		(4,3,2),
		(4,5,2),
		(4,2,12),
		(4,4,12),
		(5,1,1),
		(5,8,1),
		(5,6,1),
		(5,7,1),
		(6,3,2),
		(6,5,2),
		(6,2,24),
		(6,4,24),
		(7,2,12),
		(7,4,12),
		(8,8,2),
		(9,NULL,NULL),
		(10,NULL,NULL),
		(11,1,1),
		(11,8,1),
		(11,11,1)

--productos insumos (id_insumo, id_producto, cantidad_insumo)
insert into productos_insumos
	values
		(1,1,0.05),
		(11,1,0.5),
		(13,1,0.02),
		(15,1,0.25),
		(17,1,1),
		(1,2,0.2),
		(5,2,1),
		(3,3,0.2),
		(4,3,0.002),
		(6,3,0.1),
		(7,3,0.1),
		(8,3,0.1),
		(9,3,0.25),
		(5,4,1),
		(9,4,0.05),
		(19,4,0.05),
		(3,5,0.2),
		(4,5,0.002),
		(9,5,0.25),
		(10,5,2),
		(16,6,3),
		(20,6,0.1),
		(16,7,8),
		(20,7,0.15),
		(2,8,0.2),
		(11,8,0.2),
		(13,8,0.02),
		(15,8,0.2),
		(18,8,1),
		(21,8,0.025),
		(22,8,0.01),
		(23,9,1),
		(24,10,1),
		(25,11,1)


--FIN INSERTAR DATOS

--CONSULTAS

/*Mostrar una lista  de los articulos comprados ayer que ya fueron entregados junto
al nombre completo del cliente y el encargado, el nombre de la sucursal, el metodo de pago y la hora 
en la que fue emitido. */
/*
select p.id_pedido 'N� Pedido',
		prod.nombre 'Producto' ,
		c.nombre +' '+ c.apellido 'Cliente',
		e.nombre + ' ' + e.apellido 'Encargado', 
		s.descripcion 'Sucursal', 
		st.descripcion 'Estado',
		fp.descripcion 'Forma de pago',
		trim(Str(datepart(HH,p.hora_emision))) +':'+ trim(str(datepart(MINUTE,p.hora_emision))) 'Hora Emisi�n'

from det_pedidos dp join pedidos p on dp.id_pedido = p.id_pedido
join clientes c on p.id_cliente = c.id_cliente
join encargados e on p.id_encargado = e.id_encargado
join sucursales s on p.id_sucursal = s.id_sucursal
join estados_pedido st on p.id_estado = st.id_estado_pedido
join formas_pago fp on p.id_forma_pago = fp.id_forma_pago
join productos prod on dp.id_producto = prod.id_producto
where DATEDIFF(day,getdate(),p.hora_emision) = -1 and st.descripcion like 'Entregado'


/*Lista de pedidos junto a los productos solicitados, mostrando el monto con y sin descuento, 
el nombre completo del cliente y el encargado, el nombre de la sucursal y la fecha en la que fue realizado. No mostrar los
encargos que fueron cancelados y los pedidos hechos por clientes cuyo apellido termina con 'a'.
*/

select p.id_pedido 'N� Pedido', 
		p.hora_emision 'Fecha' , 
		prod.nombre 'Producto' ,
		round(dp.precio_venta * dp.cantidad,3) 'Monto', 
		round(dp.precio_venta * dp.cantidad * descuento,3) 'Monto final', 
		fp.descripcion 'Forma de pago',
		c.nombre +' '+ c.apellido 'Cliente',
		e.nombre + ' ' + e.apellido 'Encargado', 
		s.descripcion 'Sucursal', 
		st.descripcion 'Estado'


from det_pedidos dp join pedidos p on dp.id_pedido = p.id_pedido
join clientes c on p.id_cliente = c.id_cliente
join encargados e on p.id_encargado = e.id_encargado
join sucursales s on p.id_sucursal = s.id_sucursal
join estados_pedido st on p.id_estado = st.id_estado_pedido
join formas_pago fp on p.id_forma_pago = fp.id_forma_pago
join productos prod on dp.id_producto = prod.id_producto

where 
st.descripcion not like 'Cancelado'
and c.apellido like '%a'


/*Lista de pedidos que fueron entregados por delivery y que tardaron m�s de 15 minutos en ser entregados.
Mostrar n�mero de pedido, n�mero de viaje, tiempo de entrega en minutos, nombre completo del repartidor a cargo, sucursal y direcci�n de entrega.
*/

select p.id_pedido 'N� Pedido', 
		v.id_viaje 'N� Viaje',
		FORMAT(p.hora_partida, 'hh:mm') +' pm' 'Hora Partida',
		FORMAT(p.hora_entrega, 'hh:mm') +' pm' 'Hora Entrega',
		datediff(minute,p.hora_partida,p.hora_entrega) 'Tiempo Entrega (minutos)',
		r.nombre + ' ' + r.apellido 'Repartidor',
		d.direccion 'Destino',
		s.descripcion 'Sucursal'

from pedidos p join clientes c on p.id_cliente = c.id_cliente
join sucursales s on p.id_sucursal = s.id_sucursal
join viajes v on p.id_viaje = v.id_viaje
join repartidores r on v.id_repartidor = r.id_repartidor
join direcciones d on p.id_direccion = d.id_direccion

where p.hora_entrega is not null and datediff(minute,p.hora_partida,p.hora_entrega) > 15

/*
Lista de clientes que no viven en los barrios 'Centro', 'San Lorenzo', 'Espa�a y Hospitales', 'Abasto' y 'Las Malvinas' y tienen 
menos de 40 a�os. 
*/

SELECT cl.nombre +' '+ cl.apellido 'Cliente',
		cl.documento 'Documento', 
		td.descripcion 'Tipo Documento', 
		datediff(year,cl.fecha_nac,getdate()) 'Edad',
		b.nombre 'Barrio', 
		c.nombre 'Ciudad'

FROM clientes cl
JOIN direcciones d ON cl.id_cliente = d.id_cliente
JOIN barrios b ON d.id_barrio = b.id_barrio
JOIN ciudades c ON b.id_ciudad = c.id_ciudad
JOIN tipos_documento td on cl.id_tipo_documento = td.id_tipo_documento

WHERE b.nombre NOT IN ('Centro', 'San Lorenzo', 'Espa�a y Hospitales', 'Abasto', 'Las Malvinas')
and datediff(year,cl.fecha_nac,getdate()) < 40;


/*
Pedidos realizados por clientes cuyo apellido termina en 's' y que viven en la ciudad de C�rdoba. 
*/

select p.id_pedido 'N� Pedido',
		FORMAT(hora_emision,'dd/MM/yyyy') 'Fecha',
		c.nombre +' '+ c.apellido 'Cliente',
		e.nombre + ' ' + e.apellido 'Encargado', 
		s.descripcion 'Sucursal',
		d.direccion +', '+b.nombre+', '+ciud.nombre+', '+prov.nombre 'Direccion completa'

from pedidos p join clientes c on p.id_cliente = c.id_cliente
join encargados e on p.id_encargado = e.id_encargado
join sucursales s on p.id_sucursal = s.id_sucursal
join direcciones d on p.id_direccion = d.id_direccion
join barrios b on b.id_barrio = d.id_barrio
join ciudades ciud on ciud.id_ciudad = b.id_ciudad
join provincias prov on prov.id_provincia = ciud.id_provincia

where c.apellido like '%s'
and ciud.nombre like 'C�rdoba'

/*
Lista de productos que requieren de muzarella o tomate para su fabricaci�n y cuyo precio es mayor a 9000 pesos.
Mostrar el stock del insumo.
*/

select p.nombre 'Producto', p.precio 'Precio', i.nombre 'Insumo', str(i.stock) +' '+ um.descripcion 'Stock'
from productos p join productos_insumos pin on p.id_producto = pin.id_producto
join insumos i on i.id_insumo = pin.id_insumo
join unidades_medida um on i.id_unidad_medida = um.id_unidad_medida

where (i.nombre like 'Muzarella' or  i.nombre like 'Tomate')
and p.precio > 9000

/*

Mostrar las promociones que tengan pizza o hamburguesas y que apliquen m�s de 85% de descuento (porcentajes menores, descuento mayor).

*/

select distinct prom.nombre 'Promoci�n', prom.descuento 'Descuento',prom.descripcion 'Descripci�n' 
from promociones prom join productos_promociones pp on prom.id_promocion = pp.id_promocion
join productos prod on prod.id_producto = pp.id_producto

where (prod.nombre like 'Pizza%' or prod.nombre like 'Hamburguesa')
and prom.descuento < 0.85


/*
Mostrar los contactos de los repartidores que vivan en Rosario que sean n�meros de tel�fono.
*/

select r.nombre +' '+ r.apellido 'Repartidor',
		con.contacto 'Contacto',
		b.nombre'Barrio', 
		c.nombre 'Ciudad'
from repartidores r join direcciones d on d.id_repartidor = r.id_repartidor
join barrios b on d.id_barrio = b.id_barrio 
join ciudades c on b.id_ciudad = c.id_ciudad
join contactos con on r.id_repartidor = con.id_repartidor
join tipos_contacto tc on con.id_tipo_contacto = tc.id_tipo_contacto

where c.nombre like 'Rosario'
and tc.descripcion like 'Tel�fono%'

*/
--FIN CONSULTAS


--insercion de datos

/*
Formato de comentarios

INICIO NOMBRE DE TABLA
nombre_tabla (campos a insertar)
	subdivision de sentencias para mejor lectura
sentencias insert
FIN NOMBRE DE TABLA

*/

set dateformat dmy

use rotiseria_cuatro_estaciones_nueva

--provincias
insert into provincias
	values
		('Córdoba'),
		('Santa Fe')

--ciudades (nombre, id_provincia)
insert into ciudades
	values
		('Córdoba',1), 
		('Rosario',2),
		('Río Ceballos', 1),
		('Alta Gracia', 1),
		('Carlos Paz', 1),
		('Villa La Bolsa',1),
		('Capitán Bermúdez', 2),
		('Santa Fe', 2),
		('Villa Constitución', 2),
		('San Lorenzo', 2)

--INICIO BARRIOS
--barrios (nombre, id_ciudad)
--		barrios Cordoba
insert into barrios
	values
		('Güemes',1),
		('Alta Córdoba',1),
		('Alberdi',1),
		('Alto Alberdi',1),
		('Centro',1),
		('Villa El Libertador',1),
		('Nueva Córdoba',1),
		('Argüello',1),
		('General Pueyrredón',1),
		('San vicente',1),
		('General Bustos',1),
		('General Paz',1),
		('Jardín',1),
		('Cerro de las Rosas',1)

--		barrios Rosario
insert into barrios
	values
		('Centro',2),
		('Alberdi',2),
		('Lisandro de la Torre',2),
		('Ludueña Norte',2),
		('Abasto',2),
		('Fisherton',2),
		('Azcuénaga',2),
		('Las Malvinas',2),
		('Belgrano',2),
		('España y Hospitales',2)


--		barrios ciudades menores de Córdoba
insert into barrios
	values
		('Bella Vista',3),
		('Don Bosco',3),
		('El Caracol',3),
		('Sur',4),
		('El Crucero',4),
		('Cámara',4),
		('Centro',5),
		('Los Manantiales',5),
		('Sarmiento',5),
		('Altos',6),
		('Los Cerritos',6)

--		barrios ciudades menores de Santa Fe
insert into barrios
	values
		('Argumedo',7),
		('Batallán',7),
		('Las Quintas',7),
		('Centro',8),
		('La Costa',8),
		('Suroeste',8),
		('San José',9),
		('Congreve',9),
		('Evita',9),
		('3 de Febrero',10),
		('Rivadavia',10),
		('Bouchard',10)

--FIN BARRIOS

--tipos de contacto
insert into tipos_contacto
	values
		('Teléfono Celular'),
		('Teléfono Fijo'),
		('Correo Electrónico'),
		('Instagram'),
		('Facebook'),
		('TikTok'),
		('Twitter')


--tipos documento
insert into tipos_documento
	values
		('DNI'),
		('Libreta Cívica'),
		('Libreta de Enrolamiento'),
		('Cédula'),
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
		('Débito'),
		('Crédito'),
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
		('Martina', 'González', 31087654, 3, '15/07/1998'),
		('Facundo', 'López', 28543216, 1, '03/11/1995'),
		('Camila', 'Martínez', 29387461, 4, '22/09/1996'),
		('Lucas', 'Rodríguez', 32784569, 2, '10/04/1993'),
		('Valentina', 'Gómez', 29567843, 5, '28/06/1997'),
		('Tomás', 'Quiroga', 30219876, 3, '17/10/1992'),
		('Sofía', 'Pérez', 31245698, 1, '05/12/1994'),
		('Santiago', 'Díaz', 31478532, 4, '12/08/1999'),
		('Julieta', 'Sánchez', 33126987, 2, '19/03/1991'),
		('Matías', 'Romero', 34058712, 5, '07/05/1990')

--repartidores (nombre,apellido,documento,id_tipo_documento,fecha_nac)
insert into repartidores
	values
		('Luis', 'Acosta', 27895423, 4, '15/08/1990'),
		('María', 'Fernández', 29354687, 1, '03/06/1985'),
		('Carlos', 'Ramírez', 30217896, 3, '22/10/1980'),
		('Laura', 'Fuentes', 28136452, 5, '10/04/1982'),
		('Diego', 'Alvarez', 29987541, 2, '28/12/1975'),
		('Silvia', 'Hernández', 28563479, 1, '17/09/1978'),
		('Fernando', 'Torres', 30987456, 3, '05/03/1995'),
		('Ana', 'Santos', 29674532, 2, '12/07/2000'),
		('Tomás', 'Rago', 43770902, 1, '30/04/2002'),
		('Julián', 'Rago', 45345008, 1, '25/04/2006')
		
--clientes (nombre,apellido,documento,id_tipo_documento,fecha_nac)
insert into clientes
	values
		('Luciana', 'Castillo', 30249876, 4, '15/08/1990'),
		('Facundo', 'Luna', 29453768, 1, '03/06/1985'),
		('Valentina', 'Sosa', 28761983, 3, '22/10/1980'),
		('Maximiliano', 'Giménez', 29973456, 5, '10/04/1982'),
		('Marcela', 'Ríos', 27684539, 2, '28/12/1975'),
		('Gonzalo', 'Vargas', 28874621, 1, '17/09/1978'),
		('Camila', 'Molina', 30987564, 3, '05/03/1995'),
		('Ezequiel', 'Moreno', 29386574, 2, '12/07/2000'),
		('Julieta', 'Ferrari', 30754986, 5, '19/11/1972'),
		('Matías', 'Peralta', 28469573, 4, '07/01/1993'),
		('Agustín', 'Soria', 29874651, 4, '15/08/1990'),
		('Sofía', 'Vega', 29487563, 1, '03/06/1985'),
		('Joaquín', 'Herrera', 28795468, 3, '22/10/1980'),
		('Camila', 'Fernández', 29984756, 5, '10/04/1982'),
		('Lucas', 'Pereyra', 27659874, 2, '28/12/1975'),
		('Valentina', 'Bustos', 28876543, 1, '17/09/1978'),
		('Mateo', 'Ferreyra', 30987465, 3, '05/03/1995'),
		('Martina', 'Sosa', 29387654, 2, '12/07/2000'),
		('Gabriela', 'López', 28875649, 5, '19/11/1972'),
		('Pablo', 'Rojas', 30784563, 4, '07/01/1993')
		



--sucursales (descripcion)
insert into sucursales
	values
		('Alto Alberdi'),
		('Cerro'),
		('Nueva Córdoba'),
		('Jardín'),
		('Centro'),
		('Fisherton'),
		('Abasto'),
		('Belgrano'),
		('Alberdi'),
		('Azcuénaga')


--INICIO DIRECCIONES
--direcciones (direccion, id_barrio, id_cliente, id_repartidor, id_encargado, id_sucursal)
--		direcciones encargados
insert into direcciones
	values
		('Colón 3052',4,NULL,NULL,1,NULL),
		('Chacabuco 132',5,NULL,NULL,2,NULL),
		('Duarte Quirós 2814',4,NULL,NULL,3,NULL),
		('General Paz 120',5,NULL,NULL,4,NULL),
		('Hipólito Yrigoyen 2670',7,NULL,NULL,5,NULL),
		('Córdoba 1910',18,NULL,NULL,6,NULL),
		('Francia 2246',15,NULL,NULL,7,NULL),
		('Avellaneda 2820',23,NULL,NULL,8,NULL),
		('Maipú 1634',23,NULL,NULL,9,NULL),
		('Alberdi 3100',20,NULL,NULL,10,NULL),
		('Pellegrini 1714',19,NULL,NULL,8,NULL),
		('Acosta 322',14,NULL,NULL,3,NULL)

--		direcciones repartidores
insert into direcciones
	values
		('Deán Funes 450',1,NULL,1,NULL,NULL),
		('Vélez Sarsfield 2902',3,NULL,2,NULL,NULL),
		('Sucre 814',8,NULL,3,NULL,NULL),
		('Los granaderos 1744',7,NULL,4,NULL,NULL),
		('General Paz 3412',12,NULL,5,NULL,NULL),
		('San Lorenzo 911',17,NULL,6,NULL,NULL),
		('Entre Ríos 212',20,NULL,7,NULL,NULL),
		('Oroño 340',21,NULL,8,NULL,NULL),
		('Sarmiento 15',34,NULL,9,NULL,NULL),
		('Sarmiento 15',34,NULL,10,NULL,NULL),
		('Rafael Lozada 314',28,NULL,10,NULL,NULL)
		

--		direcciones clientes
insert into direcciones
	values
		('Buenos Aires 1436',1,1,NULL,NULL,NULL),
		('Colón 1520',13,2,NULL,NULL,NULL),
		('San Jerónimo 520',5,3,NULL,NULL,NULL),
		('Chacabuco 1254',4,4,NULL,NULL,NULL),
		('Laprida 993',7,5,NULL,NULL,NULL),
		('Avellaneda 2002',21,6,NULL,NULL,NULL),
		('Presidente Perón 3145',24,7,NULL,NULL,NULL),
		('Oroño 1510',18,8,NULL,NULL,NULL),
		('Catamarca 3100 ',22,9,NULL,NULL,NULL),
		('27 de Febrero 440',19,9,NULL,NULL,NULL),
		('Pellegrini 150',12,10,NULL,NULL,NULL),
		('San Juan 527',7,5,NULL,NULL,NULL)

--		direcciones sucursales
insert into direcciones
	values
		('Colón 2855',4,NULL,NULL,NULL,1),
		('Rafael Núñez 256',14,NULL,NULL,NULL,2),
		('Rondeau 165',7,NULL,NULL,NULL,3),
		('Esperanza 3075',13,NULL,NULL,NULL,4),
		('Maipú 320',5,NULL,NULL,NULL,5),
		('Eva Perón 8201',20,NULL,NULL,NULL,6),
		('Riobamba 1301 ',19,NULL,NULL,NULL,7),
		('San Lorenzo 6750',23,NULL,NULL,NULL,8),
		('Rondeau 2802',16,NULL,NULL,NULL,9),
		('Pellegrini 5045',21,NULL,NULL,NULL,10)

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
		()

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
		('Jamón',24.77,2),
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
		('Empanada de jamón y queso',850,'Empanada al horno rellena con queso y trozos de jamón.'),
		('Pizza Fugazzeta',8500,'Pizza casera con cebollas.'),
		('Papas fritas chicas',3800,'Porción pequeña de papas fritas.'),
		('Papas fritas grandes',5600,'Porción grande de papas fritas.'),
		('Hamburguesa',10000,'Hamburguesa con medallón, lechuga, tomate, pickles y cheddar.'),
		('Pollo asado',16000,'Pollo asado completo con aderezos y salsas a elección.'),
		('Cerveza rubia 0.47L ',2500,'Lata de cerveza Imperial'),
		('Gaseosa 0.5L',2800,'Botella de gaseosa línea Coca-cola de 0.5L ')

--promociones (nombre, descripcion, descuento)
insert into promociones
	values
		('2x1 Lomitos','¡Pagá 1 lomito, llevá 2!',0.5),
		('Super Combo','Llevá un lomito o una hamburguesa junto a una gaseosa.',0.85),
		('Happy Hour','Descuento a cerveza.',0.7),
		('Familiar','2 pizzas + 1 docena de empanadas.',0.75),
		('Clásico','Lomito o Hamburguesa + Porcion de papas',0.9),
		('Familiar Extra','2 pizzas + 2 docenas de empanadas',0.66),
		('Docena de empanadas','12 empanadas',0.8),
		('Llenador', '2 hamburguesas', 0.75),
		('Ticket 15 mil', 'Descuento a compra de más de 15 mil pesos',0.9),
		('Ticket 30 mil','Descuento a compra de más de 30 mil pesos',0.8),
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
		(1,2,1,1,1,1,5,'23/05/2024 20:21:14', '23/05/2024 20:21:14', '23/05/2024 20:21:14'),
		(10,1,1,1,1,11,5,'23/05/2024 20:42:21', '23/05/2024 21:10:01', '23/05/2024 21:15:20'),
		(4,2,1,1,NULL,NULL,6,'23/05/2024 20:28:41', NULL, NULL),
		(2,4,1,1,NULL,NULL,5,'23/05/2024 21:21:44', '23/05/2024 21:41:54', '23/05/2024 22:01:13'),
		(3,4,1,1,NULL,3,3,'23/05/2024 21:29:36', NULL, NULL),
		(5,2,1,1,NULL,5,6,'23/05/2024 22:01:02', NULL, NULL),
		(4,5,1,1,NULL,4,1,'23/05/2024 22:31:33', NULL, NULL),
	--ayer
		(10,2,2,1,NULL,11,6,'22/05/2024 20:21:51', NULL, NULL),
		(8,1,9,9,1,8,5,'22/05/2024 20:53:51', '22/05/2024 21:19:46', '22/05/2024 21:03:01'),
		(9,4,8,8,NULL,NULL,5,'22/05/2024 21:22:32', '22/05/2024 21:44:12', '22/05/2024 21:54:32'),
		(3,3,4,4,1,3,5,'22/05/2024 22:17:22', '22/05/2024 22:37:52', '22/05/2024 23:07:25'),
	--hasta 16/05
		(5,1,3,3,1,5,5,'21/05/2024 20:12:25', '21/05/2024 20:32:43', '21/05/2024 21:47:19'),
		(7,2,10,10,NULL,NULL,5,'21/05/2024 22:15:26', '21/05/2024 22:35:16', '21/05/2024 22:36:56'),
		(2,4,1,1,1,2,5,'20/05/2024 20:41:16', '20/05/2024 21:01:08', '20/05/2024 21:14:23'),
		(1,4,3,3,NULL,1,6,'20/05/2024 21:33:31', NULL, NULL),
		(9,2,6,6,1,9,5,'20/05/2024 22:10:53', '20/05/2024 22:32:53', '20/05/2024 22:43:17'),
		(10,2,1,1,NULL,11,6,'20/05/2024 23:15:16', NULL, NULL),
		(4,1,3,3,NULL,NULL,5,'19/05/2024 20:17:25', '19/05/2024 20:30:11', '19/05/2024 20:35:35'),
		(5,1,2,2,1,12,5,'19/05/2024 22:35:18', '19/05/2024 22:50:24', '19/05/2024 23:10:25'),
		(9,4,8,8,1,10,5,'18/05/2024 21:17:59', '18/05/2024 21:40:24', '23/05/2024 21:49:11'),
		(1,4,5,5,NULL,1,6,'18/05/2024 22:33:11', NULL, NULL),
		(3,3,4,4,1,3,5,'17/05/2024 21:45:51', '17/05/2024 22:01:41', '17/05/2024 22:18:20'),
		(6,5,10,10,NULL,NULL,5,'16/05/2024 22:05:01', '16/05/2024 22:26:21', '16/05/2024 22:28:19'),
	--abril
		(6,1,9,9,1,6,5,'30/04/2024 22:12:33', '30/04/2024 22:35:12', '30/04/2024 22:43:09'),
		(10,1,4,4,1,11,5,'26/04/2024 21:46:17', '26/04/2024 22:05:22', '26/04/2024 22:12:51'),
		(7,2,7,7,NULL,NULL,5,'10/04/2024 22:15:12', '10/04/2024 22:31:06', '10/04/2024 22:36:56'),
		(2,4,1,1,NULL,2,6,'05/04/2024 20:51:37', NULL, NULL)
		
		

--detalles pedidos (id_pedido, id_producto, precio_venta, cantidad, id_promocion, descuento)
insert into det_pedidos
values()


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



select  id_direccion, id_repartidor, b.nombre
from direcciones d join barrios b on d.id_barrio = b.id_barrio
where b.id_ciudad = 1 and id_repartidor is not null

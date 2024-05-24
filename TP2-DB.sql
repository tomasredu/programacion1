create database rotiseria_cuatro_estaciones_nueva
go
use rotiseria_cuatro_estaciones_nueva
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
	documento varchar(25) not null,
	id_tipo_documento int not null,
	fecha_nac datetime not null

	constraint pk_repartidor primary key (id_repartidor),
	constraint fk_repartidor_tipo_doc foreign key(id_tipo_documento)
		references tipos_documento(id_tipo_documento), 
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
	id_repartidor int,
	id_encargado int,
	id_sucursal int


	constraint pk_direccion primary key (id_direccion),
	constraint fk_direccion_barrio foreign key(id_barrio)
		references barrios(id_barrio),
	constraint fk_direccion_cliente foreign key(id_cliente)
		references clientes(id_cliente),
	constraint fk_direccion_repartidor foreign key(id_repartidor)
		references repartidores(id_repartidor),
	constraint fk_direccion_encargado foreign key(id_encargado)
		references encargados(id_encargado),
	constraint fk_direccion_sucursal foreign key(id_sucursal)
		references sucursales(id_sucursal),

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
	id_producto int not null,
	cantidad int not null

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
use rotiseria_cuatro_estaciones_GUI
go

select r.nombre, r.apellido, r.id_tipo_documento, td.descripcion, r.id_barrio, b.nombre,c.nombre,p.nombre 
from repartidores r join barrios b on b.id_barrio = r.id_barrio
join ciudades c on c.id_ciudad = b.id_ciudad
join provincias p on p.id_provincia = c.id_provincia
join tipos_documento td on r.id_tipo_documento = td.id_tipo_documento 
select * from barrios
select * from tipos_documento


go
create proc sp_editar_repartidor
@codigo int,
@nombre varchar(50),
@apellido varchar(50),
@documento int,
@id_tipo_documento int,
@fecha_nac datetime,
@direccion varchar(50),
@id_barrio int
as
update repartidores
set nombre = @nombre,
	apellido = @apellido,
	documento = @documento,
	id_tipo_documento = @id_tipo_documento,
	fecha_nac = @fecha_nac,
	direccion = @direccion,
	id_barrio = @id_barrio
where id_repartidor = @codigo
go

create proc sp_eliminar_repartidor
@codigo int,
as
delete from repartidores
where id_repartidor = @codigo;

go

create proc sp_traer_filtrados
@codigo int,
@nombre varchar(50),
@apellido varchar(50),
@documento int,
@tipo_documento varchar(50),
@fecha_nac datetime,
@direccion varchar(50),
@barrio varchar(100),
@ciudad varchar(100),
@provincia varchar(100)
as
select r.*, b.id_ciudad idBarrio, b.nombre Barrio,
		c.id_ciudad idCiudad, c.nombre Ciudad,
        p.id_provincia idProvincia, p.nombre Provincia,
        td.id_tipo_documento idTipo, td.descripcion Tipo 
from Repartidores r join Barrios b on r.id_barrio = b.id_barrio 
join Ciudades c on c.id_ciudad = b.id_ciudad 
join Provincias p on p.id_provincia = c.id_provincia 
join Tipos_Documento td on td.id_tipo_documento = r.id_tipo_documento
where CAST(r.id_repartidor as varchar) like '%@codigo%'
and r.nombre like '%@nombre%'
and r.apellido like '%@apellido%'
and Cast(r.documento as varchar) like '%'+@documento+'%'
and td.descripcion = @tipo_documento
and r.fecha_nac >= CAST(@fecha_nac as datetime)
and r.direccion like '%@direccion%'
and b.nombre = @barrio
and c.nombre = @ciudad
and p.nombre = @provincia

go

create proc sp_traer_custom
@codigo varchar(100),
@nombre varchar(50)
as
select r.*, b.id_ciudad idBarrio, b.nombre Barrio, c.id_ciudad idCiudad, c.nombre Ciudad, p.id_provincia idProvincia, p.nombre Provincia, td.id_tipo_documento idTipo, td.descripcion Tipo 
from Repartidores r join Barrios b on r.id_barrio = b.id_barrio 
join Ciudades c on c.id_ciudad = b.id_ciudad join Provincias p on p.id_provincia = c.id_provincia 
join Tipos_Documento td on td.id_tipo_documento = r.id_tipo_documento 
where cast(id_repartidor as varchar) like '%@codigo%' and r.nombre like '%@nombre%'

exec sp_traer_custom '3','a'

select r.*, b.id_ciudad idBarrio, b.nombre Barrio, c.id_ciudad idCiudad, c.nombre Ciudad, p.id_provincia idProvincia, p.nombre Provincia, td.id_tipo_documento idTipo, td.descripcion Tipo 
from Repartidores r join Barrios b on r.id_barrio = b.id_barrio 
join Ciudades c on c.id_ciudad = b.id_ciudad join Provincias p on p.id_provincia = c.id_provincia 
join Tipos_Documento td on td.id_tipo_documento = r.id_tipo_documento 
where cast(id_repartidor as varchar) like '%3%' and r.nombre like '%@b%'
select * from repartidores
select r.*, b.id_ciudad idBarrio, b.nombre Barrio, c.id_ciudad idCiudad, c.nombre Ciudad, p.id_provincia idProvincia, p.nombre Provincia, td.id_tipo_documento idTipo, td.descripcion Tipo from Repartidores r join Barrios b on r.id_barrio = b.id_barrio join Ciudades c on c.id_ciudad = b.id_ciudad join Provincias p on p.id_provincia = c.id_provincia join Tipos_Documento td on td.id_tipo_documento = r.id_tipo_documento where cast(id_repartidor as varchar) like '%3%'


select p.id_pedido 'Nº Pedido',
		prod.nombre 'Producto' ,
		c.nombre +' '+ c.apellido 'Cliente',
		e.nombre + ' ' + e.apellido 'Encargado', 
		s.descripcion 'Sucursal', 
		st.descripcion 'Estado',
		fp.descripcion 'Forma de pago',
		trim(Str(datepart(HH,p.hora_emision))) +':'+ trim(str(datepart(MINUTE,p.hora_emision))) 'Hora Emisión'

from det_pedidos dp join pedidos p on dp.id_pedido = p.id_pedido
join clientes c on p.id_cliente = c.id_cliente
join encargados e on p.id_encargado = e.id_encargado
join sucursales s on p.id_sucursal = s.id_sucursal
join estados_pedido st on p.id_estado = st.id_estado_pedido
join formas_pago fp on p.id_forma_pago = fp.id_forma_pago
join productos prod on dp.id_producto = prod.id_producto
where format(p.hora_emision,'dd/MM/yyyy') = '23/05/2024' and st.descripcion like 'Entregado'

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
and tc.descripcion like 'Teléfono%'
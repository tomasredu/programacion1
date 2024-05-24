select * from encargados order by fecha_nac;
select * from repartidores order by fecha_nac
select * from clientes order by fecha_nac

select * from barrios 

select direccion, barrios.nombre from direcciones join barrios on barrios.id_barrio = direcciones.id_barrio
select * from direcciones

select * from contactos

select * from promociones


delete encargados
dbcc checkident (encargados, reseed, 0);

delete repartidores
dbcc checkident (repartidores, reseed, 0);

delete clientes
dbcc checkident (clientes, reseed, 0);

delete direcciones
dbcc checkident (direcciones, reseed, 0);


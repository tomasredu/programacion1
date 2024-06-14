using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace TP3.Datos
{
    public class ConsultaDao
    {
        AccesoDatos oBD;
        string[] consultas =
        {
            "select p.id_pedido 'Nº Pedido',\r\n\t\tprod.nombre 'Producto' ,\r\n\t\tc.nombre +' '+ c.apellido 'Cliente',\r\n\t\te.nombre + ' ' + e.apellido 'Encargado', \r\n\t\ts.descripcion 'Sucursal', \r\n\t\tst.descripcion 'Estado',\r\n\t\tfp.descripcion 'Forma de pago',\r\n\t\ttrim(Str(datepart(HH,p.hora_emision))) +':'+ trim(str(datepart(MINUTE,p.hora_emision))) 'Hora Emisión'\r\n\r\nfrom det_pedidos dp join pedidos p on dp.id_pedido = p.id_pedido\r\njoin clientes c on p.id_cliente = c.id_cliente\r\njoin encargados e on p.id_encargado = e.id_encargado\r\njoin sucursales s on p.id_sucursal = s.id_sucursal\r\njoin estados_pedido st on p.id_estado = st.id_estado_pedido\r\njoin formas_pago fp on p.id_forma_pago = fp.id_forma_pago\r\njoin productos prod on dp.id_producto = prod.id_producto\r\nwhere format(p.hora_emision,'dd/MM/yyyy') = '23/05/2024' and st.descripcion like 'Entregado'\r\n",
            "select p.id_pedido 'Nº Pedido', \r\n\t\tp.hora_emision 'Fecha' , \r\n\t\tprod.nombre 'Producto' ,\r\n\t\tround(dp.precio_venta * dp.cantidad,3) 'Monto', \r\n\t\tround(dp.precio_venta * dp.cantidad * descuento,3) 'Monto final', \r\n\t\tfp.descripcion 'Forma de pago',\r\n\t\tc.nombre +' '+ c.apellido 'Cliente',\r\n\t\te.nombre + ' ' + e.apellido 'Encargado', \r\n\t\ts.descripcion 'Sucursal', \r\n\t\tst.descripcion 'Estado'\r\n\r\n\r\nfrom det_pedidos dp join pedidos p on dp.id_pedido = p.id_pedido\r\njoin clientes c on p.id_cliente = c.id_cliente\r\njoin encargados e on p.id_encargado = e.id_encargado\r\njoin sucursales s on p.id_sucursal = s.id_sucursal\r\njoin estados_pedido st on p.id_estado = st.id_estado_pedido\r\njoin formas_pago fp on p.id_forma_pago = fp.id_forma_pago\r\njoin productos prod on dp.id_producto = prod.id_producto\r\n\r\nwhere \r\nst.descripcion not like 'Cancelado'\r\nand c.apellido like '%a'",
            "select p.id_pedido 'Nº Pedido', \r\n\t\tv.id_viaje 'Nº Viaje',\r\n\t\tFORMAT(p.hora_partida, 'hh:mm') +' pm' 'Hora Partida',\r\n\t\tFORMAT(p.hora_entrega, 'hh:mm') +' pm' 'Hora Entrega',\r\n\t\tdatediff(minute,p.hora_partida,p.hora_entrega) 'Tiempo Entrega (minutos)',\r\n\t\tr.nombre + ' ' + r.apellido 'Repartidor',\r\n\t\td.direccion 'Destino',\r\n\t\ts.descripcion 'Sucursal'\r\n\r\nfrom pedidos p join clientes c on p.id_cliente = c.id_cliente\r\njoin sucursales s on p.id_sucursal = s.id_sucursal\r\njoin viajes v on p.id_viaje = v.id_viaje\r\njoin repartidores r on v.id_repartidor = r.id_repartidor\r\njoin direcciones d on p.id_direccion = d.id_direccion\r\n\r\nwhere p.hora_entrega is not null and datediff(minute,p.hora_partida,p.hora_entrega) > 15",
            "SELECT cl.nombre +' '+ cl.apellido 'Cliente',\r\n\t\tcl.documento 'Documento', \r\n\t\ttd.descripcion 'Tipo Documento', \r\n\t\tdatediff(year,cl.fecha_nac,getdate()) 'Edad',\r\n\t\tb.nombre 'Barrio', \r\n\t\tc.nombre 'Ciudad'\r\n\r\nFROM clientes cl\r\nJOIN direcciones d ON cl.id_cliente = d.id_cliente\r\nJOIN barrios b ON d.id_barrio = b.id_barrio\r\nJOIN ciudades c ON b.id_ciudad = c.id_ciudad\r\nJOIN tipos_documento td on cl.id_tipo_documento = td.id_tipo_documento\r\n\r\nWHERE b.nombre NOT IN ('Centro', 'San Lorenzo', 'España y Hospitales', 'Abasto', 'Las Malvinas')\r\nand datediff(year,cl.fecha_nac,getdate()) < 40;",
            "select p.id_pedido 'Nº Pedido',\r\n\t\tFORMAT(hora_emision,'dd/MM/yyyy') 'Fecha',\r\n\t\tc.nombre +' '+ c.apellido 'Cliente',\r\n\t\te.nombre + ' ' + e.apellido 'Encargado', \r\n\t\ts.descripcion 'Sucursal',\r\n\t\td.direccion +', '+b.nombre+', '+ciud.nombre+', '+prov.nombre 'Direccion completa'\r\n\r\nfrom pedidos p join clientes c on p.id_cliente = c.id_cliente\r\njoin encargados e on p.id_encargado = e.id_encargado\r\njoin sucursales s on p.id_sucursal = s.id_sucursal\r\njoin direcciones d on p.id_direccion = d.id_direccion\r\njoin barrios b on b.id_barrio = d.id_barrio\r\njoin ciudades ciud on ciud.id_ciudad = b.id_ciudad\r\njoin provincias prov on prov.id_provincia = ciud.id_provincia\r\n\r\nwhere c.apellido like '%s'\r\nand ciud.nombre like 'Córdoba'",
            "select p.nombre 'Producto', p.precio 'Precio', i.nombre 'Insumo', str(i.stock) +' '+ um.descripcion 'Stock'\r\nfrom productos p join productos_insumos pin on p.id_producto = pin.id_producto\r\njoin insumos i on i.id_insumo = pin.id_insumo\r\njoin unidades_medida um on i.id_unidad_medida = um.id_unidad_medida\r\n\r\nwhere (i.nombre like 'Muzarella' or  i.nombre like 'Tomate')\r\nand p.precio > 9000",
            "select distinct prom.nombre 'Promoción', prom.descuento 'Descuento',prom.descripcion 'Descripción' \r\nfrom promociones prom join productos_promociones pp on prom.id_promocion = pp.id_promocion\r\njoin productos prod on prod.id_producto = pp.id_producto\r\n\r\nwhere (prod.nombre like 'Pizza%' or prod.nombre like 'Hamburguesa')\r\nand prom.descuento < 0.85",
            "select r.nombre +' '+ r.apellido 'Cliente',\r\n\t\tcon.contacto 'Contacto',\r\n\t\tb.nombre'Barrio', \r\n\t\tc.nombre 'Ciudad'\r\nfrom Clientes r join direcciones d on d.id_cliente = r.id_cliente\r\njoin barrios b on d.id_barrio = b.id_barrio \r\njoin ciudades c on b.id_ciudad = c.id_ciudad\r\njoin contactos con on r.id_cliente = con.id_cliente\r\njoin tipos_contacto tc on con.id_tipo_contacto = tc.id_tipo_contacto\r\n\r\nwhere c.nombre like 'Rosario'\r\nand tc.descripcion like 'Teléfono%'"
            
        };

        public ConsultaDao()
        {
            oBD = new AccesoDatos();
        }

        public DataTable hacerConsulta(int i)
        {
            return oBD.consultarBD(consultas[i]);
        }
    }
}

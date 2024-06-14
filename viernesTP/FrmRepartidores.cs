using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TP3.Negocio;
using TP3.Presentacion.Consultas;


namespace TP3.Presentacion
{
    public partial class FrmRepartidores : Form
    {
        public FrmRepartidores()
        {
            InitializeComponent();
        }

        private void FrmRepartidores_Load(object sender, EventArgs e)
        {
            cargarCombo(cboProvincia);
            cargarCombo(cboTipoDocumento);
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            Form fd = new FormDetalles(Modo.Nuevo, new Repartidor());
            fd.ShowDialog();
        }

        private void btnConsultar_Click(object sender, EventArgs e)
        {
            if (chkTodos.Checked)
            {
                cargarGrilla();
            }
            else 
            {
                cargarGrilla(capturarCampos());
                
            }
            
        }
        public void cargarCombo(ComboBox comboBox)
        {


            switch (comboBox.Name)
            {
                case "cboProvincia":
                    UbicacionServicio ubiSvc = new UbicacionServicio();
                    List<Provincia> provincias = ubiSvc.traerProvincias();
                    comboBox.DataSource = provincias;

                    break;
                case "cboTipoDocumento":
                    RepartidorServicio rSvc = new RepartidorServicio();
                    List<TipoDocumento> tipos = rSvc.traerTiposDocumento();
                    comboBox.DataSource = tipos;
                    break;

            }
            comboBox.SelectedIndex = -1;
            comboBox.DropDownStyle = ComboBoxStyle.DropDownList;
        }

        private void cargarGrilla()
        {
            RepartidorServicio rSvc = new RepartidorServicio();
            dgvRepartidores.DataSource = rSvc.traerRepartidores();
            this.dgvRepartidores.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
        }
        private void cargarGrilla(string[] valores)
        {
            RepartidorServicio rSvc = new RepartidorServicio();
            this.dgvRepartidores.DataSource = rSvc.traerRepartidores(valores);
            this.dgvRepartidores.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
        }

        private string[] capturarCampos()
        {
            string[] valores = new string[10];
            
            valores[0] = !string.IsNullOrEmpty(txtCodigo.Text) ? txtCodigo.Text : "";
            valores[1] = !string.IsNullOrEmpty(txtNombre.Text) ? txtNombre.Text : "";
            valores[2] = !string.IsNullOrEmpty(txtApellido.Text) ? txtApellido.Text : "";
            valores[3] = !string.IsNullOrEmpty(txtDocumento.Text) ? txtDocumento.Text : "";
            valores[4] = cboTipoDocumento.SelectedItem != null ? cboTipoDocumento.SelectedItem.ToString() : "";
            valores[5] = !(dtpFechaNacimiento.Value.ToString("dd/MM/yyyy") == DateTime.Now.ToString("dd/MM/yyyy")) ? dtpFechaNacimiento.Value.ToString("dd/MM/yyyy") : "";
            valores[6] = !string.IsNullOrEmpty(txtDireccion.Text) ? txtDireccion.Text : "";
            valores[7] = cboProvincia.SelectedItem != null ? cboProvincia.SelectedItem.ToString() : "";
            valores[8] = cboCiudad.SelectedItem != null ? cboCiudad.SelectedItem.ToString() : "";
            valores[9] = cboBarrio.SelectedItem != null ? cboBarrio.SelectedItem.ToString() : "";

            return valores;
        }

        private void cboProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void cboCiudad_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            if((Repartidor)dgvRepartidores.SelectedRows[0].DataBoundItem != null)
            {
            Form fd = new FormDetalles(Modo.Editar, (Repartidor)dgvRepartidores.SelectedRows[0].DataBoundItem);
            fd.ShowDialog();

            }
            else{
            MessageBox.Show("Seleccione un repartidor de la grilla");
            }
            
        }

        private void btnDetalle_Click(object sender, EventArgs e)
        {
        
            if((Repartidor)dgvRepartidores.SelectedRows[0].DataBoundItem != null){
            Form fd = new FormDetalles(Modo.Detalle, (Repartidor)dgvRepartidores.SelectedRows[0].DataBoundItem);
            fd.ShowDialog();
            }
            else{
            MessageBox.Show("Seleccione un repartidor de la grilla");
            }
            
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
        
            if((Repartidor)dgvRepartidores.SelectedRows[0].DataBoundItem != null){
            Form fd = new FormDetalles(Modo.Detalle, (Repartidor)dgvRepartidores.SelectedRows[0].DataBoundItem);
            fd.ShowDialog();
            else{
            MessageBox.Show("Seleccione un repartidor de la grilla");
            }
            
        }

        private void cboProvincia_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            UbicacionServicio ubiSvc = new UbicacionServicio();
            if (cboProvincia.SelectedItem != null)
            {
                this.cboCiudad.DataSource = ubiSvc.traerCiudades((Provincia)cboProvincia.SelectedItem);
                cboCiudad.SelectedIndex = -1;
                cboCiudad.DropDownStyle = ComboBoxStyle.DropDownList;

            }
        }

        private void cboCiudad_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            UbicacionServicio ubiSvc = new UbicacionServicio();
            if (cboCiudad.SelectedItem != null)
            {
                this.cboBarrio.DataSource = ubiSvc.traerBarrios((Ciudad)cboCiudad.SelectedItem);
                cboBarrio.SelectedIndex = -1;
                cboBarrio.DropDownStyle = ComboBoxStyle.DropDownList;
            }
        }

        private void chkTodos_CheckedChanged(object sender, EventArgs e)
        {
            toggleCampos();
            limpiarCampos();
        }

        public void toggleCampos()
        {
            this.txtCodigo.Enabled = !txtCodigo.Enabled;
            this.txtNombre.Enabled = !txtNombre.Enabled;
            this.txtApellido.Enabled = !txtApellido.Enabled;
            this.txtDocumento.Enabled = !txtDocumento.Enabled;
            this.cboTipoDocumento.Enabled = !cboTipoDocumento.Enabled;
            this.dtpFechaNacimiento.Enabled = !dtpFechaNacimiento.Enabled;
            this.txtDireccion.Enabled = !txtDireccion.Enabled;
            this.cboProvincia.Enabled = !cboProvincia.Enabled;
            this.cboCiudad.Enabled = !cboCiudad.Enabled;
            this.cboBarrio.Enabled = !cboBarrio.Enabled;
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            limpiarCampos();
        }

        public void limpiarCampos()
        {
            this.txtCodigo.Text = null;
            this.txtNombre.Text = string.Empty;
            this.txtApellido.Text = string.Empty;
            this.txtDocumento.Text = null;
            this.cboTipoDocumento.SelectedIndex = -1;
            this.dtpFechaNacimiento.Value = DateTime.Now;
            this.txtDireccion.Text = string.Empty;
            this.cboProvincia.SelectedIndex = -1;
            this.cboCiudad.SelectedIndex = -1;
            this.cboBarrio.SelectedIndex = -1;

        }

        private void desarrolloToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Trabajo realizado por: Rago, Tomás 412012 - Grupo 5");
        }

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void repartidoresToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form fs = new FrmSoporte();
            fs.ShowDialog();
        }

        private void consulta1ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmC1 fc = new FrmC1("Mostrar una lista  de los articulos comprados ayer que ya fueron entregados junto al nombre completo del cliente y el encargado, el nombre de la sucursal, el metodo de pago y la hora en la que fue emitido.", 0);
            fc.ShowDialog();
        }

        private void consulta2ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmC1 fc = new FrmC1("Lista de pedidos junto a los productos solicitados, mostrando el monto con y sin descuento, el nombre completo del cliente y el encargado, el nombre de la sucursal y la fecha en la que fue realizado. No mostrar los encargos que fueron cancelados y los pedidos hechos por clientes cuyo apellido termina con 'a'.", 1);
            fc.ShowDialog();
        }

        private void consulta3ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmC1 fc = new FrmC1("Lista de pedidos que fueron entregados por delivery y que tardaron más de 15 minutos en ser entregados. Mostrar número de pedido, número de viaje, tiempo de entrega en minutos, nombre completo del repartidor a cargo, sucursal y dirección de entrega.", 2);
            fc.ShowDialog();
        }

        private void consulta4ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmC1 fc = new FrmC1("Lista de clientes que no viven en los barrios 'Centro', 'San Lorenzo', 'España y Hospitales', 'Abasto' y 'Las Malvinas' y tienen menos de 40 años. ", 3);
            fc.ShowDialog();
        }

        private void consulta5ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmC1 fc = new FrmC1("Pedidos realizados por clientes cuyo apellido termina en 's' y que viven en la ciudad de Córdoba.", 4);
            fc.ShowDialog();
        }

        private void consulta6ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmC1 fc = new FrmC1("Lista de productos que requieren de muzarella o tomate para su fabricación y cuyo precio es mayor a 9000 pesos. Mostrar el stock del insumo.", 5);
            fc.ShowDialog();
        }

        private void consulta7ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmC1 fc = new FrmC1("Mostrar las promociones que tengan pizza o hamburguesas y que apliquen más de 85% de descuento (porcentajes menores, descuento mayor).", 6);
            fc.ShowDialog();
        }

        private void consulta8ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmC1 fc = new FrmC1("Mostrar los contactos de los clientes que vivan en Rosario cuyo contacto sea números de teléfono.", 7);
            fc.ShowDialog();
        }

        private void FrmRepartidores_Enter(object sender, EventArgs e)
        {
            cargarGrilla();
        }

        private void FrmRepartidores_FormClosing(object sender, FormClosingEventArgs e)
        {
            if(MessageBox.Show("¿Quiere salir de la aplicación?", 
                "Salir", MessageBoxButtons.YesNo,MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.No) e.Cancel = true;

        }

        private void btnSalir_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void txtCodigo_Leave(object sender, EventArgs e)
        {
            if(chkFiltro.Checked) {
                cargarGrilla(capturarCampos());
            }
        }

        private void txtNombre_Leave(object sender, EventArgs e)
        {
            if (chkFiltro.Checked)
            {
                cargarGrilla(capturarCampos());
            }
        }

        private void txtApellido_Leave(object sender, EventArgs e)
        {
            if (chkFiltro.Checked)
            {
                cargarGrilla(capturarCampos());
            }
        }

        private void txtDocumento_Leave(object sender, EventArgs e)
        {
            if (chkFiltro.Checked)
            {
                cargarGrilla(capturarCampos());
            }
        }

        private void cboTipoDocumento_Leave(object sender, EventArgs e)
        {
            if (chkFiltro.Checked)
            {
                cargarGrilla(capturarCampos());
            }
        }

        private void dtpFechaNacimiento_Leave(object sender, EventArgs e)
        {
            if (chkFiltro.Checked)
            {
                cargarGrilla(capturarCampos());
            }
        }

        private void txtDireccion_Leave(object sender, EventArgs e)
        {
            if (chkFiltro.Checked)
            {
                cargarGrilla(capturarCampos());
            }
        }

        private void cboProvincia_Leave(object sender, EventArgs e)
        {
            if (chkFiltro.Checked)
            {
                cargarGrilla(capturarCampos());
            }
        }

        private void cboCiudad_Leave(object sender, EventArgs e)
        {
            if (chkFiltro.Checked)
            {
                cargarGrilla(capturarCampos());
            }
        }

        private void cboBarrio_Leave(object sender, EventArgs e)
        {
            if (chkFiltro.Checked)
            {
                cargarGrilla(capturarCampos());
            }
        }
    }
}

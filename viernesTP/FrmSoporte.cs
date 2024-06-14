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


namespace TP3.Presentacion
{
    public partial class FrmSoporte : Form
    {
        public FrmSoporte()
        {
            InitializeComponent();
        }

        private void FrmSoporte_Load(object sender, EventArgs e)
        {
            cargarCombo(cboCiudad);
            cargarGrilla();
            
        }

        public void cargarCombo(ComboBox comboBox)
        {
            UbicacionServicio ubiSvc = new UbicacionServicio();
            this.cboCiudad.DataSource = ubiSvc.traerCiudades();
            comboBox.SelectedIndex = -1;
            comboBox.DropDownStyle = ComboBoxStyle.DropDownList;
        }

        private void cargarGrilla()
        {
            UbicacionServicio rSvc = new UbicacionServicio();
            this.dgvBarrios.DataSource = rSvc.traerBarrios();
            this.dgvBarrios.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            Form fb = new FrmDetBarrio(Modo.Nuevo, new Barrio());
            fb.ShowDialog();
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            Form fb = new FrmDetBarrio(Modo.Editar, (Barrio)dgvBarrios.SelectedRows[0].DataBoundItem);
            fb.ShowDialog();
        }

        private void btnDetalle_Click(object sender, EventArgs e)
        {
            Form fb = new FrmDetBarrio(Modo.Detalle, (Barrio)dgvBarrios.SelectedRows[0].DataBoundItem);
            fb.ShowDialog();
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            Form fb = new FrmDetBarrio(Modo.Eliminar, (Barrio)dgvBarrios.SelectedRows[0].DataBoundItem);
            fb.ShowDialog();
        }

        private void btnConsultar_Click(object sender, EventArgs e)
        {
            UbicacionServicio ubiSvc = new UbicacionServicio();
            if(chkTodos.Checked)
            {
                cargarGrilla();
            }
            else
            {
                dgvBarrios.DataSource = ubiSvc.traerBarrios((Ciudad)cboCiudad.SelectedItem);
            }
            
        }
    }
}

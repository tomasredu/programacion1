using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using TP3.Negocio;

namespace TP3.Presentacion
{
    public partial class FrmDetBarrio : Form
    {
        Barrio b;
        Modo modo;
        public FrmDetBarrio(Modo modo, Barrio b)
        {
            InitializeComponent();
            this.b = b;
            this.modo = modo;
        }

        private void FrmDetBarrio_Load(object sender, EventArgs e)
        {
            cargarCombo(cboCiudad);
            switch (modo)
            {
                case Modo.Nuevo:
                    limpiarCampos();
                    txtCodigo.Enabled = false;
                    this.Text = "Nuevo barrio";
                    break;
                case Modo.Detalle:
                    toggleCampos();
                    renderCampos();
                    this.Text = "Detalle barrio";
                    break;
                case Modo.Editar:
                    this.txtCodigo.Enabled = false;
                    renderCampos();
                    this.Text = "Editar barrio";
                    break;
                case Modo.Eliminar:
                    toggleCampos();
                    renderCampos();
                    this.Text = "Eliminar barrio";
                    break;
                default:
                    toggleCampos();
                    break;

            }
        }
        public void cargarCombo(ComboBox comboBox)
        {
            UbicacionServicio ubiSvc = new UbicacionServicio();
            this.cboCiudad.DataSource = ubiSvc.traerCiudades();
            comboBox.SelectedIndex = -1;
            comboBox.DropDownStyle = ComboBoxStyle.DropDownList;
        }
        public void limpiarCampos()
        {
            this.txtCodigo.Text = null;
            this.txtNombre.Text = string.Empty;
            this.cboCiudad.SelectedIndex = -1;
           

        }

        public void toggleCampos()
        {
            this.txtCodigo.Enabled = !txtCodigo.Enabled;
            this.txtNombre.Enabled = !txtNombre.Enabled;
            this.cboCiudad.Enabled = false;
        }

        private void renderCampos()
        {
            UbicacionServicio ubiSvc = new UbicacionServicio();
            this.txtCodigo.Text = b.Codigo.ToString();
            this.txtNombre.Text = b.Nombre;
            this.cboCiudad.SelectedIndex = indexOfCiudad(b.Ciudad);
            
        }
        public int indexOfCiudad(Ciudad c2)
        {
            int indice = -1;
            for (int i = 0; i < cboCiudad.Items.Count; i++)
            {
                Ciudad c1 = (Ciudad)cboCiudad.Items[i];
                if (c1.Nombre == c2.Nombre)
                {
                    indice = i;
                }
            }
            return indice;
        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            UbicacionServicio ubiSvc = new UbicacionServicio();
            //validar campos

            if (this.ValidateChildren())
            {

                cargarBarrio();

                switch (modo)
                {
                    case Modo.Nuevo:
                        if (MessageBox.Show("¿Está seguro de añadir el barrio?",
                                        "Nuevo barrio",
                                        MessageBoxButtons.YesNo,
                                        MessageBoxIcon.Question,
                                        MessageBoxDefaultButton.Button2)
                        == DialogResult.Yes) ubiSvc.agregarBarrio(b);
                       
                        break;
                    case Modo.Editar:
                        if(MessageBox.Show("¿Está seguro de editar el barrio?",
                                        "Editar barrio",
                                        MessageBoxButtons.YesNo,
                                        MessageBoxIcon.Question,
                                        MessageBoxDefaultButton.Button2)
                        == DialogResult.Yes) ubiSvc.editarBarrio(b);
                        break;
                    case Modo.Eliminar:
                        if (MessageBox.Show("¿Está seguro de eliminar el barrio?",
                                        "Eliminar barrio",
                                        MessageBoxButtons.YesNo,
                                        MessageBoxIcon.Question,
                                        MessageBoxDefaultButton.Button2)
                        == DialogResult.Yes) ubiSvc.eliminarBarrio(b);
                        break;

                }

                Close();

            }
            
            
        }
        public void cargarBarrio()
        {
            if (txtCodigo.Text == "")
            {
                b.Codigo = 0;
            }
            else
            {
                b.Codigo = Convert.ToInt32(txtCodigo.Text);
            }

            b.Nombre = txtNombre.Text;
            b.Ciudad = (Ciudad)cboCiudad.SelectedItem;
        }

        public bool esNombreValido(string s, out string err)
        {
            bool aux = true;
            err = "";
            if (string.IsNullOrEmpty(s))
            {
                aux = false;
                err = "Ingrese un nombre";
            }
            else
            {
                if (!esMenorALongitud(s, 50))
                {
                    aux = false;
                    err = "El nombre debe ser menor a 50 caracteres";

                }
                if (contieneNumOEsp(s))
                {
                    aux = false;
                    err = "El nombre no debe contener números o caracteres especiales";

                }
            }
            return aux;
        }
        public bool esMenorALongitud(string s, int length)
        {
            bool aux = false;

            if (s.Length > 0 && s.Length <= length) aux = true;
            return aux;
        }
        public bool contieneNumOEsp(string s)
        {
            bool aux = Regex.Match(s, @"[^\w\s]+").Success || Regex.IsMatch(s, @"\d");
            return aux;
        }

        public bool esCiudadValida(out string err)
        {
            bool aux = true;
            err = "";
            if (cboCiudad.SelectedIndex == -1)
            {
                aux = false;
                err = "Seleccione una ciudad.";
            }

            return aux;
        }

       

        
        private void cboCiudad_Validating(object sender, CancelEventArgs e)
        {
            string err;
            if (!esCiudadValida(out err))
            {
                e.Cancel = true;
                //cboCiudad.Select();
                this.errCiudad.SetError(cboCiudad, err);
            }
        }

        private void cboCiudad_Validated(object sender, EventArgs e)
        {
            this.errCiudad.SetError(cboCiudad, "");
        }
    }
}

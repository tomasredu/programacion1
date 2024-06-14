using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using TP3.Negocio;


namespace TP3.Presentacion
{
    public partial class FormDetalles : Form
    {
        Modo modo;
        Repartidor repartidor;
        public FormDetalles(Modo modo, Repartidor repartidor)
        {
            InitializeComponent();
            this.modo = modo;
            this.repartidor = repartidor;
        }

        private void FormDetalles_Load(object sender, EventArgs e)
        {
            cargarCombo(cboProvincia);
            cargarCombo(cboTipoDocumento);
            
            
            switch (modo){
                case Modo.Nuevo:
                    limpiarCampos();
                    txtCodigo.Enabled = false;
                    break;
                case Modo.Detalle:
                    toggleCampos();
                    renderCampos();
                    break;
                case Modo.Editar:
                    this.txtCodigo.Enabled = false;
                    renderCampos();
                    break;
                case Modo.Eliminar:
                    toggleCampos();
                    renderCampos();
                    break;
                default:
                    toggleCampos();
                    break;

            }
            
            
            

        }

        private void renderCampos()
        {
            UbicacionServicio ubiSvc = new UbicacionServicio();
            this.txtCodigo.Text = repartidor.Codigo.ToString();
            this.txtNombre.Text = repartidor.Nombre;
            this.txtApellido.Text = repartidor.Apellido;
            this.txtDocumento.Text = repartidor.Documento.ToString();
            this.cboTipoDocumento.SelectedIndex = indexOfTipo(repartidor.TipoDocumento);
            this.dtpFechaNacimiento.Value = repartidor.FechaNacimiento;
            this.txtDireccion.Text = repartidor.Direccion;
            
           
            this.cboProvincia.SelectedIndex = indexOfProvincia(repartidor.Barrio.Ciudad.Provincia);
            this.cboCiudad.SelectedIndex = indexOfCiudad(repartidor.Barrio.Ciudad);
            this.cboBarrio.SelectedIndex = indexOfBarrio(repartidor.Barrio);
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
                    List<TipoDocumento> tipos =  rSvc.traerTiposDocumento();
                    comboBox.DataSource = tipos;
                    break;
                
            }
            comboBox.SelectedIndex = -1;
            comboBox.DropDownStyle = ComboBoxStyle.DropDownList;
        }

        private void cboProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            UbicacionServicio ubiSvc = new UbicacionServicio();
            if(cboProvincia.SelectedItem != null)
            {
                this.cboCiudad.DataSource = ubiSvc.traerCiudades((Provincia)cboProvincia.SelectedItem);
                cboCiudad.SelectedIndex = -1;
                cboCiudad.DropDownStyle = ComboBoxStyle.DropDownList;

            }
            
        }

        private void cboBarrio_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void cboCiudad_SelectedIndexChanged(object sender, EventArgs e)
        {
            UbicacionServicio ubiSvc = new UbicacionServicio();
            if (cboCiudad.SelectedItem != null)
            {
                this.cboBarrio.DataSource = ubiSvc.traerBarrios((Ciudad)cboCiudad.SelectedItem);
                cboBarrio.SelectedIndex = -1;
                cboBarrio.DropDownStyle = ComboBoxStyle.DropDownList;
            }

            
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

        public void toggleCbo(ComboBox cbo)
        {
            cbo.SelectedIndex = -1;
            cbo.Visible = !cboCiudad.Visible;
        }

        public int indexOfProvincia(Provincia p2)
        {
            int indice = -1;
            for (int i = 0; i < cboProvincia.Items.Count; i++)
            {
                Provincia p1 = (Provincia)cboProvincia.Items[i];
                if (p1.Nombre == p2.Nombre)
                {
                    indice = i;
                }
            }
            return indice;
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
        public int indexOfBarrio(Barrio b2)
        {
            int indice = -1;
            for (int i = 0; i < cboBarrio.Items.Count; i++)
            {
                Barrio b1 = (Barrio)cboBarrio.Items[i];
                if (b1.Nombre == b2.Nombre)
                {
                    indice = i;
                }
            }
            return indice;
        }

        public int indexOfTipo(TipoDocumento td2)
        {
            int indice = -1;
            for (int i = 0; i < cboTipoDocumento.Items.Count; i++)
            {
                TipoDocumento td1 = (TipoDocumento)cboTipoDocumento.Items[i];
                if (td1.Tipo == td2.Tipo && td1.Codigo == td2.Codigo)
                {
                    indice = i;
                }
            }
            
            return indice;
        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            RepartidorServicio rSvc = new RepartidorServicio();
            //validar campos
            
            if (this.ValidateChildren())
            { 
                cargarRepartidor();

                switch (modo)
                {
                    case Modo.Nuevo:
                        if (MessageBox.Show("¿Está seguro de añadir al repartidor?",
                                        "Nuevo repartidor",
                                        MessageBoxButtons.YesNo,
                                        MessageBoxIcon.Question,
                                        MessageBoxDefaultButton.Button2)
                        == DialogResult.Yes) {
                            rSvc.agregarRepartidor(repartidor);
                            Close();
                        } 

                        break;
                    case Modo.Editar:
                        if (MessageBox.Show("¿Está seguro de modificar los datos del repartidor?",
                                        "Modificar repartidor",
                                        MessageBoxButtons.YesNo,
                                        MessageBoxIcon.Question,
                                        MessageBoxDefaultButton.Button2)
                        == DialogResult.Yes)
                        {
                            rSvc.editarRepartidor(repartidor);
                            Close();
                        } 
                            
                        break;
                    case Modo.Eliminar:
                        if (MessageBox.Show("¿Está seguro de eliminar al repartidor?",
                                        "Eliminar repartidor",
                                        MessageBoxButtons.YesNo,
                                        MessageBoxIcon.Question,
                                        MessageBoxDefaultButton.Button2)
                        == DialogResult.Yes)
                        {
                            rSvc.eliminarRepartidor(repartidor);
                            Close();
                        }
                            
                        break;

                }
                
                
            }
            else
            {
                MessageBox.Show("Datos no validos");
            }
            
            
            

            //repartidor ==> campos
            


            //llevar repartidor a servicios
            
            
        }

        public void cargarRepartidor()
        {
            if(txtCodigo.Text == "")
            {
                repartidor.Codigo = 0;
            }
            else
            {
                repartidor.Codigo = Convert.ToInt32(txtCodigo.Text);
            }
            
            repartidor.Nombre = txtNombre.Text;
            repartidor.Apellido = txtApellido.Text;
            repartidor.Documento = Convert.ToInt32(txtDocumento.Text);
            repartidor.TipoDocumento = (TipoDocumento)cboTipoDocumento.SelectedItem;
            repartidor.FechaNacimiento = dtpFechaNacimiento.Value;
            repartidor.Direccion = txtDireccion.Text;
            repartidor.Barrio = (Barrio)cboBarrio.SelectedItem; 
        }
        

        public bool esNombreValido(string s, out string err)
        {
            bool aux = true;
            err = "";
            if (string.IsNullOrEmpty(s)) {
                aux = false;
                err =  "Ingrese un nombre";
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
        public bool esApellidoValido(string s, out string err)
        {
            bool aux = true;
            err = "";

            if (string.IsNullOrEmpty(s))
            {
                aux = false;
                err = "Ingrese un apellido";
                
            }
            else
            {
                if (!esMenorALongitud(s, 50))
                {
                    aux = false;
                    err = "El apellido debe ser menor a 50 caracteres";
                    
                }
                if (contieneNumOEsp(s))
                {
                    aux = false;
                    err = "El apellido no debe contener números o caracteres especiales";
                    
                }
            }
            return aux;
        }
        public bool esDocumentoValido(string d, out string err)
        {
            bool aux = true;
            err = "";
            if (string.IsNullOrEmpty(d))
            {
                aux = false;
                err = "Ingrese un documento";
            }
            else
            {
                if (contieneLetras(d))
                {
                    aux = false;
                    err = "El documento no debe contener letras o caracteres especiales";
                }
                else
                {
                    int inputNumerico = Convert.ToInt32(Regex.Replace(d, @"\D", string.Empty));
                    if (inputNumerico < 9999999 || inputNumerico > 99999999)
                    {
                        aux = false;
                        err = "El documento debe ser valido";
                    }
                }
            }
            return aux;
        }
        public bool esFechaValida(DateTime date, out string err)
        {
            bool aux = true;
            err = "";

            
            if(date >= DateTime.Now)
            {
                aux = false;
                err = "Fecha de nacimiento no válida.";
            }
            else
            {
                int edadR = (DateTime.Now - date).Days;
                if (edadR < 16)
                {
                    aux = false;
                    err = "Repartidor debe tener al menos 16 años.";
                }
            }
            
            
            return aux;
        }

        public bool esDireccionValida(string s, out string err)
        {
            bool aux = true;
            err = "";
            if (string.IsNullOrEmpty(s))
            {
                aux = false;
                err = "Ingrese una direccion";
            }
            else
            {
                if (!esMenorALongitud(s, 50))
                {
                    aux = false;
                    err = "La direccion debe ser menor a 50 caracteres";
                }
                if (Regex.Match(s, @"[^\w\s]+").Success)
                {
                    aux = false;
                    err = "La direccion no debe contener caracteres especiales";
                }
                if (!Regex.IsMatch(s, @"\w\s\d"))
                {
                    aux = false;
                    err = "La direccion no es valida";
                }
            }
            return aux;
        }

        public bool esTipoValido(out string err)
        {
            bool aux = true;
            err = "";
            if (cboTipoDocumento.SelectedIndex == -1)
            {
                aux = false;
                err = "Seleccione un tipo de documento.";
            }
            
            return aux;
        }
        public bool esProvinciaValida(out string err)
        {
            bool aux = true;
            err = "";
            if (cboProvincia.SelectedIndex == -1)
            {
                aux = false;
                err = "Seleccione una provincia.";
            }
            
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
        public bool esBarrioValido(out string err)
        {
            bool aux = true;
            err = "";
            if (cboBarrio.SelectedIndex == -1)
            {
                aux = false;
                err = "Seleccione un barrio.";
                
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
            bool aux = Regex.Match(s, @"[^\w\s]+").Success || Regex.IsMatch(s,@"\d");
            return aux;
        }
        public bool contieneLetras(string s)
        {
            return Regex.Match(s, @"\D").Success;
        }

        private void txtNombre_Validating(object sender, CancelEventArgs e)
        {
            string err;
            if(!esNombreValido(txtNombre.Text,out err))
            {
                e.Cancel = true;
                //txtNombre.Select(0, txtNombre.Text.Length);
                this.errNombre.SetError(txtNombre, err);
            }
        }

        private void txtNombre_Validated(object sender, EventArgs e)
        {
            this.errNombre.SetError(txtNombre, "");
        }

        private void txtApellido_Validating(object sender, CancelEventArgs e)
        {
            string err;
            if(!esApellidoValido(txtApellido.Text,out err))
            {
                e.Cancel = true;
                //txtApellido.Select(0, txtApellido.Text.Length);
                this.errApellido.SetError(txtApellido, err);
            }
        }

        private void txtApellido_Validated(object sender, EventArgs e)
        {
            
            this.errNombre.SetError(txtApellido, "");
            //MessageBox.Show("Validado");


        }

        private void txtDocumento_Validating(object sender, CancelEventArgs e)
        {
            string err;
            if (!esDocumentoValido(txtDocumento.Text, out err))
            {
                e.Cancel = true;
                //txtDocumento.Select(0, txtDocumento.Text.Length);
                this.errDocumento.SetError(txtDocumento, err);
            }
        }

        private void txtDocumento_Validated(object sender, EventArgs e)
        {
            this.errDocumento.SetError(txtDocumento, "");
        }

        private void cboTipoDocumento_Validating(object sender, CancelEventArgs e)
        {
            string err;
            if (!esTipoValido(out err))
            {
                e.Cancel = true;
                //cboTipoDocumento.Select();
                this.errTipo.SetError(cboTipoDocumento, err);
            }
        }
        private void cboTipoDocumento_Validated(object sender, EventArgs e)
        {
            this.errTipo.SetError(cboTipoDocumento, "");
        }

        private void dtpFechaNacimiento_Validating(object sender, CancelEventArgs e)
        {
            string err;
            if(!esFechaValida(dtpFechaNacimiento.Value,out err))
            {
                e.Cancel=true;
                dtpFechaNacimiento.Select();
                this.errTipo.SetError(dtpFechaNacimiento, err);
            }
        }

        private void dtpFechaNacimiento_Validated(object sender, EventArgs e)
        {
            this.errFecha.SetError(dtpFechaNacimiento, "");
            //MessageBox.Show("Validado");
        }

        private void txtDireccion_Validating(object sender, CancelEventArgs e)
        {
            string err;
            if(!esDireccionValida(txtDireccion.Text, out err))
            {
                e.Cancel=true;
                //txtDireccion.Select(0,txtDireccion.Text.Length);
                this.errDireccion.SetError(txtDireccion, err);
            }
        }

        private void cboProvincia_Validating(object sender, CancelEventArgs e)
        {
            string err;
            if(!esProvinciaValida(out err))
            {
                e.Cancel=true;
                //cboProvincia.Select();
                this.errProvincia.SetError(cboProvincia, err);
            }
        }

        private void cboProvincia_Validated(object sender, EventArgs e)
        {
            this.errProvincia.SetError(cboProvincia, "");
        }

        private void txtDireccion_Validated(object sender, EventArgs e)
        {
            this.errDireccion.SetError(txtDireccion, "");
        }

        private void cboCiudad_Validating(object sender, CancelEventArgs e)
        {
            string err;
            if(!esCiudadValida(out err))
            {
                e.Cancel=true;
                //cboCiudad.Select();
                this.errCiudad.SetError(cboCiudad, err);
            }
        }

        private void cboCiudad_Validated(object sender, EventArgs e)
        {
            this.errCiudad.SetError(cboCiudad, "");
        }

        private void cboBarrio_Validating(object sender, CancelEventArgs e)
        {
            string err;
            if(!esBarrioValido(out err))
            {
                e.Cancel=true;
                //cboBarrio.Select();
                this.errBarrio.SetError(cboBarrio, err);
            }
        }

        private void cboBarrio_Validated(object sender, EventArgs e)
        {
            this.errBarrio.SetError(cboBarrio, "");
        }
    }
}

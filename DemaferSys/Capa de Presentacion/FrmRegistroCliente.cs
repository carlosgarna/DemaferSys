using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using DevComponents.DotNetBar;
using CapaLogicaNegocio;

namespace Capa_de_Presentacion
{
    public partial class FrmRegistroCliente : DevComponents.DotNetBar.Metro.MetroForm
    {
        private clsCliente C = new clsCliente();

        public FrmRegistroCliente()
        {
            InitializeComponent();
            iniciarCamposBloqueados();
        }

        private void button1_Click(object sender, EventArgs e)
        {
                        if (txtDireccion.Text.Trim() != "")
                        {
                            if (txtTelefono.Text.Trim() != "")
                            {

                                if (Program.Evento == 0)
                                {
                                    C.Ruc = txtRuc.Text;
                                    C.Empresa = txtEmpresa.Text;
                                    C.Dni = txtDni.Text;
                                    C.Apellidos = txtApellidos.Text;
                                    C.Nombres = txtNombres.Text;
                                    C.Direccion = txtDireccion.Text;
                                    C.Telefono = txtTelefono.Text;
                                    DevComponents.DotNetBar.MessageBoxEx.Show(C.RegistrarCliente(), "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                    Limpiar();
                                }
                                else
                                {
                                    C.Ruc = txtRuc.Text;
                                    C.Empresa = txtEmpresa.Text;
                                    C.Dni = txtDni.Text;
                                    C.Apellidos = txtApellidos.Text;
                                    C.Nombres = txtNombres.Text;
                                    C.Direccion = txtDireccion.Text;
                                    C.Telefono = txtTelefono.Text;
                                    DevComponents.DotNetBar.MessageBoxEx.Show(C.ActualizarCliente(), "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                    Limpiar();
                                }
                            }
                            else
                            {
                                DevComponents.DotNetBar.MessageBoxEx.Show("Por Favor Ingrese N° de Teléfono o Celular.", "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                                txtTelefono.Focus();
                            }
                        }
                        else
                        {
                            DevComponents.DotNetBar.MessageBoxEx.Show("Por Favor Ingrese Dirección del Cliente.", "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                            txtDireccion.Focus();
                        }
       }

        private void Limpiar() {
            txtDni.Clear();
            txtRuc.Clear();
            txtEmpresa.Clear();
            txtApellidos.Clear();
            txtNombres.Clear();
            txtDireccion.Clear();
            txtTelefono.Clear();
            txtDni.Focus();
        }

        private void FrmRegistroCliente_Load(object sender, EventArgs e)
        {
            txtDni.Focus();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (DevComponents.DotNetBar.MessageBoxEx.Show("¿Está Seguro que Desea Salir.?", "Sistema de Ventas.", MessageBoxButtons.YesNo,MessageBoxIcon.Error) == DialogResult.Yes)
            {
                this.Close();
            }
        }

        private void FrmRegistroCliente_Activated(object sender, EventArgs e)
        {
            txtDni.Focus();
        }

        private void rbnClienteNat_CheckedChanged(object sender, EventArgs e)
        {
            if (rbnClienteNat.Checked == true)
            {
                txtDni.ReadOnly = false;
                txtApellidos.ReadOnly = false;
                txtNombres.ReadOnly = false;
                txtDireccion.ReadOnly = false;
                txtTelefono.ReadOnly = false;
                txtRuc.ReadOnly = true;
                txtEmpresa.ReadOnly = true;

                txtDni.Text = "";
                txtApellidos.Text = "";
                txtNombres.Text = "";
                txtDireccion.Text = "";
                txtTelefono.Text = "";
                txtRuc.Text = "";
                txtEmpresa.Text = "";
            }
        }

        private void rbnClienteEmp_CheckedChanged(object sender, EventArgs e)
        {
            if (rbnClienteEmp.Checked == true)
            {
                txtRuc.ReadOnly = false;
                txtEmpresa.ReadOnly = false;
                txtDireccion.ReadOnly = false;
                txtTelefono.ReadOnly = false;
                txtDni.ReadOnly = true;
                txtApellidos.ReadOnly = true;
                txtNombres.ReadOnly = true;    

                txtDni.Text = "";
                txtApellidos.Text = "";
                txtNombres.Text = "";
                txtDireccion.Text = "";
                txtTelefono.Text = "";
                txtRuc.Text = "";
                txtEmpresa.Text = "";
            }
        }

        private void txtDni_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(char.IsNumber(e.KeyChar)) && (e.KeyChar != (char)Keys.Back))
            {
                e.Handled = true;
            }
        }

        private void txtRuc_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(char.IsNumber(e.KeyChar)) && (e.KeyChar != (char)Keys.Back))
            {
                e.Handled = true;
            }
        }

        private void iniciarCamposBloqueados()
        {
            txtDni.ReadOnly = true;
            txtRuc.ReadOnly = true;
            txtEmpresa.ReadOnly = true;
            txtApellidos.ReadOnly = true;
            txtNombres.ReadOnly = true;
            txtDireccion.ReadOnly = true;
            txtTelefono.ReadOnly = true;
        }
    }
}

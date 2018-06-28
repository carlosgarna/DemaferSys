using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using DevComponents.DotNetBar;
using CapaLogicaNegocio;


namespace Capa_de_Presentacion
{
    public partial class FrmDescuento : DevComponents.DotNetBar.Metro.MetroForm
    {
        private clsDescuento D = new clsDescuento();

        public FrmDescuento()
        {
            InitializeComponent();
        }

        private void btnRegistrar_Click(object sender, EventArgs e)
        {
            if (dateTimePicker1.Value <= dateTimePicker2.Value)
            {
                D.FechaInicio = Convert.ToDateTime(dateTimePicker1.Value);
                D.FechaFin = Convert.ToDateTime(dateTimePicker2.Value);
                D.Descuento = Convert.ToDecimal(txtDescuento.Text);
                DevComponents.DotNetBar.MessageBoxEx.Show(D.RegistrarDescuento(), "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1);
                Limpiar();
            }
            else
            {
                DevComponents.DotNetBar.MessageBoxEx.Show("La Fecha de inicio debe ser Menor a la fecha fin.", "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
            
        }

        private void Limpiar()
        {
            dateTimePicker1.Value = DateTime.Now;
            dateTimePicker2.Value = DateTime.Now;
            txtDescuento.Text = "";
        }

        private void ListarElementos()
        {
            dataGridView1.ClearSelection();
            DataTable dt = new DataTable();
            dt = D.Listado();
            try
            {
                dataGridView1.Rows.Clear();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dataGridView1.Rows.Add(dt.Rows[i][0]);
                    dataGridView1.Rows[i].Cells[0].Value = dt.Rows[i][0].ToString();
                    dataGridView1.Rows[i].Cells[1].Value = dt.Rows[i][1].ToString();
                    dataGridView1.Rows[i].Cells[2].Value = dt.Rows[i][2].ToString();
                    dataGridView1.Rows[i].Cells[3].Value = dt.Rows[i][3].ToString();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        private void FrmDescuento_Load(object sender, EventArgs e)
        {
            ListarElementos();
        }
    }
}

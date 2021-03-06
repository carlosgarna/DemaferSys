﻿using System;
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
    public partial class FrmRegistroVentas : DevComponents.DotNetBar.Metro.MetroForm
    {
        clsVentas Ventas = new clsVentas();
        clsDetalleVenta Detalle = new clsDetalleVenta();
        clsDescuento descuento = new clsDescuento();

        private List<clsVenta> lst = new List<clsVenta>();

        public FrmRegistroVentas()
        {
            InitializeComponent();
        }

        private void rbnFactura_CheckedChanged(object sender, EventArgs e)
        {
            if (rbnFactura.Checked == true)
            {
                lblTipo.Text = "FACTURA";
                lblDniRuc.Text = "R.U.C.:";
                lblNaturalEmpresa.Text = "EMPRESA:";
            }
            else
            {
                lblTipo.Text = "BOLETA DE VENTA";
                lblDniRuc.Text = "D.N.I.:";
                lblNaturalEmpresa.Text = "Sr (a):";
            }
        }

        private void rbnBoleta_CheckedChanged(object sender, EventArgs e)
        {
            GenerarNumeroComprobante();
        }

        private void FrmVentas_Load(object sender, EventArgs e)
        {
            GenerarNumeroComprobante();
            GenerarIdVenta();
            GenerarSeriedeDocumento();
            dataGridView1.ColumnHeadersDefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter;
            ObtenerDescuento();
        }

        private void GenerarIdVenta() {
            txtIdVenta.Text = Ventas.GenerarIdVenta();
        }

        private void GenerarSeriedeDocumento() {
            lblSerie.Text = Ventas.GenerarSerieDocumento();
        }

        private void GenerarNumeroComprobante()
        {
            if (rbnBoleta.Checked == true)
                lblNroCorrelativo.Text = Ventas.NumeroComprobante("Boleta");
            else
                lblNroCorrelativo.Text = Ventas.NumeroComprobante("Factura");
        }

        private void btnBusqueda_Click(object sender, EventArgs e)
        {
            FrmListadoClientes C = new FrmListadoClientes();
            C.Show();
        }

        private void FrmVentas_Activated(object sender, EventArgs e)
        {
            //txtIdProducto.Text = Program.IdCliente+"";
            if (rbnFactura.Checked == true)
            {
                txtDocIdentidad.Text = Program.Ruc;
                txtDatos.Text = Program.Empresa;
            }
            else
            {
                txtDocIdentidad.Text = Program.DocumentoIdentidad;
                txtDatos.Text = Program.ApellidosCliente + ", " + Program.NombreCliente;
            }
            txtIdProducto.Text = Program.IdProducto+"";
            txtDescripcion.Text = Program.Descripcion;
            txtMarca.Text = Program.Marca;
            txtStock.Text = Program.Stock+"";
            txtPVenta.Text = Program.PrecioVenta+"";
        }

        private void btnBusquedaProducto_Click(object sender, EventArgs e)
        {
            FrmListadoProductos P = new FrmListadoProductos();
            P.Show();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            clsVenta V = new clsVenta();
            Decimal Porcentaje = 0; Decimal SubTotal; int productoDuplicado = 0;
            if(this.txtDocIdentidad.Text.Trim()!=""){
                if (txtDescripcion.Text.Trim() != ""){
                    if (txtCantidad.Text.Trim() != ""){
                        if (Convert.ToInt32(txtCantidad.Text) >= 0){
                            if (Convert.ToInt32(txtCantidad.Text) <= Convert.ToInt32(txtStock.Text)){
                                    if (lst.Count != 0)
                                    {
                                        for (int i = 0; i < lst.Count; i++)
                                        {
                                            if (Convert.ToInt32(txtIdProducto.Text) == lst[i].IdProducto)
                                            {
                                                lst[i].Cantidad = lst[i].Cantidad + Convert.ToInt32(txtCantidad.Text);
                                                lst[i].SubTotal = (Convert.ToDecimal(txtPVenta.Text) * lst[i].Cantidad);
//                                                lst[i].Igv = Math.Round(Convert.ToDecimal(lst[i].SubTotal) * (Convert.ToDecimal(txtIgv.Text) / (100)), 2);
                                                LlenarGrilla();
                                                Limpiar();
                                                productoDuplicado = 1;
                                                break;
                                            }
                                        }

                                        if (productoDuplicado == 0)
                                        {
                                            V.IdProducto = Convert.ToInt32(txtIdProducto.Text);
                                            V.IdVenta = Convert.ToInt32(txtIdVenta.Text);
                                            V.Descripcion = txtDescripcion.Text + " - " + txtMarca.Text;
                                            V.Cantidad = Convert.ToInt32(txtCantidad.Text);
                                            V.PrecioVenta = Convert.ToDecimal(txtPVenta.Text);
//                                            Porcentaje = (Convert.ToDecimal(txtIgv.Text) / 100) + 1;
                                            SubTotal = (Convert.ToDecimal(txtPVenta.Text) * Convert.ToInt32(txtCantidad.Text));
//                                            V.Igv = Math.Round(Convert.ToDecimal(SubTotal) * (Convert.ToDecimal(txtIgv.Text) / (100)), 2);
                                            V.SubTotal = Math.Round(SubTotal, 2);
                                            lst.Add(V);
                                            LlenarGrilla();
                                            Limpiar();
                                        }
                                        
                                    }
                                    else
                                    {
                                        V.IdProducto = Convert.ToInt32(txtIdProducto.Text);
                                        V.IdVenta = Convert.ToInt32(txtIdVenta.Text);
                                        V.Descripcion = txtDescripcion.Text + " - " + txtMarca.Text;
                                        V.Cantidad = Convert.ToInt32(txtCantidad.Text);
                                        V.PrecioVenta = Convert.ToDecimal(txtPVenta.Text);
//                                        Porcentaje = (Convert.ToDecimal(txtIgv.Text) / 100) + 1;
                                        SubTotal = (Convert.ToDecimal(txtPVenta.Text) * Convert.ToInt32(txtCantidad.Text));
//                                        V.Igv = Math.Round(Convert.ToDecimal(SubTotal) * (Convert.ToDecimal(txtIgv.Text) / (100)), 2);
                                        V.SubTotal = Math.Round(SubTotal, 2);
                                        lst.Add(V);
                                        LlenarGrilla();
                                        Limpiar();
                                    }  
                            }else{
                                DevComponents.DotNetBar.MessageBoxEx.Show("Stock Insuficiente para Realizar la Venta.", "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Exclamation, MessageBoxDefaultButton.Button1);
                            }
                        }else{
                            DevComponents.DotNetBar.MessageBoxEx.Show("Cantidad Ingresada no Válida.", "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Error, MessageBoxDefaultButton.Button1);
                            txtCantidad.Clear();
                            txtCantidad.Focus();
                        }
                    }
                    else {
                        DevComponents.DotNetBar.MessageBoxEx.Show("Por Favor Ingrese Cantidad a Vender.", "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Error, MessageBoxDefaultButton.Button1);
                        txtCantidad.Focus();
                    }
                }
                else {
                    DevComponents.DotNetBar.MessageBoxEx.Show("Por Favor Busque el Producto a Vender.", "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Error, MessageBoxDefaultButton.Button1);
                }
            }else{
                DevComponents.DotNetBar.MessageBoxEx.Show("Por Favor Busque el Cliente a Vender.", "Sistema de Ventas", MessageBoxButtons.OK, MessageBoxIcon.Error, MessageBoxDefaultButton.Button1);
            }
        }

        private void LlenarGrilla() {
            Decimal SumaSubTotal = 0; Decimal SumaIgv = 0; Decimal SumaTotal = 0; Decimal Descuento = 0; Decimal a = 0;
            dataGridView1.Rows.Clear();
            for (int i = 0; i < lst.Count; i++)
            {
                dataGridView1.Rows.Add();
                dataGridView1.Rows[i].Cells[0].Value = lst[i].IdVenta;
                dataGridView1.Rows[i].Cells[1].Value = lst[i].Cantidad;
                dataGridView1.Rows[i].Cells[2].Value = lst[i].Descripcion;
                dataGridView1.Rows[i].Cells[3].Value = lst[i].PrecioVenta;
                dataGridView1.Rows[i].Cells[4].Value = lst[i].SubTotal;
                dataGridView1.Rows[i].Cells[5].Value = lst[i].IdProducto;
//                dataGridView1.Rows[i].Cells[6].Value = lst[i].Igv;
                SumaSubTotal += Convert.ToDecimal(dataGridView1.Rows[i].Cells[4].Value);
//                SumaIgv += Convert.ToDecimal(dataGridView1.Rows[i].Cells[6].Value);
            }

            SumaIgv = SumaSubTotal * Convert.ToDecimal(0.18);
            dataGridView1.Rows.Add();
            dataGridView1.Rows.Add();
            dataGridView1.Rows[lst.Count + 1].Cells[3].Value = "SUB-TOTAL  S/.";
            dataGridView1.Rows[lst.Count + 1].Cells[4].Value = SumaSubTotal;
            dataGridView1.Rows.Add();
            dataGridView1.Rows[lst.Count + 2].Cells[3].Value = "      I.G.V.        %";
            dataGridView1.Rows[lst.Count + 2].Cells[4].Value = SumaIgv;
            dataGridView1.Rows.Add();

            dataGridView1.Rows[lst.Count + 3].Cells[3].Value = "DESCUENTO %";
            dataGridView1.Rows[lst.Count + 3].Cells[4].Value = txtDescuento.Text;
            dataGridView1.Rows.Add();

            dataGridView1.Rows[lst.Count + 4].Cells[3].Value = "     TOTAL     S/.";
            SumaTotal += SumaSubTotal + SumaIgv;
            Descuento = SumaTotal * (Convert.ToDecimal(txtDescuento.Text) / 100);
            dataGridView1.Rows[lst.Count + 4].Cells[4].Value = SumaTotal - Descuento;
            dataGridView1.ClearSelection();
        }

        private void Limpiar() {
            txtDescripcion.Clear();
            txtMarca.Clear();
            txtStock.Clear();
            txtPVenta.Clear();
            txtCantidad.Clear();
            txtCantidad.Focus();
            Program.Descripcion = "";
            Program.Stock = 0;
            Program.Marca = "";
            Program.PrecioVenta = 0;
        }

        private void btnSalir_Click(object sender, EventArgs e)
        {
            if (DevComponents.DotNetBar.MessageBoxEx.Show("¿Está Seguro que Desea Salir.?", "Sistema de Ventas", MessageBoxButtons.YesNo, MessageBoxIcon.Error) == DialogResult.Yes) {
                this.Close();
            }
        }

        private void btnEliminarItem_Click(object sender, EventArgs e)
        {
            if (dataGridView1.Rows.Count > 0){
                if (dataGridView1.Rows[dataGridView1.CurrentRow.Index].Selected == true){
                    if (Convert.ToString(dataGridView1.CurrentRow.Cells[2].Value) != ""){
                    dataGridView1.Rows.RemoveAt(dataGridView1.CurrentRow.Index);
                    lst.RemoveAt(dataGridView1.CurrentRow.Index);
                        LlenarGrilla();
                        DevComponents.DotNetBar.MessageBoxEx.Show("Producto Eliminado de la Lista Ok.","Sistema de Ventas.",MessageBoxButtons.OK,MessageBoxIcon.Information);
                }else{
                      DevComponents.DotNetBar.MessageBoxEx.Show("No Existe Ningun Elemento en la Lista.", "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Error);
                      dataGridView1.ClearSelection();
                    }
                }else{
                 DevComponents.DotNetBar.MessageBoxEx.Show("Por Favor Seleccione Item a Eliminar de la Lista.", "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
            }
            else {
                DevComponents.DotNetBar.MessageBoxEx.Show("No Existe Ningun Elemento en la Lista","Sistema de Ventas.",MessageBoxButtons.OK,MessageBoxIcon.Error);
            }
        }

        private void dataGridView1_Click(object sender, EventArgs e)
        {
            if (dataGridView1.Rows.Count > 0) {
                dataGridView1.Rows[dataGridView1.CurrentRow.Index].Selected = true;
            }
        }

        private void btnRegistrarVenta_Click(object sender, EventArgs e)
        {
            if (dataGridView1.Rows.Count > 0){
                if (Convert.ToString(dataGridView1.CurrentRow.Cells[2].Value) != ""){
                    GuardarVenta();
                    try{
                        for (int i = 0; i < dataGridView1.Rows.Count; i++){
                            Decimal SumaIgv = 0; Decimal SumaSubTotal = 0;
                            if (Convert.ToString(dataGridView1.Rows[i].Cells[2].Value) != ""){
//                                SumaIgv += Convert.ToDecimal(dataGridView1.Rows[i].Cells[6].Value);
                                SumaSubTotal += Convert.ToDecimal(dataGridView1.Rows[i].Cells[4].Value);
                                Detalle.IdProducto = Convert.ToInt32(dataGridView1.Rows[i].Cells[5].Value);
                                Detalle.IdVenta = Convert.ToInt32(dataGridView1.Rows[i].Cells[0].Value);
                                Detalle.Cantidad = Convert.ToInt32(dataGridView1.Rows[i].Cells[1].Value);
                                Detalle.PUnitario = Convert.ToDecimal(dataGridView1.Rows[i].Cells[3].Value);
//                                Detalle.Igv = SumaIgv;
                                Detalle.SubTotal = SumaSubTotal;
                                GuardarDetalleVenta(Detalle);
                            }
                        }
                        Limpiar1();
                    }catch (Exception ex)                    {
                        DevComponents.DotNetBar.MessageBoxEx.Show(ex.Message);
                    }
                }else{
                    DevComponents.DotNetBar.MessageBoxEx.Show("No Existe Ningún Elemento en la Lista.", "Sistema de Ventas.", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }else{
                DevComponents.DotNetBar.MessageBoxEx.Show("No Existe Ningún Elemento en la Lista.","Sistema de Ventas.",MessageBoxButtons.OK,MessageBoxIcon.Error);
            }
        }

        private void GuardarVenta()
        {
            decimal Total = 0; decimal descuento = 0; decimal desctotal = 0;
            if (Convert.ToString(dataGridView1.CurrentRow.Cells[2].Value) != "") {
                for (int i = 0; i < dataGridView1.Rows.Count; i++){
			        Total=Convert.ToDecimal(dataGridView1.Rows[i].Cells[4].Value);
			    }
            string TipoDocumento = "";
            TipoDocumento = rbnBoleta.Checked == true ? "Boleta" : "Factura";
            Ventas.IdEmpleado=Program.IdEmpleadoLogueado;
            Ventas.IdCliente=Program.IdCliente;
            Ventas.Serie=lblSerie.Text;
            Ventas.NroComprobante=lblNroCorrelativo.Text;
            Ventas.TipoDocumento=TipoDocumento;
            Ventas.FechaVenta=Convert.ToDateTime(dateTimePicker1.Value);
            Ventas.Igv = Convert.ToDecimal(0.18);
            Ventas.DescuentoVenta = Convert.ToDecimal(txtDescuento.Text) / 100;
            Ventas.Total=Total;
            DevComponents.DotNetBar.MessageBoxEx.Show(Ventas.RegistrarVenta(),"Sistema de Ventas.",MessageBoxButtons.OK,MessageBoxIcon.Information);
            }
        }

        private void GuardarDetalleVenta(clsDetalleVenta detalle){
                    
                    Detalle.RegistrarDetalleVenta();
//                    Limpiar1();
                    GenerarIdVenta();
                    GenerarNumeroComprobante();
        }

        private void Limpiar1() {
            txtDocIdentidad.Clear();
            txtDatos.Clear();
            dataGridView1.Rows.Clear();
            Program.IdEmpleadoLogueado = 0;
            Program.IdCliente = 0;
            txtIdProducto.Clear();
            rbnBoleta.Checked = true;
            Program.Ruc = "";
            Program.Empresa = "";
            Program.DocumentoIdentidad = "";
            Program.ApellidosCliente = "";
            Program.NombreCliente = "";
        }

        private void txtCantidad_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(char.IsNumber(e.KeyChar)) && (e.KeyChar != (char)Keys.Back))
            {
                e.Handled = true;
            }
        }

        private void ObtenerDescuento()
        {
            
            try
            {
                DataTable dt = new DataTable();
                dt = descuento.ObtenerDescuentoDia();
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        txtDescuento.Text = dt.Rows[i][3].ToString();
                    }
                }
                else
                {
                    txtDescuento.Text = "0";
                }
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //private void btnQuitar_Click(object sender, EventArgs e)
        //{
        //    DialogResult Resultado = new DialogResult();
        //    Resultado = DevComponents.DotNetBar.MessageBoxEx.Show("¿Está Seguro Que Desea Quitar Este Producto.?", "Sistema de Ventas.", MessageBoxButtons.YesNo, MessageBoxIcon.Exclamation);
        //       if(Resultado==DialogResult.OK){
        //            try{	        
        //                foreach (DataGridViewRow row in dataGridView1.Rows)
        //                {
        //                    Boolean Activo=Convert.ToBoolean(row.Cells["Eliminar"].Value);
        //                    if(Activo){
        //                        for (int i = 0; i < dataGridView1.RowCount; i++)
        //                        {
        //                            dataGridView1.Rows.RemoveAt(i);
        //                        }
        //                    }
        //                }
        //            }catch (Exception ex){
        //                 DevComponents.DotNetBar.MessageBoxEx.Show(ex.Message);
        //            }
        //       }
        //}

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using CapaEnlaceDatos;

namespace CapaLogicaNegocio
{
    public class clsDescuento
    {
        private clsManejador M = new clsManejador();

        private int m_IdDescuento;
        private DateTime m_FechaInicio;
        private DateTime m_FechaFin;
        private Decimal m_Descuento;

        public int IdDescuento
        {
            get { return m_IdDescuento; }
            set { m_IdDescuento = value; }
        }

        public DateTime FechaInicio
        {
            get { return m_FechaInicio; }
            set { m_FechaInicio = value; }
        }

        public DateTime FechaFin
        {
            get { return m_FechaFin; }
            set { m_FechaFin = value; }
        }

        public Decimal Descuento
        {
            get { return m_Descuento; }
            set { m_Descuento = value; }
        }


        public DataTable Listado()
        {
            return M.Listado("ListarDescuentos", null);
        }

        public DataTable ObtenerDescuentoDia()
        {
            return M.Listado("ObtenerDescuentoDia", null);
        }

        public String RegistrarDescuento()
        {
            List<clsParametro> lst = new List<clsParametro>();
            String Mensaje = "";
            try
            {
                lst.Add(new clsParametro("@FechaInicio", m_FechaInicio));
                lst.Add(new clsParametro("@FechaFin", m_FechaFin));
                lst.Add(new clsParametro("@PorcentajeDescuento", m_Descuento));
                lst.Add(new clsParametro("@Mensaje", "", SqlDbType.VarChar, ParameterDirection.Output, 50));
                M.EjecutarSP("RegistrarDescuento", ref lst);
                Mensaje = lst[3].Valor.ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return Mensaje;
        }
    }
}

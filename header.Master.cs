using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace medallia
{
    public partial class header : System.Web.UI.MasterPage
    {
        String cadena = "Data Source=10.249.15.194\\DATAFLOW; Initial Catalog=TELEGESTION; User ID=telegestion; Password=telefonica"; //CONEXION CON USUARIO Y CONTRASEÑA
        //string cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; Integrated Security=SSPI"; //CONEXION CON CREDENCIALES DE RED


        protected void Page_Load(object sender, EventArgs e)
        {
            string usuario = Convert.ToString(Session["id_usuario"]);
            string centro = Convert.ToString(Session["centro_sesion"]);

            string javaScript = "carga_cant_casos('" + usuario + "','" + centro + "');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", javaScript, true);


            if ((string)Session["centro_sesion"] != "TASA")
            {
                // OCULTA MENU MEDALLIA A CONTRATISTAS
                string jscript1 = "<script>document.getElementById('li_carga_medallia').style.display = 'none'</script>";
                System.Type a = this.GetType();
                Page.ClientScript.RegisterStartupScript(a, "a", jscript1);

                string jscript2 = "<script>document.getElementById('li_bandeja_clooper').style.display = 'none'</script>";
                System.Type b = this.GetType();
                Page.ClientScript.RegisterStartupScript(b, "b", jscript2);

                string jscript3 = "<script>document.getElementById('li_soporte_sistemas').style.display = 'none'</script>";
                System.Type c = this.GetType();
                Page.ClientScript.RegisterStartupScript(c, "c", jscript3);

                // OCULTA MENU MONITOREOS A CONTRATISTAS
                string jscript4 = "<script>document.getElementById('li_carga_monitoreo').style.display = 'none'</script>";
                System.Type d = this.GetType();
                Page.ClientScript.RegisterStartupScript(d, "d", jscript4);

                string jscript5 = "<script>document.getElementById('li_genera_pendiente').style.display = 'none'</script>";
                System.Type f = this.GetType();
                Page.ClientScript.RegisterStartupScript(f, "f", jscript5);

                string jscript6 = "<script>document.getElementById('li_pend_monitoreo').style.display = 'none'</script>";
                System.Type g = this.GetType();
                Page.ClientScript.RegisterStartupScript(g, "g", jscript6);

                string jscript7 = "<script>document.getElementById('li_pend_gestor').style.display = 'none'</script>";
                System.Type h = this.GetType();
                Page.ClientScript.RegisterStartupScript(h, "h", jscript7);

                string jscript8 = "<script>document.getElementById('li_bandeja_descargo_gestor').style.display = 'none'</script>";
                System.Type i = this.GetType();
                Page.ClientScript.RegisterStartupScript(h, "i", jscript8);

                // OCULTA BOTON CARGA MANUAL DE METRICAS A CONTRATISTA
                string jscript9 = "<script>document.getElementById('li_carga_manual').style.display = 'none'</script>";
                System.Type j = this.GetType();
                Page.ClientScript.RegisterStartupScript(j, "j", jscript9);

                // OCULTA BOTON BUSCADOR A CONTRATISTAS
                string jscript10 = "<script>document.getElementById('li_buscador_tecnico_detalle').style.display = 'none'</script>";
                System.Type k = this.GetType();
                Page.ClientScript.RegisterStartupScript(k, "k", jscript10);
            }
        }

        protected void btn_salir_Click(object sender, EventArgs e)
        {
            Session.Remove("validacion");
            Session.Remove("usuario");
            Session.Remove("id_usuario");
            Session.Remove("centro_sesion");
            Response.Redirect("login.aspx");
        }

        protected void btn_descargar_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(cadena);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "medallia_exporta_casos";
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;

            con.Open();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            adapter.Fill(ds);

            con.Close();

            //EMPIEZA LA EXPORTACION

            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DataGrid dgrid = new DataGrid();
            //this.form1.Controls.Add(dgrid);
            dgrid.DataSource = ds;
            dgrid.DataBind();

            dgrid.RenderControl(hw);

            //Response.Write(@"<style> .sborder [color: Red; border: 6px Solid Black;] </style>");
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            //ESTAS 2 LINEAS SIGUIENTES ME ARREGLAN LOS PROBLEMAS DE ACENTOS
            Response.ContentEncoding = System.Text.Encoding.Unicode;
            Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
            //FIN
            Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=gestiones_medallia.xls");

            this.EnableViewState = false;
            Response.Write(tw.ToString());
            Response.End();
        }

        protected void btn_monitoreos_trabajados_Click(object sender, EventArgs e)
        {
            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = "lista_gestionados";
            cmdcadena.Connection = conexion;

            SqlDataAdapter adapter = new SqlDataAdapter(cmdcadena);
            DataSet ds = new DataSet();

            adapter.Fill(ds);

            //EMPIEZA LA EXPORTACION

            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DataGrid dgrid = new DataGrid();
            //this.form1.Controls.Add(dgrid);
            dgrid.DataSource = ds;
            dgrid.DataBind();

            dgrid.RenderControl(hw);

            //Response.Write(@"<style> .sborder [color: Red; border: 6px Solid Black;] </style>");
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            //ESTAS 2 LINEAS SIGUIENTES ME ARREGLAN LOS PROBLEMAS DE ACENTOS
            Response.ContentEncoding = System.Text.Encoding.Unicode;
            Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
            Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=monitoreos_crudo.xls");

            this.EnableViewState = false;
            Response.Write(tw.ToString());
            Response.End();
        }

        protected void btn_descargar_devoluciones_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(cadena);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "garantia_descarga_descargo";
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;

            con.Open();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            adapter.Fill(ds);

            con.Close();

            //EMPIEZA LA EXPORTACION

            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DataGrid dgrid = new DataGrid();
            //this.form1.Controls.Add(dgrid);
            dgrid.DataSource = ds;
            dgrid.DataBind();

            dgrid.RenderControl(hw);

            //Response.Write(@"<style> .sborder [color: Red; border: 6px Solid Black;] </style>");
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            //ESTAS 2 LINEAS SIGUIENTES ME ARREGLAN LOS PROBLEMAS DE ACENTOS
            Response.ContentEncoding = System.Text.Encoding.Unicode;
            Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
            //FIN
            Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=descargo_garantias.xls");

            this.EnableViewState = false;
            Response.Write(tw.ToString());
            Response.End();
        }
    }
}
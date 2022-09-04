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
    public partial class medallia_graphs2 : System.Web.UI.Page
    {
        String cadena = "Data Source=10.249.15.194\\DATAFLOW; Initial Catalog=TELEGESTION; User ID=telegestion; Password=telefonica"; //CONEXION CON USUARIO Y CONTRASEÑA
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["validacion"] != "validado")
            {
                Response.Redirect("error_404.aspx");
            }
            else
            {
                string centro = Convert.ToString(Session["centro_sesion"]);

                string javaScript = "dibuja_lista_fecha('" + centro + "','','');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", javaScript, true);

                ClientScript.RegisterStartupScript(this.GetType(), "myScript", "<script>javascript:lista_cbo_contratas('" + centro + "');</script>");//ENVIO EL PARAMETRO A LA FUNCION JAVASCRIPT DE ESTA PAGINA
            }
        }

        protected void btn_descargar_Click(object sender, EventArgs e)
        {
            string centro = Convert.ToString(Session["centro_sesion"]);
            String query = "";
            
            SqlConnection con = new SqlConnection(cadena);
            if (centro == "TASA")
            {
                query = @"select Reagenda,
		                     Motivo,
		                     Contexto,
		                     usuario as Clooper,
		                     Id_cliente,
		                     Id_encuesta,
		                     fecha_encuesta as [Fecha encuesta],
		                     fecha_mail as [Fecha carga],
		                     fecha_fin as [Fecha cierre],
		                     nombre_tecnico as [Técnico],
		                     Dni,
		                     nombre_cliente as [Nombre cliente],
		                     Direccion,
		                     Localidad,
		                     Contacto,
		                     nro_orden as [N° Orden],
		                     access_id as [Access ID],
		                     Bucket,
		                     descripcion_contrata as Empresa,
		                     Nps,
		                     Tecnico,
		                     Puntualidad,
		                     Profesionalidad,
		                     Conocimiento,
		                     Calidad,
		                     [Motivo detractor],
		                     Concepto,
		                     Subconcepto,
		                     Detalle,
		                     [Acción ejecutada],
		                     Estado,
		                     comentarios_cliente as [Comentarios del cliente]
		
                     from lista_medallia_casos
                     where [Acción ejecutada] = 'Derivado a la contratista' and
		                     (Estado = 'Escalado / Refuerzo' or
		                     Estado = 'Escalado')";
            }
            else
            {
                query = @"select Reagenda,
		                     Motivo,
		                     Contexto,
		                     usuario as Clooper,
		                     Id_cliente,
		                     Id_encuesta,
		                     fecha_encuesta as [Fecha encuesta],
		                     fecha_mail as [Fecha carga],
		                     fecha_fin as [Fecha cierre],
		                     nombre_tecnico as [Técnico],
		                     Dni,
		                     nombre_cliente as [Nombre cliente],
		                     Direccion,
		                     Localidad,
		                     Contacto,
		                     nro_orden as [N° Orden],
		                     access_id as [Access ID],
		                     Bucket,
		                     descripcion_contrata as Empresa,
		                     Nps,
		                     Tecnico,
		                     Puntualidad,
		                     Profesionalidad,
		                     Conocimiento,
		                     Calidad,
		                     [Motivo detractor],
		                     Concepto,
		                     Subconcepto,
		                     Detalle,
		                     [Acción ejecutada],
		                     Estado,
		                     comentarios_cliente as [Comentarios del cliente]
		
                     from lista_medallia_casos
                     where descripcion_contrata = '" + centro + @"' and
                             [Acción ejecutada] = 'Derivado a la contratista' and
		                     (Estado = 'Escalado / Refuerzo' or
		                     Estado = 'Escalado')";
            }

            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
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
            //FIN
            Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=encuestas_pendientes.xls");

            this.EnableViewState = false;
            Response.Write(tw.ToString());
            Response.End();
            con.Close();
        }
    }
}
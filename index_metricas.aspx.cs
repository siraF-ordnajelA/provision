using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medallia
{
    public partial class index_metricas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["validacion"] != "validado")
            {
                Response.Redirect("error_404.aspx");
            }
            else
            {
                string mes_actual = Request.QueryString["mes"];//id_caso
                string fecha = Request.QueryString["fecha"];//id_caso
                string opcion = Request.QueryString["opc"];// Opción consulta
                string tecnologia = Request.QueryString["tec"];// Tecnología
                string empresa = Request.QueryString["ctta"];// Empresa consulta
                ClientScript.RegisterStartupScript(this.GetType(), "myScript1", "<script>javascript:indicador_estrellas_metricas('" + mes_actual + "','" + fecha + "','" + opcion + "','" + tecnologia + "','" + empresa + "');</script>");
            }
        }
    }
}
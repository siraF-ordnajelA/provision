using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medallia
{
    public partial class medallia_graphs4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["validacion"] != "validado")
            {
                Response.Redirect("error_404.aspx");
            }
            else
            {
                string id_ctta = Convert.ToString(Session["id_ctta"]);
                string centro = Convert.ToString(Session["centro_sesion"]);

                ClientScript.RegisterStartupScript(this.GetType(), "myScript1", "<script>javascript:combo_fechas_periodos();</script>");
                ClientScript.RegisterStartupScript(this.GetType(), "myScript2", "<script>javascript:lista_cbo_contratas('" + centro + "');</script>");

                string javaScript1 = "barras_detracciones_por_accion('" + id_ctta + "', 1);";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", javaScript1, true);
                string javaScript2 = "pie_detraciones_accion('" + id_ctta + "', 1);";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script2", javaScript2, true);
            }
        }
    }
}
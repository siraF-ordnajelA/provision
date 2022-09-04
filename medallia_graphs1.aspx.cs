using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medallia
{
    public partial class medallia_graphs1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["validacion"] != "validado")
            {
                Response.Redirect("error_404.aspx");
            }
            else
            {
                string centro = Convert.ToString(Session["centro_sesion"]);

                string javaScript = "dibuja_motivos_detractor(0,'" + centro + "','','','','','');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", javaScript, true);

                ClientScript.RegisterStartupScript(this.GetType(), "myScript", "<script>javascript:lista_cbo_contratas('" + centro + "');</script>");//ENVIO EL PARAMETRO A LA FUNCION JAVASCRIPT DE ESTA PAGINA
            }
        }
    }
}
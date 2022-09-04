using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medallia
{
    public partial class medallia_formload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["validacion"] != "validado")
            {
                Response.Redirect("error_404.aspx");
            }
            else
            {
                string parametro = Request.QueryString["param"];//id_caso
                string opcion = Request.QueryString["opc"];// Opción bandeja
                ClientScript.RegisterStartupScript(this.GetType(), "myScript", "<script>javascript:medallia_carga_form('" + parametro + "','" + opcion + "');</script>");//ENVIO EL PARAMETRO A LA FUNCION JAVASCRIPT DE ESTA PAGINA
            }
        }
    }
}
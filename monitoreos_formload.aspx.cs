using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medallia
{
    public partial class monitoreos_formload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["validacion"] != "validado")
            {
                Response.Redirect("error_404.aspx");
            }
            else
            {
                string parametro = Request.QueryString["param"];//OBTENGO VALOR DE PARAMETRO RECIBIDO DESDE EL INDEX.ASPX EN JAVASCRIPT
                string tecnico = Request.QueryString["tec"];
                ClientScript.RegisterStartupScript(this.GetType(), "myScript", "<script>javascript:carga_detalle_tecnico('" + parametro + "','" + tecnico + "');</script>");//ENVIO EL PARAMETRO A LA FUNCION JAVASCRIPT DE ESTA PAGINA
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medallia
{
    public partial class monitoreos_formload_pendiente2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["validacion"] != "validado")
            {
                Response.Redirect("error_404.aspx");
            }
            else
            {
                string id_pendiente = Request.QueryString["id_pendiente"];
                string id_recurso = Request.QueryString["recurso"];//OBTENGO VALOR DE PARAMETRO RECIBIDO DESDE EL INDEX.ASPX EN JAVASCRIPT
                string tecnico = Request.QueryString["tec"];
                string dni = Request.QueryString["dni"];
                string empresa = Request.QueryString["empre"];
                ClientScript.RegisterStartupScript(this.GetType(), "myScript", "<script>javascript:carga_formulario_pendiente('" + id_pendiente + "','" + id_recurso + "','" + tecnico + "','" + dni + "','" + empresa + "');</script>");//ENVIO EL PARAMETRO A LA FUNCION JAVASCRIPT DE ESTA PAGINA
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace medallia
{
    public partial class medallia_lista_cerrados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["validacion"] != "validado")
            {
                Response.Redirect("error_404.aspx");
            }
            else
            {
                if ((string)Session["centro_sesion"] != "TASA")
                {
                    string jscript1 = "<script>document.getElementById('chk_todos').style.display = 'none'</script>";
                    System.Type a = this.GetType();
                    Page.ClientScript.RegisterStartupScript(a, "a", jscript1);

                    string jscript2 = "<script>document.getElementById('p_todos_chk').style.display = 'none'</script>";
                    System.Type b = this.GetType();
                    Page.ClientScript.RegisterStartupScript(b, "b", jscript2);
                }
            }
        }
    }
}
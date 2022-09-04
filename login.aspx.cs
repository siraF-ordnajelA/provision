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
    public partial class login : System.Web.UI.Page
    {
        string cadena = "Data Source=10.249.15.194\\DATAFLOW; Initial Catalog=TELEGESTION; User ID=telegestion; Password=telefonica";
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_aceptar_Click(object sender, EventArgs e)
        {
            if (txt_usuario.Text != "" && txt_pass.Text != "")
            {
                string usuario = txt_usuario.Text;

                SqlConnection con = new SqlConnection(cadena);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "busca_user @usuario, @paso";
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@usuario", SqlDbType.Text).Value = usuario;
                cmd.Parameters.Add("@paso", SqlDbType.Text).Value = txt_pass.Text;

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                con.Open();
                cmd.ExecuteNonQuery();
                int filas = ds.Tables[0].Rows.Count;

                con.Close();

                if (filas > 0)
                {
                    System.Web.HttpContext.Current.Session["validacion"] = "validado"; //crea la variable de sesión llamada "validacion" y le guardo el string "validado"
                    System.Web.HttpContext.Current.Session["uvilla del pasuario"] = ds.Tables[0].Rows[0]["apellido"].ToString() + " " + ds.Tables[0].Rows[0]["nombre"].ToString();
                    System.Web.HttpContext.Current.Session["id_usuario"] = ds.Tables[0].Rows[0]["id_usr"].ToString();
                    System.Web.HttpContext.Current.Session["centro_sesion"] = ds.Tables[0].Rows[0]["centro"].ToString();
                    System.Web.HttpContext.Current.Session["perfil"] = ds.Tables[0].Rows[0]["perfil"].ToString();

                    Random rd = new Random();
                    int rand_num = rd.Next(1, 10000);
                    System.Web.HttpContext.Current.Session["rd_number"] = rand_num;


                    //Session["perfil_sesion"] == "Admin"
                    Response.Redirect("index.aspx");
                }
                else
                {
                    string jscript = "<script>alert('El usuario o la contrase\u00F1a es err\u00F3nea')</script>";
                    System.Type t = this.GetType();
                    ClientScript.RegisterStartupScript(t, "k", jscript);
                    //Response.Redirect("error_404.aspx");
                }
            }
            else
            {
                string jscript = "<script>alert('Debe completar ambos campos')</script>";
                System.Type t = this.GetType();
                ClientScript.RegisterStartupScript(t, "k", jscript);
            }
        }
    }
}
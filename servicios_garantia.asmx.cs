using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Text;

namespace medallia
{
    /// <summary>
    /// Summary description for servicios_garantia
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class servicios_garantia : System.Web.Services.WebService
    {
        String cadena = "Data Source=10.249.15.194\\DATAFLOW; Initial Catalog=TELEGESTION; User ID=telegestion; Password=telefonica"; //CONEXION CON USUARIO Y CONTRASEÑA
        String cadena2 = "Data Source=TE101104\\PROVISIONSERVER; Initial Catalog=CCP; User ID=usuariotableros; Password=usuarionet";
        
        [WebMethod]
        public void busca_toa(string peticion)
        {
            List<medallia.clases.garantias_res> lista_garantia = new List<medallia.clases.garantias_res>();

            using (SqlConnection con = new SqlConnection(cadena2))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "garantia_busca @nro_peticion";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@nro_peticion", SqlDbType.Text).Value = peticion;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.garantias_res combito = new medallia.clases.garantias_res();

                    combito.Sintoma = lector["Síntoma"].ToString();

                    combito.id_recurso = Convert.ToInt32(lector["ID RECURSO"].ToString());
                    combito.tecnico = lector["Técnico"].ToString();
                    combito.ctta = lector["Empresa"].ToString();
                    combito.access = lector["Access ID"].ToString();
                    combito.estado = lector["Estado de la orden"].ToString();

                    combito.subtipo_actividad = lector["Subtipo de Actividad"].ToString();
                    combito.distrito = lector["DISTRITO_ATC"].ToString();
                    combito.gerencia = lector["GERENCIA"].ToString();
                    combito.id_central = Convert.ToInt32(lector["central"].ToString());
                    combito.central = lector["CENT_DESCRIP_COTA"].ToString();

                    combito.peticion = lector["Número de Petición"].ToString();
                    combito.nro_orden = lector["Número de Orden"].ToString();

                    combito.segmento = lector["Segmento del cliente"].ToString();
                    combito.tecno = lector["tecnologia"].ToString();
                    combito.fecha_toa = lector["Fecha creacion toa"].ToString();
                    combito.fecha_cierre = lector["Fecha/Hora de autorizacion del cierre"].ToString();

                    lista_garantia.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_garantia));
        }

        [WebMethod]
        public void obtener_cbo_motivos(Int16 opcion)
        {
            List<medallia.clases.combos> lista_cbo1 = new List<medallia.clases.combos>();
            string consulta;

            switch (opcion)
            {
                case 1: consulta = "select * from garantias_cbo_motivo where estado = 1 order by motivo";
                    break;
                case 2: consulta = "select * from garantias_cbo_motivo_gestor where estado = 1 order by motivo";
                    break;
                default: consulta = "select * from garantias_cbo_motivo where estado = 1 order by motivo";
                    break;
            }
            
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(consulta, con);
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.combos combito = new medallia.clases.combos();

                    combito.valor = lector["id_motivo"].ToString();
                    combito.texto = lector["motivo"].ToString();

                    lista_cbo1.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo1));
        }

        [WebMethod]
        public void obtener_cbo_submotivo(Int16 opcion, Int16 motivo_id)
        {
            List<medallia.clases.combos> lista_cbo1 = new List<medallia.clases.combos>();

            string consulta;

            switch (opcion)
            {
                case 1: consulta = "select * from garantias_cbo_submotivo where id_motivo = " + motivo_id + " and estado = 1 order by submotivo";
                    break;
                case 2: consulta = "select * from garantias_cbo_submotivo_gestor where id_motivo = " + motivo_id + " and estado = 1 order by submotivo";
                    break;
                default: consulta = "select * from garantias_cbo_submotivo where id_motivo = " + motivo_id + " and estado = 1 order by submotivo";
                    break;
            }

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(consulta, con);
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.combos combito = new medallia.clases.combos();

                    combito.valor = lector["id_submotivo"].ToString();
                    combito.texto = lector["submotivo"].ToString();

                    lista_cbo1.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo1));
        }

        [WebMethod]
        public void guardado_descargo(Int32 clooper, string peticion, string sinto, int recurso, string ctta, Int64 access_id, string estado_orden, string subtipo, Int32 id_central, string seg_cliente, string tecno, string fecha_in, string fecha_out, Int16 mot, Int32 submot, string respuesta_sup, string sn_ant, string sn_act)
        {
            List<medallia.clases.cbo_tecnico> respuesta = new List<medallia.clases.cbo_tecnico>();

            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = @"garantia_guarda_descargo @id_clooper,
                                                                @peticion,
                                                                @sintoma,
                                                                @recurso,
                                                                @ctta,
                                                                @access,
                                                                @estado,
                                                                @subtipo,
                                                                @central,
                                                                @segmento,
                                                                @tecnologia,
                                                                @f_ingreso,
                                                                @f_cierre,
                                                                @motivo,
                                                                @submotivo,
                                                                @respuesta,
                                                                @sn_anterior,
                                                                @sn_actual";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            //DATOS DE LA ENCUESTA
            cmdcadena.Parameters.Add("@id_clooper", SqlDbType.SmallInt).Value = clooper;
            cmdcadena.Parameters.Add("@peticion", SqlDbType.Text).Value = peticion;
            cmdcadena.Parameters.Add("@sintoma", SqlDbType.Text).Value = sinto;
            cmdcadena.Parameters.Add("@recurso", SqlDbType.Int).Value = recurso;
            cmdcadena.Parameters.Add("@ctta", SqlDbType.Text).Value = ctta;
            cmdcadena.Parameters.Add("@access", SqlDbType.BigInt).Value = access_id;
            cmdcadena.Parameters.Add("@estado", SqlDbType.Text).Value = estado_orden;
            cmdcadena.Parameters.Add("@subtipo", SqlDbType.Text).Value = subtipo;
            cmdcadena.Parameters.Add("@central", SqlDbType.SmallInt).Value = id_central;
            cmdcadena.Parameters.Add("@segmento", SqlDbType.Text).Value = seg_cliente;
            cmdcadena.Parameters.Add("@tecnologia", SqlDbType.Text).Value = tecno;
            cmdcadena.Parameters.Add("@f_ingreso", SqlDbType.Text).Value = fecha_in;
            cmdcadena.Parameters.Add("@f_cierre", SqlDbType.Text).Value = fecha_out;    
            cmdcadena.Parameters.Add("@motivo", SqlDbType.TinyInt).Value = mot;
            cmdcadena.Parameters.Add("@submotivo", SqlDbType.SmallInt).Value = submot;
            cmdcadena.Parameters.Add("@respuesta", SqlDbType.Text).Value = respuesta_sup;
            cmdcadena.Parameters.Add("@sn_anterior", SqlDbType.Text).Value = sn_ant;
            cmdcadena.Parameters.Add("@sn_actual", SqlDbType.Text).Value = sn_act;

            conexion.Open();
            //cmdcadena.ExecuteNonQuery();

            SqlDataReader lector = cmdcadena.ExecuteReader();

            while (lector.Read())
            {
                medallia.clases.cbo_tecnico combito = new medallia.clases.cbo_tecnico();
                combito.ctta = lector["mensaje"].ToString();
                respuesta.Add(combito);
            }
            conexion.Close();

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(respuesta));
        }

        [WebMethod]
        public void actualiza_descargo(Int32 clooper, Int32 id_descargo, Int16 mot, Int32 submot, string respuesta_gestor)
        {
            List<medallia.clases.cbo_tecnico> respuesta = new List<medallia.clases.cbo_tecnico>();

            //ACA VA LA CARGA DEL NO CONTACTADO
            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = @"garantia_actualiza_descargo @id_clooper,
                                                                @id_descargo,
                                                                @motivo,
                                                                @submotivo,
                                                                @respuesta";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            //DATOS DE LA ENCUESTA
            cmdcadena.Parameters.Add("@id_clooper", SqlDbType.SmallInt).Value = clooper;
            cmdcadena.Parameters.Add("@id_descargo", SqlDbType.Int).Value = id_descargo;
            cmdcadena.Parameters.Add("@motivo", SqlDbType.TinyInt).Value = mot;
            cmdcadena.Parameters.Add("@submotivo", SqlDbType.SmallInt).Value = submot;
            cmdcadena.Parameters.Add("@respuesta", SqlDbType.Text).Value = respuesta_gestor;

            conexion.Open();
            //cmdcadena.ExecuteNonQuery();

            SqlDataReader lector = cmdcadena.ExecuteReader();

            while (lector.Read())
            {
                medallia.clases.cbo_tecnico combito = new medallia.clases.cbo_tecnico();
                combito.ctta = lector["mensaje"].ToString();
                respuesta.Add(combito);
            }
            conexion.Close();

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(respuesta));
        }

        [WebMethod]
        public void garantias_lista_descargos(Int16 opc, Int32 id_descargo)
        {
            List<medallia.clases.garantias_descargos> lista_descargos = new List<medallia.clases.garantias_descargos>();
            string consulta;

            if (opc == 1)
            {
                consulta = "select top 1000 * from garantia_lista_descargos where trabajado_gestor = 0 order by fecha_descargo desc";
            }
            else
            {
                consulta = "select top 1000 * from garantia_lista_descargos where id_descargo = " + id_descargo;
            }
            
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(consulta, con);
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.garantias_descargos combito = new medallia.clases.garantias_descargos();

                    combito.id_descargo = Convert.ToInt32(lector["id_descargo"].ToString());
                    combito.usuario = lector["usuario"].ToString();

                    combito.peticion = lector["nro_peticion"].ToString();
                    combito.sintoma = lector["sintoma"].ToString();
                    combito.fecha_descargo = lector["fecha_descargo"].ToString();

                    combito.tecnico = lector["tecnico"].ToString();
                    combito.ctta = lector["descripcion_contrata"].ToString();
                    combito.access = lector["access_id"].ToString();
                    combito.estado = lector["estado"].ToString();

                    combito.subtipo_actividad = lector["subtipo_actividad"].ToString();
                    combito.distrito = lector["Distrito"].ToString();
                    combito.gerencia = lector["Gerencia"].ToString();
                    combito.central = lector["central"].ToString();

                    combito.segmento = lector["segmento"].ToString();
                    combito.tecnologia = lector["tecnologia"].ToString();
                    combito.fecha_toa = lector["fecha_ingreso"].ToString();
                    combito.fecha_cierre = lector["fecha_cierre"].ToString();

                    combito.comentarios_ctta = lector["comentarios_ctta"].ToString();
                    combito.motivo = lector["motivo"].ToString();
                    combito.submotivo = lector["submotivo"].ToString();

                    combito.sn_anterior = lector["sn_anterior"].ToString();
                    combito.sn_actual = lector["sn_actual"].ToString();

                    lista_descargos.Add(combito);
                }
                con.Close();

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.Write(js.Serialize(lista_descargos));
            }
        }

        [WebMethod]
        public void garantias_busca_lista_descargos(string empresa, string fecha1, string fecha2)
        {
            List<medallia.clases.garantias_descargos> lista_descargos = new List<medallia.clases.garantias_descargos>();
            string consulta = "select top 1000 * from garantia_lista_descargos where descripcion_contrata = '" + empresa + "' and fecha_descargo between '" + fecha1 + "' and '" + fecha2 + "' order by fecha_descargo desc";

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(consulta, con);
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.garantias_descargos combito = new medallia.clases.garantias_descargos();

                    combito.id_descargo = Convert.ToInt32(lector["id_descargo"].ToString());
                    combito.usuario = lector["usuario"].ToString();

                    combito.peticion = lector["nro_peticion"].ToString();
                    combito.sintoma = lector["sintoma"].ToString();
                    combito.fecha_descargo = lector["fecha_descargo"].ToString();

                    combito.tecnico = lector["tecnico"].ToString();
                    combito.ctta = lector["descripcion_contrata"].ToString();
                    combito.access = lector["access_id"].ToString();
                    combito.estado = lector["estado"].ToString();

                    combito.subtipo_actividad = lector["subtipo_actividad"].ToString();
                    combito.distrito = lector["Distrito"].ToString();
                    combito.gerencia = lector["Gerencia"].ToString();
                    combito.central = lector["central"].ToString();

                    combito.segmento = lector["segmento"].ToString();
                    combito.tecnologia = lector["tecnologia"].ToString();
                    combito.fecha_toa = lector["fecha_ingreso"].ToString();
                    combito.fecha_cierre = lector["fecha_cierre"].ToString();

                    combito.comentarios_ctta = lector["comentarios_ctta"].ToString();
                    combito.motivo = lector["motivo"].ToString();
                    combito.submotivo = lector["submotivo"].ToString();

                    combito.sn_anterior = lector["sn_anterior"].ToString();
                    combito.sn_actual = lector["sn_actual"].ToString();

                    lista_descargos.Add(combito);
                }
                con.Close();

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.Write(js.Serialize(lista_descargos));
            }
        }
    }
}

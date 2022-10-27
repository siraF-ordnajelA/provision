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
    /// Summary description for servicios_medallia
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class servicios_medallia : System.Web.Services.WebService
    {
        String cadena = "Data Source=10.249.15.194\\DATAFLOW; Initial Catalog=TELEGESTION; User ID=telegestion; Password=telefonica"; //CONEXION CON USUARIO Y CONTRASEÑA
        //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; Integrated Security=SSPI"; //CONEXION CON CREDENCIALES DE RED
        
        [WebMethod]
        public void obtener_contratas()
        {
            List<medallia.clases.cbo_tecnico> lista_cbo2 = new List<medallia.clases.cbo_tecnico>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "lista_contratas";
                cmdcadena.CommandType = CommandType.Text;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.cbo_tecnico combito = new medallia.clases.cbo_tecnico();
                    combito.ID_RECURSO = lector["id_contrata"].ToString();
                    combito.ctta = lector["ctta"].ToString();
                    lista_cbo2.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo2));
        }

        [WebMethod]
        public void contador_casos(Int16 parametro_user, string parametro_centro)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<medallia.clases.avisos_bandeja> lista_avisos = new List<medallia.clases.avisos_bandeja>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_cuenta_casos @id_usuario, @empresa";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@id_usuario", SqlDbType.TinyInt).Value = parametro_user;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = parametro_centro;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.avisos_bandeja combito = new medallia.clases.avisos_bandeja();
                    combito.escalados = lector["escalados"].ToString();
                    combito.refuerzos = lector["refuerzos"].ToString();
                    combito.pend_clooper = lector["pend_clooper"].ToString();
                    combito.sistemas = lector["sistemas"].ToString();
                    combito.cerrados = lector["cerrados"].ToString();
                    combito.pend_monitoreo = lector["pend_monitoreo"].ToString();
                    combito.pend_gestor = lector["pend_gestor"].ToString();
                    combito.provisorios = lector["provisorios"].ToString();
                    combito.noaptos = lector["noaptos"].ToString();
                    lista_avisos.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_avisos));
        }

        [WebMethod]
        public void obtener_conceptos(string id_detraccion)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<medallia.clases.cbo_tecnico> lista_cbo2 = new List<medallia.clases.cbo_tecnico>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_combo_conceptos @id_motivo";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@id_motivo", SqlDbType.Text).Value = id_detraccion;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.cbo_tecnico combito = new medallia.clases.cbo_tecnico();
                    combito.ID_TOA = lector["id_concepto"].ToString();
                    combito.Ingresante = lector["concepto"].ToString();
                    lista_cbo2.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo2));
        }

        [WebMethod]
        public void obtener_subconceptos(string id_concepto)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<medallia.clases.cbo_tecnico> lista_cbo2 = new List<medallia.clases.cbo_tecnico>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_combo_subconceptos @id_concepto";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@id_concepto", SqlDbType.Text).Value = id_concepto;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.cbo_tecnico combito = new medallia.clases.cbo_tecnico();
                    combito.ID_TOA = lector["id_subconcepto"].ToString();
                    combito.Ingresante = lector["sub_concepto"].ToString();
                    lista_cbo2.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo2));
        }

        [WebMethod]
        public void obtener_detalles(string id_subconcepto)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<medallia.clases.cbo_tecnico> lista_cbo2 = new List<medallia.clases.cbo_tecnico>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_combo_detalle @id_subconcepto";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@id_subconcepto", SqlDbType.Text).Value = id_subconcepto;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.cbo_tecnico combito = new medallia.clases.cbo_tecnico();
                    combito.ID_TOA = lector["id_detalle"].ToString();
                    combito.Ingresante = lector["detalle"].ToString();
                    lista_cbo2.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo2));
        }

        [WebMethod]
        public void busca_toa(string id_cliente, string dni, string id_encuesta, Int16 opc)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<medallia.clases.medallia_res> lista_cbo2 = new List<medallia.clases.medallia_res>();

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_busca @id_cliente, @dni, @id_encuesta, @opcion";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@id_cliente", SqlDbType.Text).Value = id_cliente;
                cmdcadena.Parameters.Add("@dni", SqlDbType.Text).Value = dni;
                cmdcadena.Parameters.Add("@id_encuesta", SqlDbType.Text).Value = id_encuesta;
                cmdcadena.Parameters.Add("@opcion", SqlDbType.TinyInt).Value = Convert.ToInt16(opc);

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.medallia_res combito = new medallia.clases.medallia_res();
                    combito.cliente = lector["Nombre"].ToString();
                    combito.direccion = lector["direccion"].ToString();
                    combito.region_mop = lector["region_mop"].ToString();
                    combito.gerencia = lector["GERENCIA"].ToString();
                    combito.distrito_atc = lector["DISTRITO_ATC"].ToString();
                    combito.distrito = lector["distrito"].ToString();
                    combito.id_central = Convert.ToInt32(lector["id_central"].ToString());
                    combito.central = lector["central"].ToString();
                    combito.contacto = lector["telefono contacto 1"].ToString();
                    combito.segmento = lector["Segmento del cliente"].ToString();
                    combito.tecnologia = lector["tecnologia"].ToString();
                    combito.tecnico = lector["Técnico"].ToString();
                    combito.id_recurso = Convert.ToInt32(lector["ID RECURSO"].ToString());

                    combito.empresa = lector["Empresa"].ToString();
                    combito.orden = lector["Número de Petición"].ToString();
                    combito.access = lector["Access ID"].ToString();
                    combito.bucket = lector["Bucket Inicial"].ToString();
                    lista_cbo2.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo2));
        }

        [WebMethod]
        public void buscador_medallia(string cliente, string tecnico, string encuesta, string ctta, string f1, string f2)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<medallia.clases.medallia_gestiones> lista_cbo2 = new List<medallia.clases.medallia_gestiones>();

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_busca_2 @id_encuesta, @id_cliente, @tec, @cbo_ctta, @f1, @f2";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@id_cliente", SqlDbType.BigInt).Value = Convert.ToInt64(cliente);
                cmdcadena.Parameters.Add("@tec", SqlDbType.Text).Value = tecnico;
                cmdcadena.Parameters.Add("@cbo_ctta", SqlDbType.Text).Value = ctta;
                cmdcadena.Parameters.Add("@id_encuesta", SqlDbType.Int).Value = Convert.ToInt32(encuesta);
                cmdcadena.Parameters.Add("@f1", SqlDbType.Text).Value = f1;
                cmdcadena.Parameters.Add("@f2", SqlDbType.Text).Value = f2;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.medallia_gestiones combito = new medallia.clases.medallia_gestiones();
                    combito.clooper = lector["usuario"].ToString();
                    combito.id_encuesta = Convert.ToInt32(lector["id_encuesta"].ToString());
                    combito.id_caso = Convert.ToInt32(lector["id_caso"].ToString());
                    combito.fecha_encuesta = lector["fecha_encuesta"].ToString();
                    combito.fecha_mail = lector["fecha_mail"].ToString();
                    combito.fecha_fin = lector["fecha_fin"].ToString();
                    combito.nombre_tecnico = lector["nombre_tecnico"].ToString();
                    combito.nombre_cliente = lector["descripcion_contrata"].ToString();
                    combito.serial_anterior = lector["Acción ejecutada"].ToString();
                    combito.serial_actual = lector["Estado"].ToString();
                    lista_cbo2.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo2));
        }

        [WebMethod]
        public void guardado_1(Int16 mot, Int16 contex, Int32 id_clooper, Int64 id_cliente, int id_recurso, int id_encu, string fecha, string nom, string region, string dire, string loca, string tel, string orden, string access_id, string bucket, Int32 central, string segmento, string tecno, string ctta, Int16 nps, Int16 tec, Int16 puntu, Int16 profe, Int16 conocimiento, Int16 calidad, Int16 comu, Int16 motivo, Int16 concepto, Int16 sub, Int16 detalle, Int16 accion, Int16 estado, Int16 gestion_clooper, string comentarios_cliente, Int16 resp_cliente, Int16 resp_final_cliente)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<medallia.clases.cbo_tecnico> respuesta = new List<medallia.clases.cbo_tecnico>();

            //ACA VA LA CARGA DEL NO CONTACTADO
            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = @"medallia_guardado_1 @motivo,
                                                            @contexto,
                                                            @id_clooper,
                                                            @id_cliente,
                                                            @id_recurso,
                                                            @id_encuesta,
                                                            @fecha,
                                                            @nombre,
                                                            @region,
                                                            @direccion,
                                                            @localidad,
                                                            @telefono,
                                                            @orden,
                                                            @access,
                                                            @bucket,
                                                            @empresa,
                                                            @nps,
                                                            @tecnico,
                                                            @puntualidad,
                                                            @profesionalismo,
                                                            @conocimiento,
                                                            @calidad,
                                                            @comunicacion,
                                                            @motivo_detractor,
                                                            @concepto,
                                                            @subconcepto,
                                                            @detalle,
                                                            @accion,
                                                            @estado,
                                                            @gest_clooper,
                                                            @coment_cliente,
                                                            @resp_cliente,
                                                            @resp_final_cliente,
                                                            @central,
                                                            @segmento,
                                                            @tecnologia";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            //DATOS DE LA ENCUESTA
            cmdcadena.Parameters.Add("@motivo", SqlDbType.TinyInt).Value = mot;
            cmdcadena.Parameters.Add("@contexto", SqlDbType.TinyInt).Value = contex;
            cmdcadena.Parameters.Add("@id_clooper", SqlDbType.SmallInt).Value = id_clooper;
            cmdcadena.Parameters.Add("@id_cliente", SqlDbType.BigInt).Value = id_cliente;
            cmdcadena.Parameters.Add("@segmento", SqlDbType.Text).Value = segmento;
            cmdcadena.Parameters.Add("@tecnologia", SqlDbType.Text).Value = tecno;
            cmdcadena.Parameters.Add("@id_recurso", SqlDbType.Int).Value = id_recurso;
            cmdcadena.Parameters.Add("@id_encuesta", SqlDbType.Int).Value = id_encu;
            cmdcadena.Parameters.Add("@fecha", SqlDbType.Text).Value = fecha;
            cmdcadena.Parameters.Add("@nombre", SqlDbType.Text).Value = nom;
            cmdcadena.Parameters.Add("@region", SqlDbType.Text).Value = region;
            cmdcadena.Parameters.Add("@direccion", SqlDbType.Text).Value = dire;
            cmdcadena.Parameters.Add("@localidad", SqlDbType.Text).Value = loca;
            cmdcadena.Parameters.Add("@telefono", SqlDbType.Text).Value = tel;
            cmdcadena.Parameters.Add("@orden", SqlDbType.Text).Value = orden;
            cmdcadena.Parameters.Add("@access", SqlDbType.Text).Value = access_id;
            cmdcadena.Parameters.Add("@bucket", SqlDbType.Text).Value = bucket;
            cmdcadena.Parameters.Add("@central", SqlDbType.SmallInt).Value = central;
            cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = ctta;
            //CALIFICACION
            cmdcadena.Parameters.Add("@nps", SqlDbType.TinyInt).Value = nps;
            cmdcadena.Parameters.Add("@tecnico", SqlDbType.TinyInt).Value = tec;
            cmdcadena.Parameters.Add("@puntualidad", SqlDbType.TinyInt).Value = puntu;
            cmdcadena.Parameters.Add("@profesionalismo", SqlDbType.TinyInt).Value = profe;
            cmdcadena.Parameters.Add("@conocimiento", SqlDbType.TinyInt).Value = conocimiento;
            cmdcadena.Parameters.Add("@calidad", SqlDbType.TinyInt).Value = calidad;
            cmdcadena.Parameters.Add("@comunicacion", SqlDbType.TinyInt).Value = comu;
            //MOTIVOS
            cmdcadena.Parameters.Add("@motivo_detractor", SqlDbType.TinyInt).Value = motivo;
            cmdcadena.Parameters.Add("@concepto", SqlDbType.TinyInt).Value = concepto;
            cmdcadena.Parameters.Add("@subconcepto", SqlDbType.TinyInt).Value = sub;
            cmdcadena.Parameters.Add("@detalle", SqlDbType.TinyInt).Value = detalle;
            cmdcadena.Parameters.Add("@accion", SqlDbType.TinyInt).Value = accion;
            cmdcadena.Parameters.Add("@estado", SqlDbType.TinyInt).Value = estado;
            cmdcadena.Parameters.Add("@gest_clooper", SqlDbType.TinyInt).Value = gestion_clooper;
            //CLIENTE
            cmdcadena.Parameters.Add("@coment_cliente", SqlDbType.Text).Value = comentarios_cliente;
            cmdcadena.Parameters.Add("@resp_cliente", SqlDbType.TinyInt).Value = resp_cliente;
            cmdcadena.Parameters.Add("@resp_final_cliente", SqlDbType.TinyInt).Value = resp_final_cliente;

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
        public void guardado_2(int id_caso, string resp_sup, Int16 cbo_resp_sup, string sn_anterior, string sn_actual)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA

            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = @"medallia_guardado_2 @id_cas,
                                                            @resp_supervisor,
                                                            @cbo_resp_supervisor,
                                                            @sn_anterior,
                                                            @sn_actual";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            cmdcadena.Parameters.Add("@id_cas", SqlDbType.Int).Value = id_caso;
            cmdcadena.Parameters.Add("@resp_supervisor", SqlDbType.Text).Value = resp_sup;
            cmdcadena.Parameters.Add("@cbo_resp_supervisor", SqlDbType.TinyInt).Value = cbo_resp_sup;
            cmdcadena.Parameters.Add("@sn_anterior", SqlDbType.Text).Value = sn_anterior;
            cmdcadena.Parameters.Add("@sn_actual", SqlDbType.Text).Value = sn_actual;

            conexion.Open();
            cmdcadena.ExecuteNonQuery();
            conexion.Close();
        }

        [WebMethod]
        public void guardado_2_reagenda(int id_caso, Int16 chk_reagenda)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA

            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = @"medallia_guardado_2_reagenda @id_cas, @chk_reagenda";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            cmdcadena.Parameters.Add("@id_cas", SqlDbType.Int).Value = id_caso;
            cmdcadena.Parameters.Add("@chk_reagenda", SqlDbType.TinyInt).Value = chk_reagenda;

            conexion.Open();
            cmdcadena.ExecuteNonQuery();
            conexion.Close();
        }

        [WebMethod]
        public void guardado_3(int id_recurso, Int16 motivo, Int16 concepto, Int16 sub, Int16 detalle, Int16 accion, Int16 estado, Int16 gestion_clooper, Int16 resp_cliente, Int16 resp_final_cliente, string resp_clooper)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web";

            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = @"medallia_guardado_3 @id_recurso,
                                                            @motivo_detractor,
                                                            @concepto,
                                                            @subconcepto,
                                                            @detalle,
                                                            @accion,
                                                            @estado,
                                                            @gest_clooper,
                                                            @resp_cliente,
                                                            @resp_final_cliente,
                                                            @resp_clooper";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            //DATOS DE LA ENCUESTA
            cmdcadena.Parameters.Add("@id_recurso", SqlDbType.Int).Value = id_recurso;
            //MOTIVOS
            cmdcadena.Parameters.Add("@motivo_detractor", SqlDbType.TinyInt).Value = motivo;
            cmdcadena.Parameters.Add("@concepto", SqlDbType.TinyInt).Value = concepto;
            cmdcadena.Parameters.Add("@subconcepto", SqlDbType.TinyInt).Value = sub;
            cmdcadena.Parameters.Add("@detalle", SqlDbType.TinyInt).Value = detalle;
            cmdcadena.Parameters.Add("@accion", SqlDbType.TinyInt).Value = accion;
            cmdcadena.Parameters.Add("@estado", SqlDbType.TinyInt).Value = estado;
            cmdcadena.Parameters.Add("@gest_clooper", SqlDbType.TinyInt).Value = gestion_clooper;
            //CLIENTE
            cmdcadena.Parameters.Add("@resp_cliente", SqlDbType.TinyInt).Value = resp_cliente;
            cmdcadena.Parameters.Add("@resp_final_cliente", SqlDbType.TinyInt).Value = resp_final_cliente;
            //RESPUESTA DEL CLOOPER
            cmdcadena.Parameters.Add("@resp_clooper", SqlDbType.Text).Value = resp_clooper;

            conexion.Open();
            cmdcadena.ExecuteNonQuery();
            conexion.Close();
        }

        [WebMethod]
        public void guardado_4(int id_recurso, Int16 accion, string respuesta_cloop)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web";

            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = @"medallia_guardado_4 @id_recurso, @accion_clooper, @resp_clooper";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            //DATOS DE LA ENCUESTA
            cmdcadena.Parameters.Add("@id_recurso", SqlDbType.Int).Value = id_recurso;
            cmdcadena.Parameters.Add("@accion_clooper", SqlDbType.TinyInt).Value = accion;
            cmdcadena.Parameters.Add("@resp_clooper", SqlDbType.Text).Value = respuesta_cloop;

            conexion.Open();
            cmdcadena.ExecuteNonQuery();
            conexion.Close();
        }

        [WebMethod]
        public void medallia_lista_casos(Int16 parametro_user, string parametro_centro, int id_caso, Int16 opcion)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<medallia.clases.res_busqueda> lista_cerrados = new List<medallia.clases.res_busqueda>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_lista_casos @id_usuario, @centro, @id_caso, @opc";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@id_usuario", SqlDbType.SmallInt).Value = parametro_user;
                cmdcadena.Parameters.Add("@centro", SqlDbType.Text).Value = parametro_centro;
                cmdcadena.Parameters.Add("@id_caso", SqlDbType.Int).Value = id_caso;
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opcion;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.res_busqueda combito = new medallia.clases.res_busqueda();
                    combito.instalaciones = Convert.ToInt32(lector["id_caso"]);
                    combito.tecnico = lector["usuario"].ToString();
                    combito.garantias = Convert.ToInt32(lector["id_encuesta"]);
                    combito.access = lector["access_id"].ToString();
                    combito.calificacion = lector["nombre"].ToString();
                    combito.empresa = lector["ctta"].ToString();
                    combito.fecha_inicio = lector["fecha_inicio"].ToString();
                    combito.fecha_fin = lector["fecha_cierre"].ToString();

                    lista_cerrados.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cerrados));
        }

        [WebMethod]
        public void medallia_lista_todos(Int16 parametro_opcion)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<medallia.clases.res_busqueda> lista_cerrados = new List<medallia.clases.res_busqueda>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_lista_todos @opc";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = parametro_opcion;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.res_busqueda combito = new medallia.clases.res_busqueda();
                    combito.instalaciones = Convert.ToInt32(lector["id_caso"]);
                    combito.tecnico = lector["usuario"].ToString();
                    combito.garantias = Convert.ToInt32(lector["id_encuesta"]);
                    combito.access = lector["access_id"].ToString();
                    combito.calificacion = lector["nombre"].ToString();
                    combito.empresa = lector["ctta"].ToString();
                    combito.fecha_inicio = lector["fecha_inicio"].ToString();
                    combito.fecha_fin = lector["fecha_cierre"].ToString();

                    lista_cerrados.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cerrados));
        }

        [WebMethod]
        public void cargar_formulario(int id_encuesta, Int16 opcion)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<medallia.clases.medallia_gestiones> lista_gestion = new List<medallia.clases.medallia_gestiones>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_lista_gestiones @id_caso, @opc";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@id_caso", SqlDbType.Int).Value = id_encuesta;
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opcion;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.medallia_gestiones combito = new medallia.clases.medallia_gestiones();
                    combito.id_caso = Convert.ToInt32(lector["id_caso"]);
                    combito.motivo = Convert.ToInt16(lector["motivo"]);
                    combito.contexto = Convert.ToInt16(lector["contexto"]);
                    combito.id_clooper = Convert.ToInt16(lector["id_clooper"]);
                    combito.clooper = lector["usuario"].ToString();
                    combito.id_cliente = Convert.ToInt64(lector["id_cliente"]);
                    combito.id_encuesta = Convert.ToInt32(lector["id_encuesta"]);
                    combito.fecha_encuesta = lector["fecha_encuesta"].ToString();
                    combito.fecha_mail = lector["fecha_mail"].ToString();
                    combito.fecha_fin = lector["fecha_fin"].ToString();
                    combito.id_recurso = Convert.ToInt32(lector["id_recurso"]);
                    combito.nombre_tecnico = lector["nombre_tecnico"].ToString();
                    combito.dni_tecnico = lector["dni"].ToString();
                    combito.nombre_cliente = lector["nombre_cliente"].ToString();
                    combito.direccion = lector["direccion"].ToString();
                    combito.localidad = lector["DISTRITO_ATC"].ToString();
                    combito.contacto = lector["contacto"].ToString();
                    combito.segmento = lector["segmento"].ToString();
                    combito.tecnologia = lector["tecnologia"].ToString();
                    combito.nro_orden = lector["nro_orden"].ToString();
                    combito.access = lector["access_id"].ToString();
                    combito.bucket = lector["bucket"].ToString();
                    combito.ctta = lector["descripcion_contrata"].ToString();
                    combito.nps = Convert.ToInt16(lector["nps"]);
                    combito.tecnico = Convert.ToInt16(lector["tecnico"]);
                    combito.puntualidad = Convert.ToInt16(lector["puntualidad"]);
                    combito.profesionalidad = Convert.ToInt16(lector["profesionalidad"]);
                    combito.conocimiento = Convert.ToInt16(lector["conocimiento"]);
                    combito.calidad = Convert.ToInt16(lector["calidad"]);
                    combito.comunicacion = Convert.ToInt16(lector["comunicacion"]);
                    combito.mot_detractor = Convert.ToInt16(lector["motivo_detractor"]);
                    combito.id_concepto = Convert.ToInt16(lector["id_concepto"]);
                    combito.concepto = lector["concepto"].ToString();
                    combito.id_subconcepto = Convert.ToInt16(lector["id_sub_concepto"]);
                    combito.subconcepto = lector["subconcepto"].ToString();
                    combito.id_detalle = Convert.ToInt16(lector["id_detalle"]);
                    combito.detalle = lector["detalle"].ToString();
                    combito.accion = Convert.ToInt16(lector["accion_ejecutada"]);
                    combito.estado = Convert.ToInt16(lector["estado"]);
                    combito.id_accion_clooper = Convert.ToInt16(lector["accion_clooper"]);
                    combito.comentarios_cliente = lector["comentarios_cliente"].ToString();
                    combito.resp_cliente = Convert.ToInt16(lector["respuesta_cliente"]);
                    combito.resp_final_cliente = Convert.ToInt16(lector["resp_final_cliente"]);
                    combito.resp_supervisor = lector["resp_supervisor"].ToString();
                    combito.id_resp_sup = Convert.ToInt16(lector["id_resp_supervisor"]);
                    combito.serial_anterior = lector["sn_anterior"].ToString();
                    combito.serial_actual = lector["sn_actual"].ToString();
                    combito.resp_clooper = lector["respuesta_clooper"].ToString();
                    combito.reagenda = Convert.ToInt16(lector["reagenda"]);
                    combito.id_central = Convert.ToInt32(lector["id_central"]);
                    combito.gerencia = lector["GERENCIA"].ToString();
                    combito.distrito_atc = lector["localidad"].ToString();
                    combito.central = lector["CENT_DESCRIP_COTA"].ToString();
                    lista_gestion.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_gestion));
        }

        [WebMethod]
        public void obtener_motivos_detractor(Int16 opc, string centro, string fecha1, string fecha2, string mot, string concep, string sub)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<clases.medallia_barras> lista_bar = new List<clases.medallia_barras>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_motivos_detractores @opcion, @empresa, @f1, @f2, @mot, @concep, @sub";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@opcion", SqlDbType.TinyInt).Value = opc;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = centro;
                cmdcadena.Parameters.Add("@f1", SqlDbType.Text).Value = fecha1;
                cmdcadena.Parameters.Add("@f2", SqlDbType.Text).Value = fecha2;
                cmdcadena.Parameters.Add("@mot", SqlDbType.Text).Value = mot;
                cmdcadena.Parameters.Add("@concep", SqlDbType.Text).Value = concep;
                cmdcadena.Parameters.Add("@sub", SqlDbType.Text).Value = sub;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.medallia_barras barritas = new clases.medallia_barras();
                    barritas.motivo = lector["motivo"].ToString();
                    barritas.cantidad = Convert.ToInt32(lector["Cant"].ToString());

                    lista_bar.Add(barritas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }

        [WebMethod]
        public void medallia_dibuja_grafico1_detalle(string centro, string fecha1, string fecha2, string subconcepto, string detalle, Int16 opcion)
        {
            List<clases.medallia_gestiones> lista_bar = new List<clases.medallia_gestiones>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_detalle_motivos @empresa, @f1, @f2, @subconcep, @detalle, @opcion";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = centro;
                cmdcadena.Parameters.Add("@f1", SqlDbType.Text).Value = fecha1;
                cmdcadena.Parameters.Add("@f2", SqlDbType.Text).Value = fecha2;
                cmdcadena.Parameters.Add("@subconcep", SqlDbType.Text).Value = subconcepto;
                cmdcadena.Parameters.Add("@detalle", SqlDbType.Text).Value = detalle;
                cmdcadena.Parameters.Add("@opcion", SqlDbType.TinyInt).Value = opcion;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.medallia_gestiones barritas = new clases.medallia_gestiones();
                    barritas.id_caso = Convert.ToInt32(lector["id_caso"].ToString());
                    barritas.clooper = lector["clooper"].ToString();
                    barritas.nombre_tecnico = lector["nombre"].ToString();
                    barritas.ctta = lector["ctta"].ToString();
                    barritas.fecha_encuesta = lector["fecha_encuesta"].ToString();
                    barritas.fecha_fin = lector["fecha_fin"].ToString();
                    barritas.comentarios_cliente = lector["comentarios_cliente"].ToString();
                    barritas.resp_supervisor = lector["resp_supervisor"].ToString();
                    barritas.accion_ejecutada = lector["Acción ejecutada"].ToString();

                    lista_bar.Add(barritas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }

        [WebMethod]
        public void obtener_barras(String valor_centro)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<clases.medallia_barras> lista_bar = new List<clases.medallia_barras>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "historico_barras @empresa, @anio";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = valor_centro;
                cmdcadena.Parameters.Add("@anio", SqlDbType.Text).Value = 0;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.medallia_barras barritas = new clases.medallia_barras();
                    barritas.motivo = lector["Empresa"].ToString();
                    barritas.cantidad = Convert.ToInt32(lector["Enero"].ToString());

                    lista_bar.Add(barritas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }

        [WebMethod]
        public void obtener_top10_encuestas(Int16 opc, string valor_centro, string fecha1, string fecha2)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<clases.cbo_tecnico> lista_bar = new List<clases.cbo_tecnico>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_lista_pendiente @opc, @empresa, @f1, @f2";
                cmdcadena.CommandType = CommandType.Text;
                
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opc;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = valor_centro;
                cmdcadena.Parameters.Add("@f1", SqlDbType.Text).Value = fecha1;
                cmdcadena.Parameters.Add("@f2", SqlDbType.Text).Value = fecha2;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.cbo_tecnico barritas = new clases.cbo_tecnico();
                    barritas.Nombre = lector["nombre"].ToString();
                    barritas.ctta = lector["descripcion_contrata"].ToString();
                    barritas.Ingresante = lector["Cant"].ToString();

                    lista_bar.Add(barritas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }

        [WebMethod]
        public void obtener_pendiente_encuestas(Int16 opc, string valor_centro, string fecha1, string fecha2)
        {
            //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; User ID=usr_web; Password=usr_web"; //CONEXION CON USUARIO Y CONTRASEÑA
            List<clases.cbo_tecnico> lista_bar = new List<clases.cbo_tecnico>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "medallia_lista_pendiente @opc, @empresa, @f1, @f2";
                cmdcadena.CommandType = CommandType.Text;

                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opc;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = valor_centro;
                cmdcadena.Parameters.Add("@f1", SqlDbType.Text).Value = fecha1;
                cmdcadena.Parameters.Add("@f2", SqlDbType.Text).Value = fecha2;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.cbo_tecnico barritas = new clases.cbo_tecnico();
                    barritas.ctta = lector["descripcion_contrata"].ToString();
                    barritas.Ingresante = lector["Cant"].ToString();
                    barritas.ID_TOA = lector["Diff"].ToString();

                    lista_bar.Add(barritas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }
    }
}

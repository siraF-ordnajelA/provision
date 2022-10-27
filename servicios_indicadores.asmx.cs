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
    /// Summary description for servicios_indicadores
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class servicios_indicadores : System.Web.Services.WebService
    {
        String cadena = "Data Source=10.249.15.194\\DATAFLOW; Initial Catalog=TELEGESTION; User ID=telegestion; Password=telefonica"; //CONEXION CON USUARIO Y CONTRASEÑA
        
        [WebMethod]
        public void performance(string fecha, Int16 opc, Int16 tec, string centro)
        {
            List<clases.res_metricas> lista_bar = new List<clases.res_metricas>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "metricas_consulta @fecha, @opc, @tec, @empresa";
                cmdcadena.CommandType = CommandType.Text;

                cmdcadena.Parameters.Add("@fecha", SqlDbType.Text).Value = fecha;
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opc;
                cmdcadena.Parameters.Add("@tec", SqlDbType.TinyInt).Value = tec;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = centro;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.res_metricas metricas = new clases.res_metricas();
                    if (opc == 1)
                    {
                        metricas.empresa = lector["descripcion_contrata"].ToString();
                    }
                    else
                    {
                        metricas.empresa = lector["nombre"].ToString();
                    }
                    metricas.metrica_cumplidas = float.Parse(lector["metrica_cumplidas"].ToString());
                    metricas.metrica_garantias = float.Parse(lector["metrica_garantias"].ToString());
                    metricas.metrica_garantias_7d = float.Parse(lector["metrica_garantias_7d"].ToString());
                    metricas.metrica_monitoreos = float.Parse(lector["metrica_monitoreos"].ToString());
                    metricas.metrica_diarias = float.Parse(lector["metrica_diarias"].ToString());
                    metricas.metrica_citas = float.Parse(lector["metrica_citas"].ToString());
                    metricas.metrica_presentismo = float.Parse(lector["metrica_presentismo"].ToString());
                    metricas.estrellas = float.Parse(lector["5 Estrellas"].ToString());
                    metricas.tecnologia = lector["tecno"].ToString();

                    lista_bar.Add(metricas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }

        [WebMethod]
        public void performance_por_gerencia_distrito(string fecha, Int16 opc, Int16 tec, string centro, string gerencia, string distrito)
        {
            List<clases.res_metricas> lista_bar = new List<clases.res_metricas>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "metricas_consulta_por_central @fecha, @opc, @tec, @empresa, @region, @distrito";
                cmdcadena.CommandType = CommandType.Text;

                cmdcadena.Parameters.Add("@fecha", SqlDbType.Text).Value = fecha;
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opc;
                cmdcadena.Parameters.Add("@tec", SqlDbType.TinyInt).Value = tec;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = centro;
                cmdcadena.Parameters.Add("@region", SqlDbType.Text).Value = gerencia;
                cmdcadena.Parameters.Add("@distrito", SqlDbType.Text).Value = distrito;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.res_metricas metricas = new clases.res_metricas();
                    if (opc == 1)
                    {
                        metricas.empresa = lector["descripcion_contrata"].ToString();
                    }
                    else
                    {
                        metricas.empresa = lector["nombre"].ToString();
                    }
                    metricas.metrica_cumplidas = float.Parse(lector["metrica_cumplidas"].ToString());
                    metricas.metrica_garantias = float.Parse(lector["metrica_garantias"].ToString());
                    metricas.metrica_garantias_7d = float.Parse(lector["metrica_garantias_7d"].ToString());
                    metricas.metrica_monitoreos = float.Parse(lector["metrica_monitoreos"].ToString());
                    metricas.metrica_diarias = float.Parse(lector["metrica_diarias"].ToString());
                    metricas.metrica_citas = float.Parse(lector["metrica_citas"].ToString());
                    metricas.metrica_presentismo = float.Parse(lector["metrica_presentismo"].ToString());
                    metricas.estrellas = float.Parse(lector["5 Estrellas"].ToString());
                    metricas.tecnologia = lector["tecno"].ToString();

                    lista_bar.Add(metricas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }

        [WebMethod]
        public void obtener_fechas_metricas()
        {
            List<medallia.clases.combos> lista_cbo1 = new List<medallia.clases.combos>();

            string consulta = "select top 12 cast (Fecha as varchar(10)) as Fecha, replace(Fecha,'-','') as valor from metricas_ctta group by Fecha order by Fecha desc";

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(consulta, con);
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.combos combito = new medallia.clases.combos();

                    combito.valor = lector["valor"].ToString();
                    combito.texto = lector["Fecha"].ToString();

                    lista_cbo1.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo1));
        }

        [WebMethod]
        public void dibuja_indicador_semanal(string valor_fecha, string valor_centro, Int16 tec)
        {
            List<clases.res_metricas> lista_bar = new List<clases.res_metricas>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "metricas_consulta_semanal @fecha, @empresa, @tec";
                cmdcadena.CommandType = CommandType.Text;

                cmdcadena.Parameters.Add("@fecha", SqlDbType.Text).Value = valor_fecha;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = valor_centro;
                cmdcadena.Parameters.Add("@tec", SqlDbType.TinyInt).Value = tec;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.res_metricas metricas = new clases.res_metricas();
                    metricas.semana = lector["semana"].ToString();
                    metricas.empresa = lector["descripcion_contrata"].ToString();
                    metricas.metrica_cumplidas = float.Parse(lector["metrica_cumplidas"].ToString());
                    //metricas.metrica_garantias = float.Parse(lector["metrica_garantias"].ToString());
                    metricas.metrica_garantias_7d = float.Parse(lector["metrica_garantias_7d"].ToString());
                    //metricas.metrica_monitoreos = float.Parse(lector["metrica_monitoreos"].ToString());
                    metricas.metrica_diarias = float.Parse(lector["metrica_diarias"].ToString());
                    metricas.metrica_citas = float.Parse(lector["metrica_citas"].ToString());
                    metricas.metrica_presentismo = float.Parse(lector["metrica_presentismo"].ToString());
                    metricas.estrellas = float.Parse(lector["5 Estrellas"].ToString());
                    metricas.tecnologia = lector["tecno"].ToString();
                    metricas.fecha = lector["fecha"].ToString();
                    metricas.color = lector["color"].ToString();

                    lista_bar.Add(metricas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }

        [WebMethod]
        public void obtener_barras_historico(Int32 fecha, Int16 tecno, string valor_centro)
        {
            List<clases.barras> lista_bar = new List<clases.barras>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "metricas_consulta_anual @fecha, @tecno, @empresa";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@fecha", SqlDbType.SmallInt).Value = fecha;
                cmdcadena.Parameters.Add("@tecno", SqlDbType.TinyInt).Value = tecno;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = valor_centro;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.barras barritas = new clases.barras();
                    barritas.empresa = lector["Empresa"].ToString();
                    barritas.enero = Convert.ToSingle(lector["Enero"].ToString());
                    barritas.febrero = Convert.ToSingle(lector["Febrero"].ToString());
                    barritas.marzo = Convert.ToSingle(lector["Marzo"].ToString());
                    barritas.abril = Convert.ToSingle(lector["Abril"].ToString());
                    barritas.mayo = Convert.ToSingle(lector["Mayo"].ToString());
                    barritas.junio = Convert.ToSingle(lector["Junio"].ToString());
                    barritas.julio = Convert.ToSingle(lector["Julio"].ToString());
                    barritas.agosto = Convert.ToSingle(lector["Agosto"].ToString());
                    barritas.septiembre = Convert.ToSingle(lector["Septiembre"].ToString());
                    barritas.octubre = Convert.ToSingle(lector["Octubre"].ToString());
                    barritas.noviembre = Convert.ToSingle(lector["Noviembre"].ToString());
                    barritas.diciembre = Convert.ToSingle(lector["Diciembre"].ToString());
                    barritas.tecnologia = lector["tecno"].ToString();

                    lista_bar.Add(barritas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }

        [WebMethod]
        public void obtener_fechas_metrica_manual()
        {
            List<medallia.clases.combos> lista_cbo1 = new List<medallia.clases.combos>();

            string consulta = "select top 3 replace((dateadd(month,-2, Fecha)),'-','') as valor, left(dateadd(month,-2, Fecha), 7) as Fecha from metricas_ctta group by fecha order by fecha desc";

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(consulta, con);
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.combos combito = new medallia.clases.combos();

                    combito.valor = lector["valor"].ToString();
                    combito.texto = lector["Fecha"].ToString();

                    lista_cbo1.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo1));
        }

        [WebMethod]
        public void metrica_manual_lectura(Int16 opcion)
        {
            List<clases.combos> lista_metricas = new List<clases.combos>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "metricas_manual_lectura @opc";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opcion;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.combos fechas = new clases.combos();
                    fechas.texto = lector["Fecha"].ToString();
                    fechas.valor = lector["valor"].ToString();

                    lista_metricas.Add(fechas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_metricas));
        }

        [WebMethod]
        public void guarda_acelerador(float val, Int16 empresa, string fecha)
        {
            List<clases.combos> lista_metricas = new List<clases.combos>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "metricas_manual_guarda @valor, @ctta, @fecha";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@valor", SqlDbType.Float).Value = val;
                cmdcadena.Parameters.Add("@ctta", SqlDbType.TinyInt).Value = empresa;
                cmdcadena.Parameters.Add("@fecha", SqlDbType.Text).Value = fecha;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.combos fechas = new clases.combos();
                    fechas.texto = lector["text"].ToString();

                    lista_metricas.Add(fechas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_metricas));
        }

        [WebMethod]
        public void buscador_tecnicos(Int32 fecha, Int16 opc, string tecnico, Int16 ingreso)
        {
            List<clases.cbo_tecnico> lista = new List<clases.cbo_tecnico>();
            List<clases.res_busqueda> lista2 = new List<clases.res_busqueda>();

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;

                if (opc == 1)
                {
                    //cmdcadena.CommandText = "buscador_tecnico @tecnico";
                    cmdcadena.CommandText = "busca_tecnico @tecnico";
                    cmdcadena.CommandType = CommandType.Text;
                    cmdcadena.Parameters.Add("@tecnico", SqlDbType.Text).Value = tecnico;

                    cmdcadena.Connection = con;
                    con.Open();
                    SqlDataReader lector = cmdcadena.ExecuteReader();

                    while (lector.Read())
                    {
                        clases.cbo_tecnico res_tecnicos = new clases.cbo_tecnico();
                        res_tecnicos.ctta = lector["ctta"].ToString();
                        res_tecnicos.Nombre = lector["nombre"].ToString();
                        res_tecnicos.ID_TOA = lector["dni"].ToString();
                        res_tecnicos.ID_RECURSO = lector["id_tecnico"].ToString();
                        res_tecnicos.activo = lector["activo"].ToString();
                        res_tecnicos.Ingresante = lector["Ingresante"].ToString();

                        lista.Add(res_tecnicos);
                    }
                    con.Close();

                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(lista));
                }

                else if (ingreso == 1)
                {
                    cmdcadena.CommandText = "mon_busca_tecnico @id_recurso";
                    cmdcadena.CommandType = CommandType.Text;
                    cmdcadena.Parameters.Add("@id_recurso", SqlDbType.SmallInt).Value = Convert.ToInt32(tecnico);

                    cmdcadena.Connection = con;
                    con.Open();
                    SqlDataReader lector = cmdcadena.ExecuteReader();

                    while (lector.Read())
                    {
                        clases.res_busqueda res_tecnicos = new clases.res_busqueda();
                        res_tecnicos.tecnico = lector["nombre"].ToString();
                        res_tecnicos.id_recurso = Convert.ToInt32(lector["id_recurso"].ToString());
                        res_tecnicos.monitoreos = Convert.ToInt32(lector["monitoreos"].ToString());
                        res_tecnicos.calificacion = lector["Calificacion Promedio"].ToString();

                        lista2.Add(res_tecnicos);
                    }
                    con.Close();

                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(lista2));
                }
                else
                {
                    cmdcadena.CommandText = "metricas_consulta_tecnico @fecha, @tecno, @id_recurso";
                    cmdcadena.CommandType = CommandType.Text;
                    cmdcadena.Parameters.Add("@fecha", SqlDbType.Text).Value = fecha;
                    cmdcadena.Parameters.Add("@tecno", SqlDbType.TinyInt).Value = opc;
                    cmdcadena.Parameters.Add("@id_recurso", SqlDbType.SmallInt).Value = Convert.ToInt32(tecnico);

                    cmdcadena.Connection = con;
                    con.Open();
                    SqlDataReader lector = cmdcadena.ExecuteReader();

                    while (lector.Read())
                    {
                        clases.res_busqueda res_tecnicos = new clases.res_busqueda();
                        res_tecnicos.tecnico = lector["nombre"].ToString();
                        res_tecnicos.id_recurso = Convert.ToInt32(lector["id_recurso"].ToString());
                        res_tecnicos.instalaciones = Convert.ToInt32(lector["instalaciones"].ToString());
                        res_tecnicos.no_realizado = Convert.ToInt32(lector["no_realizado"].ToString());
                        res_tecnicos.suspendido = Convert.ToInt32(lector["suspendido"].ToString());
                        res_tecnicos.garantias = Convert.ToInt32(lector["garantias"].ToString());
                        res_tecnicos.garantias_7d = Convert.ToInt32(lector["garantias_7d"].ToString());
                        res_tecnicos.medallas = Convert.ToInt32(lector["medallias"].ToString());
                        res_tecnicos.monitoreos = Convert.ToInt32(lector["monitoreos"].ToString());
                        res_tecnicos.dias_trabajados = Convert.ToInt32(lector["dias_trabajados"].ToString());
                        res_tecnicos.produ = Convert.ToDecimal(lector["prom_inst_diarias"].ToString());
                        res_tecnicos.metrica_cumplidas = Convert.ToDecimal(lector["metrica_cumplidas"].ToString());
                        res_tecnicos.metrica_garantias = Convert.ToDecimal(lector["metrica_garantias"].ToString());
                        res_tecnicos.metrica_garantias_7d = Convert.ToDecimal(lector["metrica_garantias_7d"].ToString());
                        res_tecnicos.metrica_diarias = Convert.ToDecimal(lector["metrica_diarias"].ToString());
                        res_tecnicos.metrica_citas = Convert.ToDecimal(lector["metrica_citas"].ToString());
                        res_tecnicos.metrica_presentismo = Convert.ToDecimal(lector["metrica_presentismo"].ToString());
                        res_tecnicos.estrellas = Convert.ToDecimal(lector["5 Estrellas"].ToString());

                        lista2.Add(res_tecnicos);
                    }
                    con.Close();

                    JavaScriptSerializer js = new JavaScriptSerializer();
                    Context.Response.Write(js.Serialize(lista2));
                }
            }
        }

        [WebMethod]
        public void buscador_tecnicos_medallias(Int32 id_recurso)
        {
            List<clases.medallia_gestiones> lista_medallias = new List<clases.medallia_gestiones>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "buscador_tecnico_medallias @recurso";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@recurso", SqlDbType.Int).Value = id_recurso;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.medallia_gestiones resultados = new clases.medallia_gestiones();
                    resultados.id_caso = Convert.ToInt32(lector["id_caso"].ToString());
                    resultados.clooper = lector["usuario"].ToString();
                    resultados.id_encuesta = Convert.ToInt32(lector["id_encuesta"].ToString());
                    resultados.fecha_encuesta = lector["fecha_encuesta"].ToString();
                    resultados.fecha_mail = lector["fecha_mail"].ToString();
                    resultados.fecha_fin = lector["fecha_fin"].ToString();
                    resultados.accion_ejecutada = lector["Acción ejecutada"].ToString();
                    resultados.central = lector["Estado"].ToString();

                    lista_medallias.Add(resultados);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_medallias));
        }

        [WebMethod]
        public void barra_detracciones_por_altas(Int16 id_empresa, String fecha1, String fecha2, Int16 opc)
        {
            List<clases.metricas_detractores_instalaciones> lista_datos = new List<clases.metricas_detractores_instalaciones>();

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "metricas_detractores_altas @id_empresa, @fecha1, @fecha2, @opc";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@id_empresa", SqlDbType.TinyInt).Value = id_empresa;
                cmdcadena.Parameters.Add("@fecha1", SqlDbType.Text).Value = fecha1;
                cmdcadena.Parameters.Add("@fecha2", SqlDbType.Text).Value = fecha2;
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opc;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.metricas_detractores_instalaciones resultados = new clases.metricas_detractores_instalaciones();
                    if (opc == 1)
                    {
                        resultados.empresa = lector["Empresa"].ToString();
                        resultados.instalaciones = Convert.ToInt32(lector["Instalados"].ToString());
                        resultados.cantidad = Convert.ToInt32(lector["casos"].ToString());
                        resultados.porcentaje = Convert.ToSingle(lector["Porcentaje"].ToString());
                    }
                    if (opc == 2)
                    {
                        resultados.empresa = lector["region"].ToString();
                        resultados.instalaciones = Convert.ToInt32(lector["Instalados"].ToString());
                        resultados.cantidad = Convert.ToInt32(lector["casos"].ToString());
                        resultados.porcentaje = Convert.ToSingle(lector["Porcentaje"].ToString());
                    }
                    if (opc == 3)
                    {
                        resultados.empresa = lector["Segmento"].ToString();
                        resultados.instalaciones = Convert.ToInt32(lector["Instalados"].ToString());
                        resultados.cantidad = Convert.ToInt32(lector["casos"].ToString());
                        resultados.porcentaje = Convert.ToSingle(lector["Porcentaje"].ToString());
                    }
                    if (opc == 4)
                    {
                        resultados.empresa = lector["tecnologia"].ToString();
                        resultados.instalaciones = Convert.ToInt32(lector["Instalados"].ToString());
                        resultados.cantidad = Convert.ToInt32(lector["casos"].ToString());
                        //resultados.instalaciones = Convert.ToInt32(lector["total"].ToString());
                        resultados.porcentaje = Convert.ToSingle(lector["Porcentaje"].ToString());
                    }
                    if (opc == 5)
                    {
                        resultados.empresa = lector["localidad"].ToString();
                        resultados.instalaciones = Convert.ToInt32(lector["Instalados"].ToString());
                        resultados.cantidad = Convert.ToInt32(lector["casos"].ToString());
                        resultados.porcentaje = Convert.ToSingle(lector["Porcentaje"].ToString());
                    }

                    lista_datos.Add(resultados);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_datos));
        }

        [WebMethod]
        public void barra_detracciones_por_accion(Int16 id_empresa, String fecha1, String fecha2, Int16 opc)
        {
            List<clases.metricas_detractores_instalaciones> lista_datos = new List<clases.metricas_detractores_instalaciones>();

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "metricas_detractores_accion @id_empresa, @fecha1, @fecha2, @opc";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@id_empresa", SqlDbType.TinyInt).Value = id_empresa;
                cmdcadena.Parameters.Add("@fecha1", SqlDbType.Text).Value = fecha1;
                cmdcadena.Parameters.Add("@fecha2", SqlDbType.Text).Value = fecha2;
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opc;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.metricas_detractores_instalaciones resultados = new clases.metricas_detractores_instalaciones();
                    if (opc == 1)
                    {
                        resultados.empresa = lector["Accion_ejecutada"].ToString();
                        resultados.cantidad = Convert.ToInt32(lector["casos"].ToString());
                        resultados.instalaciones = Convert.ToInt32(lector["totales"].ToString());
                        resultados.porcentaje = Convert.ToSingle(lector["Porcentaje"].ToString());
                    }
                    if (opc == 2)
                    {
                        resultados.empresa = lector["region_mop"].ToString();
                        resultados.cantidad = Convert.ToInt32(lector["casos"].ToString());
                        resultados.instalaciones = Convert.ToInt32(lector["totales"].ToString());
                        resultados.porcentaje = Convert.ToSingle(lector["Porcentaje"].ToString());
                    }
                    if (opc == 3)
                    {
                        resultados.empresa = lector["Segmento"].ToString();
                        resultados.cantidad = Convert.ToInt32(lector["casos"].ToString());
                        resultados.instalaciones = Convert.ToInt32(lector["totales"].ToString());
                        resultados.porcentaje = Convert.ToSingle(lector["Porcentaje"].ToString());
                    }
                    if (opc == 4)
                    {
                        resultados.empresa = lector["tecnologia"].ToString();
                        resultados.cantidad = Convert.ToInt32(lector["casos"].ToString());
                        resultados.instalaciones = Convert.ToInt32(lector["totales"].ToString());
                        resultados.porcentaje = Convert.ToSingle(lector["Porcentaje"].ToString());
                    }
                    if (opc == 5)
                    {
                        resultados.empresa = lector["localidad"].ToString();
                        resultados.cantidad = Convert.ToInt32(lector["casos"].ToString());
                        resultados.instalaciones = Convert.ToInt32(lector["totales"].ToString());
                        resultados.porcentaje = Convert.ToSingle(lector["Porcentaje"].ToString());
                    }

                    lista_datos.Add(resultados);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_datos));
        }
    }
}

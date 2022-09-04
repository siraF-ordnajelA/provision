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
    /// Summary description for servicios_monitoreos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class servicios_monitoreos : System.Web.Services.WebService
    {

        String cadena = "Data Source=10.249.15.194\\DATAFLOW; Initial Catalog=TELEGESTION; User ID=telegestion; Password=telefonica"; //CONEXION CON USUARIO Y CONTRASEÑA
        //String cadena = "Data Source=10.244.89.164; Initial Catalog=TELEGESTION; Integrated Security=SSPI"; //CONEXION CON CREDENCIALES DE RED
        
        [WebMethod]
        public void obtener_contratas()
        {
            List<medallia.clases.cbo_tecnico> lista_cbo1 = new List<medallia.clases.cbo_tecnico>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("lista_contratas", con);//PROCEDIMIENTO ALMACENADO
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.cbo_tecnico combito = new medallia.clases.cbo_tecnico();
                    combito.Nombre = lector["ctta"].ToString(); //COMBITO.ID ES EL ELEMENTO DE SERVICIO COMBITO. Y LO QUE VA EN COMILLAS DOBLES ES LA COLUMNA DE LA TABLA

                    lista_cbo1.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo1));
        }

        [WebMethod]
        public void obtener_tecnicos()
        {
            List<medallia.clases.cbo_tecnico> lista_cbo1 = new List<medallia.clases.cbo_tecnico>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("lista_tecnicos", con);//PROCEDIMIENTO ALMACENADO
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.cbo_tecnico combito = new medallia.clases.cbo_tecnico();
                    combito.ctta = lector["CTTA"].ToString();
                    combito.Nombre = lector["Nombre"].ToString();
                    combito.ID_TOA = lector["ID_TOA"].ToString();
                    combito.ID_RECURSO = lector["ID_RECURSO"].ToString(); //COMBITO.ID ES EL ELEMENTO DE SERVICIO COMBITO. Y LO QUE VA EN COMILLAS DOBLES ES LA COLUMNA DE LA TABLA

                    lista_cbo1.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo1));
        }

        [WebMethod]
        public void obtener_dato_tecnico(string id_toa)
        {
            List<medallia.clases.cbo_tecnico> lista_cbo2 = new List<medallia.clases.cbo_tecnico>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("obtener_tecnico", con);//PROCEDIMIENTO ALMACENADO
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter parametro = new SqlParameter()
                {
                    ParameterName = "@id_recu",//NOMBRE DE LA VARIABLE EN SQL
                    Value = id_toa
                };
                cmd.Parameters.Add(parametro);

                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.cbo_tecnico combito = new medallia.clases.cbo_tecnico();
                    combito.ctta = lector["CTTA"].ToString();
                    combito.ID_TOA = lector["ID_TOA"].ToString();
                    lista_cbo2.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo2));
        }

        [WebMethod]
        public void guardar(Int16 opcion, int id_pend, int usuario, int tecnico, string f_manual, string ap_tecnico, string nom_tecnico, string dni_tec, string empresa_tecnico, Int16 campo, Int16 credencial, Int16 equipo, Int16 cita, Int16 vehiculo_estado, Int16 vehiculo_identif, Int16 vehiculo_escalera, Int16 vehiculo_porta, string vehiculo_patente, Int16 contex_insta, Int16 kit_sano, Int16 epp, Int16 vestimenta, Int16 metodo, Int16 drop_plano, Int16 drop_circular, string obs, Int16 mobbi, Int16 mobbi20, Int16 whop, Int16 pdr, Int16 qr, Int16 analizer, Int16 smart, Int16 kevlar, Int16 cleaver, Int16 pw, Int16 triple, Int16 drop, Int16 alcohol, Int16 panios, Int16 laser, Int16 mobbi1_inst, Int16 mobbi20_inst, Int16 whop_inst, Int16 qr_inst, Int16 pdr_inst, Int16 analizer_inst, Int16 smart_inst, Int16 iptv, Int16 hgu, Int16 voip, Int16 alicate, Int16 pinzas, Int16 destornilla, Int16 aguj, Int16 micro, Int16 interna, Int16 ficha, Int16 filtro, Int16 martillo, Int16 pela_cable, Int16 alargue, Int16 res_final)
        {
            //ACA VA LA CARGA DEL NO CONTACTADO
            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = @"carga_monitoreo @opcion,
                                                        @id_pendiente,
                                                        @usuario,
                                                        @tecnico,
                                                        @f_manual,
                                                        @ap_tecnico,
                                                        @nom_tecnico,
                                                        @dni_tecnico,
                                                        @empre_tecnico,
                                                        @campo,
                                                        @credencial,
                                                        @equipo,
                                                        @valcita,
                                                        @vehiculo_estado,
                                                        @vehiculo_identif,
                                                        @vehiculo_escalera,
                                                        @vehiculo_porta,
                                                        @vehiculo_patente,
                                                        @contex_insta,
                                                        @kit_sano,
                                                        @epp,
                                                        @vestimenta,
                                                        @metodo,
                                                        @drop_plano,
                                                        @drop_circular,
                                                        @obs,
                                                        @mobbi,
                                                        @mobbi20,
                                                        @whop,
                                                        @pdr,
                                                        @qr,
                                                        @analizer,
                                                        @smart,
                                                        @kevlar,
                                                        @cleaver,
                                                        @pw,
                                                        @triple,
                                                        @drop,
                                                        @alcohol,
                                                        @panios,
                                                        @laser,
                                                        @mobbi_insta,
                                                        @mobbi20_insta,
                                                        @whop_insta,
                                                        @qr_insta,
                                                        @pdr_insta,
                                                        @analizer_insta,
                                                        @smart_insta,
                                                        @iptv,
                                                        @hgu,
                                                        @voip,
                                                        @alicate,
                                                        @pinzas,
                                                        @destornilla,
                                                        @agu,
                                                        @micro,
                                                        @interna,
                                                        @ficha,
                                                        @filtro,
                                                        @martillo,
                                                        @pela_cable,
                                                        @alargue,
                                                        @calificacione";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            cmdcadena.Parameters.Add("@opcion", SqlDbType.TinyInt).Value = opcion;
            cmdcadena.Parameters.Add("@id_pendiente", SqlDbType.Int).Value = id_pend;
            cmdcadena.Parameters.Add("@usuario", SqlDbType.SmallInt).Value = usuario;
            cmdcadena.Parameters.Add("@tecnico", SqlDbType.SmallInt).Value = tecnico;
            cmdcadena.Parameters.Add("@campo", SqlDbType.TinyInt).Value = campo;
            cmdcadena.Parameters.Add("@credencial", SqlDbType.TinyInt).Value = credencial;
            cmdcadena.Parameters.Add("@equipo", SqlDbType.TinyInt).Value = equipo;
            cmdcadena.Parameters.Add("@valcita", SqlDbType.TinyInt).Value = cita;
            //cmdcadena.Parameters.Add("@vehiculo", SqlDbType.TinyInt).Value = vehiculo;
            //VEHICULO
            cmdcadena.Parameters.Add("@vehiculo_estado", SqlDbType.TinyInt).Value = vehiculo_estado;
            cmdcadena.Parameters.Add("@vehiculo_identif", SqlDbType.TinyInt).Value = vehiculo_identif;
            cmdcadena.Parameters.Add("@vehiculo_escalera", SqlDbType.TinyInt).Value = vehiculo_escalera;
            cmdcadena.Parameters.Add("@vehiculo_porta", SqlDbType.TinyInt).Value = vehiculo_porta;
            cmdcadena.Parameters.Add("@vehiculo_patente", SqlDbType.Text).Value = vehiculo_patente;
            //CONTEXTO DE INSTALACION Y KIT DE SANIDAD
            cmdcadena.Parameters.Add("@contex_insta", SqlDbType.TinyInt).Value = contex_insta;
            cmdcadena.Parameters.Add("@kit_sano", SqlDbType.TinyInt).Value = kit_sano;

            cmdcadena.Parameters.Add("@epp", SqlDbType.TinyInt).Value = epp;
            cmdcadena.Parameters.Add("@vestimenta", SqlDbType.TinyInt).Value = vestimenta;
            cmdcadena.Parameters.Add("@metodo", SqlDbType.TinyInt).Value = metodo;
            cmdcadena.Parameters.Add("@drop_plano", SqlDbType.TinyInt).Value = drop_plano;
            cmdcadena.Parameters.Add("@drop_circular", SqlDbType.TinyInt).Value = drop_circular;
            cmdcadena.Parameters.Add("@obs", SqlDbType.Text).Value = obs;
            //CHECKBOX TECNICO INGRESO NUEVO
            cmdcadena.Parameters.Add("@f_manual", SqlDbType.Text).Value = f_manual;
            cmdcadena.Parameters.Add("@ap_tecnico", SqlDbType.Text).Value = ap_tecnico;
            cmdcadena.Parameters.Add("@nom_tecnico", SqlDbType.Text).Value = nom_tecnico;
            cmdcadena.Parameters.Add("@dni_tecnico", SqlDbType.Text).Value = dni_tec;
            cmdcadena.Parameters.Add("@empre_tecnico", SqlDbType.Text).Value = empresa_tecnico;
            //ESTOS SON LOS VALORES DE LOS RADIO BUTTONS
            //Conocimiento uso APP
            //cmdcadena.Parameters.Add("@nd", SqlDbType.SmallInt).Value = Convert.ToInt16(nd);
            cmdcadena.Parameters.Add("@mobbi", SqlDbType.TinyInt).Value = mobbi;
            cmdcadena.Parameters.Add("@mobbi20", SqlDbType.TinyInt).Value = mobbi20;
            cmdcadena.Parameters.Add("@whop", SqlDbType.TinyInt).Value = whop;
            cmdcadena.Parameters.Add("@pdr", SqlDbType.TinyInt).Value = pdr;
            cmdcadena.Parameters.Add("@qr", SqlDbType.TinyInt).Value = qr;
            //cmdcadena.Parameters.Add("@sptest", SqlDbType.TinyInt).Value = sptest;
            cmdcadena.Parameters.Add("@analizer", SqlDbType.TinyInt).Value = analizer;
            cmdcadena.Parameters.Add("@smart", SqlDbType.TinyInt).Value = smart;
            //Herramientas Kit Fibra
            cmdcadena.Parameters.Add("@kevlar", SqlDbType.TinyInt).Value = kevlar;
            cmdcadena.Parameters.Add("@cleaver", SqlDbType.TinyInt).Value = cleaver;
            cmdcadena.Parameters.Add("@pw", SqlDbType.TinyInt).Value = pw;
            cmdcadena.Parameters.Add("@triple", SqlDbType.TinyInt).Value = triple;
            cmdcadena.Parameters.Add("@drop", SqlDbType.TinyInt).Value = drop;
            cmdcadena.Parameters.Add("@alcohol", SqlDbType.TinyInt).Value = alcohol;
            cmdcadena.Parameters.Add("@panios", SqlDbType.TinyInt).Value = panios;
            cmdcadena.Parameters.Add("@laser", SqlDbType.TinyInt).Value = laser;
            //APP Instaladas
            cmdcadena.Parameters.Add("@mobbi_insta", SqlDbType.TinyInt).Value = mobbi1_inst;
            cmdcadena.Parameters.Add("@mobbi20_insta", SqlDbType.TinyInt).Value = mobbi20_inst;
            cmdcadena.Parameters.Add("@whop_insta", SqlDbType.TinyInt).Value = whop_inst;
            cmdcadena.Parameters.Add("@qr_insta", SqlDbType.TinyInt).Value = qr_inst;
            cmdcadena.Parameters.Add("@pdr_insta", SqlDbType.TinyInt).Value = pdr_inst;
            cmdcadena.Parameters.Add("@analizer_insta", SqlDbType.TinyInt).Value = analizer_inst;
            cmdcadena.Parameters.Add("@smart_insta", SqlDbType.TinyInt).Value = smart_inst;
            //Procesos
            cmdcadena.Parameters.Add("@iptv", SqlDbType.TinyInt).Value = iptv;
            cmdcadena.Parameters.Add("@hgu", SqlDbType.TinyInt).Value = hgu;
            cmdcadena.Parameters.Add("@voip", SqlDbType.TinyInt).Value = voip;
            //Cobre adaptación
            cmdcadena.Parameters.Add("@alicate", SqlDbType.TinyInt).Value = alicate;
            cmdcadena.Parameters.Add("@pinzas", SqlDbType.TinyInt).Value = pinzas;
            cmdcadena.Parameters.Add("@destornilla", SqlDbType.TinyInt).Value = destornilla;
            cmdcadena.Parameters.Add("@agu", SqlDbType.TinyInt).Value = aguj;
            cmdcadena.Parameters.Add("@micro", SqlDbType.TinyInt).Value = micro;
            cmdcadena.Parameters.Add("@interna", SqlDbType.TinyInt).Value = interna;
            cmdcadena.Parameters.Add("@ficha", SqlDbType.TinyInt).Value = ficha;
            cmdcadena.Parameters.Add("@filtro", SqlDbType.TinyInt).Value = filtro;
            cmdcadena.Parameters.Add("@martillo", SqlDbType.TinyInt).Value = martillo;
            cmdcadena.Parameters.Add("@pela_cable", SqlDbType.TinyInt).Value = pela_cable;
            cmdcadena.Parameters.Add("@alargue", SqlDbType.TinyInt).Value = alargue;
            //Calificación Final
            cmdcadena.Parameters.Add("@calificacione", SqlDbType.TinyInt).Value = res_final;

            conexion.Open();
            cmdcadena.ExecuteNonQuery();
            conexion.Close();
        }

        [WebMethod]
        public void busca_tecnico(string tecnico)
        {
            List<medallia.clases.cbo_tecnico> lista_cbo2 = new List<medallia.clases.cbo_tecnico>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("busca_tecnico", con);//PROCEDIMIENTO ALMACENADO
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter parametro = new SqlParameter()
                {
                    ParameterName = "@tec",//NOMBRE DE LA VARIABLE EN SQL
                    Value = tecnico
                };
                cmd.Parameters.Add(parametro);

                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.cbo_tecnico combito = new medallia.clases.cbo_tecnico();
                    combito.ID_RECURSO = lector["id_tecnico"].ToString();
                    combito.Nombre = lector["nombre"].ToString();
                    combito.ctta = lector["ctta"].ToString();
                    combito.ID_TOA = lector["dni"].ToString();
                    combito.Ingresante = lector["Ingresante"].ToString();
                    lista_cbo2.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo2));
        }

        [WebMethod]
        public void busca_tecnico2(string tecnico)
        {
            List<medallia.clases.res_busqueda> lista_res = new List<medallia.clases.res_busqueda>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand("mon_busca_tecnico", con);//PROCEDIMIENTO ALMACENADO
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter parametro = new SqlParameter()
                {
                    ParameterName = "@tecnico",//NOMBRE DE LA VARIABLE EN SQL
                    Value = tecnico
                };
                cmd.Parameters.Add(parametro);

                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.res_busqueda combito = new medallia.clases.res_busqueda();
                    combito.id_recurso = Convert.ToInt32(lector["id_recurso"]);
                    combito.tecnico = lector["Nombre"].ToString();
                    combito.monitoreos = Convert.ToInt32(lector["Monitoreos"]);
                    combito.calificacion = lector["Calificacion Promedio"].ToString();
                    lista_res.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_res));
        }

        [WebMethod]
        public void detalle_tecnico1(int tecnico)
        {
            List<medallia.clases.res_busqueda> lista_res = new List<medallia.clases.res_busqueda>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(@"select cast([Fecha de carga] as date) as Fecha, [Resultado Final] from mon_lista_gestionados_tecnico
                                                    where id_recurso = " + tecnico + " order by [Fecha de carga] desc", con);
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader lector = cmd.ExecuteReader();
                while (lector.Read())
                {
                    medallia.clases.res_busqueda combito = new medallia.clases.res_busqueda();

                    combito.fecha_inicio = lector["Fecha"].ToString();
                    combito.calificacion = lector["Resultado Final"].ToString();

                    lista_res.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_res));
        }

        [WebMethod]
        public void detalle_tecnico2(string fecha, int tecnico)
        {
            List<medallia.clases.detalle> lista_cbo1 = new List<medallia.clases.detalle>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "mon_lista_busqueda_gestion @tecnico, @fecha";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@tecnico", SqlDbType.Int).Value = tecnico;
                cmdcadena.Parameters.Add("@fecha", SqlDbType.Text).Value = fecha;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.detalle combito = new medallia.clases.detalle();
                    //DATOS DEL MONITOREO
                    combito.fecha = lector["Fecha de carga"].ToString();
                    combito.monitor = lector["Usuario auditor"].ToString();
                    combito.motivo = lector["Motivo Calibración"].ToString();
                    combito.cito = lector["Monitoreo realizado"].ToString();
                    combito.contexto = lector["Contexto"].ToString();
                    //DATOS DEL TECNICO
                    combito.tecnico = lector["Nombre del Tecnico"].ToString();
                    combito.ingresante = Convert.ToInt16(lector["Ingresante"]);
                    combito.contratista = lector["Contratista"].ToString();
                    combito.dni = lector["DNI"].ToString();
                    combito.credencial = lector["Credencial"].ToString();
                    combito.celular = lector["Equipo Cel."].ToString();
                    //VEHICULO
                    combito.vehiculo = lector["Estado del Vehiculo"].ToString();
                    combito.escalera = lector["Escalera"].ToString();
                    combito.porta_escalera = lector["Porta escalera"].ToString();
                    combito.identificacion = lector["Identificacion"].ToString();
                    combito.patente = lector["Patente"].ToString();
                    combito.kit_sanidad = lector["KIT de sanidad"].ToString();
                    combito.presencia = lector["Vestimenta"].ToString();
                    combito.epp = lector["EPP"].ToString();
                    //CONOCIMIENTO USO - APPS
                    //combito.mobbi = lector["Conocimiento uso - Mobbi"].ToString();
                    combito.mobbi2 = lector["Conocimiento uso - Mobbi 2.0"].ToString();
                    //combito.whop = lector["Conocimiento uso - Whop"].ToString();
                    combito.pdr = lector["Conocimiento uso - PDR"].ToString();
                    combito.qr = lector["Conocimiento uso - Escaner QR"].ToString();
                    combito.wifianalizer = lector["Conocimiento uso - WiFi analizer"].ToString();
                    combito.smartwifi = lector["Conocimiento uso - Smart WiFi"].ToString();
                    //APPS INSTALADAS
                    //combito.insta_mobbi = lector["APP instaladas - Mobbi"].ToString();
                    combito.insta_mobbi2 = lector["APP instaladas - Mobbi 2.0"].ToString();
                    //combito.insta_whop = lector["APP instaladas - Whop"].ToString();
                    combito.insta_pdr = lector["APP instaladas - PDR"].ToString();
                    combito.insta_qr = lector["APP instaladas - Lector QR"].ToString();
                    combito.insta_wifianalizer = lector["APP instaladas - WiFi Analizer"].ToString();
                    //combito.insta_smartwifi = lector["APP instaladas - Smart WiFi"].ToString();
                    //HERRAMIENTAS KIT FIBRA
                    combito.tijeras = lector["Herramientas Kit Fibra - Tijera Kevlar"].ToString();
                    combito.cleaver = lector["Herramientas Kit Fibra - Cortadora Cleaver"].ToString();
                    combito.powermeter = lector["Herramientas Kit Fibra - Power Meter"].ToString();
                    combito.triple = lector["Herramientas Kit Fibra - Pinza peladora triple ranura"].ToString();
                    combito.peladora = lector["Herramientas Kit Fibra - Peladora Drop rect"].ToString();
                    combito.alcohol = lector["Herramientas Kit Fibra - Alcohol"].ToString();
                    combito.panios = lector["Herramientas Kit Fibra - Paños"].ToString();
                    combito.linterna = lector["Herramientas Kit Fibra - Linterna láser"].ToString();
                    //PROCESOS
                    combito.iptv = lector["Procesos - IPTV"].ToString();
                    combito.hgu = lector["Procesos - HGU"].ToString();
                    combito.voip = lector["Procesos - VoIp"].ToString();
                    //COBRE ADAPTACION
                    combito.alicate = lector["Cobre adaptación VoIp - Alicate"].ToString();
                    combito.pinzas = lector["Cobre adaptación VoIp - Pinzas"].ToString();
                    combito.destornilla = lector["Cobre adaptación VoIp - Destornillador"].ToString();
                    combito.agujereadora = lector["Cobre adaptación VoIp - Agujereadora/Mechas"].ToString();
                    combito.micro = lector["Cobre adaptación VoIp - Microteléfono"].ToString();
                    combito.cable_int = lector["Cobre adaptación VoIp - Cable inst. interna"].ToString();
                    combito.americana = lector["Cobre adaptación VoIp - Ficha americana"].ToString();
                    combito.filtros = lector["Cobre adaptación VoIp - Filtros combinado"].ToString();
                    combito.martillo = lector["Cobre adaptación VoIp - Martillo"].ToString();
                    combito.pela_cable = lector["Cobre adaptación VoIp - Pela cable"].ToString();
                    combito.alargue = lector["Cobre adaptación VoIp - Alargue"].ToString();
                    //ARMADO DE CONECTORES
                    combito.drop_metodo = lector["Método constructivo"].ToString();
                    combito.drop_plano = lector["Drop plano"].ToString();
                    combito.drop_circular = lector["Drop circular"].ToString();

                    combito.obs = lector["observaciones"].ToString();
                    combito.calificacion = lector["Resultado Final"].ToString();

                    lista_cbo1.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cbo1));
        }

        [WebMethod]
        public void monitoreos_lista_pendiente(Int16 opcion)
        {
            List<medallia.clases.monitoreos_pendiente> lista_cerrados = new List<medallia.clases.monitoreos_pendiente>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "mon_lista_pendiente @opc";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opcion;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.monitoreos_pendiente combito = new medallia.clases.monitoreos_pendiente();
                    combito.id_pendiente = Convert.ToInt32(lector["id_pendiente"]);
                    combito.id_medallia = Convert.ToInt32(lector["id_medallia"]);
                    combito.id_encuesta = Convert.ToInt64(lector["id_encuesta"]);
                    combito.id_clooper = Convert.ToInt32(lector["id_usuario"]);
                    combito.clooper = lector["clooper"].ToString();
                    combito.id_recurso = Convert.ToInt32(lector["id_recurso"]);
                    combito.tecnico = lector["nombre"].ToString();
                    combito.empresa = lector["ctta"].ToString();
                    combito.dni = lector["dni"].ToString();
                    combito.fecha_ingreso = lector["fyhingreso"].ToString();
                    combito.observaciones = lector["observaciones"].ToString();
                    combito.observaciones_ctta = lector["obs_ctta"].ToString();
                    combito.bandera = lector["bandera"].ToString();

                    lista_cerrados.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cerrados));
        }

        [WebMethod]
        public void monitoreos_devuelve_medallia(int id_medallia, int id_monitoreo)
        {
            //ACA VA LA CARGA DEL NO CONTACTADO
            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = "mon_devuelve_a_medallia @id_gest, @id_mon";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            cmdcadena.Parameters.Add("@id_gest", SqlDbType.Int).Value = id_medallia;
            cmdcadena.Parameters.Add("@id_mon", SqlDbType.Int).Value = id_monitoreo;

            conexion.Open();
            cmdcadena.ExecuteNonQuery();
            conexion.Close();
        }

        [WebMethod]
        public void monitoreos_lista_noaptos(Int16 opcion, string empresa)
        {
            List<medallia.clases.monitoreos_pendiente> lista_cerrados = new List<medallia.clases.monitoreos_pendiente>();
            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "mon_lista_resultados @opc, @empresa";
                cmdcadena.CommandType = CommandType.Text;
                cmdcadena.Parameters.Add("@opc", SqlDbType.TinyInt).Value = opcion;
                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = empresa;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    medallia.clases.monitoreos_pendiente combito = new medallia.clases.monitoreos_pendiente();
                    combito.id_pendiente = Convert.ToInt32(lector["id_gestion"]);
                    combito.bandera = lector["fyhgestion"].ToString();
                    combito.fecha_ingreso = lector["fyhmonitoreo"].ToString();
                    combito.clooper = lector["Usuario Auditor"].ToString();
                    combito.id_clooper = Convert.ToInt32(lector["id_recurso"]);
                    combito.tecnico = lector["Nombre del Tecnico"].ToString();
                    combito.dni = lector["dni"].ToString();
                    combito.id_recurso = Convert.ToInt32(lector["ingresante"]);
                    combito.empresa = lector["Contratista"].ToString();
                    combito.observaciones = lector["Motivo Calibración"].ToString();

                    lista_cerrados.Add(combito);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_cerrados));
        }

        [WebMethod]
        public void monitoreos_ok_ctta (int id_gestion, string comentario)
        {
            //ACA VA LA CARGA DEL NO CONTACTADO
            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = "mon_confirma_ok_ctta @id_gest, @coment";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            cmdcadena.Parameters.Add("@id_gest", SqlDbType.Int).Value = id_gestion;
            cmdcadena.Parameters.Add("@coment", SqlDbType.Text).Value = comentario;

            conexion.Open();
            cmdcadena.ExecuteNonQuery();
            conexion.Close();
        }

        [WebMethod]
        public void monitoreos_carga_manual(int id_usr, int tecnico, string obs)
        {
            SqlConnection conexion = new SqlConnection(cadena);
            SqlCommand cmdcadena = new SqlCommand();
            cmdcadena.CommandType = CommandType.StoredProcedure;
            cmdcadena.CommandText = "mon_ingreso_manual @id_user, @id_recurso, @observa";
            cmdcadena.Connection = conexion;

            cmdcadena.CommandType = CommandType.Text;

            cmdcadena.Parameters.Add("@id_user", SqlDbType.Int).Value = id_usr;
            cmdcadena.Parameters.Add("@id_recurso", SqlDbType.Int).Value = tecnico;
            cmdcadena.Parameters.Add("@observa", SqlDbType.Text).Value = obs;

            conexion.Open();
            cmdcadena.ExecuteNonQuery();
            conexion.Close();
        }

        [WebMethod]
        public void monitoreo_dibuja_grafico1(Int16 opc, string valor_centro, string fecha1, string fecha2)
        {
            List<clases.cbo_tecnico> lista_bar = new List<clases.cbo_tecnico>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "mon_indicadores_1 @opc, @empresa, @f1, @f2";
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
                    barritas.Nombre = lector["Nombre"].ToString(); // EMPRESA O TECNICO
                    barritas.ctta = lector["valor1"].ToString(); // CASOS MEDALLIA O APTO
                    barritas.Ingresante = lector["valor2"].ToString(); // TECNICOS INGRESANTE O NO APTO
                    barritas.ID_TOA = lector["valor3"].ToString(); // TECNICOS TRABAJANDO O PROVISORIO

                    lista_bar.Add(barritas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }

        [WebMethod]
        public void monitoreo_dibuja_grafico2(string valor_centro, string fecha1, string fecha2)
        {
            List<clases.cbo_tecnico> lista_bar = new List<clases.cbo_tecnico>();//LLAMO A LA CLASE CORRESPONDIENTE

            using (SqlConnection con = new SqlConnection(cadena))
            {
                SqlCommand cmdcadena = new SqlCommand();
                cmdcadena.CommandType = CommandType.StoredProcedure;
                cmdcadena.CommandText = "mon_indicadores_1 3, @empresa, @f1, @f2";
                cmdcadena.CommandType = CommandType.Text;

                cmdcadena.Parameters.Add("@empresa", SqlDbType.Text).Value = valor_centro;
                cmdcadena.Parameters.Add("@f1", SqlDbType.Text).Value = fecha1;
                cmdcadena.Parameters.Add("@f2", SqlDbType.Text).Value = fecha2;

                cmdcadena.Connection = con;
                con.Open();
                SqlDataReader lector = cmdcadena.ExecuteReader();

                while (lector.Read())
                {
                    clases.cbo_tecnico barritas = new clases.cbo_tecnico();
                    barritas.ctta = lector["ctta"].ToString();
                    barritas.Ingresante = lector["monitoreos"].ToString(); // Cantidad de monitoreos
                    barritas.ID_TOA = lector["tecnicos"].ToString(); // Cantidad de técnicos

                    lista_bar.Add(barritas);
                }
                con.Close();
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(lista_bar));
        }
    }
}

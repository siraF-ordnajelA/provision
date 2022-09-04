using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace medallia.clases
{
    public class medallia_gestiones
    {
        public int id_caso { get; set; }
        public Int16 motivo { get; set; }
        public Int16 contexto { get; set; }
        public Int16 id_clooper { get; set; }
        public string clooper { get; set; }
        public Int64 id_cliente { get; set; }
        public int id_encuesta { get; set; }
        public string segmento { get; set; }
        public string tecnologia { get; set; }
        public string fecha_encuesta { get; set; }
        public string fecha_mail { get; set; }
        public string fecha_fin { get; set; }
        public Int32 id_recurso { get; set; }
        public string nombre_tecnico { get; set; }
        public string dni_tecnico { get; set; }
        public string nombre_cliente { get; set; }
        public string direccion { get; set; }
        public string localidad { get; set; }
        public string contacto { get; set; }
        public string nro_orden { get; set; }
        public string access { get; set; }
        public string bucket { get; set; }
        public string ctta { get; set; }
        public Int16 nps { get; set; }
        public Int16 tecnico { get; set; }
        public Int16 puntualidad { get; set; }
        public Int16 profesionalidad { get; set; }
        public Int16 conocimiento { get; set; }
        public Int16 calidad { get; set; }
        public Int16 comunicacion { get; set; }
        public Int16 mot_detractor { get; set; }
        public Int16 id_concepto { get; set; }
        public string concepto { get; set; }
        public Int16 id_subconcepto { get; set; }
        public string subconcepto { get; set; }
        public Int16 id_detalle { get; set; }
        public string detalle { get; set; }
        public Int16 accion { get; set; }
        public string accion_ejecutada { get; set; }
        public Int16 estado { get; set; }
        public string comentarios_cliente { get; set; }
        public Int16 resp_cliente { get; set; }
        public Int16 resp_final_cliente { get; set; }
        public string resp_supervisor { get; set; }
        public Int16 id_resp_sup { get; set; }
        public string serial_anterior { get; set; }
        public string serial_actual { get; set; }
        public Int16 id_accion_clooper { get; set; }
        public string resp_clooper { get; set; }
        public Int16 reagenda { get; set; }
        public Int32 id_central { get; set; }
        public string gerencia { get; set; }
        public string distrito_atc { get; set; }
        public string central { get; set; }
    }
}
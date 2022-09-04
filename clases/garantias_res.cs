using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace medallia.clases
{
    public class garantias_res
    {
        public Int32 id_recurso { get; set; }
        public string tecnico { get; set; }
        public string ctta { get; set; }
        public string subtipo_actividad { get; set; }
        public string peticion { get; set; }
        public string nro_orden { get; set; }
        public string access { get; set; }
        public string Sintoma { get; set; }
        public Int32 id_central { get; set; }
        public string central { get; set; }
        public string distrito { get; set; }
        public string gerencia { get; set; }
        public string agrupacion { get; set; }
        public string bucket { get; set; }
        public string fecha_toa { get; set; }
        public string fecha_cierre { get; set; }
        public string estado { get; set; }
        public string segmento { get; set; }
        public string multiproducto { get; set; }
        public string tecno { get; set; }
        public Int64 id_cliente { get; set; }
    }
}
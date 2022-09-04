using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace medallia.clases
{
    public class monitoreos_pendiente
    {
        public int id_pendiente { get; set; }
        public int id_medallia { get; set; }
        public Int64 id_encuesta { get; set; }
        public int id_clooper { get; set; }
        public string clooper { get; set; }
        public int id_recurso { get; set; }
        public string tecnico { get; set; }
        public string empresa { get; set; }
        public string dni { get; set; }
        public string fecha_ingreso { get; set; }
        public string observaciones { get; set; }
        public string observaciones_ctta { get; set; }
        public string bandera { get; set; }
    }
}
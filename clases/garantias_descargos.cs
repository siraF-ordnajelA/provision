using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace medallia.clases
{
    public class garantias_descargos
    {
        public Int32 id_descargo { get; set; }
        public string usuario { get; set; }
        public string tecnico { get; set; }
        public string ctta { get; set; }
        public string peticion { get; set; }
        public string access { get; set; }
        public string estado { get; set; }
        public string distrito { get; set; }
        public string gerencia { get; set; }
        public string central { get; set; }
        public string subtipo_actividad { get; set; }
        public string sintoma { get; set; }
        public string fecha_toa { get; set; }
        public string fecha_cierre { get; set; }
        public string fecha_descargo { get; set; }
        public string segmento { get; set; }
        public string tecnologia { get; set; }
        public string comentarios_ctta { get; set; }
        public string motivo { get; set; }
        public string submotivo { get; set; }
        public string comentarios_gestor { get; set; }
        public string cbo1_gestor { get; set; }
        public string cbo2_gestor { get; set; }
        public string sn_anterior { get; set; }
        public string sn_actual { get; set; }
        public string trabajado { get; set; }
    }
}
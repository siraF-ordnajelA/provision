using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace medallia.clases
{
    public class res_busqueda
    {
        public int id_recurso { get; set; }
        public string empresa { get; set; }
        public string tecnico { get; set; }
        public int instalaciones { get; set; }
        public int no_realizado { get; set; }
        public int suspendido { get; set; }
        public int garantias { get; set; }
        public int garantias_7d { get; set; }
        public int medallas { get; set; }
        public int monitoreos { get; set; }
        public int dias_trabajados { get; set; }
        public decimal produ { get; set; }
        public decimal metrica_cumplidas { get; set; }
        public decimal metrica_garantias { get; set; }
        public decimal metrica_garantias_7d { get; set; }
        public decimal metrica_diarias { get; set; }
        public decimal metrica_citas { get; set; }
        public decimal metrica_presentismo { get; set; }
        public decimal estrellas { get; set; }
        public string calificacion { get; set; }
        public string fecha_inicio { get; set; }
        public string fecha_fin { get; set; }
        public string access { get; set; }
    }
}
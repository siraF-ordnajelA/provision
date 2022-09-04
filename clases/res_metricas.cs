using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace medallia.clases
{
    public class res_metricas
    {
        public string semana { get; set; }
        public string empresa { get; set; }
        public float metrica_cumplidas { get; set; }
        public float metrica_garantias { get; set; }
        public float metrica_garantias_7d { get; set; }
        public float metrica_monitoreos { get; set; }
        public float metrica_diarias { get; set; }
        public float metrica_citas { get; set; }
        public float metrica_presentismo { get; set; }
        public float resultado { get; set; }
        public float estrellas { get; set; }
        public string tecnologia { get; set; }
        public string fecha { get; set; }
        public string color { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace medallia.clases
{
    public class detalle
    {
        //DATOS DEL MONITOR
        public string monitor { get; set; }
        public string motivo { get; set; }
        public string cito { get; set; }
        public string contexto { get; set; }
        public string fecha { get; set; }
        //DATOS DEL TECNICO
        public string tecnico { get; set; }
        public Int16 ingresante { get; set; }
        //public string tecnico_ingresante { get; set; }
        public string contratista { get; set; }
        public string dni { get; set; }
        public string credencial { get; set; }
        public string celular { get; set; }
        public string vehiculo { get; set; }
        public string escalera { get; set; }
        public string porta_escalera { get; set; }
        public string identificacion { get; set; }
        public string patente { get; set; }
        public string kit_sanidad { get; set; }
        public string presencia { get; set; }
        public string epp { get; set; }
        //CONOCIMIENTO USO - APPS
        public string mobbi { get; set; }
        public string mobbi2 { get; set; }
        public string whop { get; set; }
        public string pdr { get; set; }
        public string qr { get; set; }
        public string wifianalizer { get; set; }
        public string smartwifi { get; set; }
        //APPS INSTALADAS
        public string insta_mobbi { get; set; }
        public string insta_mobbi2 { get; set; }
        public string insta_whop { get; set; }
        public string insta_pdr { get; set; }
        public string insta_qr { get; set; }
        public string insta_wifianalizer { get; set; }
        public string insta_smartwifi { get; set; }
        //HERRAMIENTAS KIT FIBRA
        public string tijeras { get; set; }
        public string cleaver { get; set; }
        public string powermeter { get; set; }
        public string triple { get; set; }
        public string peladora { get; set; }
        public string alcohol { get; set; }
        public string panios { get; set; }
        public string linterna { get; set; }
        //PROCESOS
        public string iptv { get; set; }
        public string hgu { get; set; }
        public string voip { get; set; }
        //COBRE ADAPTACION
        public string alicate { get; set; }
        public string pinzas { get; set; }
        public string destornilla { get; set; }
        public string agujereadora { get; set; }
        public string micro { get; set; }
        public string cable_int { get; set; }
        public string americana { get; set; }
        public string filtros { get; set; }
        public string martillo { get; set; }
        public string pela_cable { get; set; }
        public string alargue { get; set; }
        //ARMADO DE CONECTORES
        public string drop_metodo { get; set; }
        public string drop_plano { get; set; }
        public string drop_circular { get; set; }

        public string obs { get; set; }
        public string calificacion { get; set; }
    }
}
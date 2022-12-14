CREATE TABLE [dbo].[provision_toa](
	[T?cnico] [varchar](100) NULL,
	[ID RECURSO] smallint NULL,
	[Subtipo de Actividad] [varchar](80) NULL,
	[C?digo de actuaci?n] [varchar](80) NULL,
	[N?mero de Petici?n] [varchar](50) NULL,
	[N?mero de Orden] [varchar](50) NULL,
	[Empresa] [varchar](50) NULL,
	[Fecha de Emisi?n/Reclamo] smalldatetime NULL,
	[Intervalo de tiempo] [varchar](10) NULL,
	[SLA Inicio] smalldatetime NULL,
	[SLA Fin] smalldatetime NULL,
	[Ciudad] [varchar](100) NULL,
	[Direcci?n] [nvarchar](max) NULL,
	[Direcci?n (componente vertical)] [nvarchar](max) NULL,
	[Direccion Polar X] [varchar](30) NULL,
	[Direccion Polar Y] [varchar](30) NULL,
	[Central_Manzana] [varchar](12) NULL,
	[Zona de Trabajo] [varchar](150) NULL,
	[Segmento del cliente] [varchar](20) NULL,
	[Nombre] [varchar](120) NULL,
	[Telefono Contacto 1] [varchar](15) NULL,
	[Telefono Contacto 2] [varchar](15) NULL,
	[N?mero Tel?fono] [varchar](15) NULL,
	[Tiempo de Viaje] [varchar](8) NULL,
	[Duraci?n de la actividad] [varchar](8) NULL,
	[Habilidad del trabajo] [varchar](120) NULL,
	[Estado de la orden] [varchar](25) NULL,
	[Pendiente instancia externa] [varchar](80) NULL,
	[Categor?a de Capacidad] [varchar](100) NULL,
	[Tecnologia Voz] [varchar](20) NULL,
	[Tecnologia Banda Ancha] [varchar](20) NULL,
	[Tecnologia TV] [varchar](20) NULL,
	[Multiproducto] [varchar](50) NULL,
	[Tipo de Acceso] [varchar](10) NULL,
	[Tipo Equipo de Acceso] [varchar](25) NULL,
	[Tipo de Terminaci?n] [varchar](25) NULL,
	[S?ntoma] [varchar](80) NULL,
	[Diagn?stico Inicial] [varchar](100) NULL,
	[Diagn?stico Actual] [varchar](80) NULL,
	[Repetido] [varchar](2) NULL,
	[Garant?a] [varchar](3) NULL,
	[Validaci?n t?cnica] [varchar](3) NULL,
	[Rural] [varchar](3) NULL,
	[Zona Peligrosa] [varchar](3) NULL,
	[Cable Primario] smallint NULL,
	[Par Primario] smallint NULL,
	[Par Secundario] smallint NULL,
	[Pin ADSL] tinyint NULL,
	[Bloque ADSL] [varchar](8) NULL,
	[N?mero de equipo de PI] [varchar](15) NULL,
	[Armario] [varchar](15) NULL,
	[Nivel de Urgencia (Prioridad)] [varchar](3) NULL,
	[Prioridad] tinyint NULL,
	[Central] smallint NULL,
	[Nombre Central] [varchar](50) NULL,
	[Fecha de Cita Original] date NULL,
	[Bucket Inicial] [varchar](80) NULL,
	[Reitero_48HS] [varchar](3) NULL,
	[Cuadrante] [varchar](15) NULL,
	[Manzana] smallint NULL,
	[Ventana de servicio] [varchar](10) NULL,
	[Ventana de Llegada] [varchar](10) NULL,
	[Correo electronico] [varchar](150) NULL,
	[Cr?nico] [varchar](3) NULL,
	[Desviado] [varchar](3) NULL,
	[Ubicacion] [varchar](50) NULL,
	[Enrutado autom?tico a fecha] date NULL,
	[Cita ID] int NULL,
	[Razon de Suspension Instalacion] [varchar](100) NULL,
	[Motivo no realizado instalaci?n] [varchar](150) NULL,
	[Comentarios Tecnico] [nvarchar](max) NULL,
	[A_SLOW_NAVIGATION] [varchar](3) NULL,
	[A_VOIP_NOT_WORKING] [varchar](3) NULL,
	[Primera operaci?n manual] [varchar](80) NULL,
	[Distancia a la Ubicacion mas cercana] smallint NULL,
	[Primera operaci?n manual realizada por usuario] smallint NULL,
	[Usuario que autorizo el cierre] [varchar](100) NULL,
	[Fecha/Hora de autorizacion del cierre] smalldatetime NULL,
	[Fecha/Hora de autorizacion de la suspension] smalldatetime NULL,
	[Usuario que autorizo la suspension#] [varchar](15) NULL,
	[Fecha/Hora de autorizacion del quiebre] smalldatetime NULL,
	[Usuario que Autoriza Informar] [varchar](150) NULL,
	[Access ID] [varchar](25) NULL,
	[Recordatorio Realizado] [varchar](3) NULL,
	[Respuesta del Cliente] [varchar](10) NULL,
	[Fecha de respuesta del cliente] smalldatetime NULL,
	[Cita al ingreso] date NULL,
	[Tipo de cliente] [varchar](50) NULL,
	[Subtipo de cliente] [varchar](50) NULL,
	Programacion varchar (15) null,
	Actualizacion smalldatetime null
)
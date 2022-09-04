create table av_averias (id int primary key identity (1,1) not null,
	[T�cnico] [varchar](100) NULL,
	[ID RECURSO] smallint NULL,
	[Subtipo de Actividad] [varchar](80) NULL,
	[C�digo de actuaci�n] [varchar](80) NULL,
	[N�mero de Petici�n] [varchar](50) NULL,
	[N�mero de Orden] [varchar](50) NULL,
	[Empresa] [varchar](50) NULL,
	[Fecha de Emisi�n/Reclamo] smalldatetime NULL,
	[Estado de la orden] [varchar](25) NULL,
	[Categor�a de Capacidad] [varchar](100) NULL,
	[Tecnologia Voz] [varchar](20) NULL,
	[Tecnologia Banda Ancha] [varchar](20) NULL,
	[Tecnologia TV] [varchar](20) NULL,
	[Multiproducto] [varchar](50) NULL,
	[Tipo de Acceso] [varchar](10) NULL,
	[Tipo Equipo de Acceso] [varchar](25) NULL,
	[S�ntoma] [varchar](80) NULL,
	[Diagn�stico Inicial] [varchar](100) NULL,
	[Diagn�stico Actual] [varchar](80) NULL,
	[Garant�a] [varchar](3) NULL,
	[Central] smallint NULL,
	[Nombre Central] [varchar](50) NULL,
	[Bucket Inicial] [varchar](80) NULL,
	[Razon de Suspension Instalacion] [varchar](100) NULL,
	[Motivo no realizado instalaci�n] [varchar](150) NULL,
	[Comentarios Tecnico] [nvarchar](max) NULL,
	[Usuario que autorizo el cierre] [varchar](100) NULL,
	[Fecha/Hora de autorizacion del cierre] smalldatetime NULL,
	[Fecha/Hora de autorizacion de la suspension] smalldatetime NULL,
	[Usuario que autorizo la suspension#] [varchar](15) NULL,
	[Fecha/Hora de autorizacion del quiebre] smalldatetime NULL,
	[Usuario que Autoriza Informar] [varchar](150) NULL,
	[Access ID] [varchar](25) NULL,
	[Tipo de cliente] [varchar](50) NULL,
	[Subtipo de cliente] [varchar](50) NULL,
	Programacion varchar (15) null,
	Fecha_de_actualizacion smalldatetime null,
	Fecha_de_cumplimiento_insta date null,
	Asignacion varchar(12) null,
	Averia varchar(10) null,
	[Subtipo de Avctividad Instalacion] varchar(80) null,
	[Codigo de Actividad Instalacion] varchar(80) null,
	[C�digo de actuaci�n Instalacion] varchar(80) null,
	[T�cnico que instal�] varchar(100) null,
	[Empresa que instal�] varchar(50) null,
	[Multiproducto instalado] varchar(50),
	[Tecnolog�a instalada] varchar(50) null,
	[Fecha creaci�n TOA] date null
)
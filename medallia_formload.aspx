<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="medallia_formload.aspx.cs" Inherits="medallia.medallia_formload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item"><a href="javascript: history.go(-1)">Bandeja</a></li>
                        <li class="breadcrumb-item active">Formulario Medallia</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid mb-2">
            <div class="row">
                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Datos de la encuesta</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>ID Cliente</label>
                                        <input type="number" class="form-control" id="txt_cliente" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>DNI del t&eacute;cnico</label>
                                        <input type="number" class="form-control" id="txt_dni_tecnico" disabled />
                                        <label id="lbl_idrecurso" hidden></label>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>ID Encuesta</label>
                                        <input type="number" class="form-control" id="txt_idencuesta" disabled />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Cliente</label>
                                        <input type="text" class="form-control" id="txt_nombre" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Direcci&oacute;n</label>
                                        <input type="text" class="form-control" id="txt_direccion" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Localidad</label>
                                        <input type="text" class="form-control" id="txt_localidad" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Contacto</label>
                                        <input type="text" class="form-control" id="txt_contacto" disabled />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>T&eacute;cnico</label>
                                        <input type="text" class="form-control" id="txt_tecnico" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Empresa</label>
                                        <input type="text" class="form-control" id="txt_empresa" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>N° de orden</label>
                                        <input type="text" class="form-control" id="txt_orden" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Bucket</label>
                                        <input type="text" class="form-control" id="txt_bucket" disabled />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Access ID</label>
                                        <input type="text" class="form-control" id="txt_accessid" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Gerencia</label>
                                        <input type="text" class="form-control" id="txt_gerencia" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Distrito</label>
                                        <input type="text" class="form-control" id="txt_distrito" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Central</label>
                                        <label id="lbl_idcentral" hidden></label>
                                        <input type="text" class="form-control" id="txt_central" disabled />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Segmento</label>
                                        <input type="text" class="form-control" id="txt_segmento" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Fecha encuesta</label>
                                        <input type="date" id="dat_encuesta" class="form-control" disabled>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Fecha clooper</label>
                                        <input type="date" id="dat_mail" class="form-control" disabled>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Fecha cierre</label>
                                        <input type="date" id="dat_cierre" class="form-control" disabled>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Tecnolog&iacute;a</label>
                                        <input type="text" class="form-control" id="txt_tecno" disabled />
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-12 -->

                <div class="col-md-6">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Calificaci&oacute;n / Puntuaci&oacute;n</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group row">
                                        <label for="cbo_nps2" class="col-sm-4 col-form-label">NPS</label>
                                        <div class="col-sm-5">
                                            <select class="form-control" id="cbo_nps" disabled>
                                                <option value="11">Sin Datos</option>
                                                <option value="0">0</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group row">
                                        <label for="cbo_tecnico" class="col-sm-4 col-form-label">T&eacute;cnico</label>
                                        <div class="col-sm-5">
                                            <select class="form-control" id="cbo_tecnico" disabled>
                                                <option value="11">Sin Datos</option>
                                                <option value="0">0</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group row">
                                        <label for="cbo_puntu" class="col-sm-4 col-form-label">Puntualidad</label>
                                        <div class="col-sm-5">
                                            <select class="form-control" id="cbo_puntu" disabled>
                                                <option value="11">Sin Datos</option>
                                                <option value="0">0</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group row">
                                        <label for="cbo_profe" class="col-sm-4 col-form-label">Profesionalidad</label>
                                        <div class="col-sm-5">
                                            <select class="form-control" id="cbo_profe" disabled>
                                                <option value="11">Sin Datos</option>
                                                <option value="0">0</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group row">
                                        <label for="cbo_conocimiento" class="col-sm-4 col-form-label">Conocimiento</label>
                                        <div class="col-sm-5">
                                            <select class="form-control" id="cbo_conocimiento" disabled>
                                                <option value="11">Sin Datos</option>
                                                <option value="0">0</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group row">
                                        <label for="cbo_calidad" class="col-sm-4 col-form-label">Calidad</label>
                                        <div class="col-sm-5">
                                            <select class="form-control" id="cbo_calidad" disabled>
                                                <option value="11">Sin Datos</option>
                                                <option value="0">0</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group row">
                                        <label for="cbo_comunica" class="col-sm-4 col-form-label">Comunicaci&oacute;n</label>
                                        <div class="col-sm-5">
                                            <select class="form-control" id="cbo_comunica" disabled>
                                                <option value="11">Sin Datos</option>
                                                <option value="0">0</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-6 -->

                <div class="col-md-6">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Comentarios del cliente</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group">
                                        <label>Comentarios del cliente</label>
                                        <textarea id="txt_comentarios_cliente" class="form-control" rows="8" disabled></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>Respuesta del cliente</label>
                                        <select class="form-control" id="cbo_resp_2" disabled>
                                            <option value="0">--Seleccione respuesta del cliente--</option>
                                            <option value="5">Agradece llamado</option>
                                            <option value="1">Funciona OK</option>
                                            <option value="2">Per&iacute;odo de prueba</option>
                                            <option value="3">No contactado</option>
                                            <option value="4">Sin respuesta</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-6 -->

                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Gesti&oacute;n / Motivos</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row border-bottom">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Motivo</label>
                                        <select class="form-control" id="cbo_motivo" disabled>
                                            <option value="1">Instalaci&oacute;n</option>
                                            <option value="2">Cancelaci&oacute;n</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Contexto</label>
                                        <select class="form-control" id="cbo_contexto" disabled>
                                            <option value="1">COVID-19</option>
                                            <option value="2">Tradicional</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            </br>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group row">
                                        <label for="cbo_motivo_detraccion" class="col-sm-3 col-form-label">Motivo detractor</label>
                                        <div class="col-sm-4">
                                            <select class="form-control" id="cbo_motivo_detraccion" onchange="cbo_motivo_clase();" disabled>
                                                <option value="0">--Seleccione motivo--</option>
                                                <option value="3">Cliente</option>
                                                <option value="1">Comercial</option>
                                                <option value="4">Despacho provisi&oacute;n</option>
                                                <option value="2">T&eacute;cnico</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group row">
                                        <label for="cbo_concepto" class="col-sm-3 col-form-label">Concepto</label>
                                        <div class="col-sm-6">
                                            <select id="cbo_concepto" class="form-control" onchange="cbo_subconcepto();" disabled><option value="0">--Debe seleccionar motivo--</option></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group row">
                                        <label for="cbo_sub_concepto" class="col-sm-3 col-form-label">Sub-concepto</label>
                                        <div class="col-sm-6">
                                            <select id="cbo_sub_concepto" class="form-control" onchange="cbo_detail();" disabled>
                                                <option value="99">--Debe seleccionar concepto--</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group row">
                                        <label for="cbo_detalle" class="col-sm-3 col-form-label">Detalle</label>
                                        <div class="col-sm-6">
                                            <select id="cbo_detalle" class="form-control" disabled>
                                                <option value="99">--Debe seleccionar sub-concepto--</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </br>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Acci&oacute;n ejecutada</label>
                                        <select class="form-control" onchange="cbo_accion_ejecutada();" id="cbo_accion" disabled>
                                            <option value="0">--Selecciones acci&oacute;n--</option>
                                            <!--<option value="5">Cerrado/No contactado</option>-->
                                            <option value="1">Derivado a contratista</option>
                                            <option value="2">Derivado a clooper comercial</option>
                                            <option value="3">Derivado a soporte sistema</option>
                                            <option value="4">Gestionado por clooper</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Estado</label>
                                        <select class="form-control" id="cbo_estado" disabled>
                                            <option value="0">--Seleccione estado--</option>
                                            <option value="1">Cerrado</option>
                                            <option value="2">Escalado</option>
                                            <option value="4">Escalado/Refuerzo</option>
                                            <option value="3">Pendiente</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row border-top">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Gesti&oacute;n clooper</label>
                                        <select class="form-control" id="cbo_gest_clooper" disabled>
                                            <option value="0">--Seleccione gesti&oacute;n--</option>
                                            <option value="5">FUNCIONA OK</option>
                                            <option value="6">BAJA EN PROCESO</option>
                                            <option value="27">CLIENTE NO PERMITE INGRESO</option>
                                            <option value="1">DERIVADO A OPERACIONES</option>
                                            <option value="2">DERIVADO A REDES</option>
                                            <option value="3">DERIVADO A SISTEMAS</option>
                                            <option value="7">DESPACHO PROVISI&Oacute;N</option>
                                            <option value="8">INSTRUCCIÓN EN IPTV</option>
                                            <option value="9">INSTRUCCIÓN EN PLAYBOX</option>
                                            <option value="10">INSTRUCCIÓN EN REDES/EQUIPOS</option>
                                            <option value="11">INSTRUCCIÓN EN VOIP</option>
                                            <option value="12">INSTRUCCIÓN TEST DE VELOCIDAD</option>
                                            <option value="26">FALTA DE LIMPIEZA</option>
                                            <option value="13">PDR - REGENERAR</option>
                                            <option value="14">PDR - REINICIAR</option>
                                            <option value="15">PDR - RESET ONT</option>
                                            <option value="16">PDR - VALORES DE FÁBRICA</option>
                                            <option value="17">PDR - VER PRUEBAS DE VELOCIDAD</option>
                                            <option value="18">PDR - ACS - ACTUALIZACIÓN FIRMWARE</option>
                                            <option value="19">PDR - VOIP - BOOTSTRAP</option>
                                            <option value="20">PDR - VOIP - RECONFIGURAR IAD</option>
                                            <option value="21">RESUELTO POR ATC</option>
                                            <option value="4">RESUELTO POR SOPORTE SISTEMAS</option>
                                            <option value="24">RESUELTO POR SOPORTE SISTEMAS - DERIVADO A TASA</option>
                                            <option value="22">SIGRES - CAMBIO FTTH</option>
                                            <option value="23">SIGRES - VOIP - REGENERAR CLAVE</option>
                                            <option value="25">VERIFICACION EN SISTEMA</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-12 -->

                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Respuesta del supervisor</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group">
                                        <label>Comentarios del supervisor</label>
                                        <textarea id="txt_resp_supervisor" class="form-control" rows="8" disabled></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Gesti&oacute;n</label>
                                        <select class="form-control" onchange="cambia_cbo_resp_supervisor();" id="cbo_resp_supervisor" disabled>
                                            <option value="0">--Seleccione opci&oacute;n--</option>
                                            <option value="1" disabled>Materiales</option>
                                            <option value="2" disabled>M&eacute;todo constructivo</option>
                                            <option value="48">BAJA POR ERROR</option>
                                            <option value="3">CAMBIO ANDROID TV</option>
                                            <option value="4">CAMBIO ANDROID TV RECUPERADO</option>
                                            <option value="5">CAMBIO CABLE DE RED</option>
                                            <option value="6">CAMBIO CAJA ESTANCO</option>
                                            <option value="7">CAMBIO CONECTOR</option>
                                            <option value="8">CAMBIO DROP</option>
                                            <option value="9">CAMBIO HGU</option>
                                            <option value="10">CAMBIO HGU RECUPERADO</option>
                                            <option value="11">CAMBIO PATCH CORD FO</option>
                                            <option value="12">CAMBIO REPETIDOR</option>
                                            <option value="13">CAMBIO REPETIDOR RECUPERADO</option>
                                            <option value="14">CAMBIO ROSETA OPTICA</option>
                                            <option value="15">CAMBIO STB IPTV</option>
                                            <option value="16">CAMBIO STB IPTV RECUPERADO</option>
                                            <option value="44">CLIENTE AUSENTE</option>
                                            <option value="17">CONEXIÓN ANDROID TV</option>
                                            <option value="18">CONEXIÓN CABLE DE RED</option>
                                            <option value="19">CONEXIÓN EN CTO</option>
                                            <option value="20">CONEXIÓN HGU</option>
                                            <option value="21">CONEXIÓN REPETIDOR</option>
                                            <option value="22">CONEXIÓN STB IPTV</option>
                                            <option value="23">CONEXIÓN VOIP</option>
                                            <option value="24">CONFIGURACIÓN ANDROID TV</option>
                                            <option value="45">CONFIGURACIÓN BP</option>
                                            <option value="49">CONFIGURACIÓN HGU</option>
                                            <option value="25">CONFIGURACIÓN REDES</option>
                                            <option value="26">CONFIGURACIÓN STB IPTV</option>
                                            <option value="27">CONFIGURACIÓN VOIP</option>
                                            <option value="43">CORTE FO</option>
                                            <option value="28">CTO SIN POTENCIA</option>
                                            <option value="46">DESCONEXIÓN DROP</option>
                                            <option value="29">DISP. NO COMPATIBLE C/ 5GHZ</option>
                                            <option value="30">EMPRENDIMIENTOS/COUNTRY</option>
                                            <option value="31">FALLA MASIVA</option>
                                            <option value="47">MANIPULACIIÓN DE INSTALACIÓN</option>
                                            <option value="32">MEDICIÓN DE VELOCIDAD</option>
                                            <option value="33">NO PERMITE INGRESO</option>
                                            <option value="34">PIDIÓ BAJA DEL SERVICIO</option>
                                            <option value="35">PROBLEMAS CON ALIANZAS</option>
                                            <option value="36">REFUERZO AL TÉCNICO</option>
                                            <option value="37">REPARÓ INSTALACIÓN EXTERNA</option>
                                            <option value="38">REPARÓ INSTALACIÓN INTERNA</option>
                                            <option value="39">REUBICACIÓN HGU</option>
                                            <option value="40">REUBICACIÓN REPETIDOR</option>
                                            <option value="41">SERVICIO YA FUNCIONANDO</option>
                                            <option value="42">TAMA&Ntilde;O DE LA VIVIENDA</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group mt-4">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="chk_reagenda" onclick="reagenda_escalado();" disabled>
                                            <label class="form-check-label">Cliente posterga visita</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>S/N - CAS ID - MAC (anterior)</label>
                                        <input type="text" class="form-control" id="txt_sn_anterior" disabled />
                                    </div>
                                    <div class="form-group">
                                        <label>S/N - CAS ID - MAC  (actual)</label>
                                        <input type="text" class="form-control" id="txt_sn_actual" disabled />
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-12 -->
                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Comentarios del clooper y respuesta final del cliente</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group">
                                        <label>Comentario clooper</label>
                                        <textarea id="txt_comentarios_clooper" class="form-control" rows="8" disabled></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Respuesta final del cliente</label>
                                        <select class="form-control" id="cbo_resp_final_cliente" disabled>
                                            <option value="0">--Seleccione una opci&oacute;n</option>
                                            <option value="1">Funciona OK</option>
                                            <option value="2">No contactado</option>
                                            <option value="3">Sin respuesta</option>
                                            <option value="4">Volver a Gestionar</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-12 -->
            </div>
            <!-- /.row -->
            <center>
                <input type="button" id="btn_guardar_escalado" onclick="guardar_escalado();" class="btn btn-primary" value="Guardar" />&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" id="btn_guardar_pendiente" onclick="guardar_pendientes();" class="btn btn-primary" value="Guardar" />&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" id="btn_guardar_soporte" onclick="guardar_soporte();" class="btn btn-primary" value="Guardar" />&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" id="btn_volver" onclick="volver_atras();" class="btn btn-secondary" value="Volver" />
            </center>
            </br>
        </div>
        <!-- /.container -->
    </section>
</div>
<!-- /.content-wrapper -->
</asp:Content>
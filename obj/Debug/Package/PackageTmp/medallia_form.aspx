<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="medallia_form.aspx.cs" Inherits="medallia.medallia_form" %>
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
                        <li class="breadcrumb-item"><a href="index.aspx">Home</a></li>
                        <li class="breadcrumb-item">Medallia</li>
                        <li class="breadcrumb-item active">Formulario de carga Medallia</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
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
                                        <input type="number" class="form-control" id="txt_cliente" />
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>DNI del t&eacute;cnico</label>
                                        <input type="number" class="form-control" id="txt_dni_tecnico" />
                                        <label id="lbl_idrecurso" hidden></label>
                                        <label id="lbl_id_user" hidden><%= Session["id_usuario"] %></label>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>ID Encuesta</label>
                                        <input type="number" class="form-control" id="txt_idencuesta" />
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
                                        <label id="lbl_region_mop" hidden></label>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Distrito</label>
                                        <label id="lbl_idcentral" hidden></label>
                                        <input type="text" class="form-control" id="txt_distrito" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Central</label>
                                        <label id="Label1" hidden></label>
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
                                        <label>Tecnolog&iacute;a</label>
                                        <input type="text" class="form-control" id="txt_tecno" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Fecha encuesta</label>
                                        <input type="date" id="dat_encuesta" class="form-control" placeholder="yyyy-mm-dd">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <input type="button" class="btn btn-primary mt-4" id="btn_busca" value="Buscar" onclick="buscar();" />
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body 
                        <div class="card-footer"></div>-->
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
                                            <select class="form-control" id="cbo_nps">
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
                                            <select class="form-control" id="cbo_tecnico">
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
                                            <select class="form-control" id="cbo_puntu">
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
                                            <select class="form-control" id="cbo_profe">
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
                                            <select class="form-control" id="cbo_conocimiento">
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
                                            <select class="form-control" id="cbo_calidad">
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
                                            <select class="form-control" id="cbo_comunica">
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
                                        <textarea id="txt_comentarios_cliente" class="form-control" rows="8" placeholder="Ingrese comentario del cliente de la web medallia..."></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>Respuesta del cliente</label>
                                        <select class="form-control" id="cbo_resp_2">
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
                                        <select class="form-control" id="cbo_motivo">
                                            <option value="1">Instalaci&oacute;n</option>
                                            <option value="2">Cancelaci&oacute;n</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Contexto</label>
                                        <select class="form-control" id="cbo_contexto">
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
                                            <select class="form-control" id="cbo_motivo_detraccion" onchange="cbo_motivo_clase();">
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
                                            <select id="cbo_concepto" class="form-control" onchange="cbo_subconcepto();"><option value="0">--Debe seleccionar motivo--</option></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group row">
                                        <label for="cbo_sub_concepto" class="col-sm-3 col-form-label">Sub-concepto</label>
                                        <div class="col-sm-6">
                                            <select id="cbo_sub_concepto" class="form-control" onchange="cbo_detail();"><option value="99">--Debe seleccionar concepto--</option></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group row">
                                        <label for="cbo_detalle" class="col-sm-3 col-form-label">Detalle</label>
                                        <div class="col-sm-6">
                                            <select id="cbo_detalle" class="form-control"><option value="99">--Debe seleccionar sub-concepto--</option></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </br>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Acci&oacute;n ejecutada</label>
                                        <select class="form-control" onchange="cbo_accion_ejecutada();" id="cbo_accion">
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
                                        <textarea id="txt_resp_supervisor" class="form-control" rows="8" placeholder="Aclarar nombre del supervisor al comienzo del mensaje..." disabled></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Gesti&oacute;n</label>
                                        <select class="form-control" id="cbo_resp_supervisor" disabled>
                                            <option value="0">--Seleccione opci&oacute;n--</option>
                                            <option value="1">Materiales</option>
                                            <option value="2">M&eacute;todo constructivo</option>
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
            <center><input type="button" id="btn btn-primary" onclick="guardar();" class="btn btn-primary" value="Guardar caso" /></center>
        </div>
        <!-- /.container -->
    </section>
</div>
<!-- /.content-wrapper -->

</asp:Content>
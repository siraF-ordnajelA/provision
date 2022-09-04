<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="monitoreos_formload.aspx.cs" Inherits="medallia.monitoreos_formload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Javascript correspondientes a Monitoreos -->
    <script type="text/javascript" src="js/monitoreos.js?v=<%= Session["rd_number"] %>"></script>
    
    <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item">Calibraciones y Monitoreos</li>
                        <li class="breadcrumb-item active">Formulario ingresado</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Calibraci&oacute;n - Monitoreo</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Motivo</label>
                                        <select class="form-control" id="cbo_cita" disabled></select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Monitoreado</label>
                                        <select class="form-control" id="cbo_campo" disabled></select>
                                    </div>
                                </div>
                            </div>
                        </div><!-- /.card-body -->
                    </div><!-- /.card -->
                </div>

                <div class="col-md-6">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Datos del auditor</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Auditado por</label>
                                        <input type="text" class="form-control" id="lbl_user" disabled />
                                        <label id="lbl_id_usr" hidden><%= Session["id_usuario"]%></label>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>F. Auditoria (AAAA-MM-DD)</label>
                                        <input type="date" class="form-control" id="txt_fecha_manual" disabled />
                                    </div>
                                </div>
                            </div>
                        </div><!-- /.card-body -->
                    </div><!-- /.card -->
                </div>
            </div><!-- /.row -->

            <div class="row">
                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Datos del t&eacute;cnico</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="drop_tecnico" class="col-sm-3 col-form-label">T&eacute;cnico</label>
                                        <select id="drop_tecnico" class="form-control col-sm-8" disabled></select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="lbl_dni" class="col-sm-3 col-form-label">DNI</label>
                                        <input type="tel" class="form-control col-sm-5" id="lbl_dni" maxlenght="8" disabled />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="chk_tecnico" class="col-sm-3 col-form-label">Ingresante</label>
                                        <input type="checkbox" class="form-control col-sm-1" id="chk_tecnico" value="chk_tec" disabled />&nbsp;|&nbsp;&nbsp;
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="chk_tecnico" class="col-sm-3 col-form-label">Empresa</label>
                                        <select class="form-control col-sm-6" id="cbo_empresa" disabled></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="drop_credencial" class="col-sm-3 col-form-label">Credencial</label>
                                        <select class="form-control col-sm-6" id="drop_credencial" disabled></select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="txt_nombre_tec" class="col-sm-3 col-form-label">Nombre</label>
                                        <input type="text" class="form-control col-sm-5" id="txt_nombre_tec" disabled />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="drop_equipo" class="col-sm-3 col-form-label">Equipo celular</label>
                                        <select class="form-control col-sm-6" id="drop_equipo" disabled></select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="txt_apellido_tec" class="col-sm-3 col-form-label">Apellido</label>
                                        <input type="text" class="form-control col-sm-5" id="txt_apellido_tec" disabled />
                                    </div>
                                </div>
                            </div>
                        </div><!-- /.card-body -->
                    </div><!-- /.card -->
                </div>
            </div><!-- /.row -->

            <div class="row">
                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Relevamiento</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <label>Veh&iacute;culo</label>
                                    <div class="form-check">
                                        Estado del veh&iacute;culo:&nbsp;<label class="form-check-label font-weight-bold" id="txt_estado"></label>
                                    </div>
                                    <div class="form-check">
                                        Escalera:&nbsp;<label class="form-check-label font-weight-bold" id="txt_escalera"></label>
                                    </div>
                                    <div class="form-check">
                                        Porta escalera:&nbsp;<label class="form-check-label font-weight-bold" id="txt_porta"></label>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="8" id="chk_veh_ingresante" disabled />
                                        <label class="form-check-label" for="chk_veh_ingresante">T&eacute;cnico ingresante</label>
                                    </div>
                                    <div class="form-check">
                                        Identificaci&oacute;n:&nbsp;<label class="form-check-label font-weight-bold" id="chk_veh_sinidentif"></label>
                                    </div>
                                    <div class="form-group row mt-3">
                                        <label for="txt_patente" class="col-sm-4 col-form-label">Patente</label>
                                        <input type="text" class="form-control col-sm-6" id="txt_patente" disabled />
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="drop_epp" class="col-sm-3 col-form-label">Contexto instalaci&oacute;n</label>
                                        <select class="form-control col-sm-6" id="drop_contexto" disabled></select>
                                    </div>
                                    <div class="form-group row">
                                        <label for="drop_kit_sanidad" class="col-sm-3 col-form-label">KIT sanidad</label>
                                        <select class="form-control col-sm-6" id="drop_kit_sanidad" disabled></select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="drop_epp" class="col-sm-2 col-form-label">EPP</label>
                                        <select id="drop_epp" class="form-control col-sm-7" disabled></select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="drop_presencia" class="col-sm-3 col-form-label">Presencia/</br>vestimenta</label>
                                        <select class="form-control col-sm-6" id="drop_presencia" disabled></select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <center><label>Conocimiento uso APP</label></center>
                                </div>
                                <div class="col-sm-6">
                                    <center><label>APP instaladas</label></center>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-5 p-3 border centrado" style="background-color: #fafafa">
                                    <table>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Mobbi</span> <span class="rojo">2.0</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_mobbi20"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">P</span><span class="rojo">DR</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_pdr"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline">Escaner QR</td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_qr"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Wifi Analizer</span>&nbsp;</td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_analizer"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline">Smart Wifi</td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_smart"></label></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-sm-5 p-3 border centrado" style="background-color: #fafafa">
                                    <table>
                                        <tr>
                                            <td class="align-baseline">Lector QR</td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_qr_instalada"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="rojo">Mobbi 2.0</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_mobbi2_instalada"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="rojo">PDR</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_pdr_instalada"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Wifi Analizer</span>&nbsp;</td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_analizer_instalada"></label></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-sm-6">
                                    <center><label>Herramientas Kit fibra</label></center>
                                </div>
                                <div class="col-sm-6">
                                    <center><label>Procesos y conocimientos</label></center>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-5 p-3 border centrado" style="background-color: #fafafa">
                                    <table>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Tijera corte Kevlar</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_kevlar"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Cortadora</span> <span class="rojo">Cleaver</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_cleaver"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Power Meter</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_pw" value="1"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Pinza peladora triple ranura</span>&nbsp;</td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_triple"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Peladora Drop Rectangular</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_drop"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="rojo">Alcohol isoprop&iacute;lico</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_alcohol"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Pa&ntilde;os</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_panios"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Linterna l&aacute;ser</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_laser"></label></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-sm-5 p-3 border centrado" style="background-color: #fafafa">
                                    <table>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Servicios de</span> <span class="rojo">IPTV</span>&nbsp;</td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_iptv"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">H</span><span class="rojo">GU</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_hgu"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">VO</span><span class="rojo">IP</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_voip"></label></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-sm-6">
                                    <center><label>Cobre adaptaci&oacute;n VoIP</label></center>
                                </div>
                                <div class="col-sm-6">
                                    <center><label>M&eacute;todo y armado</label></center>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-5 p-3 border centrado" style="background-color: #fafafa">
                                    <table>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Ali</span><span class="rojo">cate</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_alicate"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Pin</span><span class="rojo">zas</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_pinzas"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Destorni</span><span class="rojo">lladores</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_destornilla"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Agujereadora</span> / <span class="rojo">Mechas</span>&nbsp;</td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_agu"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Micro</span> <span class="rojo">tel&eacute;fono</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_micro"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Cable</span> <span class="rojo">inst. interna</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_interna"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Ficha</span> <span class="rojo">amerciana</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_ficha"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Filtro</span> <span class="rojo">combinado</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_filtro"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Mar</span><span class="rojo">tillo</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_martillo"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Pasa</span> <span class="rojo">cable</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_pasa_cable"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="align-baseline"><span class="amarillo">Alar</span><span class="rojo">gue</span> / <span class="amarillo">Sili</span><span class="rojo">cona</span></td>
                                            <td class="align-baseline"><label class="font-weight-bold" id="rd_alargue"></label></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-sm-5 p-2 centrado">
                                        <div class="form-group row">
                                            <label for="drop_metodo" class="col-sm-4 col-form-label">M&eacute;todo constructivo</label>
                                            <select id="drop_metodo" class="form-control col-sm-4" disabled></select>
                                        </div>
                                        <div class="form-group row">
                                            <label for="drop_plano" class="col-sm-4 col-form-label">Armado conector Plano</label>
                                            <select id="drop_plano" class="form-control col-sm-4" disabled></select>
                                        </div>
                                        <div class="form-group row">
                                            <label for="drop_circular" class="col-sm-4 col-form-label">Armado conector Circular</label>
                                            <select id="drop_circular" class="form-control col-sm-4" disabled></select>
                                        </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-8 p-1 mt-3">
                                    <div class="form-group">
                                        <label>Observaciones</label>
                                        <textarea class="form-control" rows="5" id="txt_obs"></textarea>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-12 mt-1">
                                    <center><h3>Resultado final</h3></center>
                                    <input type="radio" id="rd_1" name="rd_ND" value="1" disabled style="width: 50px; visibility:hidden;">
                                    <input type="radio" id="rd_2" name="rd_ND" value="2" disabled style="width: 50px; visibility:hidden;">
                                    <input type="radio" id="rd_3" name="rd_ND" value="3" disabled style="width: 50px; visibility:hidden;">
                                    <center><div id="txt_resultado"></div></center>
                                </div>
                            </div>

                        </div><!-- /.card-body -->
                    </div><!-- /.card -->
                </div>
            </div><!-- /.row -->

        </div><!-- /.container -->
    </section>
    </div>
</asp:Content>
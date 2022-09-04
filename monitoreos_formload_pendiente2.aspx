<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="monitoreos_formload_pendiente2.aspx.cs" Inherits="medallia.monitoreos_formload_pendiente2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="index.aspx">Home</a></li>
                        <li class="breadcrumb-item">Calibraciones y Monitoreos</li>
                        <li class="breadcrumb-item active">Trabajar pendiente</li>
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
                                        <select class="form-control" id="cbo_cita">
                                            <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                            <option value="1">T&eacute;cnico trabajando actualmente</option>
                                            <option value="2">Solicitud ingreso t&eacute;cnico nuevo</option>
                                            <option value="8">Monitoreo por Medallia</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Monitoreado</label>
                                        <select class="form-control" id="cbo_campo">
                                            <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                            <option value="5">En Campo</option>
                                            <option value="6">En Obrador</option>
                                            <option value="7">Virtual</option>
                                        </select>
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
                                        <input type="text" class="form-control" id="lbl_user" value="<%= Session["uvilla del pasuario"]%>" readonly />
                                        <label id="lbl_id_usr" hidden><%= Session["id_usuario"]%></label>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>F. Auditoria (AAAA-MM-DD)</label>
                                        <input type="date" class="form-control" id="txt_fecha_manual" />
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
                                        <input type="text" class="form-control col-sm-5" id="lbl_dni" disabled />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="chk_tecnico" class="col-sm-3 col-form-label">Ingresante</label>
                                        <input type="checkbox" class="form-control col-sm-1" id="chk_tecnico" value="chk_tec" disabled />&nbsp;|&nbsp;&nbsp;
                                        <input type="button" class="btn btn-secondary" id="btn_historia_tec" value="Historial del T&eacute;cnico" disabled />
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
                                        <select class="form-control col-sm-6" id="drop_credencial" onchange="calculo_puntaje();">
                                            <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                            <option value="1">En vigencia</option>
                                            <option class="amarillo" value="2">Vencida / No tiene</option>
                                            <!--<option value="3">Sin credencial</option>
                                            <option value="4">No corresponde</option>-->
                                            <option value="5">Vencida en gestión</option>
                                            <option value="6">Técnico ingresante</option>
                                        </select>
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
                                        <select class="form-control col-sm-6" id="drop_equipo" onchange="calculo_puntaje();">
                                            <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                            <option value="1">Dual Band con NFC</option>
                                            <option class="amarillo" value="2">Dual Band sin NFC</option>
                                            <option class="amarillo" value="6">One Band con NFC</option>
                                            <!--<option value="3">No es Dual Band</option>-->
                                            <option class="amarillo" value="4">En gestión (pérdida-robo-rotura)</option>
                                            <option value="5">Técnico ingresante</option>
                                        </select>
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
                                        <input class="form-check-input" type="checkbox" value="1" id="chk_veh_condiciones" onclick="chk_condicion(1); calculo_puntaje();" checked />
                                        <label class="form-check-label" for="chk_veh_condiciones">En condiciones</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="2" id="chk_veh_estregular" onclick="chk_condicion(2); calculo_puntaje();" />
                                        <label class="form-check-label" for="chk_veh_estregular">Estado regular</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="3" id="chk_veh_mal_estado" onclick="chk_condicion(3); calculo_puntaje();" />
                                        <label class="form-check-label" for="chk_veh_mal_estado">Mal estado</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="5" id="chk_veh_sescalera" onclick="calculo_puntaje();" />
                                        <label class="form-check-label" for="chk_veh_sescalera">Sin escalera</label>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="4" id="chk_veh_sinidentif" onclick="calculo_puntaje();" />
                                        <label class="form-check-label" for="chk_veh_sinidentif">Sin identificaci&oacute;n</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="7" id="chk_vhe_sporta" />
                                        <label class="form-check-label" for="chk_vhe_sporta">s/porta escalera corresp.</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="8" id="chk_veh_ingresante" onclick="calculo_puntaje();" />
                                        <label class="form-check-label" for="chk_veh_ingresante">T&eacute;cnico ingresante</label>
                                    </div>
                                    <div class="form-group row mt-3">
                                        <label for="txt_patente" class="col-sm-4 col-form-label">Patente</label>
                                        <input type="text" class="form-control col-sm-6" id="txt_patente" />
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="drop_epp" class="col-sm-3 col-form-label">Contexto instalaci&oacute;n</label>
                                        <select class="form-control col-sm-6" id="drop_contexto">
                                            <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                            <option value="1">Tradicional</option>
                                            <option value="2">COVID-19</option>
                                        </select>
                                    </div>
                                    <div class="form-group row">
                                        <label for="drop_kit_sanidad" class="col-sm-3 col-form-label">KIT sanidad</label>
                                        <select class="form-control col-sm-6" id="drop_kit_sanidad" onchange="calculo_puntaje();">
                                            <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                            <option value="3">Completo</option>
                                            <option class="amarillo" value="4">Incompleto</option>
                                            <option class="rojo" value="5">Tiene pero no utiliza</option>
                                            <option class="rojo" value="6">No tiene</option>
                                            <option value="7">Técnico ingresante</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="drop_epp" class="col-sm-2 col-form-label">EPP</label>
                                        <select id="drop_epp" class="form-control col-sm-7" onchange="calculo_puntaje();">
                                            <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                            <option value="17">Completo</option>
                                            <option class="rojo" value="18">Incompleto</option>
                                            <!--<option value="20">En mal estado</option>
                                            <option value="19">No tiene</option>-->
                                            <option class="amarillo" value="26">Falta EPP - No urgente</option>
                                            <option value="27">Técnico ingresante</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="drop_presencia" class="col-sm-3 col-form-label">Presencia/</br>vestimenta</label>
                                        <select class="form-control col-sm-6" id="drop_presencia" onchange="calculo_puntaje();">
                                            <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                            <option value="1">Completa</option>
                                            <option value="2">Incompleta</option>
                                            <!--<option value="3">En mal estado</option>-->
                                            <option class="amarillo" value="4">Sin vestimenta corporativa</option>
                                            <option value="7">Técnico ingresante</option>
                                        </select>
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
                                            <td>&nbsp;</td>
                                            <td>Bueno</td>
                                            <td><span class="amarillo">Regular</span></td>
                                            <td><span class="rojo">Malo</span></td>
                                            <!--<td>No utiliza</td>-->
                                        </tr>
                                        <!--<tr>
                                            <td>Mobbi 1</td>
                                            <td align="center"><input type="radio" id="rd_mobbi1" name="rd_mobbi" value="9"></td>
                                            <td align="center"><input type="radio" id="rd_mobbi2" name="rd_mobbi" value="10"></td>
                                            <td align="center"><input type="radio" id="rd_mobbi3" name="rd_mobbi" value="11"></td>
                                            <td align="center"><input type="radio" id="rd_mobbi4" name="rd_mobbi" value="12" checked></td>
                                        </tr>-->
                                        <tr>
                                            <td><span class="amarillo">Mobbi</span> <span class="rojo">2.0</span></td>
                                            <td align="center"><input type="radio" id="rd_mobbi20_1" name="rd_mobbi20" value="9" checked onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_mobbi20_2" name="rd_mobbi20" value="10" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_mobbi20_3" name="rd_mobbi20" value="11" onclick="calculo_puntaje();"></td>
                                            <!--<td align="center"><input type="radio" id="rd_mobbi20_4" name="rd_mobbi20" value="12" checked></td>-->
                                        </tr>
                                        <!--<tr>
                                            <td>Whop</td>
                                            <td align="center"><input type="radio" id="rd_whop1" name="rd_whop" value="9"></td>
                                            <td align="center"><input type="radio" id="rd_whop2" name="rd_whop" value="10"></td>
                                            <td align="center"><input type="radio" id="rd_whop3" name="rd_whop" value="11"></td>
                                            <td align="center"><input type="radio" id="rd_whop4" name="rd_whop" value="12" checked></td>
                                        </tr>-->
                                        <tr>
                                            <td><span class="amarillo">P</span><span class="rojo">DR</span></td>
                                            <td align="center"><input type="radio" id="rd_pdr1" name="rd_pdr" value="9" checked onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_pdr2" name="rd_pdr" value="10" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_pdr3" name="rd_pdr" value="11" onclick="calculo_puntaje();"></td>
                                            <!--<td align="center"><input type="radio" id="rd_pdr4" name="rd_pdr" value="12" checked></td>-->
                                        </tr>
                                        <tr>
                                            <td>Escaner QR</td>
                                            <td align="center"><input type="radio" id="rd_qr1" name="rd_qr" value="9" checked onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_qr2" name="rd_qr" value="10" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_qr3" name="rd_qr" value="11" onclick="calculo_puntaje();"></td>
                                            <!--<td align="center"><input type="radio" id="rd_qr4" name="rd_qr" value="12" checked></td>-->
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Wifi Analizer</span></td>
                                            <td align="center"><input type="radio" id="rd_analizer1" name="rd_analizer" value="9" checked onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_analizer2" name="rd_analizer" value="10" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_analizer3" name="rd_analizer" value="11" onclick="calculo_puntaje();"></td>
                                            <!--<td align="center"><input type="radio" id="rd_analizer4" name="rd_analizer" value="12" checked></td>-->
                                        </tr>
                                        <tr>
                                            <td>Smart Wifi</td>
                                            <td align="center"><input type="radio" id="rd_smart1" name="rd_smart" value="9" checked onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_smart2" name="rd_smart" value="10" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_smart3" name="rd_smart" value="11" onclick="calculo_puntaje();"></td>
                                            <!--<td align="center"><input type="radio" id="rd_smart4" name="rd_smart" value="12" checked></td>-->
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-sm-5 p-3 border centrado" style="background-color: #fafafa">
                                    <table>
                                        <tr>
                                        <td colspan="3" align="left"><label><input type="checkbox" id="chk_app_instaladas_ingresante" />&nbsp;T&eacute;cnico ingresante</label></td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>SI&nbsp;</td>
                                            <td>&nbsp;<span class="amarillo">N</span><span class="rojo">O</span></td>
                                        </tr>
                                        <tr>
                                            <td>Lector QR</td>
                                            <td align="center"><input type="radio" id="rd_lectorqr_1" name="rd_qr_instalada" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_lectorqr_2" name="rd_qr_instalada" value="2" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <!--<tr>
                                            <td>Mobbi 1</td>
                                            <td align="center"><input type="radio" id="rd_instalada_mobbi1_1" name="rd_mobbi1_instalada" value="1" checked>&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_instalada_mobbi1_2" name="rd_mobbi1_instalada" value="2"></td>
                                        </tr>-->
                                        <tr>
                                            <td><span class="rojo">Mobbi 2.0</span></td>
                                            <td align="center"><input type="radio" id="rd_instalada_mobbi2_1" name="rd_mobbi2_instalada" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_instalada_mobbi2_2" name="rd_mobbi2_instalada" value="2" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <!--<tr>
                                            <td>Whop</td>
                                            <td align="center"><input type="radio" id="rd_instalada_whop_1" name="rd_whop_instalada" value="1" checked>&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_instalada_whop_2" name="rd_whop_instalada" value="2"></td>
                                        </tr>-->
                                        <tr>
                                            <td><span class="rojo">PDR</span></td>
                                            <td align="center"><input type="radio" id="rd_instalada_pdr1" name="rd_pdr_instalada" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_instalada_pdr2" name="rd_pdr_instalada" value="2" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Wifi Analizer</span></td>
                                            <td align="center"><input type="radio" id="rd_instalada_analizer_1" name="rd_analizer_instalada" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_instalada_analizer_2" name="rd_analizer_instalada" value="2" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <!--<tr>
                                            <td>Smart Wifi</td>
                                            <td align="center"><input type="radio" id="rd_instalada_smartwifi_1" name="rd_smartwifi_instalada" value="1" checked>&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_instalada_smartwifi_2" name="rd_smartwifi_instalada" value="2"></td>
                                        </tr>-->
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
                                        <td colspan="4" align="left"><label><input type="checkbox" id="chk_herr_fibra_ingresante" />&nbsp;T&eacute;cnico ingresante</label></td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>SI&nbsp;</td>
                                            <td>&nbsp;<span class="amarillo">N</span><span class="rojo">O</span></td>
                                            <td>&nbsp;<span class="amarillo">Mal</span> <span class="rojo">estado</span></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Tijera corte Kevlar</span></td>
                                            <td align="center"><input type="radio" id="rd_kevlar_1" name="rd_kevlar" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_kevlar_2" name="rd_kevlar" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_kevlar_3" name="rd_kevlar" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Cortadora</span> <span class="rojo">Cleaver</span></td>
                                            <td align="center"><input type="radio" id="rd_cleaver_1" name="rd_cleaver" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_cleaver_2" name="rd_cleaver" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_cleaver_3" name="rd_cleaver" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Power Meter</span></td>
                                            <td align="center"><input type="radio" id="rd_pw_1" name="rd_pw" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_pw_2" name="rd_pw" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_pw_3" name="rd_pw" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Pinza peladora triple ranura</span></td>
                                            <td align="center"><input type="radio" id="rd_triple_1" name="rd_triple" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_triple_2" name="rd_triple" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_triple_3" name="rd_triple" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Peladora Drop Rectangular</span></td>
                                            <td align="center"><input type="radio" id="rd_peladrop_1" name="rd_drop" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_peladrop_2" name="rd_drop" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_peladrop_3" name="rd_drop" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="rojo">Alcohol isoprop&iacute;lico</span></td>
                                            <td align="center"><input type="radio" id="rd_alcohol_1" name="rd_alcohol" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_alcohol_2" name="rd_alcohol" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center">&nbsp;</td>
                                            <!--<td align="center"><input type="radio" id="rd_alcohol_3" name="rd_alcohol" value="3"></td>-->
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Pa&ntilde;os</span></td>
                                            <td align="center"><input type="radio" id="rd_panios_1" name="rd_panios" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_panios_2" name="rd_panios" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_panios_3" name="rd_panios" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Linterna l&aacute;ser</span></td>
                                            <td align="center"><input type="radio" id="rd_laser_1" name="rd_laser" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_laser_2" name="rd_laser" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_laser_3" name="rd_laser" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-sm-5 p-3 border centrado" style="background-color: #fafafa">
                                    <table>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>Bueno</td>
                                            <td><span class="amarillo">Regular</span></td>
                                            <td><span class="rojo">Malo</span></td>
                                            <!--<td>Desconoce</td>-->
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Servicios de</span> <span class="rojo">IPTV</span></td>
                                            <td align="center"><input type="radio" id="rd_iptv1" name="rd_iptv" value="13" checked onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_iptv2" name="rd_iptv" value="14" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_iptv3" name="rd_iptv" value="15" onclick="calculo_puntaje();"></td>
                                            <!--<td align="center"><input type="radio" id="rd_iptv4" name="rd_iptv" value="16" checked></td>-->
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">H</span><span class="rojo">GU</span></td>
                                            <td align="center"><input type="radio" id="rd_hgu1" name="rd_hgu" value="13" checked onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_hgu2" name="rd_hgu" value="14" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_hgu3" name="rd_hgu" value="15" onclick="calculo_puntaje();"></td>
                                            <!--<td align="center"><input type="radio" id="rd_hgu4" name="rd_hgu" value="16" checked></td>-->
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">VO</span><span class="rojo">IP</span></td>
                                            <td align="center"><input type="radio" id="rd_voip1" name="rd_voip" value="13" checked onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_voip2" name="rd_voip" value="14" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_voip3" name="rd_voip" value="15" onclick="calculo_puntaje();"></td>
                                            <!--<td align="center"><input type="radio" id="rd_voip4" name="rd_voip" value="16" checked></td>-->
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
                                        <td colspan="4" align="left"><label><input type="checkbox" id="chk_ingresante_herrcobre" />&nbsp;T&eacute;cnico ingresante</label></td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>SI&nbsp;</td>
                                            <td>&nbsp;<span class="amarillo">N</span><span class="rojo">O</span></td>
                                            <td>&nbsp;<span class="amarillo">Mal</span> <span class="rojo">estado</span></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Ali</span><span class="rojo">cate</span></td>
                                            <td align="center"><input type="radio" id="rd_alicate_1" name="rd_alicate" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_alicate_2" name="rd_alicate" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_alicate_3" name="rd_alicate" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Pin</span><span class="rojo">zas</span></td>
                                            <td align="center"><input type="radio" id="rd_pinzas_1" name="rd_pinzas" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_pinzas_2" name="rd_pinzas" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_pinzas_3" name="rd_pinzas" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Destorni</span><span class="rojo">lladores</span></td>
                                            <td align="center"><input type="radio" id="rd_destornilla_1" name="rd_destornilla" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_destornilla_2" name="rd_destornilla" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_destornilla_13" name="rd_destornilla" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Agujereadora</span> / <span class="rojo">Mechas</span></td>
                                            <td align="center"><input type="radio" id="rd_agu_1" name="rd_agu" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_agu_2" name="rd_agu" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_agu_3" name="rd_agu" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Micro</span> <span class="rojo">tel&eacute;fono</span></td>
                                            <td align="center"><input type="radio" id="rd_micro_1" name="rd_micro" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_micro_2" name="rd_micro" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_micro_3" name="rd_micro" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Cable</span> <span class="rojo">inst. interna</span></td>
                                            <td align="center"><input type="radio" id="rd_interna_1" name="rd_interna" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_interna_2" name="rd_interna" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_interna_3" name="rd_interna" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Ficha</span> <span class="rojo">amerciana</span></td>
                                            <td align="center"><input type="radio" id="rd_ficha_1" name="rd_ficha" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_ficha_2" name="rd_ficha" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_ficha_3" name="rd_ficha" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Filtro</span> <span class="rojo">combinado</span></td>
                                            <td align="center"><input type="radio" id="rd_filtro_1" name="rd_filtro" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_filtro_2" name="rd_filtro" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_filtro_3" name="rd_filtro" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Mar</span><span class="rojo">tillo</span></td>
                                            <td align="center"><input type="radio" id="rd_martillo_1" name="rd_martillo" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_martillo_2" name="rd_martillo" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_martillo_3" name="rd_martillo" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Pasa</span> <span class="rojo">cable</span></td>
                                            <td align="center"><input type="radio" id="rd_pasa_cable_1" name="rd_pasa_cable" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_pasa_cable_2" name="rd_pasa_cable" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_pasa_cable_3" name="rd_pasa_cable" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                        <tr>
                                            <td><span class="amarillo">Alar</span><span class="rojo">gue</span> / <span class="amarillo">Sili</span><span class="rojo">cona</span></td>
                                            <td align="center"><input type="radio" id="rd_alargue_1" name="rd_alargue" value="1" checked onclick="calculo_puntaje();">&nbsp;</td>
                                            <td align="center">&nbsp;<input type="radio" id="rd_alargue_2" name="rd_alargue" value="2" onclick="calculo_puntaje();"></td>
                                            <td align="center"><input type="radio" id="rd_alargue_3" name="rd_alargue" value="3" onclick="calculo_puntaje();"></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-sm-5 p-2 centrado">
                                        <div class="form-group row">
                                            <label for="drop_metodo" class="col-sm-4 col-form-label">M&eacute;todo constructivo</label>
                                            <select id="drop_metodo" class="form-control col-sm-4" onchange="calculo_puntaje();">
                                                <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                                <option value="21">Bueno</option>
                                                <option class="amarillo" value="22">Regular</option>
                                                <option class="rojo" value="23">Malo</option>
                                                <option value="27">T&eacute;cnico ingresante</option>
                                            </select>
                                        </div>
                                        <div class="form-group row">
                                            <label for="drop_plano" class="col-sm-4 col-form-label">Armado conector Plano</label>
                                            <select id="drop_plano" class="form-control col-sm-4" onchange="calculo_puntaje();">
                                                <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                                <option value="21">Bueno</option>
                                                <option class="amarillo" value="22">Regular</option>
                                                <option class="rojo" value="23">Malo</option>
                                                <option value="29">Conectorizado</option>
                                                <!--<option value="24">Desconoce</option>
                                                <option value="25">No realiz&oacute;</option>-->
                                                <option value="28">No se calibró</option>
                                            </select>
                                        </div>
                                        <div class="form-group row">
                                            <label for="drop_circular" class="col-sm-4 col-form-label">Armado conector Circular</label>
                                            <select id="drop_circular" class="form-control col-sm-4" onchange="calculo_puntaje();">
                                                <option value="0" selected>--Seleccione una opci&oacute;n--</option>
                                                <option value="21">Bueno</option>
                                                <option class="amarillo" value="22">Regular</option>
                                                <option class="rojo" value="23">Malo</option>
                                                <option value="29">Conectorizado</option>
                                                <!--<option value="24">Desconoce</option>
                                                <option value="25">No realiz&oacute;</option>-->
                                                <option value="28">No se calibró</option>
                                            </select>
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

                            <div class="row">
                                <div class="col-sm-12">
                                    <label id="lbl_id_pendiente" hidden></label>
                                    <center>
                                        <input class="btn btn-primary mr-2" type="button" id="btn_guardar" value="Guardar" onclick="guardar(3)" />
                                        <asp:Button ID="btn_limpiar" runat="server" Text="Nuevo" CssClass="btn btn-primary ml-2" />
                                    </center>
                                </div>
                            </div>

                        </div><!-- /.card-body -->
                    </div><!-- /.card -->
                </div>
            </div><!-- /.row -->

        </div><!-- /.container -->
    </section>
    </div>

    <!-- Javascript correspondientes a Monitoreos -->
    <script type="text/javascript" src="js/monitoreos.js?v=<%= Session["rd_number"] %>"></script>

    <script type="text/javascript">
        $(document).ready(function () {

        })

        function chk_condicion(chequeado) {
            var chk_condicion = document.getElementById("chk_veh_condiciones");
            var chk_regular = document.getElementById("chk_veh_estregular");
            var chk_mal_estado = document.getElementById("chk_veh_mal_estado");
            var chk_sidentificacion = document.getElementById("chk_veh_sinidentif");

            switch (chequeado) {
                case 1:
                    chk_regular.checked = false;
                    chk_mal_estado.checked = false;
                    //chk_sidentificacion.checked = false;
                    break;
                case 2:
                    chk_condicion.checked = false;
                    chk_mal_estado.checked = false;
                    //chk_sidentificacion.checked = false;
                    break;
                case 3:
                    chk_regular.checked = false;
                    chk_condicion.checked = false;
                    //chk_sidentificacion.checked = false;
                    break;
                /*
                case 4:
                chk_regular.checked = false;
                chk_mal_estado.checked = false;
                chk_condicion.checked = false;
                */ 
            }
        }

        function ingresante_checado() {
            var chk_tecnico = document.getElementById("chk_tecnico");
            var chk_tecnico_ingresante = document.getElementById("chk_ingresante_herrcobre");
            //VEHICULO
            var chk_veh_ingresante = document.getElementById("chk_veh_ingresante");
            var chk_condicion = document.getElementById("chk_veh_condiciones");
            var chk_regular = document.getElementById("chk_veh_estregular");
            var chk_mal_estado = document.getElementById("chk_veh_mal_estado");
            var chk_sidentificacion = document.getElementById("chk_veh_sinidentif");
            var chk_sin_escalera = document.getElementById("chk_veh_sescalera");
            var chk_sporta = document.getElementById("chk_vhe_sporta");
            //FIN VEHICULO
            var chk_app_ingresante = document.getElementById("chk_app_instaladas_ingresante");
            var chk_fibra_ingresante = document.getElementById("chk_herr_fibra_ingresante");

            if (chk_tecnico.checked) {
                chk_tecnico_ingresante.checked = true;
                chk_veh_ingresante.checked = true;
                chk_veh_ingresante.disabled = true;
                chk_condicion.disabled = true;
                chk_condicion.checked = true;
                chk_regular.disabled = true;
                chk_regular.checked = false;
                chk_mal_estado.disabled = true;
                chk_mal_estado.checked = false;
                chk_sidentificacion.disabled = true;
                chk_sidentificacion.checked = false;
                chk_sin_escalera.disabled = true;
                chk_sin_escalera.checked = false;
                chk_sporta.disabled = true;
                chk_sporta.checked = false;
                chk_app_ingresante.checked = true;
                chk_fibra_ingresante.checked = true;
                $("#drop_credencial option[value='6']").attr("selected", true);
                $("#drop_equipo option[value='5']").attr("selected", true);
                $("#drop_kit_sanidad option[value='7']").attr("selected", true);
                $("#drop_epp option[value='27']").attr("selected", true);
                $("#drop_presencia option[value='7']").attr("selected", true);
                $("#drop_metodo option[value='27']").attr("selected", true);

                for (i = 0; i < document.getElementsByName("rd_qr_instalada").length; i++) {
                    document.getElementsByName("rd_qr_instalada")[i].disabled = true;
                }
                document.getElementsByName("rd_qr_instalada")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_mobbi2_instalada").length; i++) {
                    document.getElementsByName("rd_mobbi2_instalada")[i].disabled = true;
                }
                document.getElementsByName("rd_mobbi2_instalada")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_pdr_instalada").length; i++) {
                    document.getElementsByName("rd_pdr_instalada")[i].disabled = true;
                }
                document.getElementsByName("rd_pdr_instalada")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_analizer_instalada").length; i++) {
                    document.getElementsByName("rd_analizer_instalada")[i].disabled = true;
                }
                document.getElementsByName("rd_analizer_instalada")[0].checked = true;

                for (i = 0; i < document.getElementsByName("rd_kevlar").length; i++) {
                    document.getElementsByName("rd_kevlar")[i].disabled = true;
                }
                document.getElementsByName("rd_kevlar")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_cleaver").length; i++) {
                    document.getElementsByName("rd_cleaver")[i].disabled = true;
                }
                document.getElementsByName("rd_cleaver")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_pw").length; i++) {
                    document.getElementsByName("rd_pw")[i].disabled = true;
                }
                document.getElementsByName("rd_pw")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_triple").length; i++) {
                    document.getElementsByName("rd_triple")[i].disabled = true;
                }
                document.getElementsByName("rd_triple")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_drop").length; i++) {
                    document.getElementsByName("rd_drop")[i].disabled = true;
                }
                document.getElementsByName("rd_drop")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_alcohol").length; i++) {
                    document.getElementsByName("rd_alcohol")[i].disabled = true;
                }
                document.getElementsByName("rd_alcohol")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_panios").length; i++) {
                    document.getElementsByName("rd_panios")[i].disabled = true;
                }
                document.getElementsByName("rd_panios")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_laser").length; i++) {
                    document.getElementsByName("rd_laser")[i].disabled = true;
                }
                document.getElementsByName("rd_laser")[0].checked = true;

                for (i = 0; i < document.getElementsByName("rd_alicate").length; i++) {
                    document.getElementsByName("rd_alicate")[i].disabled = true;
                }
                document.getElementsByName("rd_alicate")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_pinzas").length; i++) {
                    document.getElementsByName("rd_pinzas")[i].disabled = true;
                }
                document.getElementsByName("rd_pinzas")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_destornilla").length; i++) {
                    document.getElementsByName("rd_destornilla")[i].disabled = true;
                }
                document.getElementsByName("rd_destornilla")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_agu").length; i++) {
                    document.getElementsByName("rd_agu")[i].disabled = true;
                }
                document.getElementsByName("rd_agu")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_micro").length; i++) {
                    document.getElementsByName("rd_micro")[i].disabled = true;
                }
                document.getElementsByName("rd_micro")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_interna").length; i++) {
                    document.getElementsByName("rd_interna")[i].disabled = true;
                }
                document.getElementsByName("rd_interna")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_ficha").length; i++) {
                    document.getElementsByName("rd_ficha")[i].disabled = true;
                }
                document.getElementsByName("rd_ficha")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_filtro").length; i++) {
                    document.getElementsByName("rd_filtro")[i].disabled = true;
                }
                document.getElementsByName("rd_filtro")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_martillo").length; i++) {
                    document.getElementsByName("rd_martillo")[i].disabled = true;
                }
                document.getElementsByName("rd_martillo")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_pasa_cable").length; i++) {
                    document.getElementsByName("rd_pasa_cable")[i].disabled = true;
                }
                document.getElementsByName("rd_pasa_cable")[0].checked = true;
                for (i = 0; i < document.getElementsByName("rd_alargue").length; i++) {
                    document.getElementsByName("rd_alargue")[i].disabled = true;
                }
                document.getElementsByName("rd_alargue")[0].checked = true;
            }
            else {
                chk_tecnico_ingresante.checked = false;
                chk_veh_ingresante.checked = false;
                chk_veh_ingresante.disabled = false;
                chk_condicion.disabled = false;
                chk_regular.disabled = false;
                chk_mal_estado.disabled = false;
                chk_sidentificacion.disabled = false;
                chk_sin_escalera.disabled = false;
                chk_sporta.disabled = false;
                chk_app_ingresante.checked = false;
                chk_fibra_ingresante.checked = false;
                $("#drop_credencial option[value='0']").attr("selected", true);
                $("#drop_equipo option[value='0']").attr("selected", true);
                $("#drop_kit_sanidad option[value='0']").attr("selected", true);
                $("#drop_epp option[value='0']").attr("selected", true);
                $("#drop_presencia option[value='0']").attr("selected", true);
                $("#drop_metodo option[value='0']").attr("selected", true);

                for (i = 0; i < document.getElementsByName("rd_qr_instalada").length; i++) {
                    document.getElementsByName("rd_qr_instalada")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_mobbi2_instalada").length; i++) {
                    document.getElementsByName("rd_mobbi2_instalada")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_pdr_instalada").length; i++) {
                    document.getElementsByName("rd_pdr_instalada")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_analizer_instalada").length; i++) {
                    document.getElementsByName("rd_analizer_instalada")[i].disabled = false;
                }

                for (i = 0; i < document.getElementsByName("rd_kevlar").length; i++) {
                    document.getElementsByName("rd_kevlar")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_cleaver").length; i++) {
                    document.getElementsByName("rd_cleaver")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_pw").length; i++) {
                    document.getElementsByName("rd_pw")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_triple").length; i++) {
                    document.getElementsByName("rd_triple")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_drop").length; i++) {
                    document.getElementsByName("rd_drop")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_alcohol").length; i++) {
                    document.getElementsByName("rd_alcohol")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_panios").length; i++) {
                    document.getElementsByName("rd_panios")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_laser").length; i++) {
                    document.getElementsByName("rd_laser")[i].disabled = false;
                }

                for (i = 0; i < document.getElementsByName("rd_alicate").length; i++) {
                    document.getElementsByName("rd_alicate")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_pinzas").length; i++) {
                    document.getElementsByName("rd_pinzas")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_destornilla").length; i++) {
                    document.getElementsByName("rd_destornilla")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_agu").length; i++) {
                    document.getElementsByName("rd_agu")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_micro").length; i++) {
                    document.getElementsByName("rd_micro")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_interna").length; i++) {
                    document.getElementsByName("rd_interna")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_ficha").length; i++) {
                    document.getElementsByName("rd_ficha")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_filtro").length; i++) {
                    document.getElementsByName("rd_filtro")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_martillo").length; i++) {
                    document.getElementsByName("rd_martillo")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_pasa_cable").length; i++) {
                    document.getElementsByName("rd_pasa_cable")[i].disabled = false;
                }
                for (i = 0; i < document.getElementsByName("rd_alargue").length; i++) {
                    document.getElementsByName("rd_alargue")[i].disabled = false;
                }
            }
        }

        function calculo_puntaje() {
            var puntaje_total = 0;

            var credencial = document.getElementById("drop_credencial").value;
            var eq_celular = document.getElementById("drop_equipo").value;
            //CHECKBOX (Vehículo)
            var chk_condicion = document.getElementById("chk_veh_condiciones");
            var chk_regular = document.getElementById("chk_veh_estregular");
            var chk_mal = document.getElementById("chk_veh_mal_estado");
            if (chk_condicion.checked) {
                var veh_estado = chk_condicion.value;
            }
            if (chk_regular.checked) {
                var veh_estado = chk_regular.value;
            }
            if (chk_mal.checked) {
                var veh_estado = chk_mal.value;
            }
            var chk_sidentif = document.getElementById("chk_veh_sinidentif").value;
            var chk_sescalera = document.getElementById("chk_veh_sescalera").value;
            var chk_sporta = document.getElementById("chk_vhe_sporta").value;
            var chk_ingresante = document.getElementById("chk_veh_ingresante").value;

            var kit_sanidad = document.getElementById("drop_kit_sanidad").value;
            var epp = document.getElementById("drop_epp").value;
            var vestimenta = document.getElementById("drop_presencia").value;

            var drop_metodo = document.getElementById("drop_metodo").value;
            var drop_plano = document.getElementById("drop_plano").value;
            var drop_circular = document.getElementById("drop_circular").value;

            //VALORES DE LOS RADIO BUTTON
            //Conocimiento uso de APP
            var radio_mobbi20 = document.getElementsByName('rd_mobbi20');
            for (i = 0; i < radio_mobbi20.length; i++) {
                if (radio_mobbi20[i].checked) {
                    var valor_mobbi20 = radio_mobbi20[i].value;
                }
            }
            var radio_pdr = document.getElementsByName('rd_pdr');
            for (i = 0; i < radio_pdr.length; i++) {
                if (radio_pdr[i].checked) {
                    var valor_pdr = radio_pdr[i].value;
                }
            }
            var radio_qr = document.getElementsByName('rd_qr');
            for (i = 0; i < radio_qr.length; i++) {
                if (radio_qr[i].checked) {
                    var valor_qr = radio_qr[i].value;
                }
            }
            var radio_analizer = document.getElementsByName('rd_analizer');
            for (i = 0; i < radio_analizer.length; i++) {
                if (radio_analizer[i].checked) {
                    var valor_analizer = radio_analizer[i].value;
                }
            }
            var radio_smart = document.getElementsByName('rd_smart');
            for (i = 0; i < radio_smart.length; i++) {
                if (radio_smart[i].checked) {
                    var valor_smart = radio_smart[i].value;
                }
            }

            //APP Instaladas
            var radio_mobbi20_inst = document.getElementsByName('rd_mobbi2_instalada');
            for (i = 0; i < radio_mobbi20_inst.length; i++) {
                if (radio_mobbi20_inst[i].checked) {
                    var valor_mobbi20_inst = radio_mobbi20_inst[i].value;
                }
            }
            var radio_pdr_inst = document.getElementsByName('rd_pdr_instalada');
            for (i = 0; i < radio_pdr_inst.length; i++) {
                if (radio_pdr_inst[i].checked) {
                    var valor_pdr_inst = radio_pdr_inst[i].value;
                }
            }
            var radio_qr_ints = document.getElementsByName('rd_qr_instalada');
            for (i = 0; i < radio_qr_ints.length; i++) {
                if (radio_qr_ints[i].checked) {
                    var valor_qr_ints = radio_qr_ints[i].value;
                }
            }
            var radio_analizer_inst = document.getElementsByName('rd_analizer_instalada');
            for (i = 0; i < radio_analizer_inst.length; i++) {
                if (radio_analizer_inst[i].checked) {
                    var valor_analizer_inst = radio_analizer_inst[i].value;
                }
            }

            //Herramientas KIT Fibra
            var radio_kevlar = document.getElementsByName('rd_kevlar');
            for (i = 0; i < radio_kevlar.length; i++) {
                if (radio_kevlar[i].checked) {
                    var valor_kevlar = radio_kevlar[i].value;
                }
            }
            var radio_cleaver = document.getElementsByName('rd_cleaver');
            for (i = 0; i < radio_cleaver.length; i++) {
                if (radio_cleaver[i].checked) {
                    var valor_cleaver = radio_cleaver[i].value;
                }
            }
            var radio_pw = document.getElementsByName('rd_pw');
            for (i = 0; i < radio_pw.length; i++) {
                if (radio_pw[i].checked) {
                    var valor_pw = radio_pw[i].value;
                }
            }
            var radio_triple = document.getElementsByName('rd_triple');
            for (i = 0; i < radio_triple.length; i++) {
                if (radio_triple[i].checked) {
                    var valor_triple = radio_triple[i].value;
                }
            }
            var radio_drop = document.getElementsByName('rd_drop');
            for (i = 0; i < radio_drop.length; i++) {
                if (radio_drop[i].checked) {
                    var valor_drop = radio_drop[i].value;
                }
            }
            var radio_alcohol = document.getElementsByName('rd_alcohol');
            for (i = 0; i < radio_alcohol.length; i++) {
                if (radio_alcohol[i].checked) {
                    var valor_alcohol = radio_alcohol[i].value;
                }
            }
            var radio_panios = document.getElementsByName('rd_panios');
            for (i = 0; i < radio_panios.length; i++) {
                if (radio_panios[i].checked) {
                    var valor_panios = radio_panios[i].value;
                }
            }
            var radio_laser = document.getElementsByName('rd_laser');
            for (i = 0; i < radio_laser.length; i++) {
                if (radio_laser[i].checked) {
                    var valor_laser = radio_laser[i].value;
                }
            }

            //Procesos
            var radio_iptv = document.getElementsByName('rd_iptv');
            for (i = 0; i < radio_iptv.length; i++) {
                if (radio_iptv[i].checked) {
                    var valor_iptv = radio_iptv[i].value;
                }
            }
            var radio_hgu = document.getElementsByName('rd_hgu');
            for (i = 0; i < radio_hgu.length; i++) {
                if (radio_hgu[i].checked) {
                    var valor_hgu = radio_hgu[i].value;
                }
            }
            var radio_voip = document.getElementsByName('rd_voip');
            for (i = 0; i < radio_voip.length; i++) {
                if (radio_voip[i].checked) {
                    var valor_voip = radio_voip[i].value;
                }
            }

            //COBRE Adaptacion (VOIP)
            var radio_alicate = document.getElementsByName('rd_alicate');
            for (i = 0; i < radio_alicate.length; i++) {
                if (radio_alicate[i].checked) {
                    var valor_alicate = radio_alicate[i].value;
                }
            }
            var radio_pinzas = document.getElementsByName('rd_pinzas');
            for (i = 0; i < radio_pinzas.length; i++) {
                if (radio_pinzas[i].checked) {
                    var valor_pinzas = radio_pinzas[i].value;
                }
            }
            var radio_destornilla = document.getElementsByName('rd_destornilla');
            for (i = 0; i < radio_destornilla.length; i++) {
                if (radio_destornilla[i].checked) {
                    var valor_destornilla = radio_destornilla[i].value;
                }
            }
            var radio_agu = document.getElementsByName('rd_agu');
            for (i = 0; i < radio_agu.length; i++) {
                if (radio_agu[i].checked) {
                    var valor_agu = radio_agu[i].value;
                }
            }
            var radio_micro = document.getElementsByName('rd_micro');
            for (i = 0; i < radio_micro.length; i++) {
                if (radio_micro[i].checked) {
                    var valor_micro = radio_micro[i].value;
                }
            }
            var radio_interna = document.getElementsByName('rd_interna');
            for (i = 0; i < radio_interna.length; i++) {
                if (radio_interna[i].checked) {
                    var valor_interna = radio_interna[i].value;
                }
            }
            var radio_ficha = document.getElementsByName('rd_ficha');
            for (i = 0; i < radio_ficha.length; i++) {
                if (radio_ficha[i].checked) {
                    var valor_ficha = radio_ficha[i].value;
                }
            }
            var radio_filtro = document.getElementsByName('rd_filtro');
            for (i = 0; i < radio_filtro.length; i++) {
                if (radio_filtro[i].checked) {
                    var valor_filtro = radio_filtro[i].value;
                }
            }
            var radio_martillo = document.getElementsByName('rd_martillo');
            for (i = 0; i < radio_martillo.length; i++) {
                if (radio_martillo[i].checked) {
                    var valor_martillo = radio_martillo[i].value;
                }
            }
            var radio_pcable = document.getElementsByName('rd_pasa_cable');
            for (i = 0; i < radio_pcable.length; i++) {
                if (radio_pcable[i].checked) {
                    var valor_pcable = radio_pcable[i].value;
                }
            }
            var radio_alargue = document.getElementsByName('rd_alargue');
            for (i = 0; i < radio_alargue.length; i++) {
                if (radio_alargue[i].checked) {
                    var valor_alargue = radio_alargue[i].value;
                }
            }

            /////////////////////////////////////////////CALCULO DE PUNTAJES/////////////////////////////////////////////////////////////////
            switch (credencial) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "5": puntaje_total = puntaje_total + 5;
                    break;
                case "6": puntaje_total = puntaje_total + 10;
            }
            //alert("Puntaje credencial: " + puntaje_total.toString());

            switch (eq_celular) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "6": puntaje_total = puntaje_total - 400;
                    break;
                case "4": puntaje_total = puntaje_total - 400;
                    break;
                case "5": puntaje_total = puntaje_total + 10;
            }
            //alert("Puntaje eq.celular: " + puntaje_total.toString());

            if (chk_condicion.checked) {
                puntaje_total = puntaje_total + 10;
                //alert("Puntaje veh OK: " + puntaje_total.toString());
            }
            if (chk_regular.checked) {
                puntaje_total = puntaje_total + 5;
                //alert("Puntaje veh regular: " + puntaje_total.toString());
            }
            if (chk_ingresante.checked) {
                puntaje_total = puntaje_total + 10;
                //alert("Puntaje veh tec.ingresante: " + puntaje_total.toString());
            }

            switch (kit_sanidad) {
                case "3": puntaje_total = puntaje_total + 10;
                    break;
                case "4": puntaje_total = puntaje_total - 400;
                    break;
                case "5": puntaje_total = puntaje_total - 2000;
                    break;
                case "6": puntaje_total = puntaje_total - 2000;
                    break;
                case "7": puntaje_total = puntaje_total + 10;
            }
            //alert("Puntaje kit sanidad: " + puntaje_total.toString());

            switch (epp) {
                case "17": puntaje_total = puntaje_total + 10;
                    break;
                case "18": puntaje_total = puntaje_total - 2000;
                    break;
                case "26": puntaje_total = puntaje_total - 400;
                    break;
                case "27": puntaje_total = puntaje_total + 10;
            }
            //alert("Puntaje EPP: " + puntaje_total.toString());

            switch (vestimenta) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total + 5;
                    break;
                case "4": puntaje_total = puntaje_total - 400;
                    break;
                case "7": puntaje_total = puntaje_total + 10;
            }
            //alert("Puntaje vestimenta: " + puntaje_total.toString());

            //Conocimiento uso de APP
            switch (valor_mobbi20) {
                case "9": puntaje_total = puntaje_total + 10;
                    break;
                case "10": puntaje_total = puntaje_total - 400;
                    break;
                case "11": puntaje_total = puntaje_total - 2000;
            }
            //alert("Puntaje conoc.uso Mobbi 2.0: " + puntaje_total.toString());
            switch (valor_pdr) {
                case "9": puntaje_total = puntaje_total + 10;
                    break;
                case "10": puntaje_total = puntaje_total - 400;
                    break;
                case "11": puntaje_total = puntaje_total - 2000;
            }
            switch (valor_qr) {
                case "9": puntaje_total = puntaje_total + 10;
                    break;
                case "10": puntaje_total = puntaje_total - 5;
            }
            switch (valor_analizer) {
                case "9": puntaje_total = puntaje_total + 10;
                    break;
                case "10": puntaje_total = puntaje_total - 400;
                    break;
                case "11": puntaje_total = puntaje_total - 400;
            }
            switch (valor_smart) {
                case "9": puntaje_total = puntaje_total + 10;
                    break;
                case "10": puntaje_total = puntaje_total - 5;
            }
            //APP Instaladas
            switch (valor_mobbi20_inst) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 2000;
            }
            //alert("Puntaje APP inst. Mobbi 2.0: " + puntaje_total.toString());
            switch (valor_pdr_inst) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 2000;
            }
            switch (valor_qr_ints) {
                case "1": puntaje_total = puntaje_total + 10;
            }
            switch (valor_analizer_inst) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
            }
            //Herramientas KIT fibra
            switch (valor_kevlar) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            //alert("Puntaje herr.fibra Kevlar: " + puntaje_total.toString());
            switch (valor_cleaver) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 2000;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            //alert("Puntaje herr.fibra cleaver: " + puntaje_total.toString());
            switch (valor_pw) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            //alert("Puntaje herr.fibra power meter: " + puntaje_total.toString());
            switch (valor_triple) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            //alert("Puntaje herr.fibra triple: " + puntaje_total.toString());
            switch (valor_drop) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            //alert("Puntaje herr.fibra drop: " + puntaje_total.toString());
            switch (valor_alcohol) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 2000;
            }
            //alert("Puntaje herr.fibra alcohol: " + puntaje_total.toString());
            switch (valor_panios) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            //alert("Puntaje herr.fibra panios: " + puntaje_total.toString());
            switch (valor_laser) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            //alert("Puntaje herr.fibra Laser: " + puntaje_total.toString());
            //Procesos y conocimientos
            switch (valor_iptv) {
                case "13": puntaje_total = puntaje_total + 10;
                    break;
                case "14": puntaje_total = puntaje_total - 400;
                    break;
                case "15": puntaje_total = puntaje_total - 2000;
            }
            //alert("Puntaje procesos y conoc. IPTV: " + puntaje_total.toString());
            switch (valor_hgu) {
                case "13": puntaje_total = puntaje_total + 10;
                    break;
                case "14": puntaje_total = puntaje_total - 400;
                    break;
                case "15": puntaje_total = puntaje_total - 2000;
            }
            //alert("Puntaje procesos y conoc. HGU: " + puntaje_total.toString());
            switch (valor_voip) {
                case "13": puntaje_total = puntaje_total + 10;
                    break;
                case "14": puntaje_total = puntaje_total - 400;
                    break;
                case "15": puntaje_total = puntaje_total - 2000;
            }
            //alert("Puntaje procesos y conoc. VOIP: " + puntaje_total.toString());
            //Cobre (Adaptacion VOIP)
            switch (valor_alicate) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            //alert("Puntaje herr.cobre alicate: " + puntaje_total.toString());
            switch (valor_pinzas) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            switch (valor_destornilla) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            switch (valor_agu) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
                    break;
            }
            switch (valor_micro) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            switch (valor_interna) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            switch (valor_ficha) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            switch (valor_filtro) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            switch (valor_martillo) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            switch (valor_pcable) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            switch (valor_alargue) {
                case "1": puntaje_total = puntaje_total + 10;
                    break;
                case "2": puntaje_total = puntaje_total - 400;
                    break;
                case "3": puntaje_total = puntaje_total - 400;
            }
            //Método constructivo
            switch (drop_metodo) {
                case "21": puntaje_total = puntaje_total + 10;
                    break;
                case "22": puntaje_total = puntaje_total - 400;
                    break;
                case "23": puntaje_total = puntaje_total - 2000;
            }
            //alert("Puntaje metodo constr.: " + puntaje_total.toString());
            //Armado de conector
            switch (drop_circular) {
                case "21": puntaje_total = puntaje_total + 10;
                    break;
                case "22": puntaje_total = puntaje_total - 400;
                    break;
                case "23": puntaje_total = puntaje_total - 2000;
                    break;
                case "29": puntaje_total = puntaje_total + 10;
            }
            //alert("Puntaje armado drop circular: " + puntaje_total.toString());
            switch (drop_plano) {
                case "21": puntaje_total = puntaje_total + 10;
                    break;
                case "22": puntaje_total = puntaje_total - 400;
                    break;
                case "23": puntaje_total = puntaje_total - 2000;
                    break;
                case "29": puntaje_total = puntaje_total + 10;
            }

            //CALIFICACION FINAL
            //Apto
            if (puntaje_total >= 240 && puntaje_total <= 400) {
                document.getElementById("rd_1").checked = true;
                document.getElementById("txt_resultado").innerHTML = "<span class='blanco_grande'>APTO</span>";
            }
            //Regular
            if (puntaje_total >= -1600 && puntaje_total <= 235) {
                document.getElementById("rd_2").checked = true;
                document.getElementById("txt_obs").innerHTML = " .: VOLVER A MONITOREAR EN 72HS :. ";
                document.getElementById("txt_resultado").innerHTML = "<span class='amarillo_grande'>PROVISORIO</span>";
            }
            //No apto
            if (puntaje_total >= -36800 && puntaje_total <= -1610) {
                document.getElementById("rd_3").checked = true;
                document.getElementById("txt_obs").innerHTML = " .: VOLVER A MONITOREAR EN 24 O 36HS :. ";
                document.getElementById("txt_resultado").innerHTML = "<span class='rojo_grande'>NO APTO</span>";
            }
        }
    </script>
</asp:Content>
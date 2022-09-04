<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="medallia_graphs1.aspx.cs" Inherits="medallia.medallia_graphs1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<script src="js/highcharts.js"></script>
<script src="js/exporting.js"></script>

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <!--<div class="col-sm-6"><h1>Inline Charts</h1></div>-->
                <div class="col-sm-12">
                    <ol class="breadcrumb float-sm-right">
                      <li class="breadcrumb-item"><a href="index.aspx">Home</a></li>
                      <li class="breadcrumb-item">Medallia</li>
                      <li class="breadcrumb-item active">Indicador por motivos</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <!-- jQuery Knob -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">
                              <i class="far fa-chart-bar"></i>
                              &nbsp;Motivos detracci&oacute;n
                            </h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                                <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row pb-1">
                                <div class="col-sm-12">
                                    <div class="form-group row">
                                        <div class="col-sm-3" id="div_ctta_cbo">
                                            <select class="form-control" id="cbo_ctta"></select>
                                        </div>

                                        <label for="dat_inicio" class="col-sm col-form-label">Fecha inicio</label>
                                        <div class="col-sm">
                                            <input type="date" class="form-control" id="dat_inicio" />
                                        </div>

                                        <label for="dat_fin" class="col-sm col-form-label">Fecha fin</label>
                                        <div class="col-sm">
                                            <input type="date" class="form-control" id="dat_fin" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row pb-1">
                                <div class="col-1">
                                    <input type="button" class="form-control btn btn-primary" id="btn_ver" value="Ver" onclick="dibuja_motivos_empresa_fecha('<%= Session["centro_sesion"] %>');" />
                                </div>
                            </div>

                            <div class="row pb-4 text-center">
                                <div class="col-sm">
                                    <label id="lbl_fecha"></label>
                                </div>
                            </div>

                            <div class="row pb-4 text-center">
                                <div class="col-sm">
                                    <h4>MOTIVOS DETRACTOR</h4>
                                </div>
                            </div>

                            <div class="row justify-content-center">
                                <div class="col-4 col-md-3 text-center">
                                    <input type="text" class="knob" id="txt_cliente" data-width="120" data-height="120" data-fgColor="#00a65a" readonly>
                                    <div class="knob-label" style="cursor: pointer;" onclick="dibuja_barra_motivos('<%= Session["centro_sesion"] %>','Cliente','');">
                                        <h5>%</h5>
                                        CLIENTE</br>
                                        <strong id="str_cliente"></strong>
                                    </div>
                                </div>
                                <!-- ./col -->
                                <div class="col-4 col-md-3 text-center">
                                    <input type="text" class="knob" id="txt_comercial" data-width="120" data-height="120" data-fgColor="#39CCCC" readonly>
                                    <div class="knob-label" style="cursor: pointer;" onclick="dibuja_barra_motivos('<%= Session["centro_sesion"] %>','Comercial','');">
                                        <h5>%</h5>
                                        COMERCIAL</br>
                                        <strong id="str_comercial"></strong>
                                    </div>
                                </div>
                                <!-- ./col -->
                                <div class="col-4 col-md-3 text-center">
                                    <input type="text" class="knob" id="txt_despacho" data-width="120" data-height="120" data-fgColor="#f56954" readonly>
                                    <div class="knob-label" style="cursor: pointer;" onclick="dibuja_barra_motivos('<%= Session["centro_sesion"] %>','Despacho provisión','');">
                                        <h5>%</h5>
                                        DESPACHO PROVISION</br>
                                        <strong id="str_despacho"></strong>
                                    </div>
                                </div>
                                <!-- ./col -->
                                <div class="col-4 col-md-3 text-center">
                                    <input type="text" class="knob" id="txt_tecnico" data-width="120" data-height="120" data-fgColor="#3c8dbc" readonly>
                                    <div class="knob-label" style="cursor: pointer;" onclick="dibuja_motivos_tecnico('<%= Session["centro_sesion"] %>','Técnico');">
                                        <h5>%</h5>
                                        TECNICO</br>
                                        <strong id="str_tecnico"></strong>
                                    </div>
                                </div>
                            </div>

                            <div class="row p-4 text-center" id="div_conceptos" style="display: none">
                                <div class="col-sm">
                                    <h5>CONCEPTO TECNICO</h5>
                                </div>
                            </div>

                            <div id="div_row_circulos_1" style="display: none">
                                <div class="d-flex justify-content-center">
                                    <div class="col-4 col-md-3 text-center">
                                        <input type="text" class="knob" id="txt_conectividad" data-width="90" data-height="90" data-fgColor="#00a65a" readonly>
                                        <div class="knob-label" style="cursor: pointer;" onclick="dibuja_barra_motivos('<%= Session["centro_sesion"] %>','','Conectividad');">
                                            <h5>%</h5>
                                            CONECTIVIDAD</br>
                                            <strong id="str_conectividad"></strong>
                                        </div>
                                    </div>
                                    <!-- ./col -->
                                    <div class="col-4 col-md-3 text-center">
                                        <input type="text" class="knob" id="txt_contexto_tecnico" data-width="90" data-height="90" data-fgColor="#3c8dbc" readonly>
                                        <div class="knob-label" style="cursor: pointer;" onclick="dibuja_barra_motivos('<%= Session["centro_sesion"] %>','','Contexto técnico');">
                                            <h5>%</h5>
                                            CONTEXTO TECNICO</br>
                                            <strong id="str_contexto_tecnico"></strong>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4" id="div_row_barras" style="display: none">
                                <div class="col-md-10 offset-md-1">
                                    <div id="contenedor" style="height: 500px;"></div>
                                </div>
                            </div>

                            <div class="row mt-4" id="div_row_barras_detalle" style="display: none">
                                <div class="col-md-10 offset-md-1">
                                    <div id="contenedor_2" style="height: 500px;"></div>
                                </div>
                            </div>

                            <div class="row mt-4" id="div_tabla_detalle">
                                <div class="col-md-10 offset-md-1">
                                    <table class="table table-sm table-striped" id="tbl_detalles">
                                    
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
</div>
<!-- /.wrapper -->

</asp:Content>
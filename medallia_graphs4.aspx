<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="medallia_graphs4.aspx.cs" Inherits="medallia.medallia_graphs4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script src="js/highcharts.js?v=<%= Session["rd_number"] %>">"></script>
    <script src="js/exporting.js"></script>
    <script src="js/indicadores.js?v=<%= Session["rd_number"] %>"></script>

    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item">Medallia</li>
                        <li class="breadcrumb-item active">Indicador Detracciones x Acci&oacute;n ejecutada</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <!-- jQuery Knob -->
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>Fecha inicio</label>
                                            <select class="form-control" id="cbo_periodo1"></select>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label>Fecha fin</label>
                                            <select class="form-control" id="cbo_periodo2"></select>
                                        </div>
                                    </div>
                                    <div class="col-sm-4" id="div_ctta_cbo">
                                        <div class="form-group">
                                            <label>Empresa</label>
                                            <select class="form-control" id="cbo_ctta"></select>
                                        </div>
                                    </div>
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <input type="button" class="form-control btn btn-primary" id="btn_ver" onclick="barras_detracciones_por_accion(<%= Session["id_ctta"] %>, 0, 2); pie_detraciones_accion(<%= Session["id_ctta"] %>, 0, 2);" value="Ver" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="card">
                        <div class="card-body">
                            <div class="row justify-content-center">
                                <div class="col-4">
                                    <div class="form-group">
                                        <center><label>Motivo</label></center>
                                        <select class="form-control" id="cbo_motivo_detraccion">
                                            <option value="0">-- TODOS --</option>
                                            <option value="3">Cliente</option>
                                            <option value="1">Comercial</option>
                                            <option value="4">Despacho provisi&oacute;n</option>
                                            <option value="2">T&eacute;cnico</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                    
                            <div class="row">
                                <div class="col-12">
                                    <div class="card-body">
                                        <div id="t_det-accion" style="min-width: 1000px; height: 400px; margin: 0 auto"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-4">
                        <div class="card-body">
                            <div id="det_por_region"></div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="card-body">
                            <div id="det_por_segmento"></div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="card-body">
                            <div id="det_por_tecnologia"></div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <div class="card-body">
                            <div id="t_det-localidad" style="min-width: 900px; height: 400px; margin: 0 auto"></div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </div>
</asp:Content>
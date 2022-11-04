<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="monitoreos_graphs1.aspx.cs" Inherits="medallia.monitoreos_graphs1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Javascript correspondientes a Monitoreos -->
<script type="text/javascript" src="js/monitoreos.js?v=<%= Session["rd_number"] %>"></script>

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <!--<div class="col-sm-6"><h1>Inline Charts</h1></div>-->
                <div class="col-sm-12">
                    <ol class="breadcrumb float-sm-right">
                      <li class="breadcrumb-item"><a href="index.aspx">Home</a></li>
                      <li class="breadcrumb-item">Monitoreos</li>
                      <li class="breadcrumb-item active">Indicadores</li>
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
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">
                              <i class="far fa-chart-bar"></i>
                              &nbsp;Selecci&oacute;n
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
                                    <input type="button" class="form-control btn btn-primary" id="btn_ver" value="Ver" onclick="dibuja_seleccion_fechas_monitoreos('<%= Session["centro_sesion"] %>');" />
                                </div>
                                <div class="col-4 mt-1">
                                    <label id="lbl_fecha"></label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="card card-primary">
                        <div class="card-header"><h3 class="card-title">Motivo calibraci&oacute;n</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body pb-3">
                            <table class="table table-sm table-striped" id="tbl_motivos">
                              
                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col-md6 -->

                <div class="col-md-6">
                    <div class="card card-success">
                        <div class="card-header">
                            <h3 class="card-title">Monitoreos por Empresa</h3>
                        </div>
                        <div class="card-body">
                            <div class="chart">
                                <canvas id="barChart" style="min-height: 250px; height: 390px; max-height: 390px; max-width: 100%;"></canvas>
                            </div>

                            <div class="alert alert-warning alert-dismissible mt-2">
                              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                              <h5><i class="icon fas fa-exclamation-triangle"></i></h5>
                              Se considera un monitoreo a la suma de los ingresos por Medallia m&aacute;s monitoreos por t&eacute;cnicos trabajando actualmente.
                            </div>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col-md6 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
</div>
</asp:Content>
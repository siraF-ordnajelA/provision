<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="tecnico.aspx.cs" Inherits="medallia.tecnico" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script type="text/javascript">
    $(document).ready(function () {
        combo_fechas();
    });
</script>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="index.aspx">Home</a></li>
                        <li class="breadcrumb-item">Buscador por t&eacute;cnico</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card card-info">
                        <!-- /.card-header -->
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fa fa-search"></i>
                                &nbsp;B&uacute;squeda
                            </h3>
                        </div>
                        <!-- /.card-body -->
                        <div class="card-body">
                            <div class="row pb-1">
                                <div class="col-sm-4">
                                    <div class="form-group row">
                                        <label for="txt_nombre" class="col-form-label">Nombre / Apellido / DNI</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" id="txt_nombre" />
                                        </div>
                                    </div>
                                    
                                    <div class="form-group row">
                                        <label for="cbo_periodo" class="col-sm-3 col-form-label">Per&iacute;odo</label>
                                        <div class="col-sm-5">
                                            <select class="form-control" id="cbo_periodo"></select>
                                        </div>
                                    </div>
                                
                                    <div class="form-group row">
                                        <div class="col-sm-3">
                                            <input type="button" class="form-control btn btn-primary" id="btn_ver" onclick="buscador_global_tecnicos();" value="Buscar" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-8" id="div_tabla_res" style="display: none;">
                                    <div class="card card-secondary">
                                        <div class="card-header"><h3 class="card-title">T&eacute;cnicos hallados</h3></div>
                                        <!-- /.card-header -->
                                        <div class="card-body table-responsive p-1" style="height: 200px;">
                                            <table class="table table-hover table-head-fixed table-striped text-nowrap" id="t_resultado_tecnicos" style="font-size: 11px;"></table>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->
                    </div>
                </div>
            </div>
            <!-- /.row -->

            <div class="row" id="row_metricas" style="display: none;">
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-warning">
                        <div class="inner">
                            <h3 id="h3_estrellas"></h3>
                            <p>Estrellas</p>
                        </div>
                        <div class="icon">
                            <i class="far fa-star"></i>
                        </div>
                    </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box" id="div_cumplidas">
                        <div class="inner">
                            <h3 id="h3_cumplimiento"></h3>
                            <p>Cumplimiento</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-stats-bars"></i>
                        </div>
                    </div>
                </div>
                  <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box" id="div_garantias">
                        <div class="inner">
                            <h3 id="h3_garantias"></h3>
                            <p>Garant&iacute;as a 30 d&iacute;as</p>
                        </div>
                        <div class="icon">
                            <i class="fas fa-wrench"></i>
                        </div>
                    </div>
                </div>
                <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box" id="div_garantias_7d">
                        <div class="inner">
                            <h3 id="h3_garantias_7d"></h3>
                            <p>Garant&iacute;as a 7 d&iacute;as</p>
                        </div>
                        <div class="icon">
                            <i class="fas fa-wrench"></i>
                        </div>
                        <!--<a href="#" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>-->
                    </div>
                </div>
                <!-- ./col -->
            </div>

            <div class="row" id="row_metricas2" style="display: none;">
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box" id="div_presentismo">
                        <div class="inner">
                            <h3 id="h3_presentismo"></h3>
                            <p>Presentismo</p>
                        </div>
                        <div class="icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                    </div>
                </div>
                  <!-- ./col -->
                <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box" id="div_efcita">
                        <div class="inner">
                            <h3 id="h3_efcita"></h3>
                            <p>Cumplimiento cita</p>
                        </div>
                        <div class="icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                    </div>
                </div>
                <!-- ./col -->
            </div>

            <div class="row">
                <div class="col-12" id="div_tabla_res2" style="display: none;">
                    <div class="card card-info">
                        <div class="card-header"><h3 class="card-title" id="h3_nombre_resultado_tecnico"></h3></div>
                        <div class="card-body table-responsive p-1" style="height: 150px;">
                            <table class="table table-hover table-head-fixed text-nowrap" id="t_resultado_tecnico2"></table>
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
            </div>
            <!-- /.row -->

            <div class="row">
                <div class="col-12" id="div_lista_detalles" style="display: none;">
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title" id="h3_nombre_detalles"></h3></div>
                        <center>
                        <div class="card-body table-responsive p-1">
                            <table class="table centrado table-hover table-head-fixed text-nowrap" id="t_resultado_detalles"></table>
                        </div>
                        </center>
                    </div>
                    <!-- /.card -->
                </div>
            </div>
            <!-- /.row -->
        </div>
    </section>
</div>
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="buscar_medallia.aspx.cs" Inherits="medallia.buscar_medallia" %>

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
                        <li class="breadcrumb-item active">Buscador</li>
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
                    <div class="card card-info">
                        <div class="card-header"><h3 class="card-title">Buscador Medallia</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>ID Cliente</label>
                                        <input type="tel" class="form-control" id="txt_cliente" />
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>T&eacute;cnico</label>
                                        <input type="text" class="form-control" id="txt_tecnico" />
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>ID Encuesta</label>
                                        <input type="tel" class="form-control" id="txt_idencuesta" />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-4" id="div_ctta_cbo">
                                    <div class="form-group">
                                        <label>Contratista</label>
                                        <select class="form-control" id="cbo_ctta" onchange="buscador_ctta_medallia();"></select>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>Fecha inicio</label>
                                        <input type="date" id="fecha_inicio" class="form-control" placeholder="yyyy-mm-dd">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>Fecha fin</label>
                                        <input type="date" id="fecha_fin" class="form-control" placeholder="yyyy-mm-dd">
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                        <div class="card-footer"><input type="button" class="btn btn-info" id="btn_busca" value="Buscar" onclick="buscador_medallia();" /></div>
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-12 -->
            </div>
            <!-- /.row -->

            <div class="row" id="div_ctta" style="display: none;">
                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Bandejas por contratista</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12 col-sm-6 col-md-3">
                                    <div class="info-box">
                                        <span class="info-box-icon bg-info elevation-1"><i class="fa fa-calendar-check"></i></span>
                                        <div class="info-box-content">
                                            <span class="info-box-text">Pendientes Clooper</span>
                                            <span class="info-box-number" id="span1"></span>
                                        </div>
                                        <!-- /.info-box-content -->
                                    </div>
                                    <!-- /.info-box -->
                                </div>
                                <!-- /.col -->
                            
                                <div class="col-12 col-sm-6 col-md-3">
                                    <div class="info-box mb-3">
                                        <span class="info-box-icon bg-warning elevation-1"><i class="fa fa-clipboard-check"></i></span>
                                        <div class="info-box-content">
                                            <span class="info-box-text">Gesti&oacute;n contratista</span>
                                            <span class="info-box-number" id="span2"></span>
                                        </div>
                                        <!-- /.info-box-content -->
                                    </div>
                                    <!-- /.info-box -->
                                </div>
                                <!-- /.col -->

                                <!-- fix for small devices only -->
                                <div class="clearfix hidden-md-up"></div>
                                <div class="col-12 col-sm-6 col-md-3">
                                    <div class="info-box mb-3">
                                        <span class="info-box-icon bg-success elevation-1"><i class="fa fa-comments"></i></span>
                                        <div class="info-box-content">
                                            <span class="info-box-text">Gesti&oacute;n refuerzo</span>
                                            <span class="info-box-number" id="span3"></span>
                                        </div>
                                        <!-- /.info-box-content -->
                                    </div>
                                    <!-- /.info-box -->
                                </div>
                                <!-- /.col -->

                                <div class="col-12 col-sm-6 col-md-3">
                                    <div class="info-box mb-3">
                                        <span class="info-box-icon bg-danger elevation-1"><i class="fa fa-backspace"></i></span>
                                        <div class="info-box-content">
                                            <span class="info-box-text">Cerrados</span>
                                            <span class="info-box-number" id="span4"></span>
                                        </div>
                                        <!-- /.info-box-content -->
                                    </div>
                                    <!-- /.info-box -->
                                </div>
                                <!-- /.col -->
                            </div>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-12 -->
            </div>
            <!-- /.row -->

            <div class="row" id="div_tabla_res" style="display: none;">
                <div class="col-12">
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">Resultados</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body table-responsive p-0" style="height: 380px;">
                            <table class="table table-hover table-head-fixed text-nowrap" id="t_resultados_medallia"></table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
</div>
<!-- /.content-wrapper -->
</asp:Content>
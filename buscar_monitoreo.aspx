<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="buscar_monitoreo.aspx.cs" Inherits="medallia.buscar_monitoreo" %>

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
                        <div class="card-header"><h3 class="card-title">Buscador Monitoreos</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>Nombre o DNI del t&eacute;cnico</label>
                                        <input type="text" class="form-control" id="txt_tecnico" />
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                        <div class="card-footer"><input type="button" class="btn btn-info" id="btn_busca" value="Buscar" onclick="resultado_busqueda1();" /></div>
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-12 -->
            </div>
            <!-- /.row -->

            <div class="row">
                <div class="col-6" id="div_tabla_res" style="display: none;">
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title">T&eacute;cnicos hallados</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body table-responsive p-1" style="height: 380px;">
                            <table class="table table-hover table-head-fixed table-striped text-nowrap" id="t_resultados_monitoreos" style="font-size: 11px;"></table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>

                <div class="col-6" id="div_tabla_res2" style="display: none;">
                    <div class="card card-secondary">
                        <div class="card-header"><h3 class="card-title" id="h3_nombre_resultado_monitoreo"></h3></div>
                        <div class="card-body table-responsive p-1" style="height: 150px;">
                            <table class="table table-hover table-head-fixed text-nowrap" id="t_resultados_monitoreos2"></table>
                        </div>
                    </div>

                    <div class="card card-secondary" id="div_tabla_res3" style="display: none;">
                        <div class="card-header"><h3 class="card-title" id="h3_nombre_resultado_monitoreo_detalle"></h3></div>
                        <div class="card-body table-responsive p-1" style="height: 350px;">
                            <table class="table table-hover table-head-fixed text-nowrap" id="t_resultados_monitoreos3"></table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
</div>
<!-- /.content-wrapper -->

<!-- Javascript correspondientes a Monitoreos -->
<script type="text/javascript" src="js/monitoreos.js"></script>
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="garantias_lista_gestor.aspx.cs" Inherits="medallia.garantias_lista_gestor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Javascript correspondientes a Monitoreos -->
    <script type="text/javascript" src="js/garantias.js?v=<%= Session["rd_number"] %>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            lista_garantias_gestor();
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
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item">Garant&iacute;as</li>
                            <li class="breadcrumb-item active">Bandeja de devoluciones</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content" id="contenido">
            <div class="container-fluid">
                <div class="row" id="div_ctta_cbo">
                    <div class="col-md-12">
                        <!-- general form elements -->
                        <div class="card card-info">
                            <div class="card-header"><h3 class="card-title">Buscador</h3></div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label>Contratista</label>
                                            <select class="form-control" id="cbo_ctta"></select>
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
                            <div class="card-footer"><input type="button" class="btn btn-info" id="btn_busca" value="Buscar" onclick="buscador_descargos_gestor();" /></div>
                        </div>
                        <!-- /.card -->
                    </div>
                    <!-- /.col md-12 -->
                </div>
                <!-- /.row -->
                
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Bandeja devoluciones pendientes de revisi&oacute;n</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body table-responsive p-0" style="height: 380px;">
                                <table class="table table-hover table-head-fixed text-nowrap" id="t1" style="font-size: 13px;"></table>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                </div>
            </div>

            <!-- /.modal -->
            <div class="modal fade" id="modal-info">
                <div class="modal-dialog">
                    <div class="modal-content bg-info">
                        <div class="modal-header">
                            <h4 class="modal-title">Observaciones de la devoluci&oacute;n</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="modal-body">
                            
                        </div>
                        <div class="modal-footer justify-content-between">
                            <!--<button type="button" class="btn btn-outline-light" data-dismiss="modal">Close</button>-->
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
        </section>
    </div>
</asp:Content>
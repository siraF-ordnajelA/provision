<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="monitoreos_lista_aptos.aspx.cs" Inherits="medallia.monitoreos_lista_aptos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Javascript correspondientes a Monitoreos -->
    <script type="text/javascript" src="js/monitoreos.js?v=<%= Session["rd_number"] %>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var usuario = '<%= Session["id_usuario"] %>';
            var centro = '<%= Session["centro_sesion"] %>';

            lista_pendiente_aptos(1, centro);
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
                            <li class="breadcrumb-item">Calibraciones y Monitoreos</li>
                            <li class="breadcrumb-item active">APTO</li>
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
                        <div class="card card-success">
                            <div class="card-header">
                                <h3 class="card-title">Bandeja de monitoreos Apto</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body table-responsive p-0" style="height: 380px;">
                                <table class="table table-hover table-head-fixed text-nowrap" id="t1" style="font-size: 14px;"></table>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
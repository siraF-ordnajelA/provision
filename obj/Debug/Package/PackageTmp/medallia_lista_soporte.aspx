<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="medallia_lista_soporte.aspx.cs" Inherits="medallia.medallia_lista_soporte" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script type="text/javascript">
    $(document).ready(function () {
        var usuario = '<%= Session["id_usuario"] %>';
        var centro = '<%= Session["centro_sesion"] %>';

        lista_soporte(usuario, centro);
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
                        <li class="breadcrumb-item">Medallia bandeja</li>
                        <li class="breadcrumb-item active">Soporte sistemas</li>
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
                            <h3 class="card-title">Bandeja soporte sistemas</h3>
                            <div class="card-tools">
                                <div class="input-group input-group-sm" style="width: 80px;">
                                    Todos&nbsp;&nbsp;<input type="checkbox" name="chk_todos" id="chk_todos" class="form-control float-right" onclick="lista_todos_por_bandeja(3, '<%= Session["id_usuario"] %>', '<%= Session["centro_sesion"] %>');">
                                </div>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body table-responsive p-0" style="height: 380px;">
                            <table class="table table-hover table-head-fixed text-nowrap" id="t1" style="font-size: 12px;"></table>
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
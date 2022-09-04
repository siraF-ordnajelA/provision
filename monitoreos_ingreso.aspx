<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="monitoreos_ingreso.aspx.cs" Inherits="medallia.monitoreos_ingreso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Javascript correspondientes a Monitoreos -->
<script type="text/javascript" src="js/monitoreos.js?v=<%= Session["rd_number"] %>"></script>

<script type="text/javascript">
    $(document).ready(function () {
        var nivel1 = $('#drop_tecnico');

        $.ajax({
            url: "servicios_monitoreos.asmx/obtener_tecnicos",
            method: 'post',
            dataType: "json",
            success: function (datos) {
                $('#drop_tecnico').empty();
                $('#drop_tecnico').append("<option value='0'>--Seleccione Tecnico--</option>");
                $(datos).each(function (index, item) {
                    nivel1.append($('<option/>', { value: item.ID_RECURSO, text: item.Nombre })); //LOS VALORES "VALUE" Y "TEXT" SON ITEMS QUE TOMAN LOS VALORES DE LA CLASE cbo_nivel1.cs (ID_RECURSO Y Nombre)
                });
            }
        });
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
                        <li class="breadcrumb-item active">Solicitud de monitoreo-calibraci&oacute;n</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-8">
                    <!-- general form elements -->
                    <div class="card card-info">
                        <div class="card-header"><h3 class="card-title">Ingreso manual</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label>T&eacute;cnico</label>
                                        <select id="drop_tecnico" class="form-control"></select>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label>Observaciones</label>
                                        <textarea class="form-control" id="txt_observaciones" cols="80" rows="6"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                        <div class="card-footer"><input type="button" class="btn btn-info" id="btn_ingreso" value="Ingresar" onclick="carga_caso_manual('<%= Session["id_usuario"] %>');" /></div>
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
</div>
<!-- /.content-wrapper -->
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="carga_manual.aspx.cs" Inherits="medallia.carga_manual" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script type="text/javascript">
    $(document).ready(function () {
        carga_mes();
        lista_cbo_contratas("TASA");
    });
</script>

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="index.aspx">Home</a></li>
                        <li class="breadcrumb-item">Carga de m&eacute;tricas manuales</li>
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
                        <div class="card-header"><h3 class="card-title">M&eacute;trica ascelerador/desacelerador</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="drop_ascelerador" class="col-sm-4 col-form-label">Proporcional estrellas:</label>
                                        <input type="number" class="form-control col-sm-4" id="num_ingreso" min="-1" max="1" step="0.01" maxlength="1" value="0" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="txt_ascelerador" class="col-sm-3 col-form-label">Ultimos Valores:</label>
                                        <input class="form-control col-sm-3" type="text" id="txt_acelerador_1" readonly disabled />
                                        <input class="form-control col-sm-3" type="text" id="txt_acelerador_2" readonly disabled />
                                        <input class="form-control col-sm-3" type="text" id="txt_acelerador_3" readonly disabled />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="cbo_ctta" class="col-sm-4 col-form-label">Empresa:</label>
                                        <select class="form-control col-sm-6" id="cbo_ctta" onchange="carga_ultimas_metrica_acelerador();"></select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="txt_date1" class="col-sm-3 col-form-label">Mes:</label>
                                        <input type="text" class="form-control col-sm-3" id="txt_date1" readonly disabled />
                                        <input type="text" class="form-control col-sm-3" id="txt_date2" readonly disabled />
                                        <input type="text" class="form-control col-sm-3" id="txt_date3" readonly disabled />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group row">
                                        <label for="cbo_fecha_manual" class="col-sm-4 col-form-label">Mes:</label>
                                        <select class="form-control col-sm-4" id="cbo_fecha_manual"></select>
                                        <input class="btn btn-primary ml-2" type="button" id="btn_guarda_ascelerador" value="Guardar" onclick="guarda_acelerador();" />
                                    </div>
                                </div>
                            </div>
                        </div><!-- /.card-body -->
                    </div><!-- /.card -->
                </div>
            </div><!-- /.row -->
        </div>
    </section>
</div>
</asp:Content>
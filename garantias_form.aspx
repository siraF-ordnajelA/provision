<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="garantias_form.aspx.cs" Inherits="medallia.garantias_form" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Javascript correspondientes a Garantias -->
    <script type="text/javascript" src="js/garantias.js?v=<%= Session["rd_number"] %>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            carga_combo_motivos(1);
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
                        <li class="breadcrumb-item active">Descargo garant&iacute;a</li>
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
                    <div class="card card-secondary">
                        <div class="card-header">
                            <h3 class="card-title">B&uacute;squeda garant&iacute;a</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                                <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>N&uacute;mero de petici&oacute;n</label>
                                        <input type="text" class="form-control" id="txt_peticion" placeholder="CRM32XXXXXX_XXXXXXXXXXX" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>S&iacute;ntoma</label>
                                        <input type="text" class="form-control" id="txt_sintoma" disabled />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>T&eacute;cnico</label>
                                        <label id="lbl_idrecurso" hidden></label>
                                        <label id="lbl_id_user" hidden><%= Session["id_usuario"] %></label>
                                        <input type="text" class="form-control" id="txt_tecnico" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Empresa</label>
                                        <input type="text" class="form-control" id="txt_empresa" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Access ID</label>
                                        <input type="text" class="form-control" id="txt_accessid" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Estado de la orden</label>
                                        <input type="text" class="form-control" id="txt_estado" disabled />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Subtipo de actividad</label>
                                        <input type="text" class="form-control" id="txt_subtipo" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Distrito</label>
                                        <input type="text" class="form-control" id="txt_distrito" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Gerencia</label>
                                        <input type="text" class="form-control" id="txt_gerencia" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Central</label>
                                        <label id="lbl_idcentral" hidden></label>
                                        <input type="text" class="form-control" id="txt_central" disabled />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Segmento</label>
                                        <input type="text" class="form-control" id="txt_segmento" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Tecnolog&iacute;a</label>
                                        <input type="text" class="form-control" id="txt_tecno" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Fecha ingreso</label>
                                        <input type="text" class="form-control" id="txt_fingreso" disabled />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>Fecha cierre</label>
                                        <input type="text" class="form-control" id="txt_fcumpl" disabled />
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                        <div class="card-footer"><input type="button" class="btn btn-primary" id="btn_busca" value="Buscar" onclick="buscar_gtia();" /></div>
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-12 -->

                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="card card-info">
                        <div class="card-header"><h3 class="card-title">Respuesta del supervisor</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-10">
                                    <div class="form-group">
                                        <label>Comentarios del supervisor</label>
                                        <textarea id="txt_resp_supervisor" class="form-control" rows="8" placeholder="Una vez encontrada la garant&iacute;a, completar y aclarar nombre del supervisor al comienzo del mensaje..."></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Motivo</label>
                                        <select class="form-control" id="cbo_motivo" onchange="carga_combo_submotivo(1);"></select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>S/N - CAS ID - MAC (anterior)</label>
                                        <input type="text" class="form-control" id="txt_sn_anterior" disabled />
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Submotivo</label>
                                        <select class="form-control" id="cbo_detalle" onchange="habilita_sn_averia();">
                                            <option value="0">-- Debe seleccionar Motivo --</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>S/N - CAS ID - MAC (actual)</label>
                                        <input type="text" class="form-control" id="txt_sn_actual" disabled />
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col md-12 -->
            </div>
            <!-- /.row -->
            <center><input type="button" id="btn btn-primary" onclick="guardar_descargo();" class="btn btn-primary" value="Guardar caso" /></center>
        </div>
        <!-- /.container -->
    </section>
</div>
<!-- /.content-wrapper -->
</asp:Content>
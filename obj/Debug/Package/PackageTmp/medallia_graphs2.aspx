<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="medallia_graphs2.aspx.cs" Inherits="medallia.medallia_graphs2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <!--<div class="col-sm-6"><h1>Inline Charts</h1></div>-->
                <div class="col-sm-12">
                    <ol class="breadcrumb float-sm-right">
                      <li class="breadcrumb-item"><a href="index.aspx">Home</a></li>
                      <li class="breadcrumb-item">Medallia</li>
                      <li class="breadcrumb-item active">Indicador por t&eacute;cnicos</li>
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
                                    <input type="button" class="form-control btn btn-primary" id="btn_ver" value="Ver" onclick="dibuja_lista_seleccion('<%= Session["centro_sesion"] %>');" />
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
                    <div class="card">
                        <div class="card-header"><h3 class="card-title">Top 10 T&eacute;cnicos con encuestas</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body pb-3">
                            <table class="table table-sm" id="tbl_top10">
                              <!--<thead>
                                <tr>
                                  <th style="width: 10px">#</th>
                                  <th>T&eacute;cnico</th>
                                  <th>Empresa</th>
                                  <th style="width: 40px">Encuestas</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                  <td>1.</td>
                                  <td>Update software</td>
                                  <td>APPLE</td>
                                  <td align="center"><span class="badge bg-primary">5</span></td>
                                </tr>
                              </tbody>-->
                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col-md6 -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header"><h3 class="card-title">Pendiente de respuesta por contratista</h3></div>
                        <!-- /.card-header -->
                        <div class="card-body pb-3">
                            <table class="table table-sm" id="tbl_pendiente">
                              <!--<thead>
                                <tr>
                                  <th style="width: 10px">#</th>
                                  <th>Empresa</th>
                                  <th style="width: 40px">Encuestas</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                  <td>1.</td>
                                  <td>Update software</td>
                                  <td align="center"><span class="badge bg-primary">5</span></td>
                                </tr>
                              </tbody>-->
                            </table>

                            <div class="col-3 mt-3">
                                <asp:Button ID="btn_pendiente" runat="server" Text="Descargar" onclick="btn_descargar_Click" CssClass="form-control btn btn-primary"></asp:Button>
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
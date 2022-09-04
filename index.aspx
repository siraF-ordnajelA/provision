<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="medallia.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <style>
    .stars-outer {
      display: inline-block;
      position: relative;
      font-family:"Font Awesome 5 Free";
    }

    .stars-outer::before {
      content: "\f005 \f005 \f005 \f005 \f005";
    }

    .stars-inner {
      position: absolute;
      top: 0;
      left: 0;
      white-space: nowrap;
      overflow: hidden;
      width: 0;
    }

    .stars-inner::before {
      content: "\f005 \f005 \f005 \f005 \f005";
      color: #f8ce0b;
    }

    .attribution {
      font-size: 12px;
      color: #444;
      text-decoration: none;
      text-align: center;
      position: fixed;
      right: 10px;
      bottom: 10px;
      z-index: -1;
    }
    .attribution:hover {
      color: #1fa67a;
    }
   </style>

   <!-- Highcharts -->
   <script src="js/highcharts.js"></script>
   <script type="text/javascript">
       $(document).ready(function () {
           combo_fechas();
           indicador_estrellas('<%= Session["centro_sesion"] %>');
           barras_historico(0, 2, '<%= Session["centro_sesion"] %>');

           $('.cbo_region').select2();
           $('.cbo_distrito').select2();
       });

       $('.select2bs4').select2({
           theme: 'bootstrap4'
       })
   </script>
   
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <!-- jQuery Knob -->
                        <div class="card collapsed-card">
                            <div class="card-header">
                                <h3 class="card-title">
                                  <i class="fa fa-search"></i>
                                  &nbsp;B&uacute;squeda
                                </h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                    <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
                                </div>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div class="row pb-1">
                                    <div class="col-sm-6">
                                        <div class="form-group row">
                                            <label for="cbo_periodo" class="col-sm-2 col-form-label">Per&iacute;odo</label>
                                            <div class="col-sm-4">
                                                <select class="form-control" id="cbo_periodo"></select>
                                            </div>

                                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                                <label class="btn bg-gradient-info active">
                                                    <input type="radio" name="rd_tecnologia" id="rd_tecno_ftth" value="2" autocomplete="off" checked> FTTH
                                                </label>
                                                <label class="btn bg-gradient-info">
                                                    <input type="radio" name="rd_tecnologia" id="rd_tecno_cu" value="1" autocomplete="off"> COBRE
                                                </label>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-2">
                                                <input type="button" class="form-control btn btn-primary" id="btn_ver" onclick="indicador_estrellas('<%= Session["centro_sesion"] %>');" value="Ver" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group row">
                                            <label for="cbo_gerencia" class="col-form-label">Regi&oacute;n</label>
                                            <div class="col-sm-4">
                                                <select class="form-control select2 cbo_region" data-dropdown-css-class="select2-blue" multiple="multiple" id="cbo_region[]">
                                                    <option value="0">-- TODO --</option>
                                                    <option value="ALIADOS">ALIADOS</option>
                                                    <option value="BS AS">BS AS</option>
                                                    <option value="CUYO">CUYO</option>
                                                    <option value="NOROESTE">NOROESTE</option>
                                                    <option value="PATAGONIA">PATAGONIA</option>
                                                    <option value="SIN CLASIFICAR">SIN CLASIFICAR</option>
                                                    <option value="SUR">SUR</option>
                                                </select>
                                            </div>
                        
                                            <label for="cbo_distrito" class="ml-2 col-form-label">Distrito</label>
                                            <div class="col-sm-5">
                                                <select class="form-control select2 cbo_distrito" data-dropdown-css-class="select2-blue" multiple="multiple" id="cbo_distrito[]">
                                                    <option value="0">-- TODO --</option>
                                                    <option value="CHIVILCOY_ALIADOS">CHIVILCOY_ALIADOS</option>
                                                    <option value="DISTRITO BAHIA BLANCA Y SUR CTTA">DISTRITO BAHIA BLANCA Y SUR CTTA</option>
                                                    <option value="DISTRITO BELLA VISTA CTTA">DISTRITO BELLA VISTA CTTA</option>
                                                    <option value="DISTRITO BS AS OESTE CTTA">DISTRITO BS AS OESTE CTTA</option>
                                                    <option value="DISTRITO BS AS OESTE FTTH_CTTA">DISTRITO BS AS OESTE FTTH_CTTA</option>
                                                    <option value="DISTRITO CASTELAR CTTA">DISTRITO CASTELAR CTTA</option>
                                                    <option value="DISTRITO CHUBUT ALIADOS">DISTRITO CHUBUT ALIADOS</option>
                                                    <option value="DISTRITO CHUBUT CTTA">DISTRITO CHUBUT CTTA</option>
                                                    <option value="DISTRITO CONGRESO FTTH_CTTA">DISTRITO CONGRESO FTTH_CTTA</option>
                                                    <option value="DISTRITO EMPRENDIMIENTOS">DISTRITO EMPRENDIMIENTOS</option>
                                                    <option value="DISTRITO JONTE CTTA">DISTRITO JONTE CTTA</option>
                                                    <option value="DISTRITO LA PLATA CTTA">DISTRITO LA PLATA CTTA</option>
                                                    <option value="DISTRITO LANUS CTTA">DISTRITO LANUS CTTA</option>
                                                    <option value="DISTRITO LOMAS CTTA">DISTRITO LOMAS CTTA</option>
                                                    <option value="DISTRITO MAR DEL PLATA CTTA">DISTRITO MAR DEL PLATA CTTA</option>
                                                    <option value="DISTRITO MAR DEL PLATA FTTH_CTTA">DISTRITO MAR DEL PLATA FTTH_CTTA</option>
                                                    <option value="DISTRITO MENDOZA GODOY CRUZ CTTA">DISTRITO MENDOZA GODOY CRUZ CTTA</option>
                                                    <option value="DISTRITO MENDOZA LAS HERAS CTTA">DISTRITO MENDOZA LAS HERAS CTTA</option>
                                                    <option value="DISTRITO MENDOZA SAN MARTIN CTTA">DISTRITO MENDOZA SAN MARTIN CTTA</option>
                                                    <option value="DISTRITO MENDOZA SAN RAFAEL CTTA">DISTRITO MENDOZA SAN RAFAEL CTTA</option>
                                                    <option value="DISTRITO MERLO MORENO CTTA">DISTRITO MERLO MORENO CTTA</option>
                                                    <option value="DISTRITO MONTE GRANDE CTTA">DISTRITO MONTE GRANDE CTTA</option>
                                                    <option value="DISTRITO MORON CTTA">DISTRITO MORON CTTA</option>
                                                    <option value="DISTRITO MORON FTTH_CTTA">DISTRITO MORON FTTH_CTTA</option>
                                                    <option value="DISTRITO NEUQUEN LA PAMPA CTTA">DISTRITO NEUQUEN LA PAMPA CTTA</option>
                                                    <option value="DISTRITO NEUQUEN LA PAMPA FTTH_CTTA">DISTRITO NEUQUEN LA PAMPA FTTH_CTTA</option>
                                                    <option value="DISTRITO NORTE ATC ALIADOS">DISTRITO NORTE ATC ALIADOS</option>
                                                    <option value="DISTRITO ONCE CTTA">DISTRITO ONCE CTTA</option>
                                                    <option value="DISTRITO QUILMES CTTA">DISTRITO QUILMES CTTA</option>
                                                    <option value="DISTRITO RIO NEGRO CTTA">DISTRITO RIO NEGRO CTTA</option>
                                                    <option value="DISTRITO SAN JUAN CTTA">DISTRITO SAN JUAN CTTA</option>
                                                    <option value="DISTRITO SAN JUAN FTTH_CTTA">DISTRITO SAN JUAN FTTH_CTTA</option>
                                                    <option value="DISTRITO SAN JUSTO CTTA">DISTRITO SAN JUSTO CTTA</option>
                                                    <option value="DISTRITO SAN LUIS CTTA">DISTRITO SAN LUIS CTTA</option>
                                                    <option value="DISTRITO TIERRA DEL FUEGO ALIADOS">DISTRITO TIERRA DEL FUEGO ALIADOS</option>
                                                    <option value="DISTRITO TIERRA DEL FUEGO CTTA">DISTRITO TIERRA DEL FUEGO CTTA</option>
                                                    <option value="DISTRITO VARELA CTTA">DISTRITO VARELA CTTA</option>
                                                    <option value="DISTRITO VERNET CTTA">DISTRITO VERNET CTTA</option>
                                                    <option value="DISTRITO_BELLA VISTA FTTH_CTTA">DISTRITO_BELLA VISTA FTTH_CTTA</option>
                                                    <option value="DISTRITO_CASTELAR_FTTH_CTTA">DISTRITO_CASTELAR_FTTH_CTTA</option>
                                                    <option value="DISTRITO_JONTE_FTTH_CTTA">DISTRITO_JONTE_FTTH_CTTA</option>
                                                    <option value="DISTRITO_LA_PLATA FTTH_CTTA">DISTRITO_LA_PLATA FTTH_CTTA</option>
                                                    <option value="DISTRITO_LANUS FTTH_CTTA">DISTRITO_LANUS FTTH_CTTA</option>
                                                    <option value="DISTRITO_LOMAS FTTH_CTTA">DISTRITO_LOMAS FTTH_CTTA</option>
                                                    <option value="DISTRITO_MERLO_MORENO_FTTH_CTTA">DISTRITO_MERLO_MORENO_FTTH_CTTA</option>
                                                    <option value="DISTRITO_MONTE_GRANDE FTTH_CTTA">DISTRITO_MONTE_GRANDE FTTH_CTTA</option>
                                                    <option value="DISTRITO_MZA_GODOY_CRUZ FTTH_CTTA">DISTRITO_MZA_GODOY_CRUZ FTTH_CTTA</option>
                                                    <option value="DISTRITO_MZA_LAS HERAS FTTH_CTTA">DISTRITO_MZA_LAS HERAS FTTH_CTTA</option>
                                                    <option value="DISTRITO_ONCE_VERNET_FTTH_CTTA">DISTRITO_ONCE_VERNET_FTTH_CTTA</option>
                                                    <option value="DISTRITO_QUILMES FTTH_CTTA">DISTRITO_QUILMES FTTH_CTTA</option>
                                                    <option value="DISTRITO_SAN JUSTO_FTTH_CTTA">DISTRITO_SAN JUSTO_FTTH_CTTA</option>
                                                    <option value="DISTRITO_VARELA FTTH_CTTA">DISTRITO_VARELA FTTH_CTTA</option>
                                                    <option value="SIN CLASIFICAR">SIN CLASIFICAR</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                  <i class="far fa-chart-bar"></i>
                                  &nbsp;<label id="lbl_fecha_consulta"></label>
                                </h3>
                            </div>

                            <!--<div class="alert alert-info alert-dismissible">
                              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                              <h5><i class="icon fas fa-info"></i> Atenci&oacute;n</h5>
                              El siguiente indicador es referencial y a modo prueba. Este puede cambiar el formato. Puede pinchar sobre el nombre
                              de la empresa para obtener m&aacute;s informaci&oacute;n de las m&eacute;tricas que conforman las estrellas.
                            </div>-->

                            <div class="row justify-content-center mt-2">
                                <table id="t_performance" class="table table-bordered table-striped" style="width: 55%"></table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">
                                  <i class="fas fa-chart-line"></i>
                                  &nbsp;<label>Historico performance</label>
                                </h3>
                            </div>

                            <div id="t_historico" style="min-width: 1000px; height: 350px; margin: 0 auto"></div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /.container -->
        </section>
    </div>
</asp:Content>
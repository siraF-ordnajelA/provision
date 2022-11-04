<%@ Page Title="" Language="C#" MasterPageFile="~/header.Master" AutoEventWireup="true" CodeBehind="index_metricas.aspx.cs" Inherits="medallia.index_metricas" %>
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
                          <li class="breadcrumb-item active">M&eacute;tricas por empresa</li>
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
                                  &nbsp;M&eacute;tricas Empresa
                                </h3>
                                <button type="button" class="btn btn-secondary ml-2" data-toggle="modal" data-target="#modal-metricas">
                                  <i class="fa fa-info"></i>
                                </button>
                            </div>
                            <!--
                            <div class="alert alert-info alert-dismissible">
                              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                              <h5><i class="icon fas fa-info"></i> Informaci&oacute;n</h5>
                              El siguiente indicador es referencial y a modo prueba. Este puede cambiar el formato. Puede pinchar sobre el nombre
                              de la empresa para obtener el detalle de cada t&eacute;cnico. Aqu&iacute; se visualizar&aacute;n las m&eacute;tricas
                              que conforman el indicador global, ordenadas de la mejor calificaci&oacute;n a la menor.
                            </div>
                            -->
                            <!-- /.modal -->
                            <div class="modal fade" id="modal-metricas">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content bg-info">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Forma de c&aacute;lculo M&eacute;tricas</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span></button>
                                        </div>
                                        <div class="modal-body">
                                            <b>Cumplimiento</b> = Inst. Cumplidas / (Inst. Cumplidas + Informadas)<br />
                                            <b>Garant&iacute;as a 30 d&iacute;as</b> = Averías en garant&iacute;a dentro de los 30 d&iacute;as / Inst. Cumplidas<br />
                                            <b>Garant&iacute;as a 7 d&iacute;as</b> = Averías en garant&iacute;a dentro de los 7 d&iacute;as / Inst. Cumplidas<br />
                                            <b>Presentismo</b> = D&iacute;as trabajados / D&iacute;as h&aacute;biles<br />
                                            <b>Instalaciones diarias</b> = Suma de instalaciones del mes / D&iacute;as trabajados<br />
                                            <b>Cumplimiento cita</b> = Cant. pedidos cumplidos o informados / Cant. pedidos asignados<br />
                                        </div>
                                        <div class="modal-footer justify-content-between">
                                          <button type="button" class="btn btn-outline-light" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                  <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->

                            <!-- solid sales graph -->
                            <div class="card bg-gradient-info col-12">
                              <div class="card-header border-0">
                                <h3 class="card-title">
                                  <i class="fas fa-th mr-1"></i>
                                  <h7 id="graph_semanal"></h7>
                                </h3>
                              </div>
                              <div class="card-body">
                                <canvas class="chart" id="line-chart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                                <table id="t_semanal" class="table table-striped" style="width: 50%" align="center"></table>
                              </div>
                            </div>
                            <!-- /.card -->

                            <div class="row justify-content-center mt-2">
                                <h3 id="mes_ahora"></h3>
                            </div>

                            <div class="row justify-content-center">
                                <p>(La métrica "Garant&iacute;as a 30 d&iacute;as" no se considera dentro del c&aacute;lculo para el mes corriente ni el anterior)</p><br />
                                <table id="t_metricas" class="table table-striped mt-1" style="width: 80%" align="center"></table>
                            </div>

                            <div class="row justify-content-center mt-3">
                                <table id="t_tecnicos" class="table table-bordered table-striped table-head-fixed" style="width: 90%" align="center"></table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container -->
        </section>
    </div>

    <script>
        function semanal(mes, fecha, empre, tecno) {
            document.addEventListener("DOMContentLoaded", dibuja_grafico_semanal(fecha, empre, tecno));
            document.getElementById("graph_semanal").innerHTML = "Avance semanal métricas " + empre;
            if (tecno == 1) {
                document.getElementById("mes_ahora").innerHTML = "M&eacute;tricas del mes de " + mes + " (COBRE)";
            }
            else {
                document.getElementById("mes_ahora").innerHTML = "M&eacute;tricas del mes de " + mes + " (FTTH)";
            }
        }
        
        function dibuja_grafico_semanal(fecha, centro, tecno) {
            var tabla_semanal = $('#t_semanal');
            var ctta_temp = "";
            var array_empresa = [];
            var array_estrellas = [];
            var array_cumplimiento = [];
            var array_garantias_7d = [];
            var array_presentismo = [];
            var array_diarias = [];
            var array_citas = [];
            var array_color = [];
            var array_fecha = [];
            var array_semana = [];

            tabla_semanal.empty();
            if (centro == "TASA") {
                tabla_semanal.append('<thead><tr><th class="align-baseline text-center">EMPRESA</th><th class="align-baseline text-center">SEMANA</th><th class="align-baseline text-center">ESTRELLAS</th></tr></thead>');
            }
            else {
                tabla_semanal.append('<thead><tr><th class="align-baseline text-center">SEMANA</th><th class="align-baseline text-center">ESTRELLAS</th></tr></thead>');
            }

            alert("Fecha: " + fecha);

            $.ajax({
                url: "servicios_indicadores.asmx/dibuja_indicador_semanal",
                method: 'post',
                data: { valor_fecha: fecha, valor_centro: centro, tec: tecno },
                dataType: "json",
                success: function (datos) {
                    $(datos).each(function (index, item) {
                        if (ctta_temp == item.empresa){
                            array_estrellas.push(item.estrellas);

                            //Metricas
                            array_cumplimiento.push((item.metrica_cumplidas * 0.6 * 100).toFixed(1)); // Cumplidas
                            array_garantias_7d.push(((1 - item.metrica_garantias_7d * 0.99) * 100).toFixed(1)); //Garantias 7D
                            array_presentismo.push((item.metrica_presentismo * 0.9 * 100).toFixed(1)); //Presentismo
                            array_diarias.push((item.metrica_diarias * 2).toFixed(1)); //Instalaciones diarias
                            array_citas.push((item.metrica_citas * 0.995 * 100).toFixed(1)); //Efectividad Cita

                            array_color.push(item.color);
                            array_fecha.push(item.fecha);
                            array_semana.push(item.semana);
                        }
                        else {
                            array_empresa.push(item.empresa);
                            array_estrellas.push(item.estrellas);

                            //Metricas
                            array_cumplimiento.push((item.metrica_cumplidas * 0.6 * 100).toFixed(1)); // Cumplidas
                            array_garantias_7d.push(((1 - item.metrica_garantias_7d * 0.99) * 100).toFixed(1)); //Garantias 7D
                            array_presentismo.push((item.metrica_presentismo * 0.9 * 100).toFixed(1)); //Presentismo
                            array_diarias.push((item.metrica_diarias * 2).toFixed(1)); //Instalaciones diarias
                            array_citas.push((item.metrica_citas * 0.995 * 100).toFixed(1)); //Efectividad Cita

                            array_color.push(item.color);
                            array_fecha.push(item.fecha);
                            array_semana.push(item.semana);
                        }
                        ctta_temp = item.empresa;
                        if (centro == "TASA") {
                            tabla_semanal.append('<tr><td align="center" style="font-size: 16px">' + item.empresa + '</td><td align="center" style="font-size: 16px">'+ item.semana +' (' + item.fecha + ')</td><td align="center" style="font-size: 18px">' + (item.estrellas).toFixed(2) + '</td></tr>');
                        }
                        else {
                            tabla_semanal.append('<tr><td align="center" style="font-size: 16px">'+ item.semana +' (' + item.fecha + ')</td><td align="center" style="font-size: 18px">' + (item.estrellas).toFixed(2) + '</td></tr>');
                        }
                    });

                    var myJsonString_empresa = JSON.stringify(array_empresa);
                    var myJsonString_estrellas = JSON.stringify(array_estrellas);
                    var myJsonString_cumplimiento = JSON.stringify(array_cumplimiento);
                    var myJsonString_garantias7d = JSON.stringify(array_garantias_7d);
                    var myJsonString_presentismo = JSON.stringify(array_presentismo);
                    var myJsonString_diarias = JSON.stringify(array_diarias);
                    var myJsonString_citas = JSON.stringify(array_citas);
                    var myJsonString_color = JSON.stringify(array_color);
                    var myJsonString_fecha = JSON.stringify(array_fecha);
                    var myJsonString_semana = JSON.stringify(array_semana);

                    var jsonArray_empresa = JSON.parse(myJsonString_empresa);
                    var jsonArray_estrellas = JSON.parse(myJsonString_estrellas);
                    var jsonArray_cumplimiento = JSON.parse(myJsonString_cumplimiento);
                    var jsonArray_garantias7d = JSON.parse(myJsonString_garantias7d);
                    var jsonArray_presentismo = JSON.parse(myJsonString_presentismo);
                    var jsonArray_diarias = JSON.parse(myJsonString_diarias);
                    var jsonArray_citas = JSON.parse(myJsonString_citas);
                    var jsonArray_color = JSON.parse(myJsonString_color);
                    var jsonArray_fecha = JSON.parse(myJsonString_fecha);
                    var jsonArray_semana = JSON.parse(myJsonString_semana);

                    //alert("EMPRESA: " + myJsonString_empresa); // MUESTRA EL JSON
                    //alert("ESTRELLAS: " + myJsonString_estrellas); // MUESTRA EL JSON
                    dibuja_datos(jsonArray_empresa, jsonArray_estrellas, jsonArray_cumplimiento, jsonArray_garantias7d, jsonArray_presentismo, jsonArray_diarias, jsonArray_citas, jsonArray_color, jsonArray_fecha, jsonArray_semana);
                }
            });
        }
        
        function dibuja_datos(empresas, estrellas, cumplimiento, garantias_7d, presentismo, diarias, citas, color, fechas, semana){
            // Cargo el contenedor canvas del gráfico
            var salesGraphChartCanvas = $('#line-chart').get(0).getContext('2d');
            //$('#revenue-chart').get(0).getContext('2d');

            var salesGraphChartData = {
                labels  : fechas,
                datasets: [
                    /*{
                      label               : ['Estrellas'],//empresas,
                      fill                : false,
                      borderWidth         : 3,
                      lineTension         : 0,
                      spanGaps : true,
                      backgroundColor     : color,
                      borderColor         : color, //'#efefef',
                      pointRadius         : 4,
                      pointHoverRadius    : 7,
                      pointColor          : color,
                      pointBackgroundColor: color,
                      data                : estrellas
                    },*/
                    {
                      label               : ['Cumplidas'],//empresas,
                      fill                : false,
                      borderWidth         : 3,
                      lineTension         : 0,
                      spanGaps : true,
                      backgroundColor     : '#f76767',
                      borderColor         : '#f76767', //'#efefef',
                      pointRadius         : 4,
                      pointHoverRadius    : 7,
                      pointColor          : '#ff0000',
                      pointBackgroundColor: '#ff0000',
                      data                : cumplimiento
                    },
                    {
                      label               : ['Garantías 7D'],//empresas,
                      fill                : false,
                      borderWidth         : 3,
                      lineTension         : 0,
                      spanGaps : true,
                      backgroundColor     : '#bdffa9',
                      borderColor         : '#bdffa9', //'#efefef',
                      pointRadius         : 4,
                      pointHoverRadius    : 7,
                      pointColor          : '#3cff00',
                      pointBackgroundColor: '#3cff00',
                      data                : garantias_7d
                    },
                    {
                      label               : ['Presentismo'],//empresas,
                      fill                : false,
                      borderWidth         : 3,
                      lineTension         : 0,
                      spanGaps : true,
                      backgroundColor     : '#fff791',
                      borderColor         : '#fff791', //'#efefef',
                      pointRadius         : 4,
                      pointHoverRadius    : 7,
                      pointColor          : '#ffec00',
                      pointBackgroundColor: '#ffec00',
                      data                : presentismo
                    },
                    {
                      label               : ['Inst. Diarias'],//empresas,
                      fill                : false,
                      borderWidth         : 3,
                      lineTension         : 0,
                      spanGaps : true,
                      backgroundColor     : '#8cf3fd',
                      borderColor         : '#8cf3fd', //'#efefef',
                      pointRadius         : 4,
                      pointHoverRadius    : 7,
                      pointColor          : '#00d3e7',
                      pointBackgroundColor: '#00d3e7',
                      data                : diarias
                    },
                    {
                      label               : ['Ef. Citas'],//empresas,
                      fill                : false,
                      borderWidth         : 3,
                      lineTension         : 0,
                      spanGaps : true,
                      backgroundColor     : '#f7b3ff',
                      borderColor         : '#f7b3ff', //'#efefef',
                      pointRadius         : 4,
                      pointHoverRadius    : 7,
                      pointColor          : '#e500ff',
                      pointBackgroundColor: '#e500ff',
                      data                : citas
                    }
                ]
            }

            var salesGraphChartOptions = {
                maintainAspectRatio : false,
                responsive : true,
                legend: {
                    display: true,
                },
                scales: {
                    xAxes: [{
                        ticks : {
                            beginAtZero: true,
                            fontColor: '#ffffff',
                        },
                        gridLines : {
                            display : false,
                            color: '#efefef',
                            drawBorder: false,
                        }
                    }],
                    yAxes: [{
                        ticks : {
                            stepSize: 10,
                            beginAtZero: false,
                            fontColor: '#efefef',
                        },
                        gridLines : {
                            display : false,
                            color: '#efefef',
                            drawBorder: false,
                        }
                    }]
                }
            }

            // This will get the first returned node in the jQuery collection.
            var salesGraphChart = new Chart(salesGraphChartCanvas, {
                type: 'line', 
                data: salesGraphChartData, 
                options: salesGraphChartOptions
              }
            )
        }
    </script>
</asp:Content>
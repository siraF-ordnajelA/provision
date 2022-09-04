function combo_fechas_periodos() {
    var cbo_fecha1 = $('#cbo_periodo1');
    var cbo_fecha2 = $('#cbo_periodo2');

    $.ajax({
        url: "servicios_indicadores.asmx/obtener_fechas_metricas",
        method: 'post',
        dataType: "json",
        success: function (datos) {
            cbo_fecha1.empty();
            cbo_fecha2.empty();
            cbo_fecha1.append($('<option/>', { value: 0, text: "-- Inicio --" }));
            cbo_fecha2.append($('<option/>', { value: 0, text: "-- Fin --" }));
            $(datos).each(function (index, item) {
                cbo_fecha1.append($('<option/>', { value: item.valor, text: item.texto }));
                cbo_fecha2.append($('<option/>', { value: item.valor, text: item.texto }));
            });
        },
        error: function (jqXHR, exception) {
            if (jqXHR.status === 0) {
                alert('Not connect.n Verify Network.');
            } else if (jqXHR.status == 404) {
                alert('Requested page not found. [404]');
            } else if (jqXHR.status == 500) {
                alert('Internal Server Error [500].');
            } else if (exception === 'parsererror') {
                alert('Requested JSON parse failed.');
            } else if (exception === 'timeout') {
                alert('Time out error.');
            } else if (exception === 'abort') {
                alert('Ajax request aborted.');
            } else {
                alert('Uncaught Error.n' + jqXHR.responseText);
            }
        }
    });
}

function barras_detracciones_por_altas(opcion) {
    var resultados = $('#t_det-altas');
    var cbo_fecha1 = document.getElementById("cbo_periodo1").value;
    var cbo_fecha2 = document.getElementById("cbo_periodo2").value;
    var cbo_empresa = document.getElementById("cbo_ctta").value;
    var array_empresa = [];
    var array_instalaciones = [];
    var array_porc_detracciones = [];
    var ctta_temp = "";

    if (cbo_empresa == "") {
        cbo_empresa = 0;
    }

    resultados.empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_altas",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, opc: 1 },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (ctta_temp == item.empresa){
                    array_instalaciones.push(item.instalaciones);
                    array_porc_detracciones.push(item.porcentaje);
                }
                else {
                    array_empresa.push(item.empresa + " (" + item.cantidad + ")");
                    array_instalaciones.push(item.instalaciones);
                    array_porc_detracciones.push(item.porcentaje);
                }
                ctta_temp = item.empresa;
            });

            var myJsonString_empresa = JSON.stringify(array_empresa);
            var myJsonString_instalaciones = JSON.stringify(array_instalaciones);
            var myJsonString_porcentaje = JSON.stringify(array_porc_detracciones);

            var jsonArray_empresa = JSON.parse(myJsonString_empresa);
            var jsonArray_instalaciones = JSON.parse(myJsonString_instalaciones);
            var jsonArray_porcentaje = JSON.parse(myJsonString_porcentaje);

            dibuja_barra1_detracciones(jsonArray_empresa, jsonArray_instalaciones, jsonArray_porcentaje);
            //alert(myJsonString_porcentaje); //ME MUESTRA EL JSON
        },
        error: function () {
            alert("Hubo un error al consultar barras!.");
        }
    });
}

function dibuja_barra1_detracciones(empresas, instalaciones, porcentajes) {
    Highcharts.chart('t_det-altas', {
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: '% Detracciones por Altas cumplidas'
        },
        subtitle: {
            text: 'Fuente: Web Provision'
        },
        xAxis: [{
            categories: empresas/*['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']*/,
            crosshair: true
        }],
        yAxis: [{ // Primary yAxis
            title: {
                text: 'Detracciones',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            labels: {
                format: '{value}%',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
        }, { // Secondary yAxis
            title: {
                text: 'Instalaciones',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            labels: {
                //format: '{value} mm',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'center',
            x: 120,
            verticalAlign: 'top',
            y: 100,
            floating: true,
            backgroundColor:
            Highcharts.defaultOptions.legend.backgroundColor || // theme
            'rgba(255,255,255,0.25)'
        },
        series: [{
            name: 'Instalaciones',
            type: 'column',
            yAxis: 1,
            data: instalaciones,//[49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
            tooltip: {
                //valueSuffix: ' mm'
            }

        }, {
            name: '% Detracciones',
            type: 'spline',
            data: porcentajes,//[7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6],
            tooltip: {
                valueSuffix: '%'
            }
        }]
    });
}

function pie_detraciones_region() {
    var cbo_fecha1 = document.getElementById("cbo_periodo1").value;
    var cbo_fecha2 = document.getElementById("cbo_periodo2").value;
    var cbo_empresa = document.getElementById("cbo_ctta").value;
    var contador = 0;

    var datitos = [];
    var objetos;

    if (cbo_empresa == "") {
        cbo_empresa = 0;
    }
    
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_altas",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, opc: 2 },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (contador == 0) {
                    objetos = {
                        "name": item.empresa + " (" + item.cantidad + ")",
                        "y": item.porcentaje,
                        "sliced": true,
                        "selected": true
                    };
                }
                else {
                    objetos = {
                        "name": item.empresa + " (" + item.cantidad + ")",
                        "y": item.porcentaje
                    };
                }

                contador = contador + 1;
                datitos.push(objetos);
            });

            var myJsonString = JSON.stringify(datitos);
            var jsonArray = JSON.parse(myJsonString);

            dibuja_pie_detracciones(jsonArray);
            //alert(myJsonString); //ME MUESTRA EL JSON
        },
        error: function () {
            alert("Hubo un error al consultar pies!.");
        }
    });
}

function dibuja_pie_detracciones(region) {
    // Detracciones por Region
    Highcharts.chart('det_por_region', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: '%Detracciones x Región'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        accessibility: {
            point: {
                valueSuffix: '%'
            }
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                size: 220,
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            name: 'Detrac.',
            colorByPoint: true,
            data: region /*[{
                name: 'Chrome',
                y: 70.67,
                //sliced: true,
                //selected: true
            }, {
                name: 'Edge',
                y: 14.77
            }, {
                name: 'Firefox',
                y: 4.86
            }, {
                name: 'Safari',
                y: 2.63
            }, {
                name: 'Internet Explorer',
                y: 1.53
            }, {
                name: 'Opera',
                y: 1.40
            }, {
                name: 'Sogou Explorer',
                y: 0.84
            }, {
                name: 'QQ',
                y: 0.51
            }, {
                name: 'Other',
                y: 2.6
            }]*/
        }]
    });

    // Detracciones por Segmento
    Highcharts.chart('det_por_segmento', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: '%Detracciones x Segmento'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        accessibility: {
            point: {
                valueSuffix: '%'
            }
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            name: 'Brands',
            colorByPoint: true,
            data: [{
                name: 'Chrome',
                y: 70.67,
                sliced: true,
                selected: true
            }, {
                name: 'Edge',
                y: 14.77
            }, {
                name: 'Firefox',
                y: 4.86
            }, {
                name: 'Safari',
                y: 2.63
            }, {
                name: 'Internet Explorer',
                y: 1.53
            }, {
                name: 'Opera',
                y: 1.40
            }, {
                name: 'Sogou Explorer',
                y: 0.84
            }, {
                name: 'QQ',
                y: 0.51
            }, {
                name: 'Other',
                y: 2.6
            }]
        }]
    });

    // Detracciones por Tecnología
    Highcharts.chart('det_por_tecnologia', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: '%Detracciones x Tecnología'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        accessibility: {
            point: {
                valueSuffix: '%'
            }
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            name: 'Brands',
            colorByPoint: true,
            data: [{
                name: 'Chrome',
                y: 70.67,
                sliced: true,
                selected: true
            }, {
                name: 'Edge',
                y: 14.77
            }, {
                name: 'Firefox',
                y: 4.86
            }, {
                name: 'Safari',
                y: 2.63
            }, {
                name: 'Internet Explorer',
                y: 1.53
            }, {
                name: 'Opera',
                y: 1.40
            }, {
                name: 'Sogou Explorer',
                y: 0.84
            }, {
                name: 'QQ',
                y: 0.51
            }, {
                name: 'Other',
                y: 2.6
            }]
        }]
    });
}
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

///////////////////////////// GRAPHS3 ////////////////////////////////
function barras_detracciones_por_altas(empresa, opcion) {
    var resultados = $('#t_det-altas');
    var resultados_localidad = $('#t_det-localidad');
    var cbo_fecha1 = document.getElementById("cbo_periodo1").value;
    var cbo_fecha2 = document.getElementById("cbo_periodo2").value;
    var cbo_empresa = document.getElementById("cbo_ctta").value;
    var array_empresa = [];
    var array_instalaciones = [];
    var array_porc_detracciones = [];
    var array_localidad = [];
    var array_casos = [];
    var array_porc_localidad = [];
    var ctta_temp = "";

    if (opcion == 1)
    {
        if (empresa == 12)
        {
            cbo_empresa = 0;
        }
        else 
        {
            cbo_empresa = empresa;
        }
    }
    else
    {
        if (cbo_empresa == "" || cbo_empresa == 0)
        {
            if (empresa == 12)
            {
                cbo_empresa = 0;
            }
             else 
            {
                cbo_empresa = empresa;
            }
        }
    }

    resultados.empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    resultados_localidad.empty();

    //alert("Barra Empresa: " + empresa + " / cbo_empresa:" + cbo_empresa);
    
    // DETRACCIONES X ALTAS
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
            alert("Hubo un error al consultar barras Altas x Empresa!.");
        }
    });

    // DETRACCIONES POR LOCALIDAD
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_altas",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, opc: 5 },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (ctta_temp == item.empresa){
                    array_casos.push(item.instalaciones);
                    array_porc_localidad.push(item.porcentaje);
                }
                else {
                    array_localidad.push(item.empresa + " (" + item.cantidad + ")");
                    array_casos.push(item.instalaciones);
                    array_porc_localidad.push(item.porcentaje);
                }
                ctta_temp = item.empresa;
            });

            var myJsonString_localidad = JSON.stringify(array_localidad);
            var myJsonString_casos = JSON.stringify(array_casos);
            var myJsonString_porcentaje_localidad = JSON.stringify(array_porc_localidad);

            var jsonArray_localidad = JSON.parse(myJsonString_localidad);
            var jsonArray_casos = JSON.parse(myJsonString_casos);
            var jsonArray_porcentaje_localidad = JSON.parse(myJsonString_porcentaje_localidad);

            dibuja_barra2_detracciones_localidad(jsonArray_localidad, jsonArray_casos, jsonArray_porcentaje_localidad);
            //alert("Locas: " + myJsonString_localidad); //ME MUESTRA EL JSON
            //alert("Casos: " + myJsonString_casos);
            //alert("Porcentajes: " + myJsonString_porcentaje_localidad);
        },
        error: function () {
            alert("Hubo un error al consultar barras Detracciones x Localidad!.");
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
            x: 250,
            verticalAlign: 'top',
            y: 60,
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

function dibuja_barra2_detracciones_localidad(localidades, casos, porcentajes) {
    Highcharts.chart('t_det-localidad', {
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: 'Top 10 Detracciones por Localidad'
        },
        subtitle: {
            text: 'Fuente: Web Provision'
        },
        xAxis: [{
            categories: localidades/*['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']*/,
            crosshair: true
        }],
        yAxis: [{ // Primary yAxis
            title: {
                text: 'Porcentaje',
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
            x: 250,
            verticalAlign: 'top',
            y: 60,
            floating: true,
            backgroundColor:
            Highcharts.defaultOptions.legend.backgroundColor || // theme
            'rgba(255,255,255,0.25)'
        },
        series: [{
            name: 'Instalaciones',
            type: 'column',
            yAxis: 1,
            data: casos,//[49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
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

function pie_detraciones(empresa, opcion) {
    var cbo_fecha1 = document.getElementById("cbo_periodo1").value;
    var cbo_fecha2 = document.getElementById("cbo_periodo2").value;
    var cbo_empresa = document.getElementById("cbo_ctta").value;

    nombre_temp = "";

    var array_region = [];
    var array_segmento = [];
    var array_tecno = [];
    var array_instalaciones = [];
    var array_porc_detracciones = [];

    if (opcion == 1)
    {
        if (empresa == 12)
        {
            cbo_empresa = 0;
        }
        else 
        {
            cbo_empresa = empresa;
        }
    }
    else
    {
        if (cbo_empresa == "" || cbo_empresa == 0)
        {
            if (empresa == 12)
            {
                cbo_empresa = 0;
            }
             else 
            {
                cbo_empresa = empresa;
            }
        }
    }

    //alert("Pie Empresa: " + empresa + " / cbo_empresa:" + cbo_empresa);

    // PIE DETRACCIONES POR REGION
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_altas",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, opc: 2 },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (nombre_temp == item.empresa){
                    array_instalaciones.push(item.instalaciones);
                    array_porc_detracciones.push(item.porcentaje);
                }
                else {
                    array_region.push(item.empresa + " (" + item.cantidad + ")");
                    array_instalaciones.push(item.instalaciones);
                    array_porc_detracciones.push(item.porcentaje);
                }
                nombre_temp = item.empresa;
            });

            var myJsonString_region = JSON.stringify(array_region);
            var myJsonString_instalaciones = JSON.stringify(array_instalaciones);
            var myJsonString_porcentaje = JSON.stringify(array_porc_detracciones);

            var jsonArray_region = JSON.parse(myJsonString_region);
            var jsonArray_instalaciones = JSON.parse(myJsonString_instalaciones);
            var jsonArray_porcentaje = JSON.parse(myJsonString_porcentaje);

            dibuja_pie_detracciones_region(jsonArray_region, jsonArray_instalaciones, jsonArray_porcentaje);
            //alert(myJsonString); //ME MUESTRA EL JSON
        },
        error: function () {
            alert("Hubo un error al consultar pie Detracciones x Region!.");
        }
    });

    // PIE DETRACCIONES POR SEGMENTO
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_altas",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, opc: 3 },
        dataType: "json",
        success: function (datos) {
            array_instalaciones = [];
            array_porc_detracciones = [];
            
            $(datos).each(function (index, item) {
                if (nombre_temp == item.empresa){
                    array_instalaciones.push(item.instalaciones);
                    array_porc_detracciones.push(item.porcentaje);
                }
                else {
                    array_segmento.push(item.empresa + " (" + item.cantidad + ")");
                    array_instalaciones.push(item.instalaciones);
                    array_porc_detracciones.push(item.porcentaje);
                }
                nombre_temp = item.empresa;
            });

            var myJsonString_segmento = JSON.stringify(array_segmento);
            var myJsonString_instalaciones = JSON.stringify(array_instalaciones);
            var myJsonString_porcentaje = JSON.stringify(array_porc_detracciones);

            var jsonArray_segmento = JSON.parse(myJsonString_segmento);
            var jsonArray_instalaciones = JSON.parse(myJsonString_instalaciones);
            var jsonArray_porcentaje = JSON.parse(myJsonString_porcentaje);

            dibuja_pie_detracciones_segmento(jsonArray_segmento, jsonArray_instalaciones, jsonArray_porcentaje);
            //alert(myJsonString); //ME MUESTRA EL JSON
        },
        error: function () {
            alert("Hubo un error al consultar pie Detracciones x Segmento!.");
        }
    });

    // PIE DETRACCIONES POR TECNOLOGIA
    contador = 0;
    
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_altas",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, opc: 4 },
        dataType: "json",
        success: function (datos) {
            array_instalaciones = [];
            array_porc_detracciones = [];
            
            $(datos).each(function (index, item) {
                if (nombre_temp == item.empresa){
                    array_instalaciones.push(item.instalaciones);
                    array_porc_detracciones.push(item.porcentaje);
                }
                else {
                    array_tecno.push(item.empresa + " (" + item.cantidad + ")");
                    array_instalaciones.push(item.instalaciones);
                    array_porc_detracciones.push(item.porcentaje);
                }
                nombre_temp = item.empresa;;
            });

            var myJsonString_tecno = JSON.stringify(array_tecno);
            var myJsonString_instalaciones = JSON.stringify(array_instalaciones);
            var myJsonString_porcentaje = JSON.stringify(array_porc_detracciones);

            var jsonArray_tecno = JSON.parse(myJsonString_tecno);
            var jsonArray_instalaciones = JSON.parse(myJsonString_instalaciones);
            var jsonArray_porcentaje = JSON.parse(myJsonString_porcentaje);

            dibuja_pie_detracciones_tecno(jsonArray_tecno, jsonArray_instalaciones, jsonArray_porcentaje);
            //alert(myJsonString); //ME MUESTRA EL JSON
        },
        error: function () {
            alert("Hubo un error al consultar pie Detracciones x Segmento!.");
        }
    });
}

function dibuja_pie_detracciones_region(region, instalaciones, porcentajes) {
    // Detracciones por Region
    Highcharts.chart('det_por_region', {
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: '% Detracciones por Región'
        },
        subtitle: {
            text: 'Fuente: Web Provision'
        },
        xAxis: [{
            categories: region,
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
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        series: [{
            name: 'Instalaciones',
            type: 'column',
            yAxis: 1,
            data: instalaciones,
            tooltip: {
                //valueSuffix: ' mm'
            }

        }, {
            name: '% Detracciones',
            type: 'spline',
            data: porcentajes,
            tooltip: {
                valueSuffix: '%'
            }
        }]
    });
}

function dibuja_pie_detracciones_segmento (segmento, instalaciones, porcentajes) {
    // Detracciones por Segmento
    Highcharts.chart('det_por_segmento', {
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: '% Detracciones por Segmento'
        },
        subtitle: {
            text: 'Fuente: Web Provision'
        },
        xAxis: [{
            categories: segmento,
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
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        series: [{
            name: 'Instalaciones',
            type: 'column',
            yAxis: 1,
            data: instalaciones,
            tooltip: {
                //valueSuffix: ' mm'
            }

        }, {
            name: '% Detracciones',
            type: 'spline',
            data: porcentajes,
            tooltip: {
                valueSuffix: '%'
            }
        }]
    });
}

function dibuja_pie_detracciones_tecno (tecnologia, instalaciones, porcentajes) {
    // Detracciones por Segmento
    Highcharts.chart('det_por_tecnologia', {
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: '% Detracciones por Tecnología'
        },
        subtitle: {
            text: 'Fuente: Web Provision'
        },
        xAxis: [{
            categories: tecnologia,
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
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        series: [{
            name: 'Instalaciones',
            type: 'column',
            yAxis: 1,
            data: instalaciones,
            tooltip: {
                //valueSuffix: ' mm'
            }

        }, {
            name: '% Detracciones',
            type: 'spline',
            data: porcentajes,
            tooltip: {
                valueSuffix: '%'
            }
        }]
    });
}

///////////////////////////// GRAPHS4 ////////////////////////////////
function barras_detracciones_por_accion(empresa, opcion) {
    var resultados = $('#t_det-accion');
    var cbo_fecha1 = document.getElementById("cbo_periodo1").value;
    var cbo_fecha2 = document.getElementById("cbo_periodo2").value;
    var cbo_empresa = document.getElementById("cbo_ctta").value;
    var cbo_motivo = document.getElementById("cbo_motivo_detraccion").value;
    var total = 0;

    var array_accion = [];
    var array_casos = [];
    var array_porc_detracciones = [];

    var array_localidad = [];
    var array_casos_localidad = [];
    var array_porc_localidad = [];

    var temp = "";

    if (opcion == 1)
    {
        if (empresa == 12)
        {
            cbo_empresa = 0;
        }
        else 
        {
            cbo_empresa = empresa;
        }
    }
    else
    {
        if (cbo_empresa == "" || cbo_empresa == 0)
        {
            if (empresa == 12)
            {
                cbo_empresa = 0;
            }
            else 
            {
                cbo_empresa = empresa;
            }
        }
    }

    resultados.empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    //alert("Barra Empresa: " + empresa + " / cbo_empresa:" + cbo_empresa);
    
    // DETRACCIONES X ACCION EJECUTADA
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_accion",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, motivo: cbo_motivo, opc: 1 },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (temp == item.empresa){
                    array_casos.push(item.cantidad);
                    array_porc_detracciones.push(item.porcentaje);
                }
                else {
                    array_accion.push(item.empresa + " (" + item.cantidad + ")");
                    array_casos.push(item.cantidad);
                    array_porc_detracciones.push(item.porcentaje);
                }
                temp = item.empresa;
                total = item.instalaciones;
            });

            var myJsonString_accion = JSON.stringify(array_accion);
            var myJsonString_casos = JSON.stringify(array_casos);
            var myJsonString_porcentaje = JSON.stringify(array_porc_detracciones);

            var jsonArray_accion = JSON.parse(myJsonString_accion);
            var jsonArray_casos = JSON.parse(myJsonString_casos);
            var jsonArray_porcentaje = JSON.parse(myJsonString_porcentaje);

            dibuja_barra1_detracciones_accion(jsonArray_accion, jsonArray_casos, jsonArray_porcentaje, total);
            //alert(myJsonString_porcentaje); //ME MUESTRA EL JSON
        },
        error: function () {
            alert("Hubo un error al consultar barras Acción Ejecutada!.");
        }
    });

    // DETRACCIONES POR LOCALIDAD
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_accion",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, motivo: 0, opc: 5 },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (temp == item.empresa){
                    array_casos_localidad.push(item.instalaciones);
                    array_porc_localidad.push(item.porcentaje);
                }
                else {
                    array_localidad.push(item.empresa + " (" + item.cantidad + ")");
                    array_casos_localidad.push(item.instalaciones);
                    array_porc_localidad.push(item.porcentaje);
                }
                temp = item.empresa;
            });

            var myJsonString_localidad = JSON.stringify(array_localidad);
            var myJsonString_casos_localidad = JSON.stringify(array_casos_localidad);
            var myJsonString_porcentaje_localidad = JSON.stringify(array_porc_localidad);

            var jsonArray_localidad = JSON.parse(myJsonString_localidad);
            var jsonArray_casos_localidad = JSON.parse(myJsonString_casos_localidad);
            var jsonArray_porcentaje_localidad = JSON.parse(myJsonString_porcentaje_localidad);

            dibuja_barra2_detracciones_localidad_graphs4(jsonArray_localidad, jsonArray_casos_localidad, jsonArray_porcentaje_localidad);
            //alert("Locas: " + myJsonString_localidad); //ME MUESTRA EL JSON
            //alert("Casos: " + myJsonString_casos);
            //alert("Porcentajes: " + myJsonString_porcentaje_localidad);
        },
        error: function () {
            alert("Hubo un error al consultar barras Detracciones x Localidad!.");
        }
    });
}

function dibuja_barra1_detracciones_accion(accion, casos, porcentajes, totales) {
    Highcharts.chart('t_det-accion', {
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: '% Detracciones por Acción ejecutada (' + totales + ')' 
        },
        subtitle: {
            text: 'Fuente: Web Provision'
        },
        xAxis: [{
            categories: accion,
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
                text: 'Cantidad de casos',
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
            name: 'Casos',
            type: 'column',
            yAxis: 1,
            data: casos,//[49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
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

function dibuja_barra2_detracciones_localidad_graphs4(localidades, casos, porcentajes) {
    Highcharts.chart('t_det-localidad', {
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Top 10 Detracciones por Localidad'
        },
        subtitle: {
            text: 'Fuente: Web Provision'
        },
        xAxis: [{
            categories: localidades
        }],
        yAxis: [{ // Primary yAxis
            min: 0,
            title: {
                text: 'Detracciones (%)',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        }],
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        series: [{
            name: '% Detracciones',
            data: porcentajes,
            tooltip: {
                valueSuffix: '%'
            }
        }]
    });
}

function pie_detraciones_accion(empresa, opcion) {
    var cbo_fecha1 = document.getElementById("cbo_periodo1").value;
    var cbo_fecha2 = document.getElementById("cbo_periodo2").value;
    var cbo_empresa = document.getElementById("cbo_ctta").value;
    var cbo_motivo = document.getElementById("cbo_motivo_detraccion").value;

    var contador = 0;

    var datitos_region = [];
    var datitos_segmento = [];
    var datitos_tecnologia = [];
    var objetos;

    if (opcion == 1)
    {
        if (empresa == 12)
        {
            cbo_empresa = 0;
        }
        else 
        {
            cbo_empresa = empresa;
        }
    }
    else
    {
        if (cbo_empresa == "" || cbo_empresa == 0)
        {
            if (empresa == 12)
            {
                cbo_empresa = 0;
            }
             else 
            {
                cbo_empresa = empresa;
            }
        }
    }

    //alert("Pie Empresa: " + empresa + " / cbo_empresa:" + cbo_empresa);

    // PIE DETRACCIONES POR REGION
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_accion",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, motivo: cbo_motivo, opc: 2 },
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

                contador = item.instalaciones;
                datitos_region.push(objetos);
            });

            var myJsonString = JSON.stringify(datitos_region);
            var jsonArray = JSON.parse(myJsonString);

            dibuja_pie_detracciones_accion_region(jsonArray, contador);
            //alert(myJsonString); //ME MUESTRA EL JSON
        },
        error: function () {
            alert("Hubo un error al consultar pie Detracciones x Region!.");
        }
    });

    // PIE DETRACCIONES POR SEGMENTO
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_accion",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, motivo: cbo_motivo, opc: 3 },
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

                contador = item.instalaciones;
                datitos_segmento.push(objetos);
            });

            var myJsonString = JSON.stringify(datitos_segmento);
            var jsonArray = JSON.parse(myJsonString);

            dibuja_pie_detracciones_accion_segmento(jsonArray, contador);
            //alert(myJsonString); //ME MUESTRA EL JSON
        },
        error: function () {
            alert("Hubo un error al consultar pie Detracciones x Segmento!.");
        }
    });

    // PIE DETRACCIONES POR TECNOLOGIA
    $.ajax({
        url: "servicios_indicadores.asmx/barra_detracciones_por_accion",
        method: 'post',
        data: { id_empresa: cbo_empresa, fecha1: cbo_fecha1, fecha2: cbo_fecha2, motivo: cbo_motivo, opc: 4 },
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

                contador = item.instalaciones;
                datitos_tecnologia.push(objetos);
            });

            var myJsonString = JSON.stringify(datitos_tecnologia);
            var jsonArray = JSON.parse(myJsonString);

            dibuja_pie_detracciones_accion_tecno(jsonArray, contador);
            //alert(myJsonString); //ME MUESTRA EL JSON
        },
        error: function () {
            alert("Hubo un error al consultar pie Detracciones x Tecnología!.");
        }
    });
}

function dibuja_pie_detracciones_accion_region(datitos, total)
{
    // Detracciones por REGION
    Highcharts.chart('det_por_region', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: '%Detracciones x Región (' + total + ')'
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
                size: 200,
                dataLabels: {
                    enabled: false,
                    //format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'Detrac.',
            colorByPoint: true,
            data: datitos /*[{
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
}

function dibuja_pie_detracciones_accion_segmento(datitos, total)
{
    // Detracciones por SEGMENTO
    Highcharts.chart('det_por_segmento', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: '%Detracciones x Segmento (' + total + ')'
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
                    enabled: false,
                    //format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'Detrac.',
            colorByPoint: true,
            data: datitos
        }]
    });
}

function dibuja_pie_detracciones_accion_tecno(datitos, total)
{
    // Detracciones por TECNOLOGIA
    Highcharts.chart('det_por_tecnologia', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: '%Detracciones x Tecnología (' + total + ')'
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
                    enabled: false,
                    //format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'Detrac.',
            colorByPoint: true,
            data: datitos
        }]
    });
}
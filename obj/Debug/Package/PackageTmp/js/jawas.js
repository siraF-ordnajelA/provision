function arranca_chorizo(centro) {
    var resultados = $('#t1');
    var resultados2 = $('#t3');
    var tecnologia = document.getElementById("cbo_tecno").value;
    var subtotal1 = 0;
    var subtotal2 = 0;
    var subtotal3 = 0;
    var subtotal4 = 0;
    var subtotal5 = 0;
    var subtotal6 = 0;
    var subtotal7 = 0;
    var subtotal8 = 0;
    var sw_color = 0;

    // VALOR DEL RADIO BUTTON
    var radio_porc = document.getElementsByName('rd_ND');
    for (i = 0; i < radio_porc.length; i++) {
        if (radio_porc[i].checked) {
            var valor_radio = radio_porc[i].value;
        }
    }

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    $('#t3').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    if (valor_radio == "P") {
        resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center" colspan="11"><b>GARANTIAS ACUMULADAS POR ANTIGUEDAD A LA FECHA</b></td></tr>');
        resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>EMPRESA</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>1 DIA</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>2 DIAS</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>3 DIAS</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>4 DIAS</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>MAYOR 4 DIAS</b></td></tr>');

        $.ajax({
            url: "servicios_web.asmx/obtener_contratas", //Llama al webmethod "obtener_gerencia" del lado servidor
            method: 'post',
            data: { parametro_centro: centro, tecnologia: tecnologia },
            dataType: "json",
            success: function (datos) {
                $(datos).each(function (index, item) {
                    if (sw_color == 0) {
                        resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);"><a href="detalle_contrata.aspx?param=' + item.empresa + '">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_menos7 + '%</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_mas7 + '%</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_72hs + '%</td><td style="background-color:rgba(165, 23, 23, 0.3);" align="center">' + item.porc_96hs + '%</td><td style="background-color:rgba(165, 23, 23, 0.3);" align="center">' + item.porc_mas96hs + '%</td></tr>');
                        subtotal1 = subtotal1 + Number(item.menos7);
                        subtotal2 = subtotal2 + Number(item.mas7);
                        subtotal3 = subtotal3 + Number(item.cant_72hs);
                        subtotal4 = subtotal4 + Number(item.hs96);
                        subtotal5 = subtotal5 + Number(item.mashs96);
                        subtotal6 = subtotal6 + Number(item.subtotal);
                        sw_color = 1;
                    }
                    else {
                        resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);"><a href="detalle_contrata.aspx?param=' + item.empresa + '">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.porc_menos7 + '%</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.porc_mas7 + '%</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.porc_72hs + '%</td><td style="background-color:rgba(165, 23, 23, 0.6);" align="center">' + item.porc_96hs + '%</td><td style="background-color:rgba(165, 23, 23, 0.6);" align="center">' + item.porc_mas96hs + '%</td></tr>');
                        subtotal1 = subtotal1 + Number(item.menos7);
                        subtotal2 = subtotal2 + Number(item.mas7);
                        subtotal3 = subtotal3 + Number(item.cant_72hs);
                        subtotal4 = subtotal4 + Number(item.hs96);
                        subtotal5 = subtotal5 + Number(item.mashs96);
                        subtotal6 = subtotal6 + Number(item.subtotal);
                        sw_color = 0;
                    }
                });
                resultados.append('<tr><td colspan="11">&nbsp;</td></tr>');
                resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);">TOTAL</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + ((subtotal1 / subtotal6) * 100).toFixed(2) + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + ((subtotal2 / subtotal6) * 100).toFixed(2) + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + ((subtotal3 / subtotal6) * 100).toFixed(2) + '%</b></td><td style="background-color:rgba(165, 23, 23, 0.7);" align="center"><b>' + ((subtotal4 / subtotal6) * 100).toFixed(2) + '%</b></td><td style="background-color:rgba(165, 23, 23, 0.7);" align="center"><b>' + ((subtotal5 / subtotal6) * 100).toFixed(2) + '%</b></td></tr>');
            }
        });
    }

    if (valor_radio == "C") {
        resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center" colspan="13"><b>GARANTIAS ACUMULADAS POR ANTIGUEDAD A LA FECHA</b></td></tr>');
        resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>EMPRESA</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>1 DIA</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>2 DIAS</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>3 DIAS</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>4 DIAS</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>MAYOR 4 DIAS</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>CITAS</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>C.VENCIDAS</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>SUBTOTAL</b></td></tr>');

        $.ajax({
            url: "servicios_web.asmx/obtener_contratas", //Llama al webmethod "obtener_gerencia" del lado servidor
            method: 'post',
            data: { parametro_centro: centro, tecnologia: tecnologia },
            dataType: "json",
            success: function (datos) {
                $(datos).each(function (index, item) {
                    if (sw_color == 0) {
                        resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=0&tecnolo=' + tecnologia + '">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=1&tecnolo=' + tecnologia + '">' + item.menos7 + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=2&tecnolo=' + tecnologia + '">' + item.mas7 + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=3&tecnolo=' + tecnologia + '">' + item.cant_72hs + '</a></td><td style="background-color:rgba(165, 23, 23, 0.3);" align="center"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=4&tecnolo=' + tecnologia + '">' + item.hs96 + '</a></td><td style="background-color:rgba(165, 23, 23, 0.3);" align="center"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=5&tecnolo=' + tecnologia + '">' + item.mashs96 + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.citas + '</td><td style="background-color:rgba(165, 23, 23, 0.3);" align="center">' + item.vencidas + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.subtotal + '</td></tr>');
                        subtotal1 = subtotal1 + Number(item.menos7);
                        subtotal2 = subtotal2 + Number(item.mas7);
                        subtotal3 = subtotal3 + Number(item.cant_72hs);
                        subtotal4 = subtotal4 + Number(item.hs96);
                        subtotal5 = subtotal5 + Number(item.mashs96);
                        subtotal6 = subtotal6 + Number(item.citas);
                        subtotal7 = subtotal7 + Number(item.vencidas);
                        subtotal8 = subtotal8 + Number(item.subtotal);
                        sw_color = 1;
                    }
                    else {
                        resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=0&tecnolo=' + tecnologia + '">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=1&tecnolo=' + tecnologia + '">' + item.menos7 + '</a></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=2&tecnolo=' + tecnologia + '">' + item.mas7 + '</a></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=3&tecnolo=' + tecnologia + '">' + item.cant_72hs + '</a></td><td style="background-color:rgba(165, 23, 23, 0.6);" align="center"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=4&tecnolo=' + tecnologia + '">' + item.hs96 + '</a></td><td style="background-color:rgba(165, 23, 23, 0.6);" align="center"><a href="detalle_contrata.aspx?param=' + item.empresa + '&dia=5&tecnolo=' + tecnologia + '">' + item.mashs96 + '</a></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.citas + '</td><td style="background-color:rgba(165, 23, 23, 0.6);" align="center">' + item.vencidas + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.subtotal + '</td></tr>');
                        subtotal1 = subtotal1 + Number(item.menos7);
                        subtotal2 = subtotal2 + Number(item.mas7);
                        subtotal3 = subtotal3 + Number(item.cant_72hs);
                        subtotal4 = subtotal4 + Number(item.hs96);
                        subtotal5 = subtotal5 + Number(item.mashs96);
                        subtotal6 = subtotal6 + Number(item.citas);
                        subtotal7 = subtotal7 + Number(item.vencidas);
                        subtotal8 = subtotal8 + Number(item.subtotal);
                        sw_color = 0;
                    }
                });
                resultados.append('<tr><td colspan="13">&nbsp;</td></tr>');
                resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);">TOTAL</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + subtotal1 + '</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + subtotal2 + '</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + subtotal3 + '</b></td><td style="background-color:rgba(165, 23, 23, 0.7);" align="center"><b>' + subtotal4 + '</b></td><td style="background-color:rgba(165, 23, 23, 0.7);" align="center"><b>' + subtotal5 + '</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + subtotal6 + '</b></td><td style="background-color:rgba(165, 23, 23, 0.7);" align="center"><b>' + subtotal7 + '</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + subtotal8 + '</b></td></tr>');
            }
        });
    }

    //SEGUNDA TABLA DE LOS NO ASIGNADOS
    resultados2.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center" colspan="10"><b>GARANTIAS SIN ASIGNAR AL DIA DE HOY</b></td></tr>');

    $.ajax({
        url: "servicios_web.asmx/obtener_no_asignados", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                resultados2.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);"><a href="no_asignados.aspx">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.accessid + '</td></tr>');
            });
        }
    });
}

function carga_combos() {
    var nivel1 = $('#ddl_nivel1'); //ENTRE PARENTESIS EL ELEMENTO ID HTML (EN ESTE CASO EL COMBO)
    var nivel2 = $('#ddl_nivel2');

    $.ajax({
        url: "servicios_web.asmx/obtener_nivel1",
        method: 'post',
        dataType: "json",
        success: function (datos) {
            $('#ddl_nivel1').empty();
            $('#ddl_nivel2').empty();
            $('#ddl_nivel1').append("<option value='0'>--TODO--</option>");
            $('#ddl_nivel2').append("<option value='0'>--TODO--</option>");
            nivel2.prop('disabled', true);

            $(datos).each(function (index, item) {
                nivel1.append($('<option/>', { value: item.id, text: item.nivel1 })); //LOS VALORES "VALUE" Y "TEXT" SON ITEMS QUE TOMAN LOS VALORES DE LA CLASE cbo_nivel1.cs (ID1 Y NIVEL1)
            });
        }
    });

    nivel1.change(function () {
        if ($(this).val() == "0") {
            nivel2.empty();
            $('#ddl_nivel2').append("<option value='0'>--TODO--</option>");
            nivel2.val('0');
            //ddl_nivel2.val('0');
            nivel2.prop('disabled', false);
        }
        else {
            $.ajax({
                url: "servicios_web.asmx/obtener_nivel2", //Llama al webmethod "obtener_distrito" del lado servidor
                method: 'post',
                data: { nivel1_id: $(this).val() },
                dataType: "json",
                success: function (datos) {
                    $('#ddl_nivel2').empty();
                    $('#ddl_nivel2').append("<option value='0'>--Seleccione--</option>");
                    nivel2.prop('disabled', false);
                    $(datos).each(function (index, item) {
                        nivel2.append($('<option/>', { value: item.nivel2Id, text: item.nivel2 }));
                    });
                }
            });
        }
    });
}

function barras(centro) {
    var resultados = $('#t5');
    var cbo_fecha = $('#cbo_fecha_anio');
    $('#t5').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    
    var datitos = [];
    var objetos;

    $.ajax({
        url: "servicios_web.asmx/obtener_barras",
        method: 'post',
        data: { valor_centro: centro },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                objetos = {
                    "name": item.empresa,
                    "data": [item.enero, item.febrero, item.marzo, item.abril, item.mayo, item.junio, item.julio, item.agosto, item.septiembre, item.octubre, item.noviembre, item.diciembre]
                };
                //datitos.push(objetos);
                datitos.push(objetos);
            });

            var myJsonString = JSON.stringify(datitos);
            var jsonArray = JSON.parse(myJsonString);

            dibuja_barras(jsonArray);
            //alert(myJsonString); //ME MUESTRA EL JSON
        },
        error: function () {
            alert("Hubo un error al consultar!.");
        }
    });            //FIN AJAX
    
    resultados.append('<tr><td colspan="13" style="background-color:rgba(165, 23, 23, 0.5);" align="center"><b>GLOBAL GARANTIAS A 30 DIAS</b></td></tr>');
    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">&nbsp;</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>ENERO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>FEBRERO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>MARZO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>ABRIL</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>MAYO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>JUNIO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>JULIO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>AGOSTO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>SEPTIEMBRE</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>OCTUBRE</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>NOVIEMBRE</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>DICIEMBRE</b></td></tr>');

    $.ajax({
        url: "servicios_web.asmx/obtener_barras_global",
        method: 'post',
        data: { parametro_anio: 1 },
        dataType: "json",
        success: function (datos) {
                    $(datos).each(function (index, item) {
                        resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center"><b>GLOBAL</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.enero + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.febrero + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.marzo + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.abril + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.mayo + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.junio + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.julio + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.agosto + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.septiembre + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.octubre + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.noviembre + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.diciembre + '%</b></td></tr>');
                    });
                }
    });

    $.ajax({
        url: "servicios_web.asmx/obtener_anio_garantias_global",
        method: 'post',
        dataType: "json",
        success: function (datos) {
                    cbo_fecha.empty();
                    $(datos).each(function (index, item) {
                        cbo_fecha.append($('<option/>', { value: item.id, text: item.id }));
                    });
                }
    });
}

function cambia_anio_garantias_globales() {
    var resultados = $('#t5');
    var cbo_fecha = document.getElementById('cbo_fecha_anio').value

    resultados.empty();
    resultados.append('<tr><td colspan="13" style="background-color:rgba(165, 23, 23, 0.5);" align="center"><b>GLOBAL GARANTIAS A 30 DIAS</b></td></tr>');
    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">&nbsp;</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>ENERO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>FEBRERO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>MARZO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>ABRIL</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>MAYO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>JUNIO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>JULIO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>AGOSTO</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>SEPTIEMBRE</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>OCTUBRE</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>NOVIEMBRE</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>DICIEMBRE</b></td></tr>');

    $.ajax({
        url: "servicios_web.asmx/obtener_barras_global",
        method: 'post',
        data: { parametro_anio: cbo_fecha },
        dataType: "json",
        success: function (datos) {
                    $(datos).each(function (index, item) {
                        resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center"><b>GLOBAL</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.enero + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.febrero + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.marzo + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.abril + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.mayo + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.junio + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.julio + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.agosto + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.septiembre + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.octubre + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + item.noviembre + '%</b></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><b>' + item.diciembre + '%</b></td></tr>');
                    });
                }
    });
}

function dibuja_barras(serie) {
    $('#contenedor').highcharts({
        chart: {
            type: 'column'
            //type: 'line'
        },
        title: {
            text: 'Histórico Garantías a 30 días'
        },
        subtitle: {
            text: 'Fuente: TOA'
        },
        xAxis: {
            categories: [
                'Ene',
                'Feb',
                'Mar',
                'Abr',
                'May',
                'Jun',
                'Jul',
                'Ago',
                'Sep',
                'Oct',
                'Nov',
                'Dec'
            ],
            //crosshair: true
        },
        yAxis: {
            //min: 0,
            //max: 15,
            title: {
                text: 'Porcentaje Garantías (%)'
            }
        },
        /*tooltip: {
            backgroundColor: '#296184',
            headerFormat: '<table>',
            pointFormat: '<tr><td><p class="parrafo1">{series.name}</p></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },*/
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            },
        },
        /*plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },*/
        series: serie/*[{
            name: 'Tokyo',
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]

        }, {
            name: 'New York',
            data: [83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3]

        }, {
            name: 'London',
            data: [48.9, 38.8, 39.3, 41.4, 47.0, 48.3, 59.0, 59.6, 52.4, 65.2, 59.3, 51.2]

        }, {
            name: 'Berlin',
            data: [42.4, 33.2, 34.5, 39.7, 52.6, 75.5, 57.4, 60.4, 47.6, 39.1, 46.8, 51.1]

        }]*/
    });
}

function busca_tecnico(param_tecnico) {
    var resultados = $('#t2');
    var sw_color = 0;
    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    //var totales = 0;
    var comodin = "'";
    resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="left" colspan="17"><b>DETALLE AVERIAS DE: ' + param_tecnico + '</b></td></tr>');
    resultados.append('<tr><td colspan="17">&nbsp;</td></tr>');
    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Empresa</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Sub. Actividad</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Cod. Actuaci&oacute;n</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Petici&oacute;n</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Orden</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Access ID</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Cumplimiento Inst.</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Creaci&oacute;n TOA</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>D&iacute;as Antig.</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>S&iacute;ntoma</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Diagn&oacute;stico Inicial</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Diagn&oacute;stico Actual</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Bucket Inicial</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Programaci&oacute;n</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Estado</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Tipo cliente</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>Tecnolog&iacute;a</b></td></tr>');

    $.ajax({
        url: "servicios_web.asmx/obtener_data_tecnicos", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { parametro_tecnico: param_tecnico },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (sw_color = 0) {
                    if (item.dias > 3){
                        resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.actividad + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.actuacion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.peticion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.orden + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.accessid + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.f_instalacion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.f_emision + '</td><td style="background-color:rgba(165, 23, 23, 0.5);" align="center">' + item.dias + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.sintoma + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.diagnostico_ini + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.diagnostico_act + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.bucket + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.programacion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.estado + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.cliente + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.acceso + '</td></tr>');
                    }
                    else {
                        resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.actividad + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.actuacion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.peticion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.orden + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.accessid + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.f_instalacion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.f_emision + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.dias + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.sintoma + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.diagnostico_ini + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.diagnostico_act + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.bucket + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.programacion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.estado + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.cliente + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.acceso + '</td></tr>');
                    }
                    //totales = totales + Number(item.averias);
                    sw_color = 1;
                }
                else {
                    if (item.dias > 3){
                        resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.actividad + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.actuacion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.peticion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.orden + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.accessid + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.f_instalacion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.f_emision + '</td><td style="background-color:rgba(165, 23, 23, 0.7);" align="center">' + item.dias + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.sintoma + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.diagnostico_ini + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.diagnostico_act + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.bucket + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.programacion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.estado + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.cliente + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.acceso + '</td></tr>');
                    }
                    else {
                        resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.actividad + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.actuacion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.peticion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.orden + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.accessid + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.f_instalacion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.f_emision + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.dias + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.sintoma + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.diagnostico_ini + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.diagnostico_act + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.bucket + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.programacion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.estado + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.cliente + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.acceso + '</td></tr>');
                    }
                    sw_color = 0;
                }
            });
            resultados.append('<tr><td colspan="17">&nbsp;</td></tr>');
            resultados.append('<tr><td align="left" colspan="17"><input type="button" value="Volver" class="boton" onclick="actualizar()"></td></tr>');
        }
    });
}

function ejecuta_historico(centro) {
    document.getElementById("btn_consultar").disabled = true;
    var uno = document.getElementById('btn_consultar');
    uno.innerHTML = "Cargando...";

    $('#t2').empty();
    var resultados = $('#t2');
    $('#t1').empty();
    var resultados = $('#t1');
    var fecha_desde = document.getElementById('ContentPlaceHolder1_txt_desde').value;
    var fecha_hasta = document.getElementById('ContentPlaceHolder1_txt_hasta').value;
    var totales_insta = 0;
    var totales_gara = 0;
    var total_porc = 0;
    var sw_color = 0;
    var combo1 = document.getElementById("ddl_nivel1");
    var nivel1 = combo1.options[combo1.selectedIndex].text;
    var combo2 = document.getElementById("ddl_nivel2");
    var nivel2 = combo2.options[combo2.selectedIndex].text;
    var comodin = "'";

    var hoy = new Date();
    var fecha_hasta_formato = new Date(fecha_hasta);
    var fecha_desde_formato = new Date(fecha_desde);
    var resta1 = hoy.getTime() - fecha_hasta_formato.getTime(); //getTime devuelve milisegundos
    var resta2 = fecha_hasta_formato.getTime() - fecha_desde_formato.getTime();
    var diff_dias_hasta = (resta1 / 1000) / 60 / 60 / 24;

    //CHEQUEO VALOR DEL RD BUTTON
    //if ($('input[name="ctl00$ContentPlaceHolder1$rd_dias"]:checked').val() == "7d") {
    if ($('input[id="ContentPlaceHolder1_rd_dias_0"]:checked').val() == "7d") {
        var radio_dias = 7;
    }
    //else if ($('input[name="ctl00$ContentPlaceHolder1$rd_dias"]:checked').val() == "30d") {
    else if ($('input[id="ContentPlaceHolder1_rd_dias_1"]:checked').val() == "30d") {
        var radio_dias = 30;
    }

    if (fecha_desde != '' && fecha_hasta != '') {
        if (resta2 > 0) {
            if (radio_dias == 30) {
                if (diff_dias_hasta > 30) {
                    //alert("Hay mas de 30 dias");
                    fecha_desde = fecha_desde.replace("-", "");
                    fecha_desde = fecha_desde.replace("-", "");
                    fecha_hasta = fecha_hasta.replace("-", "");
                    fecha_hasta = fecha_hasta.replace("-", "");

                    if (nivel1 == "--TODO--") {
                        var radio1 = 1;
                    }
                    else {
                        var radio1 = 0;
                    }

                    $.ajax({
                        url: "servicios_web.asmx/obtener_data_historico",
                        method: 'post',
                        data: { empresa: centro, fecha_inicio: fecha_desde, fecha_fin: fecha_hasta, cbo_subtipo: nivel1, cbo_codigo: nivel2, todes: radio1, dias: radio_dias, val_tecnico: 0 },
                        dataType: "json",
                        success: function (datos) {
                            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">EMPRESA</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">INSTALACIONES</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">GARANTIAS</td><td style="background-color:rgba(41, 97, 132, 0.7);">PORCENTAJE</td></tr>');
                            $(datos).each(function (index, item) {
                                if (sw_color == 0) {
                                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="left"><label style="cursor:pointer" onclick="ejecuta_historico_detalle_tecnico(' + comodin + item.empresa + comodin + ',' + fecha_desde + ',' + fecha_hasta + ',' + comodin + nivel1 + comodin + ',' + comodin + nivel2 + comodin + ',' + radio1 + ',' + radio_dias + ');">' + item.empresa + '</label></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.menos7 + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.mas7 + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_menos7 + '%</td></tr>');
                                    totales_insta = totales_insta + item.menos7;
                                    totales_gara = totales_gara + item.mas7;
                                    sw_color = 1;
                                }
                                else {
                                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="left"><label style="cursor:pointer" onclick="ejecuta_historico_detalle_tecnico(' + comodin + item.empresa + comodin + ',' + fecha_desde + ',' + fecha_hasta + ',' + comodin + nivel1 + comodin + ',' + comodin + nivel2 + comodin + ',' + radio1 + ',' + radio_dias + ');">' + item.empresa + '</label></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.menos7 + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.mas7 + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.porc_menos7 + '%</td></tr>');
                                    totales_insta = totales_insta + item.menos7;
                                    totales_gara = totales_gara + item.mas7;
                                    sw_color = 0;
                                }
                            });
                            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="right"><b>TOTALES<b/></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_insta + '</b></td style="background-color:rgba(41, 97, 132, 0.7);"><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_gara + '</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + ((totales_gara / totales_insta) * 100).toFixed(2) + '%</b></td></tr>');

                            document.getElementById("btn_consultar").disabled = false;
                            uno.innerHTML = "Consultar";
                        },
                        error: function () {
                            alert("Hubo un error al consultar!.");
                            document.getElementById("btn_consultar").disabled = false;
                            uno.innerHTML = "Consultar";
                        }
                    });
                }

                else {
                    alert("La fecha HASTA debe tener por lo menos 30 dias a la fecha actual");
                    document.getElementById("btn_consultar").disabled = false;
                    uno.innerHTML = "Consultar";
                }
            } //CIERRA RADIO DIAS ES DE 30

            if (radio_dias == 7) {
                if (diff_dias_hasta > 7) {
                    fecha_desde = fecha_desde.replace("-", "");
                    fecha_desde = fecha_desde.replace("-", "");
                    fecha_hasta = fecha_hasta.replace("-", "");
                    fecha_hasta = fecha_hasta.replace("-", "");

                    if (nivel1 == "--TODO--") {
                        var radio1 = 1;
                    }
                    else {
                        var radio1 = 0;
                    }

                    $.ajax({
                        url: "servicios_web.asmx/obtener_data_historico",
                        method: 'post',
                        data: { empresa: centro, fecha_inicio: fecha_desde, fecha_fin: fecha_hasta, cbo_subtipo: nivel1, cbo_codigo: nivel2, todes: radio1, dias: radio_dias, val_tecnico: 0 },
                        dataType: "json",
                        success: function (datos) {
                            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">EMPRESA</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">INSTALACIONES</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">GARANTIAS</td><td style="background-color:rgba(41, 97, 132, 0.7);">PORCENTAJE</td></tr>');
                            $(datos).each(function (index, item) {
                                if (sw_color == 0) {
                                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="left"><label style="cursor:pointer" onclick="ejecuta_historico_detalle_tecnico (' + comodin + item.empresa + comodin + ',' + fecha_desde + ',' + fecha_hasta + ',' + comodin + nivel1 + comodin + ',' + comodin + nivel2 + comodin + ',' + radio1 + ',' + radio_dias + ');">' + item.empresa + '</label></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.menos7 + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.mas7 + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_menos7 + '%</td></tr>');
                                    totales_insta = totales_insta + item.menos7;
                                    totales_gara = totales_gara + item.mas7;
                                    sw_color = 1;
                                }
                                else {
                                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="left"><label style="cursor:pointer" onclick="ejecuta_historico_detalle_tecnico (' + comodin + item.empresa + comodin + ',' + fecha_desde + ',' + fecha_hasta + ',' + comodin + nivel1 + comodin + ',' + comodin + nivel2 + comodin + ',' + radio1 + ',' + radio_dias + ');">' + item.empresa + '</label></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.menos7 + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.mas7 + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.porc_menos7 + '%</td></tr>');
                                    totales_insta = totales_insta + item.menos7;
                                    totales_gara = totales_gara + item.mas7;
                                    sw_color = 0;
                                }
                            });
                            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="right"><b>TOTALES<b/></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_insta + '</b></td style="background-color:rgba(41, 97, 132, 0.7);"><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_gara + '</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + ((totales_gara / totales_insta) * 100).toFixed(2) + '%</b></td></tr>');

                            document.getElementById("btn_consultar").disabled = false;
                            uno.innerHTML = "Consultar";
                        },
                        error: function () {
                            alert("Hubo un error al consultar!.");
                            document.getElementById("btn_consultar").disabled = false;
                            uno.innerHTML = "Consultar";
                        }
                    });
                }

                else {
                    alert("La fecha HASTA debe tener por lo menos 7 dias a la fecha actual");
                    document.getElementById("btn_consultar").disabled = false;
                    uno.innerHTML = "Consultar";
                }
            }
        }
        else {
            alert("La fecha DESDE, debe ser menor a la fecha HASTA");
            document.getElementById("btn_consultar").disabled = false;
            uno.innerHTML = "Consultar";
        }
    }
    else {
        alert("Debe completar ambos campos de fecha con numeros en formato AAAA-MM-DD");
        document.getElementById("btn_consultar").disabled = false;
        uno.innerHTML = "Consultar";
    }
}

function ejecuta_historico_detalle_tecnico(empresa_val, f_inicio, f_fin, combo1, combo2, todos, dias) {
    document.getElementById("btn_consultar").disabled = true;
    var uno = document.getElementById('btn_consultar');
    uno.innerHTML = "Cargando...";

    $('#t2').empty();
    var resultados = $('#t2');
    var totales_insta = 0;
    var totales_gara = 0;
    var total_porc = 0;
    var sw_color = 0;

    //alert(empresa_val + ',' + f_inicio + ',' + f_fin + ',' + combo1 + ',' + combo2 + ',' + todos + ',' + dias);

    $.ajax({
        url: "servicios_web.asmx/obtener_data_historico",
        method: 'post',
        data: { empresa: empresa_val, fecha_inicio: f_inicio, fecha_fin: f_fin, cbo_subtipo: combo1, cbo_codigo: combo2, todes: todos, dias: dias, val_tecnico: 1 },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">TECNICO</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">INSTALACIONES</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">GARANTIAS</td><td style="background-color:rgba(41, 97, 132, 0.7);">PORCENTAJE</td></tr>');
            $(datos).each(function (index, item) {
                if (sw_color == 0) {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="left">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.menos7 + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.mas7 + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_menos7 + '%</td></tr>');
                    totales_insta = totales_insta + item.menos7;
                    totales_gara = totales_gara + item.mas7;
                    sw_color = 1;
                }
                else {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="left">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.menos7 + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.mas7 + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.porc_menos7 + '%</td></tr>');
                    totales_insta = totales_insta + item.menos7;
                    totales_gara = totales_gara + item.mas7;
                    sw_color = 0;
                }
            });
            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="right"><b>TOTALES<b/></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_insta + '</b></td style="background-color:rgba(41, 97, 132, 0.7);"><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_gara + '</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + ((totales_gara / totales_insta) * 100).toFixed(2) + '%</b></td></tr>');
            document.getElementById("btn_consultar").disabled = false;
            uno.innerHTML = "Consultar";
        },
        error: function () {
            alert("Hubo un error al consultar!.");
            document.getElementById("btn_consultar").disabled = false;
            uno.innerHTML = "Consultar";
        }
    });
}

function ejecuta_historico_garantias(centro) {
    document.getElementById("btn_consultar").disabled = true;
    var uno = document.getElementById('btn_consultar');
    uno.innerHTML = "Cargando...";

    $('#t1').empty();
    $('#t2').empty();
    $('#t3').empty();
    var resultados = $('#t1');
    var fecha_desde = document.getElementById('ContentPlaceHolder1_txt_desde').value;
    var fecha_hasta = document.getElementById('ContentPlaceHolder1_txt_hasta').value;
    var totales_insta = 0;
    var total_porc = 0;
    var sw_color = 0;
    var combo1 = document.getElementById("ddl_nivel1");
    var nivel1 = combo1.options[combo1.selectedIndex].text;
    var combo2 = document.getElementById("ddl_nivel2");
    var nivel2 = combo2.options[combo2.selectedIndex].text;
    var comodin = "'";

    var hoy = new Date();
    var fecha_hasta_formato = new Date(fecha_hasta);
    var fecha_desde_formato = new Date(fecha_desde);
    var resta1 = hoy.getTime() - fecha_hasta_formato.getTime(); //getTime devuelve milisegundos
    var resta2 = fecha_hasta_formato.getTime() - fecha_desde_formato.getTime();
    var diff_dias_hasta = (resta1 / 1000) / 60 / 60 / 24;

    if (fecha_desde != '' && fecha_hasta != '') {
        if (resta2 > 0) {
            //alert("Hay mas de 30 dias");
            fecha_desde = fecha_desde.replace("-", "");
            fecha_desde = fecha_desde.replace("-", "");
            fecha_hasta = fecha_hasta.replace("-", "");
            fecha_hasta = fecha_hasta.replace("-", "");

            if (nivel1 == "--TODO--") {
                var radio1 = 1;
            }
            else {
                var radio1 = 0;
            }

            $.ajax({
                url: "servicios_web.asmx/obtener_data_historico_garantias",
                method: 'post',
                data: { empresa: centro, fecha_inicio: fecha_desde, fecha_fin: fecha_hasta, cbo_subtipo: nivel1, cbo_codigo: nivel2, todes: radio1 },
                dataType: "json",
                success: function (datos) {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">EMPRESA</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">GARANTIAS</td></tr>');
                    $(datos).each(function (index, item) {
                        if (sw_color == 0) {
                            //resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="left"><a href="detalle_tecnico.aspx?param=' + item.empresa + '&f1=' + fecha_desde + '&f2=' + fecha_hasta + '">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.menos7 + '</td></tr>');
                            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="left"><label style="cursor:pointer" onclick="historico_garantia_tec(' + comodin + item.empresa + comodin + ',' + fecha_desde + ',' + fecha_hasta + ');">' + item.empresa + '</label></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.menos7 + '</td></tr>');
                            totales_insta = totales_insta + item.menos7;
                            sw_color = 1;
                        }
                        else {
                            //resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="left"><a href="detalle_tecnico.aspx?param=' + item.empresa + '&f1=' + fecha_desde + '&f2=' + fecha_hasta + '">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.menos7 + '</td></tr>');
                            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="left"><label style="cursor:pointer" onclick="historico_garantia_tec(' + comodin + item.empresa + comodin + ',' + fecha_desde + ',' + fecha_hasta + ');">' + item.empresa + '</label></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.menos7 + '</td></tr>');
                            totales_insta = totales_insta + item.menos7;
                            sw_color = 0;
                        }
                    });
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="right"><b>TOTALES<b/></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_insta + '</b></td></tr>');

                    document.getElementById("btn_consultar").disabled = false;
                    uno.innerHTML = "Consultar";
                },
                error: function () {
                    alert("Hubo un error al consultar!.");
                    document.getElementById("btn_consultar").disabled = false;
                    uno.innerHTML = "Consultar";
                }
            });
        }
        else {
            alert("La fecha DESDE, debe ser menor a la fecha HASTA");
            document.getElementById("btn_consultar").disabled = false;
            uno.innerHTML = "Consultar";
        }
    }
    else {
        alert("Debe completar ambos campos de fecha con numeros en formato AAAA-MM-DD");
        document.getElementById("btn_consultar").disabled = false;
        uno.innerHTML = "Consultar";
    }
}

function historico_garantia_tec(param_contrata, f1, f2) {
    $('#t2').empty();
    $('#t3').empty();
    var resultados = $('#t2');
    var contratista = param_contrata.split(',')[0];
    var fecha_desde = param_contrata.split(',')[1];
    var fecha_hasta = param_contrata.split(',')[2];
    var comodin = "'";
    var subtotal1 = 0;
    var sw_color = 0;

    //alert(param_contrata, f1, f2);

    resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center" colspan="2"><b>GARANTIAS POR TECNICOS DE ' + contratista + '</b></td></tr>');
    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>NOMBRE</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>GARANTIAS</b></td></tr>');

    $.ajax({
        url: "servicios_web.asmx/obtener_data_historico_garantias_tecnico", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { fecha_inicio: f1, fecha_fin: f2, parametro_contrata: param_contrata },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (sw_color == 0) {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);"><label style="cursor:pointer" onclick="historico_garantia_tec_detalle(' + comodin + item.empresa + comodin + ');">' + item.empresa + '</label></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.menos7 + '</td></tr>');
                    subtotal1 = subtotal1 + Number(item.menos7);
                    sw_color = 1;
                }
                else {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);"><label style="cursor:pointer" onclick="historico_garantia_tec_detalle(' + comodin + item.empresa + comodin + ');">' + item.empresa + '</label></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.menos7 + '</td></tr>');
                    subtotal1 = subtotal1 + Number(item.menos7);
                    sw_color = 0;
                }
            });

            resultados.append('<tr><td colspan="2">&nbsp;</td></tr>');
            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);">TOTAL</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + subtotal1 + '</b></td></tr>');
        }
    });
}

function historico_garantia_tec_detalle(param_tecnico) {
    $('#t3').empty();
    var resultados = $('#t3');
    var fecha_desde = document.getElementById('ContentPlaceHolder1_txt_desde').value;
    var fecha_hasta = document.getElementById('ContentPlaceHolder1_txt_hasta').value;
    fecha_desde = fecha_desde.replace("-", "");
    fecha_desde = fecha_desde.replace("-", "");
    fecha_hasta = fecha_hasta.replace("-", "");
    fecha_hasta = fecha_hasta.replace("-", "");
    var comodin = "'";
    var subtotal1 = 0;
    var sw_color = 0;

    //alert(param_tecnico + "," + fecha_desde + "," + fecha_hasta);

    resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center" colspan="7"><b>DETALLE GARANTIAS DE ' + param_tecnico + '</b></td></tr>');
    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>SUBTIPO DE ACTIVIDAD</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>C&Oacute;DIGO DE ACTUACI&Oacute;N</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>N&Uacute;MERO DE PETICI&Oacute;N</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>N&Uacute;MERO DE ORDEN</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>ACCESS ID</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>FECHA TOA</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>CUMPLIMIENTO</b></td></tr>');

    $.ajax({
        url: "servicios_web.asmx/obtener_data_historico_garantias_tecnico_detalle", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { fecha_inicio: fecha_desde, fecha_fin: fecha_hasta, parametro_tecnico: param_tecnico },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (sw_color == 0) {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.actividad + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.actuacion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.peticion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.orden + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.accessid + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.f_emision.slice(0, -14) + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.f_instalacion.slice(0, -14) + '</td></tr>');
                    sw_color = 1;
                }
                else {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.actividad + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.actuacion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.peticion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.orden + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.accessid + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.f_emision.slice(0, -14) + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.f_instalacion.slice(0, -14) + '</td></tr>');
                    sw_color = 0;
                }
            });

            resultados.append('<tr><td colspan="7">&nbsp;</td></tr>');
        }
    });
}

function ejecuta_historico_garantias_tecnico() {
    document.getElementById("btn_consultar").disabled = true;
    var uno = document.getElementById('btn_consultar');
    uno.innerHTML = "Cargando...";

    $('#t1').empty();
    var resultados = $('#t1');
    var fecha_desde = document.getElementById('ContentPlaceHolder1_txt_desde').value;
    var fecha_hasta = document.getElementById('ContentPlaceHolder1_txt_hasta').value;
    var totales_insta = 0;
    var total_porc = 0;
    var sw_color = 0;
    var combo1 = document.getElementById("ddl_nivel1");
    var nivel1 = combo1.options[combo1.selectedIndex].text;
    var combo2 = document.getElementById("ddl_nivel2");
    var nivel2 = combo2.options[combo2.selectedIndex].text;

    var hoy = new Date();
    var fecha_hasta_formato = new Date(fecha_hasta);
    var fecha_desde_formato = new Date(fecha_desde);
    var resta1 = hoy.getTime() - fecha_hasta_formato.getTime(); //getTime devuelve milisegundos
    var resta2 = fecha_hasta_formato.getTime() - fecha_desde_formato.getTime();
    var diff_dias_hasta = (resta1 / 1000) / 60 / 60 / 24;

    if (fecha_desde != '' && fecha_hasta != '') {
        if (resta2 > 0) {
            //alert("Hay mas de 30 dias");
            fecha_desde = fecha_desde.replace("-", "");
            fecha_desde = fecha_desde.replace("-", "");
            fecha_hasta = fecha_hasta.replace("-", "");
            fecha_hasta = fecha_hasta.replace("-", "");

            if (nivel1 == "--TODO--") {
                var radio1 = 1;
            }
            else {
                var radio1 = 0;
            }

            $.ajax({
                url: "servicios_web.asmx/obtener_data_historico_garantias",
                method: 'post',
                data: { fecha_inicio: fecha_desde, fecha_fin: fecha_hasta, cbo_subtipo: nivel1, cbo_codigo: nivel2, todes: radio1 },
                dataType: "json",
                success: function (datos) {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">EMPRESA</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">GARANTIAS</td></tr>');
                    $(datos).each(function (index, item) {
                        if (sw_color == 0) {
                            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);"><a href="detalle_contrata.aspx?param=' + item.empresa + '">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_menos7 + '%</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_mas7 + '%</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_96hs + '%</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_mas96hs + '%</td></tr>');
                            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="left"><a href="detalle_tecnico.aspx?param=' + item.empresa + '">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.menos7 + '</td></tr>');
                            totales_insta = totales_insta + item.menos7;
                            sw_color = 1;
                        }
                        else {
                            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="left">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.menos7 + '</td></tr>');
                            totales_insta = totales_insta + item.menos7;
                            sw_color = 0;
                        }
                    });
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="right"><b>TOTALES<b/></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_insta + '</b></td></tr>');

                    document.getElementById("btn_consultar").disabled = false;
                    uno.innerHTML = "Consultar";
                },
                error: function () {
                    alert("Hubo un error al consultar!.");
                    document.getElementById("btn_consultar").disabled = false;
                    uno.innerHTML = "Consultar";
                }
            });
        }
        else {
            alert("La fecha DESDE, debe ser menor a la fecha HASTA");
            document.getElementById("btn_consultar").disabled = false;
            uno.innerHTML = "Consultar";
        }
    }
    else {
        alert("Debe completar ambos campos de fecha con n\u00FAmeros en formato AAAA-MM-DD");
        document.getElementById("btn_consultar").disabled = false;
        uno.innerHTML = "Consultar";
    }
}

function ejecuta_historico_fijo_30dias(centro) {
    var resultados = $('#t2');
    $('#t2').empty();
    var sw_color = 0;
    var totales_insta = 0;
    var totales_gara = 0;

    var hoy = new Date();
    var mes30EnMilisegundos = 1000 * 60 * 60 * 24 * 30;
    var mes60EnMilisegundos = 1000 * 60 * 60 * 24 * 60;
    var resta_30 = hoy.getTime() - mes30EnMilisegundos; //getTime devuelve milisegundos de esa fecha
    var resta_60 = hoy.getTime() - mes60EnMilisegundos; //getTime devuelve milisegundos de esa fecha
    var fecha_30d = new Date(resta_30);
    var fecha_60d = new Date(resta_60);

    var mes_30 = (fecha_30d.getMonth() + 1);
    var dia_30 = fecha_30d.getDate();
    var mes_60 = (fecha_60d.getMonth() + 1);
    var dia_60 = fecha_60d.getDate();

    if (mes_30 < 10) {
        mes_30 = "0" + mes_30;
    }
    if (dia_30 < 10) {
        dia_30 = "0" + dia_30;
        var fecha_30 = "" + (dia_30) + "/" + "0" + mes_30 + "";
    }
    else {
        var fecha_30 = "" + (dia_30) + "/" + mes_30 + "";
    }

    if (mes_60 < 10) {
        mes_60 = "0" + mes_60;
    }
    if (dia_60 < 10) {
        dia_60 = "0" + dia_60;
        var fecha_60 = "" + "0" + (dia_60) + "/" + mes_60 + "";
    }
    else {
        var fecha_60 = "" + (dia_60) + "/" + mes_60 + "";
    }

    $.ajax({
        url: "servicios_web.asmx/obtener_data_historico_30dias",
        method: 'post',
        data: { parametro_centro: centro },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="left" colspan="17"><b>GARANTIAS A 30 DIAS (del ' + fecha_60 + ' al ' + fecha_30 + ')</b></td></tr>');
            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">EMPRESA</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">INSTALACIONES</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">GARANTIAS</td><td style="background-color:rgba(41, 97, 132, 0.7);">PORCENTAJE</td></tr>');
            $(datos).each(function (index, item) {
                if (sw_color == 0) {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="left"><a href="detalle_q4.aspx?contrata=' + item.empresa + '&dias=30">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.menos7 + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.mas7 + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_menos7 + '%</td></tr>');
                    totales_insta = totales_insta + item.menos7;
                    totales_gara = totales_gara + item.mas7;
                    sw_color = 1;
                }
                else {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="left"><a href="detalle_q4.aspx?contrata=' + item.empresa + '&dias=30">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.menos7 + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.mas7 + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.porc_menos7 + '%</td></tr>');
                    totales_insta = totales_insta + item.menos7;
                    totales_gara = totales_gara + item.mas7;
                    sw_color = 0;
                }
            });
            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="right"><b>TOTALES<b/></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_insta + '</b></td style="background-color:rgba(41, 97, 132, 0.7);"><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_gara + '</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + ((totales_gara / totales_insta) * 100).toFixed(2) + '%</b></td></tr>');
        },
        error: function () {
            alert("Hubo un error al consultar 30 dias!.");
        }
    });
}

function ejecuta_historico_fijo_7dias(centro) {
    var resultados = $('#t4');
    $('#t4').empty();
    var sw_color = 0;
    var totales_insta = 0;
    var totales_gara = 0;

    var hoy = new Date();
    var dias7EnMilisegundos = 1000 * 60 * 60 * 24 * 7;
    var dias14EnMilisegundos = 1000 * 60 * 60 * 24 * 14;
    var resta_7 = hoy.getTime() - dias7EnMilisegundos; //getTime devuelve milisegundos de esa fecha
    var resta_14 = hoy.getTime() - dias14EnMilisegundos; //getTime devuelve milisegundos de esa fecha
    var fecha_7d = new Date(resta_7);
    var fecha_14d = new Date(resta_14);

    var mes_7 = (fecha_7d.getMonth() + 1);
    var dia_7 = fecha_7d.getDate();
    var mes_14 = (fecha_14d.getMonth() + 1);
    var dia_14 = fecha_14d.getDate();

    if (mes_7 < 10) {
        mes_7 = "0" + mes_7;
    }
    if (dia_7 < 10) {
        dia_7 = "0" + dia_7;
        var fecha_7 = "" + (dia_7) + "/" + mes_7 + "";
    }
    else {
        var fecha_7 = "" + (dia_7) + "/" + mes_7 + "";
    }

    if (mes_14 < 10) {
        mes_14 = "0" + mes_14;
    }
    if (dia_14 < 10) {
        dia_14 = "0" + dia_14;
        var fecha_14 = "" + "0" + (dia_14) + "/" + mes_14 + "";
    }
    else {
        var fecha_14 = "" + (dia_14) + "/" + mes_14 + "";
    }

    $.ajax({
        url: "servicios_web.asmx/obtener_data_historico_7dias",
        method: 'post',
        data: { parametro_centro: centro },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="left" colspan="17"><b>GARANTIAS A 7 DIAS (del ' + fecha_14 + ' al ' + fecha_7 + ')</b></td></tr>');
            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">EMPRESA</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">INSTALACIONES</td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center">GARANTIAS</td><td style="background-color:rgba(41, 97, 132, 0.7);">PORCENTAJE</td></tr>');
            $(datos).each(function (index, item) {
                if (sw_color == 0) {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="left"><a href="detalle_q4.aspx?contrata=' + item.empresa + '&dias=7">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.menos7 + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.mas7 + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.porc_menos7 + '%</td></tr>');
                    totales_insta = totales_insta + item.menos7;
                    totales_gara = totales_gara + item.mas7;
                    sw_color = 1;
                }
                else {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="left"><a href="detalle_q4.aspx?contrata=' + item.empresa + '&dias=7">' + item.empresa + '</a></td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.menos7 + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.mas7 + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.porc_menos7 + '%</td></tr>');
                    totales_insta = totales_insta + item.menos7;
                    totales_gara = totales_gara + item.mas7;
                    sw_color = 0;
                }
            });
            resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="right"><b>TOTALES<b/></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_insta + '</b></td style="background-color:rgba(41, 97, 132, 0.7);"><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + totales_gara + '</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>' + ((totales_gara / totales_insta) * 100).toFixed(2) + '%</b></td></tr>');
        },
        error: function () {
            alert("Hubo un error al consultar 7 d\u00EDas!.");
        }
    });
}

function carga_no_asignados_detalle() {
    $('#t1').empty();
    var resultados = $('#t1');
    var sw_color = 0;

    resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center" colspan="8"><b>GARANTIAS SIN ASIGNAR AL DIA DE HOY</b></td></tr>');
    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>EMPRESA</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>TECNICO</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>C&Oacute;DIGO DE ACTUACI&Oacute;N</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>N&Uacute;MERO DE PETICI&Oacute;N</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>N&Uacute;MERO DE ORDEN</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>ACCESS ID</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>BUCKET INICIAL</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>SUBTIPO CLIENTE</b></td></tr>');

    $.ajax({
        url: "servicios_web.asmx/obtener_no_asignados_detalle", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (sw_color == 0) {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.actividad + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.actuacion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.peticion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.orden + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.accessid + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.bucket + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.cliente + '</td></tr>');
                    sw_color = 1;
                }
                else {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.actividad + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.actuacion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.peticion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.orden + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.accessid + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.bucket + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.cliente + '</td></tr>');
                    sw_color = 0;
                }
            });
        }
    });
    resultados.append('<tr><td colspan="8">&nbsp;</td></tr>');
}

function carga_lista_averias() {
    $('#t1').empty();
    var resultados = $('#t1');
    var sw_number = 0;
    var sw_color = 0;
    var itemaso;

    resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center" colspan="13"><b>LISTADO ABM DE AVERIAS CON Y SIN CITAS MANUALES</b></td></tr>');
    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>EMPRESA ASIGNADA</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>TECNICO ASIGNADO</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>SUBTIPO DE ACTIVIDAD</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>N&Uacute;MERO DE PETICI&Oacute;N</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>ACCESS ID</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>S&Iacute;NTOMA</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>DIAGN&Oacute;STICO INICIAL</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>DIAGN&Oacute;STICO ACTUAL</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>DIAS</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>F. GESTI&Oacute;N CITA</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>F. CITA MANUAL</b></td></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center" colspan="3"><b>CITA</b></td></tr>');

    $.ajax({
        url: "servicios_web.asmx/listado_citas", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                sw_number = sw_number + 1;

                if (sw_color == 0) {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.cliente + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.actividad + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.peticion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.accessid + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.sintoma + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.diagnostico_ini + '</td><td style="background-color:rgba(41, 97, 132, 0.3);">' + item.diagnostico_act + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.dias + '</td><td style="background-color:rgba(41, 97, 132, 0.3);">' + item.f_emision + '</td><td style="background-color:rgba(41, 97, 132, 0.3);">' + item.f_instalacion + '</td><td align="center"><a href="citas_abm.aspx?param_access=' + item.accessid + '" class="boton">Cita</a></td></tr>');
                    sw_color = 1;
                }
                else {
                    resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.cliente + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.actividad + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.peticion + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.accessid + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.sintoma + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.diagnostico_ini + '</td><td style="background-color:rgba(41, 97, 132, 0.6);">' + item.diagnostico_act + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.dias + '</td><td style="background-color:rgba(41, 97, 132, 0.6);">' + item.f_emision + '</td><td style="background-color:rgba(41, 97, 132, 0.6);">' + item.f_instalacion + '</td><td align="center"><a href="citas_abm.aspx?param_access=' + item.accessid + '" class="boton">Cita</a></td></tr>');
                    sw_color = 0;
                }
            });
        }
    });
    resultados.append('<tr><td colspan="13">&nbsp;</td></tr>');
}

function eliminar_cita() {
    var valor = document.getElementById('ContentPlaceHolder1_lbl_accessid').innerHTML;

    if (confirm("Seguro desea eliminar la cita " + valor + "?.")) {
        //alert(valor);

        $.ajax({
            url: "servicios_web.asmx/elimina_cita", //Llama al webmethod "obtener_gerencia" del lado servidor
            method: 'post',
            data: { access_id: valor },
            success: function (datos) {
                alert("Se elimin/u00F3 la cita.");
                window.location.replace("citas_manuales.aspx");
            },
            error: function () {
                alert("Hubo un error al eliminar la cita.");
            }
        });
    }
}

function guardar_cita() {
    var valor = document.getElementById('ContentPlaceHolder1_lbl_accessid').innerHTML;
    var fecha = document.getElementById('ContentPlaceHolder1_txt_fecha').value;
    var usuario = document.getElementById('ContentPlaceHolder1_lbl_user').innerHTML;
    /*alert(valor);
    alert(fecha);
    alert(usuario);*/

    if (fecha.length > 0) {
        $.ajax({
            url: "servicios_web.asmx/guardar_cita", //Llama al webmethod "obtener_gerencia" del lado servidor
            method: 'post',
            data: { access_id: valor, fecha_cita: fecha, user: usuario },
            success: function (datos) {
                alert("Se guard/u00F3 la cita correctamente.");
                window.location.replace("citas_manuales.aspx");
            },
            error: function () {
                alert("Hubo un error al guardar la cita.");
            }
        });
    }
    else {
        alert("Debe ingresar una fecha valida!.");
    }
}

function modificar_cita() {
    var valor = document.getElementById('ContentPlaceHolder1_lbl_accessid').innerHTML;
    var fecha = document.getElementById('ContentPlaceHolder1_txt_fecha').value;
    var usuario = document.getElementById('ContentPlaceHolder1_lbl_user').innerHTML;
    /*alert(valor);
    alert(fecha);
    alert(usuario);*/

    if (fecha.length > 0) {
        $.ajax({
            url: "servicios_web.asmx/modificar_cita",
            method: 'post',
            data: { access_id: valor, fecha_cita: fecha, user: usuario },
            success: function (datos) {
                alert("Se modifico la cita correctamente.");
                window.location.replace("citas_manuales.aspx");
            },
            error: function () {
                alert("Hubo un error al guardar la cita.");
            }
        });
    }
    else {
        alert("Debe ingresar una fecha!.");
    }
}

function novedades(opcion) {
    $('#id_dethstar').empty();
    $('#t1').empty();
    var resultados = $('#id_deathstar');
    var resultados_tabla = $('#t1');
    var sw_color = 0;

    if (opcion == 2) {
        resultados_tabla.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center" colspan="8"><b>LISTADO DE NOVEDADES</b></td></tr>');
        resultados_tabla.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>ID_NEW</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>FECHA Y HORA</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>INGRESADO POR</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>TITULO</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>USUARIO CARGA</b></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>ESTADO</b></td><td colspan="2" style="background-color:rgba(41, 97, 132, 0.5);" align="center"><b>ACCION</b></td></tr>');
    }

    $.ajax({
        url: "servicios_web.asmx/obtener_novedades",
        method: 'post',
        data: { opc: opcion },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (opcion == 1) {
                    resultados.append('<br />');
                    resultados.append('<b>TITULO: </b>' + item.titulo);
                    resultados.append('<br />');
                    resultados.append('<b>Fecha: </b>' + item.fecha);
                    resultados.append('<br /><br />');
                    resultados.append('<u><b>Novedad:</b></u>');
                    resultados.append('<br />');
                    resultados.append(item.texto);
                    resultados.append('<br />');
                    resultados.append('<hr />');
                }
                else {
                    if (sw_color == 0) {
                        resultados_tabla.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.id_new + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.fecha + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.foto + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.titulo + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.foto + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.estado + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><a href="novedades_mod.aspx?id_new=' + item.id_new + '"><u>MODIFICAR</u></a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><label style="cursor: pointer" onclick="novedades_elimina(' + item.id_new + ')"><u>ELIMINAR</u></label></td></tr>');
                        sw_color = 1;
                    }
                    else {
                        resultados_tabla.append('<tr><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.id_new + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.fecha + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.foto + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.titulo + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.foto + '</td><td style="background-color:rgba(41, 97, 132, 0.6);" align="center">' + item.estado + '</td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><a href="novedades_mod.aspx?id_new=' + item.id_new + '"><u>MODIFICAR</u></a></td><td style="background-color:rgba(41, 97, 132, 0.5);" align="center"><label style="cursor: pointer" onclick="novedades_elimina(' + item.id_new + ')"><u>ELIMINAR</u></label></td></tr>');
                        sw_color = 0;
                    }
                }
            });
        }
    });
}

function novedades_modifica() {
    var titulo = document.getElementById('ContentPlaceHolder1_txt_titulo').value;
    var novedad = document.getElementById('ContentPlaceHolder1_txt_new').value;
    var id_new = document.getElementById('ContentPlaceHolder1_lbl_new').innerHTML;
    var usuario = document.getElementById('ContentPlaceHolder1_txt_usr_ingreso').value;
    /*
    alert(titulo);
    alert(novedad);
    alert(usuario);
    alert(id_new);
    */
    if (titulo.length > 0 || novedad.length > 0) {
        $.ajax({
            url: "servicios_web.asmx/modificar_novedad",
            method: 'post',
            data: { id_nove: id_new, titu: titulo, cuerpo: novedad, usu: usuario },
            success: function (datos) {
                alert("Se modifico la novedad correctamente.");
                window.location.replace("novedades_abm.aspx");
            },
            error: function () {
                alert("Hubo un error al guardar la modificaci\u00F3n.");
            }
        });
    }
    else {
        alert("Debe completar todos los campos!.");
    }
}

function novedades_elimina(idnovedad) {
    if (confirm("Est\u00E1 seguro de eliminar esta novedad?")) {
        $.ajax({
            url: "servicios_web.asmx/eliminar_novedad",
            method: 'post',
            data: { id_nove: idnovedad },
            success: function (datos) {
                alert("Se elimin\u00F3 la novedad correctamente.");
                window.location.replace("novedades_abm.aspx");
            },
            error: function () {
                alert("Hubo un error al guardar la modificaci\u00F3n.");
            }
        });
    }
}

function actualizar() {
    location.reload(true); //Funcion que refresca la página
}
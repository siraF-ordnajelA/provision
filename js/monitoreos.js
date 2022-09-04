/////////////////////////////////////////////////////// GRAFICOS ///////////////////////////////////////////////////////
function dibuja_seleccion_fechas_monitoreos(centro) {
    var valor_cbo_empresa = document.getElementById('cbo_ctta').value;
    var texto_cbo_empresa = document.getElementById('cbo_ctta').options[document.getElementById('cbo_ctta').selectedIndex].text;
    var fecha_inicio = document.getElementById("dat_inicio").value;
    fecha_inicio = fecha_inicio.replace("-", "");
    fecha_inicio = fecha_inicio.replace("-", "");
    fecha_inicio = fecha_inicio.replace("/", "");
    fecha_inicio = fecha_inicio.replace("/", "");
    var fecha_fin = document.getElementById("dat_fin").value;
    fecha_fin = fecha_fin.replace("-", "");
    fecha_fin = fecha_fin.replace("-", "");
    fecha_fin = fecha_fin.replace("/", "");
    fecha_fin = fecha_fin.replace("/", "");

    if (valor_cbo_empresa != 0) {
        if ((fecha_inicio == "" && fecha_fin != "") || (fecha_inicio != "" && fecha_fin == "")) {
            alert("Debe completar ambos campos de fecha.");
        }
        else {
            dibuja_graficos_monitoreo(texto_cbo_empresa, fecha_inicio, fecha_fin);
        }
    }
    else {
        if ((fecha_inicio == "" && fecha_fin != "") || (fecha_inicio != "" && fecha_fin == "")) {
            alert("Debe completar ambos campos de fecha.");
        }
        else {
            dibuja_graficos_monitoreo(centro, fecha_inicio, fecha_fin);
        }
    }
}

function dibuja_graficos_monitoreo(centro, fecha1, fecha2) {
    var tabla_motivos = $('#tbl_motivos');
    var subtotal1 = 0, subtotal2 = 0, subtotal3 = 0;
    var fecha = new Date();
    var mes_actual = fecha.getMonth() + 1;
    var anio_actual = fecha.getFullYear();

    switch (mes_actual) {
        case 1: mes_actual = "Enero"; break;
        case 2: mes_actual = "Febrero"; break;
        case 3: mes_actual = "Marzo"; break;
        case 4: mes_actual = "Abril"; break;
        case 5: mes_actual = "Mayo"; break;
        case 6: mes_actual = "Junio"; break;
        case 7: mes_actual = "Julio"; break;
        case 8: mes_actual = "Agosto"; break;
        case 9: mes_actual = "Septiembre"; break;
        case 10: mes_actual = "Octubre"; break;
        case 11: mes_actual = "Noviembre"; break;
        case 12: mes_actual = "Diciembre"; break;
    }

    if (fecha1 == "" && fecha2 == "") {
        document.getElementById("lbl_fecha").innerHTML = " (Visualizando mes de " + mes_actual + " del " + anio_actual + ")";
    }
    else {
        document.getElementById("lbl_fecha").innerHTML = " (Visualizando fechas seleccionadas)";
    }

    tabla_motivos.empty();
    tabla_motivos.append('<thead><tr><th>EMPRESA</th><th>MONITOREOS MEDALLIA</th><th>MONITOREOS INGRESANTES</th><th>MON. TEC. TRABAJANDO ACTUALMENTE</th></tr></thead>');

    $.ajax({
        url: "servicios_monitoreos.asmx/monitoreo_dibuja_grafico1",
        method: 'post',
        data: { opc: 1, valor_centro: centro, fecha1: fecha1, fecha2: fecha2 },
        dataType: "json",
        success: function (datos) {
            tabla_motivos.append('<tbody>');
            $(datos).each(function (index, item) {
                tabla_motivos.append('<tr><td>' + item.Nombre + '</td><td align="center">' + item.ctta + '</td><td align="center">' + item.Ingresante + '</td><td align="center">' + item.ID_TOA + '</td></tr>');
                subtotal1 = subtotal1 + parseInt(item.ctta);
                subtotal2 = subtotal2 + parseInt(item.Ingresante);
                subtotal3 = subtotal3 + parseInt(item.ID_TOA);
            });
            tabla_motivos.append('<tr><td align="right"><strong>TOTAL</strong></td><td align="center"><strong>' + subtotal1 + '</strong></td><td align="center"><strong>' + subtotal2 + '</strong></td><td align="center"><strong>' + subtotal3 + '</strong></td></tr>');
            tabla_motivos.append('</tbody>');
        }
    });

    //Grafico 2 MOnitoreos vs Tecnicos
    var datitos1 = [];
    var datitos2 = [];
    var datitos3 = [];

    $.ajax({
        url: "servicios_monitoreos.asmx/monitoreo_dibuja_grafico2", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { valor_centro: centro, fecha1: fecha1, fecha2: fecha2 },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                datitos1.push(item.ctta);
                datitos2.push(item.Ingresante); // Cantidad de monitoreos
                datitos3.push(item.ID_TOA); // Cantidad de técnicos
            });

            var myJsonString1 = JSON.stringify(datitos1);
            var myJsonString2 = JSON.stringify(datitos2);
            var myJsonString3 = JSON.stringify(datitos3);
            var jsonArray1 = JSON.parse(myJsonString1);
            var jsonArray2 = JSON.parse(myJsonString2);
            var jsonArray3 = JSON.parse(myJsonString3);

            /*alert("CTTAS: " + myJsonString1); // MUESTRA EL JSON
            alert("MONITOREOS:" + myJsonString2); // MUESTRA EL JSON
            alert("TECNICOS: " + myJsonString3); // MUESTRA EL JSON*/
            dibuja_grafico_monitoreos_tecnicos(jsonArray1, jsonArray2, jsonArray3);
        }
    });
}

function dibuja_grafico_monitoreos_tecnicos(contratas, monitoreos, tecnicos) {
    var areaChartData = {
        //labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        labels: contratas,
        datasets: [
        {
            label: 'Tecnicos',
            backgroundColor: 'rgba(60,141,188,0.9)',
            borderColor: 'rgba(60,141,188,0.8)',
            pointRadius: false,
            pointColor: '#3b8bba',
            pointStrokeColor: 'rgba(60,141,188,1)',
            pointHighlightFill: '#fff',
            pointHighlightStroke: 'rgba(60,141,188,1)',
            //data: [28, 48, 40, 19, 86, 27, 90]
            data: tecnicos,
            yAxisID: "y-axis-tecnicos"
        },
        {
            label: 'Monitoreos',
            backgroundColor: 'rgba(81, 175, 113, 1)',
            borderColor: 'rgba(81, 175, 113, 1)',
            pointRadius: false,
            pointColor: 'rgba(210, 214, 222, 1)',
            pointStrokeColor: '#c1c7d1',
            pointHighlightFill: '#fff',
            pointHighlightStroke: 'rgba(220,220,220,1)',
            //data: [65, 59, 80, 81, 56, 55, 40]
            data: monitoreos,
            yAxisID: "y-axis-monitoreos"
        },
      ]
    }

    //-------------
    //- BAR CHART -
    //-------------
    var barChartCanvas = $('#barChart').get(0).getContext('2d')
    var barChartData = jQuery.extend(true, {}, areaChartData)
    var temp0 = areaChartData.datasets[0]
    var temp1 = areaChartData.datasets[1]
    barChartData.datasets[0] = temp1
    barChartData.datasets[1] = temp0

    var barChartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        datasetFill: true,
        scales: {
            xAxes: [{
                barPercentage: 1,
                categoryPercentage: 0.6
            }],
            yAxes: [{
                id: "y-axis-tecnicos"
            }, {
                id: "y-axis-monitoreos"
            }]
        }
    }

    var barChart = new Chart(barChartCanvas, {
        type: 'bar',
        data: barChartData,
        options: barChartOptions
    })
}
//////////////////////////////////////////////////////FIN GRAFICOS /////////////////////////////////////////////////////

/////////////////////////////////////////////////// FORMULARIO CARGA ///////////////////////////////////////////////////
function chk_habilita() {
    var chk_tecnico = document.getElementById("chk_tecnico");
    var nivel_empresa = $('#cbo_empresa');

    if (chk_tecnico.checked == true) {
        document.getElementById('txt_nombre_tec').disabled = false;
        document.getElementById('txt_apellido_tec').disabled = false;
        document.getElementById('lbl_dni').disabled = false;
        //document.getElementById('lbl_empresa').disabled = false;
        document.getElementById('cbo_empresa').disabled = false;
    }
    else {
        document.getElementById('txt_nombre_tec').disabled = true;
        document.getElementById('txt_apellido_tec').disabled = true;
        document.getElementById('txt_nombre_tec').value = "";
        document.getElementById('txt_apellido_tec').value = "";
        document.getElementById('lbl_dni').disabled = true;
        //document.getElementById('lbl_empresa').disabled = true;
        document.getElementById('cbo_empresa').disabled = true;
    }

    $.ajax({
        url: "servicios_monitoreos.asmx/obtener_contratas",
        method: 'post',
        dataType: "json",
        success: function (datos) {
            nivel_empresa.empty();
            nivel_empresa.append("<option value='0'>--Seleccione Empresa--</option>");
            $(datos).each(function (index, item) {
                nivel_empresa.append($('<option/>', { value: item.Nombre, text: item.Nombre })); //LOS VALORES "VALUE" Y "TEXT" SON ITEMS QUE TOMAN LOS VALORES DE LA CLASE cbo_nivel1.cs (ID_RECURSO Y Nombre)
            });
        }
    });
}

function cbio_cbo_tecnico() {
    var combo_tecnico = document.getElementById("drop_tecnico");
    var valor_combo = combo_tecnico.options[combo_tecnico.selectedIndex].value;
    var nivel_empresa = $('#cbo_empresa');
    //alert (valor_combo);

    $.ajax({
        url: "servicios_monitoreos.asmx/obtener_dato_tecnico",
        method: 'post',
        data: { id_toa: valor_combo },
        dataType: "json",
        success: function (datos) {
            nivel_empresa.empty();
            $(datos).each(function (index, item) {
                $('#lbl_dni').val(item.ID_TOA);
                nivel_empresa.append($('<option/>', { value: item.ctta, text: item.ctta }));
            });
        }
    });
}

function guardar(opc) {
    document.getElementById("btn_guardar").disabled = true;
    var uno = document.getElementById('btn_guardar');
    uno.innerHTML = "Guardando...";

    var chequeo_cosas = 0;
    var usuario_red = document.getElementById("lbl_id_usr").innerHTML;
    var val_tecnico = document.getElementById("drop_tecnico").value;
    var credencial = document.getElementById("drop_credencial").value;
    var eq_celular = document.getElementById("drop_equipo").value;
    var val_cita = document.getElementById("cbo_cita").value;
    var val_campo = document.getElementById("cbo_campo").value;

    //CHECKBOX
    var chk_tecnico = document.getElementById("chk_tecnico");
    var apellido_tecnico = document.getElementById('txt_apellido_tec').value;
    var apellido_upper = apellido_tecnico.toUpperCase();
    var nombre_tecnico = document.getElementById('txt_nombre_tec').value;
    var nombre_upper = nombre_tecnico.toUpperCase();
    var dni_tecnico = document.getElementById('lbl_dni').value;
    var empresa_tecnico = document.getElementById('cbo_empresa'); // VER VALOR DEL COMBO EMPRESA
    var empresa_upper = empresa_tecnico.options[empresa_tecnico.selectedIndex].value;

    //FECHA AUDITORIA MANUAL
    var fecha_manual = document.getElementById("txt_fecha_manual").value;

    //Vehículo
    //var vehiculo = document.getElementById("drop_vehiculo").value;
    var chk_condicion = document.getElementById("chk_veh_condiciones");
    var chk_regular = document.getElementById("chk_veh_estregular");
    var chk_mal = document.getElementById("chk_veh_mal_estado");
    if (chk_condicion.checked) {
        var veh_estado = chk_condicion.value;
    }
    if (chk_regular.checked) {
        var veh_estado = chk_regular.value;
    }
    if (chk_mal.checked) {
        var veh_estado = chk_mal.value;
    }
    var chk_sidentif = document.getElementById("chk_veh_sinidentif").value;
    var chk_sescalera = document.getElementById("chk_veh_sescalera").value;
    var chk_sporta = document.getElementById("chk_vhe_sporta").value;
    if (chk_sidentif.checked) {
        chk_sidentif = document.getElementById("chk_veh_sinidentif").value;
    }
    else {
        chk_sidentif = 1;
    }
    if (chk_sescalera.checked) {
        chk_sescalera = document.getElementById("chk_veh_sescalera").value;
    }
    else {
        chk_sescalera = 1;
    }
    if (chk_sporta.checked) {
        chk_sporta = document.getElementById("chk_vhe_sporta").value;
    }
    else {
        chk_sporta = 1;
    }

    var chk_ingresante = document.getElementById("chk_veh_ingresante").value;
    var veh_patente = document.getElementById('txt_patente').value;
    var veh_patente_upper = veh_patente.toUpperCase();

    var contexto = document.getElementById("drop_contexto").value;
    var kit_sanidad = document.getElementById("drop_kit_sanidad").value;
    var epp = document.getElementById("drop_epp").value;
    var vestimenta = document.getElementById("drop_presencia").value;

    var drop_metodo = document.getElementById("drop_metodo").value;
    var drop_plano = document.getElementById("drop_plano").value;
    var drop_circular = document.getElementById("drop_circular").value;

    //VALORES DE LOS RADIO BUTTON
    //Conocimiento uso de APP
    var radio_mobbi = document.getElementsByName('rd_mobbi');
    /*
    for (i = 0; i < radio_mobbi.length; i++) {
    if (radio_mobbi[i].checked) {
    var valor_mobbi = radio_mobbi[i].value;
    }
    }
    */
    var valor_mobbi = 0;

    var radio_mobbi20 = document.getElementsByName('rd_mobbi20');
    for (i = 0; i < radio_mobbi20.length; i++) {
        if (radio_mobbi20[i].checked) {
            var valor_mobbi20 = radio_mobbi20[i].value;
        }
    }
    /*
    var radio_whop = document.getElementsByName('rd_whop');
    for (i = 0; i < radio_whop.length; i++) {
    if (radio_whop[i].checked) {
    var valor_whop = radio_whop[i].value;
    }
    }
    */
    var valor_whop = 0;

    var radio_pdr = document.getElementsByName('rd_pdr');
    for (i = 0; i < radio_pdr.length; i++) {
        if (radio_pdr[i].checked) {
            var valor_pdr = radio_pdr[i].value;
        }
    }
    var radio_qr = document.getElementsByName('rd_qr');
    for (i = 0; i < radio_qr.length; i++) {
        if (radio_qr[i].checked) {
            var valor_qr = radio_qr[i].value;
        }
    }
    /*
    var radio_sptest = document.getElementsByName('rd_sptest');
    for (i = 0; i < radio_sptest.length; i++) {
    if (radio_sptest[i].checked) {
    var valor_sptest = radio_sptest[i].value;
    }
    }
    */
    var radio_analizer = document.getElementsByName('rd_analizer');
    for (i = 0; i < radio_analizer.length; i++) {
        if (radio_analizer[i].checked) {
            var valor_analizer = radio_analizer[i].value;
        }
    }
    var radio_smart = document.getElementsByName('rd_smart');
    for (i = 0; i < radio_smart.length; i++) {
        if (radio_smart[i].checked) {
            var valor_smart = radio_smart[i].value;
        }
    }

    //APP Instaladas
    /*
    var radio_mobbi1_inst = document.getElementsByName('rd_mobbi1_instalada');
    for (i = 0; i < radio_mobbi1_inst.length; i++) {
    if (radio_mobbi1_inst[i].checked) {
    var valor_mobbi1_instalada = radio_mobbi1_inst[i].value;
    }
    }
    */
    var valor_mobbi1_instalada = 0;

    var radio_mobbi20_inst = document.getElementsByName('rd_mobbi2_instalada');
    for (i = 0; i < radio_mobbi20_inst.length; i++) {
        if (radio_mobbi20_inst[i].checked) {
            var valor_mobbi20_inst = radio_mobbi20_inst[i].value;
        }
    }
    /*
    var radio_whop_inst = document.getElementsByName('rd_whop_instalada');
    for (i = 0; i < radio_whop_inst.length; i++) {
    if (radio_whop_inst[i].checked) {
    var valor_whop_inst = radio_whop_inst[i].value;
    }
    }
    */
    var valor_whop_inst = 0;

    var radio_pdr_inst = document.getElementsByName('rd_pdr_instalada');
    for (i = 0; i < radio_pdr_inst.length; i++) {
        if (radio_pdr_inst[i].checked) {
            var valor_pdr_inst = radio_pdr_inst[i].value;
        }
    }
    var radio_qr_ints = document.getElementsByName('rd_qr_instalada');
    for (i = 0; i < radio_qr_ints.length; i++) {
        if (radio_qr_ints[i].checked) {
            var valor_qr_ints = radio_qr_ints[i].value;
        }
    }
    var radio_analizer_inst = document.getElementsByName('rd_analizer_instalada');
    for (i = 0; i < radio_analizer_inst.length; i++) {
        if (radio_analizer_inst[i].checked) {
            var valor_analizer_inst = radio_analizer_inst[i].value;
        }
    }
    /*
    var radio_smartwifi_inst = document.getElementsByName('rd_smartwifi_instalada');
    for (i = 0; i < radio_smartwifi_inst.length; i++) {
    if (radio_smartwifi_inst[i].checked) {
    var valor_smartwifi_inst = radio_smartwifi_inst[i].value;
    }
    }
    */
    var valor_smartwifi_inst = 0;

    if (chk_tecnico.checked) {
        valor_mobbi20_inst = 3;
        valor_pdr_inst = 3;
        valor_qr_ints = 3;
        valor_analizer_inst = 3;
    }

    //Herramientas KIT Fibra
    var radio_kevlar = document.getElementsByName('rd_kevlar');
    for (i = 0; i < radio_kevlar.length; i++) {
        if (radio_kevlar[i].checked) {
            var valor_kevlar = radio_kevlar[i].value;
        }
    }
    var radio_cleaver = document.getElementsByName('rd_cleaver');
    for (i = 0; i < radio_cleaver.length; i++) {
        if (radio_cleaver[i].checked) {
            var valor_cleaver = radio_cleaver[i].value;
        }
    }
    var radio_pw = document.getElementsByName('rd_pw');
    for (i = 0; i < radio_pw.length; i++) {
        if (radio_pw[i].checked) {
            var valor_pw = radio_pw[i].value;
        }
    }
    var radio_triple = document.getElementsByName('rd_triple');
    for (i = 0; i < radio_triple.length; i++) {
        if (radio_triple[i].checked) {
            var valor_triple = radio_triple[i].value;
        }
    }
    var radio_drop = document.getElementsByName('rd_drop');
    for (i = 0; i < radio_drop.length; i++) {
        if (radio_drop[i].checked) {
            var valor_drop = radio_drop[i].value;
        }
    }
    var radio_alcohol = document.getElementsByName('rd_alcohol');
    for (i = 0; i < radio_alcohol.length; i++) {
        if (radio_alcohol[i].checked) {
            var valor_alcohol = radio_alcohol[i].value;
        }
    }
    var radio_panios = document.getElementsByName('rd_panios');
    for (i = 0; i < radio_panios.length; i++) {
        if (radio_panios[i].checked) {
            var valor_panios = radio_panios[i].value;
        }
    }
    var radio_laser = document.getElementsByName('rd_laser');
    for (i = 0; i < radio_laser.length; i++) {
        if (radio_laser[i].checked) {
            var valor_laser = radio_laser[i].value;
        }
    }

    if (chk_tecnico.checked) {
        valor_kevlar = 27;
        valor_cleaver = 27;
        valor_pw = 27;
        valor_triple = 27;
        valor_drop = 27;
        valor_alcohol = 27;
        valor_panios = 27;
        valor_laser = 27;
    }

    //Procesos
    var radio_iptv = document.getElementsByName('rd_iptv');
    for (i = 0; i < radio_iptv.length; i++) {
        if (radio_iptv[i].checked) {
            var valor_iptv = radio_iptv[i].value;
        }
    }
    var radio_hgu = document.getElementsByName('rd_hgu');
    for (i = 0; i < radio_hgu.length; i++) {
        if (radio_hgu[i].checked) {
            var valor_hgu = radio_hgu[i].value;
        }
    }
    var radio_voip = document.getElementsByName('rd_voip');
    for (i = 0; i < radio_voip.length; i++) {
        if (radio_voip[i].checked) {
            var valor_voip = radio_voip[i].value;
        }
    }

    //COBRE Adaptacion (VOIP)
    var radio_alicate = document.getElementsByName('rd_alicate');
    for (i = 0; i < radio_alicate.length; i++) {
        if (radio_alicate[i].checked) {
            var valor_alicate = radio_alicate[i].value;
        }
    }
    var radio_pinzas = document.getElementsByName('rd_pinzas');
    for (i = 0; i < radio_pinzas.length; i++) {
        if (radio_pinzas[i].checked) {
            var valor_pinzas = radio_pinzas[i].value;
        }
    }
    var radio_destornilla = document.getElementsByName('rd_destornilla');
    for (i = 0; i < radio_destornilla.length; i++) {
        if (radio_destornilla[i].checked) {
            var valor_destornilla = radio_destornilla[i].value;
        }
    }
    var radio_agu = document.getElementsByName('rd_agu');
    for (i = 0; i < radio_agu.length; i++) {
        if (radio_agu[i].checked) {
            var valor_agu = radio_agu[i].value;
        }
    }
    var radio_micro = document.getElementsByName('rd_micro');
    for (i = 0; i < radio_micro.length; i++) {
        if (radio_micro[i].checked) {
            var valor_micro = radio_micro[i].value;
        }
    }
    var radio_interna = document.getElementsByName('rd_interna');
    for (i = 0; i < radio_interna.length; i++) {
        if (radio_interna[i].checked) {
            var valor_interna = radio_interna[i].value;
        }
    }
    var radio_ficha = document.getElementsByName('rd_ficha');
    for (i = 0; i < radio_ficha.length; i++) {
        if (radio_ficha[i].checked) {
            var valor_ficha = radio_ficha[i].value;
        }
    }
    var radio_filtro = document.getElementsByName('rd_filtro');
    for (i = 0; i < radio_filtro.length; i++) {
        if (radio_filtro[i].checked) {
            var valor_filtro = radio_filtro[i].value;
        }
    }
    var radio_martillo = document.getElementsByName('rd_martillo');
    for (i = 0; i < radio_martillo.length; i++) {
        if (radio_martillo[i].checked) {
            var valor_martillo = radio_martillo[i].value;
        }
    }
    var radio_pcable = document.getElementsByName('rd_pasa_cable');
    for (i = 0; i < radio_pcable.length; i++) {
        if (radio_pcable[i].checked) {
            var valor_pcable = radio_pcable[i].value;
        }
    }
    var radio_alargue = document.getElementsByName('rd_alargue');
    for (i = 0; i < radio_alargue.length; i++) {
        if (radio_alargue[i].checked) {
            var valor_alargue = radio_alargue[i].value;
        }
    }

    if (chk_tecnico.checked) {
        valor_alicate = 27;
        valor_pinzas = 27;
        valor_destornilla = 27;
        valor_agu = 27;
        valor_micro = 27;
        valor_interna = 27;
        valor_ficha = 27;
        valor_filtro = 27;
        valor_martillo = 27;
        valor_pcable = 27;
        valor_alargue = 27;
    }

    // Id Pendiente de monitoreo en caso que la variable opc = 2. Si opc = 3, entonces es el id de monitoreo para actualizar a "trabajado"
    var id_pendiente = document.getElementById("lbl_id_pendiente").innerText;
    if (id_pendiente == "") { id_pendiente = 0; }

    /////////////////////////////////////////////CALCULO DE PUNTAJES/////////////////////////////////////////////////////////////////
    var puntaje_total = 0;

    switch (credencial) {
        case "1": puntaje_total = puntaje_total + 10;
            break;
        case "2": puntaje_total = puntaje_total - 400;
            break;
        case "5": puntaje_total = puntaje_total + 5;
            break;
        case "6": puntaje_total = puntaje_total + 10;
    }
    //alert("Puntaje credencial: " + puntaje_total.toString());

    switch (eq_celular) {
        case "1": puntaje_total = puntaje_total + 10;
            break;
        case "2": puntaje_total = puntaje_total - 400;
            break;
        case "6": puntaje_total = puntaje_total - 400;
            break;
        case "4": puntaje_total = puntaje_total - 400;
            break;
        case "5": puntaje_total = puntaje_total + 10;
    }
    //alert("Puntaje eq.celular: " + puntaje_total.toString());

    if (chk_condicion.checked) {
        puntaje_total = puntaje_total + 10;
        //alert("Puntaje veh OK: " + puntaje_total.toString());
    }
    if (chk_regular.checked) {
        puntaje_total = puntaje_total + 5;
        //alert("Puntaje veh regular: " + puntaje_total.toString());
    }
    if (chk_ingresante.checked) {
        puntaje_total = puntaje_total + 10;
        //alert("Puntaje veh tec.ingresante: " + puntaje_total.toString());
    }

    switch (kit_sanidad) {
        case "3": puntaje_total = puntaje_total + 10;
            break;
        case "4": puntaje_total = puntaje_total - 400;
            break;
        case "5": puntaje_total = puntaje_total - 2000;
            break;
        case "6": puntaje_total = puntaje_total - 2000;
            break;
        case "7": puntaje_total = puntaje_total + 10;
    }
    //alert("Puntaje kit sanidad: " + puntaje_total.toString());

    switch (epp) {
        case "17": puntaje_total = puntaje_total + 10;
            break;
        case "18": puntaje_total = puntaje_total - 2000;
            break;
        case "26": puntaje_total = puntaje_total - 400;
            break;
        case "27": puntaje_total = puntaje_total + 10;
    }
    //alert("Puntaje EPP: " + puntaje_total.toString());

    switch (vestimenta) {
        case "1": puntaje_total = puntaje_total + 10;
            break;
        case "2": puntaje_total = puntaje_total + 5;
            break;
        case "4": puntaje_total = puntaje_total - 400;
            break;
        case "7": puntaje_total = puntaje_total + 10;
    }
    //alert("Puntaje vestimenta: " + puntaje_total.toString());

    //Conocimiento uso de APP
    switch (valor_mobbi20) {
        case "9": puntaje_total = puntaje_total + 10;
            break;
        case "10": puntaje_total = puntaje_total - 400;
            break;
        case "11": puntaje_total = puntaje_total - 2000;
    }
    //alert("Puntaje conoc.uso Mobbi 2.0: " + puntaje_total.toString());
    switch (valor_pdr) {
        case "9": puntaje_total = puntaje_total + 10;
            break;
        case "10": puntaje_total = puntaje_total - 400;
            break;
        case "11": puntaje_total = puntaje_total - 2000;
    }
    switch (valor_qr) {
        case "9": puntaje_total = puntaje_total + 10;
            break;
        case "10": puntaje_total = puntaje_total - 5;
    }
    switch (valor_analizer) {
        case "9": puntaje_total = puntaje_total + 10;
            break;
        case "10": puntaje_total = puntaje_total - 400;
            break;
        case "11": puntaje_total = puntaje_total - 400;
    }
    switch (valor_smart) {
        case "9": puntaje_total = puntaje_total + 10;
            break;
        case "10": puntaje_total = puntaje_total - 5;
    }
    //APP Instaladas
    if (chk_tecnico.checked) {
        puntaje_total = puntaje_total + 40;
    }
    else {
        switch (valor_mobbi20_inst) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 2000;
        }
        //alert("Puntaje APP inst. Mobbi 2.0: " + puntaje_total.toString());
        switch (valor_pdr_inst) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 2000;
        }
        switch (valor_qr_ints) {
            case "1": puntaje_total = puntaje_total + 10;
        }
        switch (valor_analizer_inst) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
        }
    }
    //Herramientas KIT fibra
    if (chk_tecnico.checked) {
        puntaje_total = puntaje_total + 80;
    }
    else {
        switch (valor_kevlar) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        //alert("Puntaje herr.fibra Kevlar: " + puntaje_total.toString());
        switch (valor_cleaver) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 2000;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        //alert("Puntaje herr.fibra cleaver: " + puntaje_total.toString());
        switch (valor_pw) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        //alert("Puntaje herr.fibra power meter: " + puntaje_total.toString());
        switch (valor_triple) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        //alert("Puntaje herr.fibra triple: " + puntaje_total.toString());
        switch (valor_drop) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        //alert("Puntaje herr.fibra drop: " + puntaje_total.toString());
        switch (valor_alcohol) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 2000;
        }
        //alert("Puntaje herr.fibra alcohol: " + puntaje_total.toString());
        switch (valor_panios) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        //alert("Puntaje herr.fibra panios: " + puntaje_total.toString());
        switch (valor_laser) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        //alert("Puntaje herr.fibra Laser: " + puntaje_total.toString());
    }

    //Procesos y conocimientos
    switch (valor_iptv) {
        case "13": puntaje_total = puntaje_total + 10;
            break;
        case "14": puntaje_total = puntaje_total - 400;
            break;
        case "15": puntaje_total = puntaje_total - 2000;
    }
    //alert("Puntaje procesos y conoc. IPTV: " + puntaje_total.toString());
    switch (valor_hgu) {
        case "13": puntaje_total = puntaje_total + 10;
            break;
        case "14": puntaje_total = puntaje_total - 400;
            break;
        case "15": puntaje_total = puntaje_total - 2000;
    }
    //alert("Puntaje procesos y conoc. HGU: " + puntaje_total.toString());
    switch (valor_voip) {
        case "13": puntaje_total = puntaje_total + 10;
            break;
        case "14": puntaje_total = puntaje_total - 400;
            break;
        case "15": puntaje_total = puntaje_total - 2000;
    }
    //alert("Puntaje procesos y conoc. VOIP: " + puntaje_total.toString());

    //Cobre (Adaptacion VOIP)
    if (chk_tecnico.checked) {
        puntaje_total = puntaje_total + 110;
    }
    else {
        switch (valor_alicate) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        //alert("Puntaje herr.cobre alicate: " + puntaje_total.toString());
        switch (valor_pinzas) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        switch (valor_destornilla) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        switch (valor_agu) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
                break;
        }
        switch (valor_micro) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        switch (valor_interna) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        switch (valor_ficha) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        switch (valor_filtro) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        switch (valor_martillo) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        switch (valor_pcable) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
        switch (valor_alargue) {
            case "1": puntaje_total = puntaje_total + 10;
                break;
            case "2": puntaje_total = puntaje_total - 400;
                break;
            case "3": puntaje_total = puntaje_total - 400;
        }
    }

    //Método constructivo
    switch (drop_metodo) {
        case "21": puntaje_total = puntaje_total + 10;
            break;
        case "22": puntaje_total = puntaje_total - 400;
            break;
        case "23": puntaje_total = puntaje_total - 2000;
            break;
        case "27": puntaje_total = puntaje_total + 10;
    }
    //alert("Puntaje metodo constr.: " + puntaje_total.toString());
    //Armado de conector
    switch (drop_circular) {
        case "21": puntaje_total = puntaje_total + 10;
            break;
        case "22": puntaje_total = puntaje_total - 400;
            break;
        case "23": puntaje_total = puntaje_total - 2000;
            break;
        case "29": puntaje_total = puntaje_total + 10;
    }
    //alert("Puntaje armado drop circular: " + puntaje_total.toString());
    switch (drop_plano) {
        case "21": puntaje_total = puntaje_total + 10;
            break;
        case "22": puntaje_total = puntaje_total - 400;
            break;
        case "23": puntaje_total = puntaje_total - 2000;
            break;
        case "29": puntaje_total = puntaje_total + 10;
    }


    //CALIFICACION FINAL
    //Apto
    if (puntaje_total >= 240 && puntaje_total <= 400) {
        document.getElementById("rd_1").checked = true;
        document.getElementById("txt_resultado").innerHTML = "<span class='blanco_grande'>APTO</span>";
    }
    //Regular
    if (puntaje_total >= -1600 && puntaje_total <= 235) {
        document.getElementById("rd_2").checked = true;
        //document.getElementById("ContentPlaceHolder1_txt_obs").innerHTML = " .: VOLVER A MONITOREAR EN 72HS :. ";
        document.getElementById("txt_resultado").innerHTML = "<span class='amarillo_grande'>PROVISORIO</span>";
    }
    //No apto
    if (puntaje_total >= -36800 && puntaje_total <= -1610) {
        document.getElementById("rd_3").checked = true;
        //document.getElementById("ContentPlaceHolder1_txt_obs").innerHTML = " .: VOLVER A MONITOREAR EN 24 O 36HS :. ";
        document.getElementById("txt_resultado").innerHTML = "<span class='rojo_grande'>NO APTO</span>";
    }

    var radio_ND = document.getElementsByName('rd_ND');
    for (i = 0; i < radio_ND.length; i++) {
        if (radio_ND[i].checked) {
            var valor_ND = radio_ND[i].value;
        }
    }

    var observaciones = document.getElementById("txt_obs").value;


    /////////////////////////////////////////FIN CALCULO DE PUNTAJES/////////////////////////////////////////////////////////////////

    //Chequeo drops y otras cosas
    if (val_cita > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar si el t\u00E9cnico es nuevo");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (val_campo > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar si el monitoreo fue en campo, obrador o virtual");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (val_tecnico > 0 || chk_tecnico.checked) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar t\u00E9cnico");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (credencial > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar credencial");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (eq_celular > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar equipo celular");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (!chk_condicion.checked && !chk_regular.checked && !chk_mal.checked) {
        alert("Debe tildar el estado general del veh\u00EDculo");
    }

    if (epp > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar EPP");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (contexto > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar contexto de instalaci\u00F3n");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (kit_sanidad > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar KIT sanidad");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (vestimenta > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar presencia/vestimenta");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (vestimenta > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar presencia/vestimenta");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (drop_metodo > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar m\u00E9todo constructivo");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (drop_circular > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar armado drop circular");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    if (drop_plano > 0) {
        chequeo_cosas = chequeo_cosas + 1;
    }
    else {
        alert("Debe seleccionar armado drop plano");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }

    //GUARDOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
    if (chequeo_cosas == 13) {
        //CHECK TECNICO INGRESO MANUAL
        if (chk_tecnico.checked == true) {
            if (empresa_tecnico.value != "0") {
                if ($('#txt_nombre_tec').val().length > 0 && $('#txt_apellido_tec').val().length > 0) {
                    fecha_manual = fecha_manual.replace("-", "");
                    fecha_manual = fecha_manual.replace("-", "");
                    //alert("Caso de prueba no se guarda. (Tec.ingreso manual)");
                    //alert(opc);
                    //alert(id_pendiente);
                    $.ajax({
                        url: "servicios_monitoreos.asmx/guardar",
                        method: 'post',
                        data: { opcion: opc, id_pend: id_pendiente, usuario: usuario_red, tecnico: 0, f_manual: fecha_manual, ap_tecnico: apellido_upper, nom_tecnico: nombre_upper, dni_tec: dni_tecnico, empresa_tecnico: empresa_upper, campo: val_campo, credencial: credencial, equipo: eq_celular, cita: val_cita, vehiculo_estado: veh_estado, vehiculo_identif: chk_sidentif, vehiculo_escalera: chk_sescalera, vehiculo_porta: chk_sporta, vehiculo_patente: veh_patente_upper, contex_insta: contexto, kit_sano: kit_sanidad, epp: epp, vestimenta: vestimenta, metodo: drop_metodo, drop_plano: drop_plano, drop_circular: drop_circular, obs: observaciones, mobbi: valor_mobbi, mobbi20: valor_mobbi20, whop: valor_whop, pdr: valor_pdr, qr: valor_qr, analizer: valor_analizer, smart: valor_smart, kevlar: valor_kevlar, cleaver: valor_cleaver, pw: valor_pw, triple: valor_triple, drop: valor_drop, alcohol: valor_alcohol, panios: valor_panios, laser: valor_laser, mobbi1_inst: valor_mobbi1_instalada, mobbi20_inst: valor_mobbi20_inst, whop_inst: valor_whop_inst, qr_inst: valor_qr_ints, pdr_inst: valor_pdr_inst, analizer_inst: valor_analizer_inst, smart_inst: valor_smartwifi_inst, iptv: valor_iptv, hgu: valor_hgu, voip: valor_voip, alicate: valor_alicate, pinzas: valor_pinzas, destornilla: valor_destornilla, aguj: valor_agu, micro: valor_micro, interna: valor_interna, ficha: valor_ficha, filtro: valor_filtro, martillo: valor_martillo, pela_cable: valor_pcable, alargue: valor_alargue, res_final: valor_ND },
                        dataType: "html", //SE USA POST CUANDO EL WEB SERVICE ME DEVUELVE DATOS. USAR HTML PARA QUE EL SUCCESS FUNCIONE
                        success: function () {
                            alert("El caso se guard\u00F3 correctamente.");
                            setTimeout("redireccionar_inicio()", 1000);
                        },
                        error: function () {
                            alert("Hubo un error al guardar el caso!");
                            document.getElementById("btn_guardar").disabled = false;
                            uno.innerHTML = "Guardar";
                        }
                    });

                    document.getElementById("btn_guardar").disabled = false;
                    uno.innerHTML = "Guardar";
                }
                else {
                    alert("Debe completar ambos campos, Apellido y Nombre del t\u00E9cnico.");
                    document.getElementById("btn_guardar").disabled = false;
                    uno.innerHTML = "Guardar";
                }
            }
            else {
                alert("Debe seleccionar EMPRESA.");
                document.getElementById("btn_guardar").disabled = false;
                uno.innerHTML = "Guardar";
            }
        }
        //CHECK TECNICO INGRESO POR LISTADO DESPLEGABLE
        else {
            if (val_tecnico > 0) {
                //alert("Caso de prueba, no se guarda. (Tec ingresado por combo)");
                $.ajax({
                    url: "servicios_monitoreos.asmx/guardar",
                    method: 'post',
                    data: { opcion: opc, id_pend: id_pendiente, usuario: usuario_red, tecnico: val_tecnico, f_manual: fecha_manual, ap_tecnico: null, nom_tecnico: null, dni_tec: null, empresa_tecnico: null, campo: val_campo, credencial: credencial, equipo: eq_celular, cita: val_cita, vehiculo_estado: veh_estado, vehiculo_identif: chk_sidentif, vehiculo_escalera: chk_sescalera, vehiculo_porta: chk_sporta, vehiculo_patente: veh_patente_upper, contex_insta: contexto, kit_sano: kit_sanidad, epp: epp, vestimenta: vestimenta, metodo: drop_metodo, drop_plano: drop_plano, drop_circular: drop_circular, obs: observaciones, mobbi: valor_mobbi, mobbi20: valor_mobbi20, whop: valor_whop, pdr: valor_pdr, qr: valor_qr, analizer: valor_analizer, smart: valor_smart, kevlar: valor_kevlar, cleaver: valor_cleaver, pw: valor_pw, triple: valor_triple, drop: valor_drop, alcohol: valor_alcohol, panios: valor_panios, laser: valor_laser, mobbi1_inst: valor_mobbi1_instalada, mobbi20_inst: valor_mobbi20_inst, whop_inst: valor_whop_inst, qr_inst: valor_qr_ints, pdr_inst: valor_pdr_inst, analizer_inst: valor_analizer_inst, smart_inst: valor_smartwifi_inst, iptv: valor_iptv, hgu: valor_hgu, voip: valor_voip, alicate: valor_alicate, pinzas: valor_pinzas, destornilla: valor_destornilla, aguj: valor_agu, micro: valor_micro, interna: valor_interna, ficha: valor_ficha, filtro: valor_filtro, martillo: valor_martillo, pela_cable: valor_pcable, alargue: valor_alargue, res_final: valor_ND },
                    dataType: "html", //SE USA POST CUANDO EL WEB SERVICE ME DEVUELVE DATOS. USAR HTML PARA QUE EL SUCCESS FUNCIONE
                    success: function () {
                        alert("El caso se guard\u00F3 correctamente.");
                        setTimeout("redireccionar_inicio()", 1000);
                    },
                    error: function () {
                        alert("Hubo un error al guardar el caso!");
                        document.getElementById("btn_guardar").disabled = false;
                        uno.innerHTML = "Guardar";
                    }
                });
                document.getElementById("btn_guardar").disabled = false;
                uno.innerHTML = "Guardar";
            }
            else {
                alert("Debe seleccionar un t\u00E9cnico");
                document.getElementById("btn_guardar").disabled = false;
                uno.innerHTML = "Guardar";
            }
        }
    }
    else {
        //alert("Falt\u00F3 seleccionar algo!");
        document.getElementById("btn_guardar").disabled = false;
        uno.innerHTML = "Guardar";
    }
}
///////////////////////////////////////////////// FIN FORMULARIO CARGA /////////////////////////////////////////////////

////////////////////////////////////////////////////// BUSCADOR ////////////////////////////////////////////////////////
function resultado_busqueda1() {
    var resultados = $('#t_resultados_monitoreos');
    $('#t_resultados_monitoreos').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    //$('#t_resultados2').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    var verificador = 0;
    var comodin = "'";

    document.getElementById("btn_busca").disabled = true;
    var uno = document.getElementById('btn_busca');
    uno.innerHTML = "Buscando...";

    var param_tecnico = document.getElementById("txt_tecnico").value;

    if (param_tecnico != "") {
        $.ajax({
            url: "servicios_monitoreos.asmx/busca_tecnico",
            method: 'post',
            data: { tecnico: param_tecnico },
            dataType: "json",
            success: function (datos) {
                document.getElementById('div_tabla_res').style.display = 'block';
                document.getElementById('div_tabla_res2').style.display = 'none';
                document.getElementById('div_tabla_res3').style.display = 'none';
                resultados.append('<thead><tr><th>NOMBRE</th><th class="text-center">EMPRESA</th><th class="text-center">ID TOA</th><th class="text-center">INGRESANTE</th></tr></thead>');
                $(datos).each(function (index, item) {
                    resultados.append('<tr><td><label style="cursor: hand;" onclick="resultado_busqueda2(' + item.ID_RECURSO + ', ' + comodin + item.Ingresante + comodin + ')">' + item.Nombre + '</label></td><td align="center">' + item.ctta + '</td><td align="center">' + item.ID_TOA + '</td><td align="center">' + item.Ingresante + '</td></tr>');
                    verificador = 1;
                });

                if (verificador == 0) {
                    $('#t_resultados_monitoreos').empty(); //VACIA LA TABLA
                    resultados.append('<thead><tr><th align="center"><b>NO SE ENCONTRARON RESULTADOS</b></th></tr></thead>');
                }
            },
            error: function (data) {
                alert("Hubo un error al consultar! ");
            }
        });
    }
    else {
        alert("Debe completar el campo de b\u00FAsqueda.");
    }

    document.getElementById("btn_busca").disabled = false;
    var uno = document.getElementById('btn_busca');
    uno.innerHTML = "Buscar";
}

function resultado_busqueda2(id_tecnico, ingreso) {
    //alert(id_tecnico + " -- " + ingreso);
    var resultados = $('#t_resultados_monitoreos2');
    var h3 = $('#h3_nombre_resultado_monitoreo');
    var comodin = "'";
    var sw = 0;
    $('#t_resultados_monitoreos2').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    h3.empty();

    document.getElementById("btn_busca").disabled = true;
    var uno = document.getElementById('btn_busca');
    uno.innerHTML = "Buscando...";

    $.ajax({
        url: "servicios_monitoreos.asmx/busca_tecnico2", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { tecnico: id_tecnico },
        dataType: "json",
        success: function (datos) {
            document.getElementById('div_tabla_res2').style.display = 'block';
            document.getElementById('div_tabla_res3').style.display = 'none';
            resultados.append('<thead><tr><th class="text-center">MONITOREOS</th><th class="text-center">ULTIMA CALIFICACION</th></tr></thead>');
            $(datos).each(function (index, item) {
                h3.append("Resultados de " + item.tecnico);
                if (item.calificacion == "Apto") {
                    resultados.append('<tr><td class="text-center"><p onclick="resultado_busqueda3(' + item.id_recurso + ',' + comodin + item.tecnico + comodin + ');" style="cursor: pointer;"><u>' + item.monitoreos + '</u></p></td><td class="text-center"><div class="alert alert-success"><i class="icon fas fa-check"></i>' + item.calificacion + '</div></td></tr>');
                    sw = 1;
                }
                if (item.calificacion == "Provisorio") {
                    resultados.append('<tr><td class="text-center"><p onclick="resultado_busqueda3(' + item.id_recurso + ',' + comodin + item.tecnico + comodin + ');" style="cursor: pointer;"><u>' + item.monitoreos + '</u></p></td><td class="text-center"><div class="alert alert-warning"><i class="icon fas fa-exclamation-triangle"></i>' + item.calificacion + '</div></td></tr>');
                    sw = 1;
                }
                if (item.calificacion == "No Apto") {
                    resultados.append('<tr><td class="text-center"><p onclick="resultado_busqueda3(' + item.id_recurso + ',' + comodin + item.tecnico + comodin + ');" style="cursor: pointer;"><u>' + item.monitoreos + '</u></p></td><td class="text-center"><div class="alert alert-danger"><i class="icon fas fa-ban"></i>' + item.calificacion + '</div></td></tr>');
                    sw = 1;
                }
                if (sw == 0) {
                    h3.empty();
                    h3.append("Sin resultados");
                    resultados.empty();
                    resultados.append('<thead><tr><th class="text-center">NO SE HALLARON MONITOREOS/CALIBRACIONES</th></thead>');
                }
            });
        },
        error: function (data) {
            alert("Hubo un error al consultar! ");
        }
    });

    document.getElementById("btn_busca").disabled = false;
    var uno = document.getElementById('btn_busca');
    uno.innerHTML = "Buscar";
}

function resultado_busqueda3(param_tecnico, tecnico) {
    var resultados = $('#t_resultados_monitoreos3')
    var h3 = $('#h3_nombre_resultado_monitoreo_detalle');
    $('#t_resultados_monitoreos3').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    h3.empty();
    var comodin = "'";
    //alert(param_tecnico);

    $.ajax({
        url: "servicios_monitoreos.asmx/detalle_tecnico1",
        method: 'post',
        data: { tecnico: param_tecnico },
        dataType: "json", //SE USA POST CUANDO EL WEB SERVICE ME DEVUELVE DATOS. USAR HTML PARA QUE EL SUCCESS FUNCIONE
        success: function (datos) {
            document.getElementById('div_tabla_res3').style.display = 'block';
            h3.append("Monitoreos/Calibraciones de " + tecnico);

            resultados.append('<thead><tr><th class="text-center">CALIFICACION</th><th class="text-center">FECHA</th><th></th></tr></thead>');

            $(datos).each(function (index, item) {
                if (item.calificacion == "Apto") {
                    resultados.append('<tr><td><div class="alert alert-success"><i class="icon fas fa-check"></i>' + item.calificacion + '</div></td><td class="text-center">' + item.fecha_inicio.substring(0, 10) + '</td><td><a href="monitoreos_formload.aspx?param=' + item.fecha_inicio.substring(0, 10) + '&tec=' + param_tecnico + '" target="_blank" class="btn btn-primary">VER</a></td></tr>');
                }
                if (item.calificacion == "Provisorio") {
                    resultados.append('<tr><td><div class="alert alert-warning"><i class="icon fas fa-exclamation-triangle"></i>' + item.calificacion + '</div></td><td class="text-center">' + item.fecha_inicio.substring(0, 10) + '</td><td><a href="monitoreos_formload.aspx?param=' + item.fecha_inicio.substring(0, 10) + '&tec=' + param_tecnico + '" target="_blank" class="btn btn-primary">VER</a></td></tr>');
                }
                if (item.calificacion == "No Apto") {
                    resultados.append('<tr><td><div class="alert alert-danger"><i class="icon fas fa-ban"></i>' + item.calificacion + '</div></td><td class="text-center">' + item.fecha_inicio.substring(0, 10) + '</td><td><a href="monitoreos_formload.aspx?param=' + item.fecha_inicio.substring(0, 10) + '&tec=' + param_tecnico + '" target="_blank" class="btn btn-primary">VER</a></td></tr>');
                }
            });
        },
        error: function (jqXHR, exception) {
            //alert("Hubo un error al consultar detalle! ");
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

function carga_detalle_tecnico(param_fecha, param_tecnico) {
    var fecha = param_fecha.substring(6, 10);
    fecha += param_fecha.substring(3, 5);
    fecha += param_fecha.substring(0, 2);

    //alert("Param_fecha: " + param_fecha + " - Fecha: " + fecha);

    //DATOS DEL AUDITOR
    var cbo_cita = $('#cbo_cita');
    var cbo_campo = $('#cbo_campo');
    var usuario_red = $('#lbl_user');
    var fecha_manual = $('#txt_fecha_manual');
    //DATOS DEL TECNICO
    var val_tecnico = $('#drop_tecnico');
    var dni_tecnico = $('#lbl_dni');
    var empresa_tecnico = $('#cbo_empresa');
    var credencial = $("#drop_credencial");
    var eq_celular = $("#drop_equipo");
    var chk_tecnico = document.getElementById("chk_tecnico");
    //VEHICULO
    var veh_estado = $("#txt_estado");
    var veh_escalera = $("#txt_escalera");
    var porta_escalera = $("#txt_porta");
    var chk_sidentif = $("#chk_veh_sinidentif");
    var veh_patente = $('#txt_patente');
    //PRESENCIA Y CONTEXTO
    var contexto = $("#drop_contexto");
    var kit_sanidad = $("#drop_kit_sanidad");
    var epp = $("#drop_epp");
    var vestimenta = $("#drop_presencia");
    //CONOCIMIENTO USO APPS
    var radio_mobbi20 = $('#rd_mobbi20');
    var radio_pdr = $('#rd_pdr');
    var radio_qr = $('#rd_qr');
    var radio_analizer = $('#rd_analizer');
    var radio_smart = $('#rd_smart');
    //APP Instaladas
    var radio_mobbi20_inst = $('#rd_mobbi2_instalada');
    var radio_pdr_inst = $('#rd_pdr_instalada');
    var radio_qr_ints = $('#rd_qr_instalada');
    var radio_analizer_inst = $('#rd_analizer_instalada');
    //HERRAMIENTAS KIT FIBRA
    var radio_kevlar = $('#rd_kevlar');
    var radio_cleaver = $('#rd_cleaver');
    var radio_pw = $('#rd_pw');
    var radio_triple = $('#rd_triple');
    var radio_drop = $('#rd_drop');
    var radio_alcohol = $('#rd_alcohol');
    var radio_panios = $('#rd_panios');
    var radio_laser = $('#rd_laser');
    //PROCESOS Y CONOCIMIENTO
    var radio_iptv = $('#rd_iptv');
    var radio_hgu = $('#rd_hgu');
    var radio_voip = $('#rd_voip');
    //COBRE Adaptacion (VOIP)
    var radio_alicate = $('#rd_alicate');
    var radio_pinzas = $('#rd_pinzas');
    var radio_destornilla = $('#rd_destornilla');
    var radio_agu = $('#rd_agu');
    var radio_micro = $('#rd_micro');
    var radio_interna = $('#rd_interna');
    var radio_ficha = $('#rd_ficha');
    var radio_filtro = $('#rd_filtro');
    var radio_martillo = $('#rd_martillo');
    var radio_pcable = $('#rd_pasa_cable');
    var radio_alargue = $('#rd_alargue');
    //METODO CONSTRUCTIVO
    var drop_metodo = $("#drop_metodo");
    var drop_plano = $("#drop_plano");
    var drop_circular = $("#drop_circular");
    //OBSERVACIONES Y RESULTADO FINAL
    var observaciones = $('#txt_obs');
    var calificacion = $('#txt_resultado');

    //alert (fecha);
    //alert (param_tecnico);

    $.ajax({
        url: "servicios_monitoreos.asmx/detalle_tecnico2",
        method: 'post',
        data: { fecha: param_fecha, tecnico: param_tecnico },
        dataType: "json", //SE USA POST CUANDO EL WEB SERVICE ME DEVUELVE DATOS. USAR HTML PARA QUE EL SUCCESS FUNCIONE
        success: function (datos) {
            $(datos).each(function (index, item) {
                //DATOS DEL AUDITOR
                cbo_cita.append($('<option/>', { value: 0, text: item.motivo }));
                cbo_campo.append($('<option/>', { value: 0, text: item.cito }));
                usuario_red.val(item.monitor);
                fecha_manual.val(item.fecha);
                //DATOS DEL TECNICO
                val_tecnico.append($('<option/>', { value: 0, text: item.tecnico }));
                dni_tecnico.val(item.dni);
                empresa_tecnico.append($('<option/>', { value: 0, text: item.contratista }));
                if (item.ingresante == 1) { chk_tecnico.checked = true; }
                else { chk_tecnico.checked = false; }
                credencial.append($('<option/>', { value: 0, text: item.credencial }));
                eq_celular.append($('<option/>', { value: 0, text: item.celular }));
                //RELEVAMIENTO VEHICULO
                veh_estado.text(item.vehiculo);
                veh_escalera.text(item.escalera);
                porta_escalera.text(item.porta_escalera);
                chk_sidentif.text(item.identificacion);
                veh_patente.val(item.patente);
                contexto.append($('<option/>', { value: 0, text: item.contexto }));
                kit_sanidad.append($('<option/>', { value: 0, text: item.kit_sanidad }));
                epp.append($('<option/>', { value: 0, text: item.epp }));
                vestimenta.append($('<option/>', { value: 0, text: item.presencia }));
                //CONOCIMIENTO USO APPS
                radio_mobbi20.text(item.mobbi2);
                radio_pdr.text(item.pdr);
                radio_qr.text(item.qr);
                radio_analizer.text(item.wifianalizer);
                radio_smart.text(item.smartwifi);
                //APP INSTALADAS
                radio_mobbi20_inst.text(item.insta_mobbi2);
                radio_pdr_inst.text(item.insta_pdr);
                radio_qr_ints.text(item.insta_qr);
                radio_analizer_inst.text(item.insta_wifianalizer);
                //HERRAMIENTAS KIT FIBRA
                radio_kevlar.text(item.tijeras);
                radio_cleaver.text(item.cleaver);
                radio_pw.text(item.powermeter);
                radio_triple.text(item.triple);
                radio_drop.text(item.peladora);
                radio_alcohol.text(item.alcohol);
                radio_panios.text(item.panios);
                radio_laser.text(item.linterna);
                //PROCESOS Y CONOCIMIENTO
                radio_iptv.text(item.iptv);
                radio_hgu.text(item.hgu);
                radio_voip.text(item.voip);
                //COBRE Adaptacion (VOIP)
                radio_alicate.text(item.alicate);
                radio_pinzas.text(item.pinzas);
                radio_destornilla.text(item.destornilla);
                radio_agu.text(item.agujereadora);
                radio_micro.text(item.micro);
                radio_interna.text(item.cable_int);
                radio_ficha.text(item.americana);
                radio_filtro.text(item.filtros);
                radio_martillo.text(item.martillo);
                radio_pcable.text(item.pela_cable);
                radio_alargue.text(item.alargue);
                //METODO CONSTRUCTIVO
                drop_metodo.append($('<option/>', { value: 0, text: item.drop_metodo }));
                drop_plano.append($('<option/>', { value: 0, text: item.drop_plano }));
                drop_circular.append($('<option/>', { value: 0, text: item.drop_circular }));
                //OBSERVACIONES Y RESULTADO FINAL
                observaciones.text(item.obs);
                //calificacion.text(item.calificacion);
                if (item.calificacion == "Apto") { calificacion.append('<div class="alert alert-success" style="font-size: 30px;"><i class="icon fas fa-check"></i>' + item.calificacion + '</div>'); }
                if (item.calificacion == "No Apto") { calificacion.append('<div class="alert alert-danger" style="font-size: 30px;"><i class="icon fas fa-ban"></i>' + item.calificacion + '</div>'); }
                if (item.calificacion == "Provisorio") { calificacion.append('<div class="alert alert-warning" style="font-size: 30px;"><i class="icon fas fa-exclamation-triangle"></i>' + item.calificacion + '</div>'); }
            });
        },
        error: function (jqXHR, exception) {
            //alert("Hubo un error al consultar detalle! ");
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
//////////////////////////////////////////////////// FIN BUSCADOR //////////////////////////////////////////////////////

//////////////////////////////////////////////////BANDEJA PENDIENTES////////////////////////////////////////77//////////
function lista_pendiente_monitoreos() {
    var resultados = $('#t1');
    var contador = 1;

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    resultados.append('<thead><tr><th>&nbsp;</th><th>ID ENCUESTA</th><th>USUARIO QUE INGRESÓ</th><th>TECNICO</th><th class="text-center">EMPRESA</th><th>FECHA INGRESO</th><th>&nbsp;</th></tr></thead>');

    $.ajax({
        url: "servicios_monitoreos.asmx/monitoreos_lista_pendiente", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { opcion: 1 },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tbody>');
            $(datos).each(function (index, item) {
                if (item.id_medallia == 0) { // Pendiente manual
                    resultados.append('<tr><td class="align-baseline text-center">' + item.bandera + '</td><td class="align-baseline text-center"><button type="button" class="btn btn-info" data-toggle="modal" data-target="#modal-info_' + contador + '">Observaciones</button></td><td class="align-baseline">' + item.clooper + '</td><td class="align-baseline">' + item.tecnico + '</td><td class="align-baseline text-center">' + item.empresa + '</td><td class="align-baseline">' + item.fecha_ingreso + '</td><td class="align-baseline"><a href="monitoreos_formload_pendiente.aspx?id_pendiente=' + item.id_pendiente + '&recurso=' + item.id_recurso + '&tec=' + item.tecnico + '&dni=' + item.dni + '&empre=' + item.empresa + '" class="btn btn-primary">Trabajar</a></td></tr>');
                    inserta_modal(contador);
                    $("#modal-info_" + contador + " .modal-body").html(item.observaciones);
                    contador = ++contador;
                }
                else { // Pendiente de Medallia
                    resultados.append('<tr><td class="align-baseline"><img src="' + item.bandera + '" /></td><td class="align-baseline text-center"><a href="medallia_formload.aspx?param=' + item.id_medallia + '&opc=0" target="_blank">' + item.id_encuesta + '</a></td><td class="align-baseline">' + item.clooper + '</td><td class="align-baseline">' + item.tecnico + '</td><td class="align-baseline text-center">' + item.empresa + '</td><td class="align-baseline">' + item.fecha_ingreso + '</td><td class="align-baseline"><a href="monitoreos_formload_pendiente.aspx?id_pendiente=' + item.id_pendiente + '&recurso=' + item.id_recurso + '&tec=' + item.tecnico + '&dni=' + item.dni + '&empre=' + item.empresa + '" class="btn btn-primary">Trabajar</a></td></tr>');
                }
            });
            resultados.append('</tbody>');
        }
    });
}

function inserta_modal(id_modal) {
    /*
    <div class="modal fade" id="modal-info">
        <div class="modal-dialog">
            <div class="modal-content bg-info">
                <div class="modal-header">
                    <h4 class="modal-title">Observaciones de la solicitud</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                            
                </div>
                <div class="modal-footer justify-content-between">
                    <!--<button type="button" class="btn btn-outline-light" data-dismiss="modal">Close</button>-->
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    */
    var div_padre = document.getElementById("contenido");

    var div1 = document.createElement("div");
    div1.className = "modal fade";
    div1.setAttribute('id', 'modal-info_' + id_modal);
    var div2 = document.createElement("div");
    div2.className = "modal-dialog";
    var div3 = document.createElement("div");
    div3.className = "modal-content bg-info";
    var div4 = document.createElement("div");
    div4.className = "modal-header";
    var div5 = document.createElement("div");
    div5.className = "modal-body";
    var div6 = document.createElement("div");
    div6.className = "modal-footer justify-content-between";

    var h4 = document.createElement("h4");
    h4.setAttribute('id', 'h4_modal_' + id_modal);
    h4.className = "modal-title";
    
    var boton = document.createElement("button");
    boton.setAttribute('type', 'button');
    boton.className = "close";
    boton.setAttribute('data-dismiss', 'modal');
    boton.setAttribute('aria-label', 'close');

    var span = document.createElement("span");
    span.setAttribute('id', 'span_modal_' + id_modal);
    span.setAttribute('aria-hidden', 'true');

    div_padre.appendChild(div1);
    div1.appendChild(div2);
    div2.appendChild(div3);
    div3.appendChild(div4);
    div4.appendChild(h4);
    div4.appendChild(boton);
    div4.appendChild(span);
    div3.appendChild(div5);
    div3.appendChild(div6);

    document.getElementById("span_modal_" + id_modal).innerHTML = '&times;';
    document.getElementById("h4_modal_" + id_modal).innerHTML = 'Observaciones de la solicitud';
}

function carga_formulario_pendiente(id_pendiente, recurso, tecnico, dni, empresa) {
    var drop_tecnico = $('#drop_tecnico');
    var drop_empresa = $('#cbo_empresa');

    document.getElementById("lbl_dni").value = dni;
    document.getElementById("lbl_id_pendiente").innerText = id_pendiente;
    drop_tecnico.append($('<option/>', { value: recurso, text: tecnico }));
    drop_empresa.append($('<option/>', { value: empresa, text: empresa }));
}
////////////////////////////////////////////////FIN BANDEJA PENDIENTES////////////////////////////////////////77////////

///////////////////////////////////////////////BANDEJA PENDIENTES GESTOR////////////////////////////////////////77//////
function lista_pendiente_gestor() {
    var resultados = $('#t1');
    var contador = 1;

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    resultados.append('<thead><tr><th colspan="3" class="text-center">MONITOREO/MEDALLI/OBS.</th><th>AUDITOR</th><th>FECHA MONITOREO</th><th>TECNICO</th><th class="text-center">EMPRESA</th><th>FECHA VISTO</th><th colspan="2">&nbsp;</th></tr></thead>');

    $.ajax({
        url: "servicios_monitoreos.asmx/monitoreos_lista_pendiente", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { opcion: 2 },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tbody>');
            $(datos).each(function (index, item) {
                //alert(item.id_medallia);
                if (item.id_medallia == 0) {
                    resultados.append('<tr><td class="align-baseline"><a href="monitoreos_formload.aspx?param=' + item.fecha_ingreso + '&tec=' + item.id_recurso + '" class="btn btn-info" target="_blank">Ver</a></td><td></td><td class="align-baseline text-center"><button type="button" class="btn btn-warning" data-toggle="modal" data-target="#modal-info_' + contador + '">Observaciones</button></td><td class="align-baseline">' + item.clooper + '</td><td class="align-baseline">' + item.fecha_ingreso.substring(0, 10) + '</td><td class="align-baseline">' + item.tecnico + '</td><td class="align-baseline text-center">' + item.empresa + '</td><td class="align-baseline text-center">' + item.observaciones.substring(0, 10) + '</td><td class="align-baseline">&nbsp;</td><td class="align-baseline"><a href="monitoreos_formload_pendiente2.aspx?id_pendiente=' + item.id_pendiente + '&recurso=' + item.id_recurso + '&tec=' + item.tecnico + '&dni=' + item.dni + '&empre=' + item.empresa + '" class="btn btn-primary">Trabajar</a></td></tr>');
                    inserta_modal(contador);
                    $("#modal-info_" + contador + " .modal-body").html(item.observaciones_ctta);
                    contador = ++contador;
                }
                else {
                    resultados.append('<tr><td class="align-baseline"><a href="monitoreos_formload.aspx?param=' + item.fecha_ingreso + '&tec=' + item.id_recurso + '" class="btn btn-info" target="_blank">Ver</a></td><td class="align-baseline"><a href="medallia_formload.aspx?param=' + item.id_medallia + '&opc=0" class="btn btn-primary" target="_blank">Ver</a></td><td class="align-baseline"><button type="button" class="btn btn-info" data-toggle="modal" data-target="#modal-info_' + contador + '">Observaciones</button></td><td class="align-baseline">' + item.clooper + '</td><td class="align-baseline">' + item.fecha_ingreso.substring(0, 10) + '</td><td class="align-baseline">' + item.tecnico + '</td><td class="align-baseline text-center">' + item.empresa + '</td><td class="align-baseline text-center">' + item.observaciones.substring(0, 10) + '</td><td><button class="btn btn-danger mr-2" onclick="devuelve_caso_medallia(' + item.id_medallia + ',' + item.id_pendiente + ')">Devolver</button></td><td><a href="monitoreos_formload_pendiente2.aspx?id_pendiente=' + item.id_pendiente + '&recurso=' + item.id_recurso + '&tec=' + item.tecnico + '&dni=' + item.dni + '&empre=' + item.empresa + '" class="btn btn-primary">Trabajar</a></td></tr>');
                    inserta_modal(contador);
                    $("#modal-info_" + contador + " .modal-body").html(item.observaciones_ctta);
                    contador = ++contador;
                }
            });
            resultados.append('</tbody>');
        }
    });
}

function devuelve_caso_medallia(id_medallia, id_monitoreo) {
    alert("ID Medallia: " + id_medallia + " / ID Monitoreo: " + id_monitoreo);

    if (confirm("Desea devolver este monitoreo a la bandeja de Pendiente Monitoreo Medallia?")) {
        $.ajax({
            url: "servicios_monitoreos.asmx/monitoreos_devuelve_medallia",
            method: 'post',
            data: { id_medallia: id_medallia, id_monitoreo: id_monitoreo },
            dataType: "html",
            success: function (datos) {
                alert("Monitoreo devuelto al clooper.");
            },
            error: function (jqXHR, exception) {
                //alert("Hubo un error al consultar detalle! ");
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
}
////////////////////////////////////////////FIN BANDEJA PENDIENTES GESTOR////////////////////////////////////////77/////

//////////////////////////////////////////////FORMULARIO INGRESO MANUAL////////////////////////////////////////77///////
function carga_caso_manual(id_user) {
    var drop_tecnico = document.getElementById("drop_tecnico").value;
    var observaciones = document.getElementById("txt_observaciones").value;

    if (drop_tecnico != 0) {
        $.ajax({
            url: "servicios_monitoreos.asmx/monitoreos_carga_manual",
            method: 'post',
            data: { id_usr: id_user, tecnico: drop_tecnico, obs: observaciones },
            dataType: "html", //SE USA POST CUANDO EL WEB SERVICE ME DEVUELVE DATOS. USAR HTML PARA QUE EL SUCCESS FUNCIONE
            success: function () {
                alert("El caso se guard\u00F3 correctamente.");
                setTimeout("redireccionar_inicio()", 500);
            },
            error: function () {
                alert("Hubo un error al guardar el caso!");
                document.getElementById("btn_guardar").disabled = false;
                uno.innerHTML = "Guardar";
            }
        });
    }
    else {
        alert("Debe seleccionar un t\u00E9cnico del listado!");
    }
}
////////////////////////////////////////////FIN FORMULARIO INGRESO MANUAL////////////////////////////////////////77/////

///////////////////////////////////////////BANDEJA NO APTOS y PROVISORIOS////////////////////////////////////////77/////
function lista_pendiente_aptos(opc, empresa) {
    var resultados = $('#t1');
    var contador = 1;
    //alert(empresa);

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    $.ajax({
        url: "servicios_monitoreos.asmx/monitoreos_lista_noaptos", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { opcion: opc, empresa: empresa },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tbody>');
            $(datos).each(function (index, item) {
                if (opc == 2 || opc == 3) {
                    if (contador == 1) {
                        resultados.append('<thead><tr><th>&nbsp;</th><th>COMENTARIOS</th><th>FECHA MONITOREO</th><th>AUDITOR</th><th>TECNICO</th><th class="text-center">EMPRESA</th><th>MOTIVO CALIBRACION</th></tr></thead>');
                    }
                    //resultados.append('<tr><td class="align-baseline text-center"><a href="monitoreos_formload.aspx?param=' + item.bandera + '&tec=' + item.id_clooper + '" class="btn btn-info" target="_blank">Ver</a></td><td class="align-baseline text-center">' + item.fecha_ingreso.substring(0, 10) + '</td><td class="align-baseline">' + item.clooper + '</td><td class="align-baseline">' + item.tecnico + '</td><td class="align-baseline text-center">' + item.empresa + '</td><td class="align-baseline">NO</td><td class="align-baseline">' + item.observaciones + '</td><td class="align-baseline text-center"><a href="monitoreos_formload_pendiente2.aspx?id_pendiente=' + item.id_pendiente + '&recurso=' + item.id_clooper + '&tec=' + item.tecnico + '&dni=' + item.dni + '&empre=' + item.empresa + '" class="btn btn-primary">Trabajar</a></td></tr>');
                    resultados.append('<tr><td class="align-baseline text-center"><a href="monitoreos_formload.aspx?param=' + item.bandera + '&tec=' + item.id_clooper + '" class="btn btn-info" target="_blank">Ver</a>&nbsp;&nbsp;<button class="btn btn-success" onclick="confirma_ok_bandeja_monitoreos(' + item.id_pendiente + ', ' + contador + ')">Confirmar OK</button></td><td><textarea id="txt_obs_' + contador + '" rows="2" cols="30"></textarea></td><td class="align-baseline text-center">' + item.fecha_ingreso.substring(0, 10) + '</td><td class="align-baseline">' + item.clooper + '</td><td class="align-baseline">' + item.tecnico + '</td><td class="align-baseline text-center">' + item.empresa + '</td><td class="align-baseline">' + item.observaciones + '</td></tr>');
                }
                else {
                    if (contador == 1) {
                        resultados.append('<thead><tr><th>&nbsp;</th><th>FECHA MONITOREO</th><th>AUDITOR</th><th>TECNICO</th><th class="text-center">EMPRESA</th><th>MOTIVO CALIBRACION</th></tr></thead>');
                    }
                    resultados.append('<tr><td class="align-baseline text-center"><a href="monitoreos_formload.aspx?param=' + item.bandera + '&tec=' + item.id_clooper + '" class="btn btn-info" target="_blank">Ver</a></td><td class="align-baseline text-center">' + item.fecha_ingreso.substring(0, 10) + '</td><td class="align-baseline">' + item.clooper + '</td><td class="align-baseline">' + item.tecnico + '</td><td class="align-baseline text-center">' + item.empresa + '</td><td class="align-baseline">' + item.observaciones + '</td></tr>');
                }
                contador = contador + 1;
            });
            resultados.append('</tbody>');
        }
    });
}

function confirma_ok_bandeja_monitoreos(id_gestion, cont) {
    if (confirm("Est\u00E1a por confirmar que este monitoreo ya fue solucionado y est\u00E1 listo para su revisi\u00F3n. Desea confirmar?")) {
        var texto_ctta = document.getElementById("txt_obs_" + cont).value;
        //alert(texto_ctta);

        $.ajax({
            url: "servicios_monitoreos.asmx/monitoreos_ok_ctta",
            method: 'post',
            data: { id_gestion: id_gestion, comentario: texto_ctta },
            dataType: "html",
            success: function (datos) {
                alert("Se ha confirmado OK. En breve este monitoreo ser\u00E1 revisado por un gestor.");
            },
            error: function (jqXHR, exception) {
                //alert("Hubo un error al consultar detalle! ");
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
}
//////////////////////////////////////////FIN BANDEJA NO APTOS y PROVISORIOS////////////////////////////////////////77//
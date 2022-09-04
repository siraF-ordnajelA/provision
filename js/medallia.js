////////////////////////////////////////////FORMULARIO PRINCIPAL/////////////////////////////////////////////
function buscar() {
    document.getElementById("btn_busca").disabled = true;
    var boton_buscar = document.getElementById('btn_busca');
    boton_buscar.innerText = "Buscando...";

    var id_cliente = document.getElementById("txt_cliente").value;
    var dni_tecnico = document.getElementById("txt_dni_tecnico").value;
    var id_encuesta = document.getElementById("txt_idencuesta").value;

    var cliente = $('#txt_nombre');
    var segmento = $('#txt_segmento');
    var tecnologia = $('#txt_tecno');
    var direccion = $('#txt_direccion');
    var localidad = $('#txt_localidad');
    var tel_contacto = $('#txt_contacto');
    var tecnico = $('#txt_tecnico');
    var id_rec = $('#lbl_idrecurso');
    var empresa = $('#txt_empresa');
    var orden = $('#txt_orden');
    var access_id = $('#txt_accessid');
    var bucket = $('#txt_bucket');
    var id_central = $('#lbl_idcentral');
    var gerencia = $('#txt_gerencia');
    var distrito = $('#txt_distrito');
    var central = $('#txt_central');
    var sw = 0;

    if (id_cliente != "" && dni_tecnico != "") {
        $.ajax({
            url: "servicios_medallia.asmx/busca_toa",
            method: 'post',
            data: { id_cliente: id_cliente, dni: dni_tecnico, id_encuesta: "0", opc: 1 },
            dataType: "json",
            success: function (datos) {
                cliente.empty();
                segmento.empty();
                direccion.empty();
                localidad.empty();
                tel_contacto.empty();
                tecnico.empty();
                id_rec.empty();
                empresa.empty();
                orden.empty();
                access_id.empty();
                bucket.empty();
                gerencia.empty();
                distrito.empty();
                central.empty();
                id_central.empty();
                $(datos).each(function (index, item) {
                    cliente.val(item.cliente);
                    segmento.val(item.segmento);
                    tecnologia.val(item.tecnologia);
                    direccion.val(item.direccion);
                    localidad.val(item.distrito_atc);
                    tel_contacto.val(item.contacto);
                    tecnico.val(item.tecnico);
                    id_rec.html(item.id_recurso);
                    empresa.val(item.empresa);
                    orden.val(item.orden);
                    access_id.val(item.access);
                    bucket.val(item.bucket);
                    gerencia.val(item.gerencia);
                    distrito.val(item.distrito);
                    central.val(item.central);
                    id_central.html(item.id_central);
                    sw = sw + 1;
                });

                document.getElementById("btn_busca").disabled = false;
                boton_buscar.innerText = "Buscar";

                if (sw == 0) {
                    alert("No se encontraron resultados.");
                }
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

                document.getElementById("btn_busca").disabled = false;
                boton_buscar.innerHTML = "Buscar";
            }
        });
    }
    else {
        alert("Debe completar el ID del cliente y el DNI del t\u00E9cnico.");
    }
}

function lista_cbo_contratas(centro) {
    var cbo_contratas_B = $('#cbo_ctta');

    if (centro != "TASA") {
        document.getElementById('div_ctta_cbo').style.display = 'none';
    }
    //else {
        $.ajax({
            url: "servicios_medallia.asmx/obtener_contratas",
            method: 'post',
            dataType: "json",
            success: function (datos) {
                cbo_contratas_B.empty();
                cbo_contratas_B.append($('<option/>', { value: 0, text: "-- TODAS --" }));
                $(datos).each(function (index, item) {
                    cbo_contratas_B.append($('<option/>', { value: item.ID_RECURSO, text: item.ctta }));
                });
            }
        });
    //}
}

function lista_seleccion_cbo_user(opc) {
    var cbo_usuario_A = document.getElementById("cbo_select_user");
    //var text_cbo_usuario = cbo_usuario_A.options[cbo_usuario_A.selectedIndex].text
    //alert("Id usuario: " + cbo_usuario_A.value + " / Usuario: " + text_cbo_usuario);

    if (cbo_usuario_A.value == 0) {
        lista_todos_por_bandeja(opc);
    }
    else {
        switch (opc) {
            case 0: lista_cerrados(cbo_usuario_A.value, "TASA");
                     break;
            case 1: lista_escalados(cbo_usuario_A.value, "TASA");
                     break;
            case 2: lista_pendientes(cbo_usuario_A.value, "TASA");
                     break;
            case 3: ista_soporte(cbo_usuario_A.value, "TASA");
                     break;
            case 4: lista_refuerzos (cbo_usuario_A.value, "TASA");
        }
    }
}

function lista_todos_por_bandeja(opcion, usuario, centro) {
    var resultados = $('#t1');

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    if (document.getElementById('chk_todos').checked) {
        resultados.append('<thead><tr><th align="center">CLOOPER</th><th align="center">ID ENCUESTA</th><th align="center">ACCESS ID</th><th align="center">TECNICO</th><th align="center">EMPRESA</th><th align="center">FECHA INICIO</th><th align="center">FECHA CIERRE</th></tr></thead>');

        $.ajax({
            url: "servicios_medallia.asmx/medallia_lista_todos", //Llama al webmethod "obtener_gerencia" del lado servidor
            method: 'post',
            data: { parametro_opcion: opcion },
            dataType: "json",
            success: function (datos) {
                resultados.append('<tbody>');
                $(datos).each(function (index, item) {
                    resultados.append('<tr><td>' + item.tecnico + '</td><td align="center"><a href="medallia_formload.aspx?param=' + item.instalaciones + '&opc=' + opcion + '">' + item.garantias + '</a></td><td align="center">' + item.access + '</td><td>' + item.calificacion + '</td><td>' + item.empresa + '</td><td align="center">' + item.fecha_inicio + '</td><td align="center">' + item.fecha_fin + '</td></tr>');
                });
                resultados.append('</tbody>');
            }
        });
    }
    else {
        switch (opcion) {
            case 0: lista_cerrados(usuario, centro); // CERRADOS
                    break;
            case 1: lista_escalados(usuario, centro); // ESCALADOS CTTA
                    break;
            case 2: lista_pendientes(usuario, centro); // PENDIENTES CLOOPER
                    break;
            case 3: lista_soporte(usuario, centro); // SOPORTE SISTEMAS
                    break;
            case 4: lista_refuerzos(usuario, centro); // REFUERZOS
        }
    }
}

function cbo_motivo_clase() {
    var valor_cbo_detraccion = document.getElementById("cbo_motivo_detraccion").value;
    var cbo_estado = document.getElementById("cbo_estado");
    var cbo_concepto = $('#cbo_concepto');
    var cbo_subconcepto = $('#cbo_sub_concepto');
    var cbo_detalle = $('#cbo_detalle');

    $.ajax({
        url: "servicios_medallia.asmx/obtener_conceptos",
        method: 'post',
        data: { id_detraccion: valor_cbo_detraccion },
        dataType: "json",
        success: function (datos) {
            cbo_concepto.empty();
            if (valor_cbo_detraccion == 0) { cbo_concepto.append($('<option/>', { value: 0, text: "--Debe seleccionar motivo--" })); }
            if (valor_cbo_detraccion == 1) { cbo_concepto.append($('<option/>', { value: 0, text: "--Seleccione concepto comercial--" })); }
            if (valor_cbo_detraccion == 2) { cbo_concepto.append($('<option/>', { value: 0, text: "--Seleccione concepto técnico--" })); }
            if (valor_cbo_detraccion == 3) { cbo_concepto.append($('<option/>', { value: 0, text: "--Seleccione concepto cliente--" })); }
            if (valor_cbo_detraccion == 4) { cbo_concepto.append($('<option/>', { value: 0, text: "--Seleccione concepto despacho--" })); }
            cbo_subconcepto.empty();
            cbo_subconcepto.append($('<option/>', { value: 0, text: "--Debe seleccionar concepto--" }));
            cbo_detalle.empty();
            cbo_detalle.append($('<option/>', { value: 0, text: "--Debe seleccionar sub-concepto--" }));

            $(datos).each(function (index, item) {
                cbo_concepto.append($('<option/>', { value: item.ID_TOA, text: item.Ingresante }));
            });
        }
    });
}

function cbo_subconcepto() {
    var valor_cbo_concepto = document.getElementById("cbo_concepto").value;
    var cbo_concepto = $('#cbo_concepto');
    var cbo_sub_concepto = $('#cbo_sub_concepto');
    var cbo_detalle = $('#cbo_detalle');

    $.ajax({
        url: "servicios_medallia.asmx/obtener_subconceptos",
        method: 'post',
        data: { id_concepto: valor_cbo_concepto },
        dataType: "json",
        success: function (datos) {
            cbo_sub_concepto.empty();
            cbo_sub_concepto.append($('<option/>', { value: 0, text: "--Seleccione sub concepto--" }));
            cbo_detalle.empty();
            cbo_detalle.append($('<option/>', { value: 0, text: "--Debe seleccionar sub-concepto--" }));

            $(datos).each(function (index, item) {
                cbo_sub_concepto.append($('<option/>', { value: item.ID_TOA, text: item.Ingresante }));
            });
        }
    });
}

function cbo_detail() {
    var valor_cbo_subconcepto = document.getElementById("cbo_sub_concepto").value;
    var cbo_detalle = $('#cbo_detalle');

    $.ajax({
        url: "servicios_medallia.asmx/obtener_detalles",
        method: 'post',
        data: { id_subconcepto: valor_cbo_subconcepto },
        dataType: "json",
        success: function (datos) {
            cbo_detalle.empty();
            cbo_detalle.append($('<option/>', { value: 0, text: "--Seleccione detalle--" }));

            $(datos).each(function (index, item) {
                cbo_detalle.append($('<option/>', { value: item.ID_TOA, text: item.Ingresante }));
            });
        }
    });
}

function cbo_accion_ejecutada() {
    var valor_cbo_accion = document.getElementById("cbo_accion").value;
    var cbo_estado_A = document.getElementById("cbo_estado");
    var cbo_estado_B = $('#cbo_estado');
    var cbo_gest_clooper = document.getElementById("cbo_gest_clooper");

    switch (valor_cbo_accion) {
        case "0": 
            cbo_estado_A.disabled = true;
            cbo_estado_A.options.item(0).selected = 'selected';
            cbo_gest_clooper.disabled = true;
            cbo_gest_clooper.item(0).selected = 'selected';
            break;
        case "1": cbo_estado_A.disabled = false;
            cbo_estado_A.options.item(0).selected = 'selected';
            // Deshabilita la opción de estado: CERRADO y PENDIENTE
            let option1 = cbo_estado_A.querySelector('option[value="1"]');
            option1.disabled = true;
            let option2 = cbo_estado_A.querySelector('option[value="3"]');
            option2.disabled = true;
            let option11 = cbo_estado_A.querySelector('option[value="2"]');
            option11.disabled = false;
            let option12 = cbo_estado_A.querySelector('option[value="4"]');
            option12.disabled = false;

            cbo_gest_clooper.disabled = true;
            cbo_gest_clooper.item(0).selected = 'selected';
            break;
        case "2": cbo_estado_A.disabled = false;
            cbo_estado_A.options.item(0).selected = 'selected';
            // Deshabilita la opción de estado: ESCALADO, REFUERZO y PENDIENTE
            let option3 = cbo_estado_A.querySelector('option[value="2"]');
            option3.disabled = true;
            let option4 = cbo_estado_A.querySelector('option[value="3"]');
            option4.disabled = true;
            let option5 = cbo_estado_A.querySelector('option[value="4"]');
            option5.disabled = true;
            let option13 = cbo_estado_A.querySelector('option[value="1"]');
            option13.disabled = false;

            cbo_gest_clooper.disabled = true;
            cbo_gest_clooper.item(0).selected = 'selected';
            break;
        case "3": cbo_estado_A.disabled = false;
            cbo_estado_A.options.item(0).selected = 'selected';
            // Deshabilita la opción de estado: CERRADO, REFUERZO y PENDIENTE
            let option6 = cbo_estado_A.querySelector('option[value="1"]');
            option6.disabled = true;
            let option7 = cbo_estado_A.querySelector('option[value="3"]');
            option7.disabled = true;
            let option8 = cbo_estado_A.querySelector('option[value="4"]');
            option8.disabled = true;
            let option14 = cbo_estado_A.querySelector('option[value="2"]');
            option14.disabled = false;

            cbo_gest_clooper.disabled = true;
            cbo_gest_clooper.item(0).selected = 'selected';
            break;
        case "4": cbo_estado_A.disabled = false;
            cbo_estado_A.options.item(0).selected = 'selected';
            // Habilita todo
            let option9 = cbo_estado_A.querySelector('option[value="2"]');
            option9.disabled = false;
            let option10 = cbo_estado_A.querySelector('option[value="3"]');
            option10.disabled = false;
            let option15 = cbo_estado_A.querySelector('option[value="1"]');
            option15.disabled = false;
            let option16 = cbo_estado_A.querySelector('option[value="4"]');
            option16.disabled = false;

            cbo_gest_clooper.disabled = false;
            cbo_gest_clooper.item(0).selected = 'selected';
    }
}

function cambia_cbo_resp_supervisor() {
    var valor_resp_sup = document.getElementById("cbo_resp_supervisor").value;
    var txt_sn_anterior = document.getElementById("txt_sn_anterior");
    var txt_sn_actual = document.getElementById("txt_sn_actual");

    if (valor_resp_sup == 3 || valor_resp_sup == 4 || valor_resp_sup == 9 || valor_resp_sup == 10 || valor_resp_sup == 12 || valor_resp_sup == 13 || valor_resp_sup == 15 || valor_resp_sup == 16) {
        txt_sn_anterior.disabled = false;
        txt_sn_actual.disabled = false;
    }
    else {
        txt_sn_anterior.disabled = true;
        txt_sn_actual.disabled = true;
        txt_sn_anterior.value = "";
        txt_sn_actual.value = "";
    }
}

function cbo_motivo_llamado() {
    var valor_cbo_respuesta2 = document.getElementById("cbo_resp_2").value;
    var cbo_accion = document.getElementById("cbo_accion");
    //var texto_resp_final_cliente = document.getElementById("txt_resp_final_cliente");

    if (valor_cbo_respuesta2 == "4") {
        texto_resp_final_cliente.disabled = false;
    }
    else {
        texto_resp_final_cliente.disabled = true;
        texto_resp_final_cliente.value = "";
    }

    if (valor_cbo_respuesta2 == "5") {
        cbo_accion.options.item(1).selected = 'selected';
        //cbo_accion.disabled = true;
    }
    else {
        cbo_accion.options.item(0).selected = 'selected';
        //cbo_accion.disabled = false;
    }
}

var switch_blink = 0;

function carga_cant_casos(usuario, centro) {
    const favicon = document.getElementById("favicon");
    var pendientes_clooper = $("#span_clooper");
    var gestion_ctta = $("#span_ctta");
    var gestion_refuerzo = $("#span_refuerzo");
    var soporte_sistemas = $("#span_soporte_sistemas");
    var bandejas_total = $("#span_bandejas_total");

    var pendientes_gestor = $("#span_pendientes_gestor");
    var pendientes_monitoreos = $("#span_monitoreos_pendientes");
    var monitoreos_provisorios = $("#span_monitoreos_provisorios");
    var monitoreos_no_aptos = $("#span_monitoreos_no_aptos");
    var monitoreos_totales = $("#span_monitoreos_totales");

    var total = 0;
    var total2 = 0;
    var total3 = 0;

    $.ajax({
        url: "servicios_medallia.asmx/contador_casos",
        method: 'post',
        data: { parametro_user: usuario, parametro_centro: centro },
        dataType: "json",
        success: function (datos) {
            pendientes_clooper.empty();
            gestion_ctta.empty();
            gestion_refuerzo.empty();
            soporte_sistemas.empty();
            pendientes_gestor.empty();
            pendientes_monitoreos.empty();
            monitoreos_provisorios.empty();
            monitoreos_no_aptos.empty();
            monitoreos_totales.empty();

            $(datos).each(function (index, item) {
                if (item.pend_clooper != '0' && centro == 'TASA') { pendientes_clooper.append(item.pend_clooper); setInterval (blinkFavicon, 1000); }
                if (item.escalados != '0') { gestion_ctta.append(item.escalados); setInterval (blinkFavicon, 1000); }
                if (item.refuerzos != '0') { gestion_refuerzo.append(item.refuerzos); setInterval (blinkFavicon, 1000); }
                if (item.sistemas != '0' && centro == 'TASA') { soporte_sistemas.append(item.sistemas); setInterval (blinkFavicon, 1000); }
                if (item.pend_monitoreo != '0' && centro == 'TASA') { pendientes_monitoreos.append(item.pend_monitoreo); setInterval (blinkFavicon, 1000); }
                if (item.pend_gestor != '0' && centro == 'TASA') { pendientes_gestor.append(item.pend_gestor); setInterval (blinkFavicon, 1000); }
                if (item.provisorios != '0') { monitoreos_provisorios.append(item.provisorios); setInterval (blinkFavicon, 1000); }
                if (item.noaptos != '0') { monitoreos_no_aptos.append(item.noaptos); setInterval (blinkFavicon, 1000); }
                total = parseInt(item.pend_clooper) + parseInt(item.escalados) + parseInt(item.refuerzos) + parseInt(item.sistemas);
                total2 = parseInt(item.escalados) + parseInt(item.refuerzos);
                total3 = parseInt(item.pend_monitoreo) + parseInt(item.pend_gestor) + parseInt(item.provisorios) + parseInt(item.noaptos);

                if (total != 0 && centro == 'TASA') { bandejas_total.append(total); monitoreos_totales.append(total3); notificaciones_tasa(item.pend_clooper, item.escalados, item.refuerzos, item.sistemas); };
                if (total2 != 0 && centro != 'TASA') { bandejas_total.append(total2); notificaciones_notasa(item.escalados, item.refuerzos); };
                if (total3 != 0 && centro != 'TASA') { total3 = total3 - parseInt(item.pend_gestor) - parseInt(item.pend_monitoreo); monitoreos_totales.append(total3); };
            });
        }
    });
}

function blinkFavicon () {
    if (switch_blink == 0) {
        favicon.setAttribute("href", "imagenes/Favempire_32_Red.png");
        switch_blink = 1;
    }
    else {
        favicon.setAttribute("href", "imagenes/Favempire_32_Black.png");
        switch_blink = 0;
    }
}

function notificaciones_tasa(total_clooper, total_escalados, total_refuerzos, total_sistemas) {
    var total = parseInt(total_clooper) + parseInt(total_escalados) + parseInt(total_refuerzos) + parseInt(total_sistemas);
    var div_padre = document.getElementById("div_notificaciones");
    
    var div = document.createElement("div");
    div.className = "dropdown-divider";
    var href1 = document.createElement("a");
    href1.className = "dropdown-item";
    var href2 = document.createElement("a");
    href2.className = "dropdown-item";
    var href3 = document.createElement("a");
    href3.className = "dropdown-item";
    var href4 = document.createElement("a");
    href4.className = "dropdown-item";

    if (total != 0) {
        $("#span_total_notificaciones").append(total);
        $("#span_total_notificaciones_titulo").append(total + " Notificaciones");

        if (parseInt(total_clooper) > 0)
        {
            //alert('total_clooper: ' + total_clooper);
            href1.setAttribute('id','href_indicador_clooper');
            href1.setAttribute('href','medallia_lista_pendientes.aspx');
            div_padre.appendChild(div);
            div_padre.appendChild(href1);

            document.getElementById("href_indicador_clooper").innerHTML = '<i class="fa fa-bomb mr-2"></i> ' + total_clooper + ' caso/s en Gesti&oacute;n clooper';
        }
        if (parseInt(total_escalados) > 0)
        {
            //alert('total_escalados: ' + total_escalados);
            href2.setAttribute('id','href_indicador_escalados');
            href2.setAttribute('href','medallia_lista_escalados.aspx');
            div_padre.appendChild(div);
            div_padre.appendChild(href2);

            document.getElementById("href_indicador_escalados").innerHTML = '<i class="fa fa-bomb mr-2"></i> ' + total_escalados + ' caso/s en la bandeja de Gesti&oacute;n ctta';
        }
        if (parseInt(total_refuerzos) > 0)
        {
            //alert('total_refuerzos: ' + total_refuerzos);
            href3.setAttribute('id','href_indicador_refuerzos');
            href3.setAttribute('href','medallia_lista_refuerzos.aspx');
            div_padre.appendChild(div);
            div_padre.appendChild(href3);
            
            document.getElementById("href_indicador_refuerzos").innerHTML = '<i class="fa fa-bomb mr-2"></i> ' + total_refuerzos + ' caso/s en la bandeja de Refuerzos';
        }
        if (parseInt(total_sistemas) > 0)
        {
            //alert('total_sistemas: ' + total_sistemas);
            href4.setAttribute('id','href_indicador_sistemas');
            href4.setAttribute('href','medallia_lista_soporte.aspx');
            div_padre.appendChild(div);
            div_padre.appendChild(href4);

            document.getElementById("href_indicador_sistemas").innerHTML = '<i class="fa fa-bomb mr-2"></i> ' + total_sistemas + ' caso/s en la bandeja de Sistemas';
        }
    }
    else {
        document.getElementById('li_notificaciones').style.display = 'none';
    }
}

function notificaciones_notasa(total_escalados, total_refuerzos) {
    var total = parseInt(total_escalados) + parseInt(total_refuerzos);
    var div_padre = document.getElementById("div_notificaciones");
    
    var div = document.createElement("div");
    div.className = "dropdown-divider";
    var href1 = document.createElement("a");
    href1.className = "dropdown-item";
    var href2 = document.createElement("a");
    href2.className = "dropdown-item";
    var href3 = document.createElement("a");
    href3.className = "dropdown-item";

    if (total != 0) {
        $("#span_total_notificaciones").append(total);
        $("#span_total_notificaciones_titulo").append(total + " Notificaciones");

        if (parseInt(total_escalados) > 0)
        {
            //alert('total_escalados: ' + total_escalados);
            href2.setAttribute('id','href_indicador_escalados');
            href2.setAttribute('href','medallia_lista_escalados.aspx');
            div_padre.appendChild(div);
            div_padre.appendChild(href2);

            document.getElementById("href_indicador_escalados").innerHTML = '<i class="fa fa-bomb mr-2"></i> ' + total_escalados + ' caso/s en la bandeja de Gesti&oacute;n ctta';
        }
        if (parseInt(total_refuerzos) > 0)
        {
            //alert('total_refuerzos: ' + total_refuerzos);
            href3.setAttribute('id','href_indicador_refuerzos');
            href3.setAttribute('href','medallia_lista_refuerzos.aspx');
            div_padre.appendChild(div);
            div_padre.appendChild(href3);
            
            document.getElementById("href_indicador_refuerzos").innerHTML = '<i class="fa fa-bomb mr-2"></i> ' + total_refuerzos + ' caso/s en la bandeja de Refuerzos';
        }
    }
    else {
        document.getElementById('li_notificaciones').style.display = 'none';
    }
}

function guardar() {
    //Datos clooper
    var motivo = document.getElementById("cbo_motivo").value;
    var contexto = document.getElementById("cbo_contexto").value;
    var id_clooper = document.getElementById("lbl_id_user").innerText;
    //Datos de busqueda
    var id_cliente = document.getElementById("txt_cliente").value;
    var id_recurso = document.getElementById("lbl_idrecurso").innerText;
    var id_encuesta = document.getElementById("txt_idencuesta").value;
    var nombre = document.getElementById("txt_nombre").value;
    var direccion = document.getElementById("txt_direccion").value;
    var localidad = document.getElementById("txt_localidad").value;
    var tel_contacto = document.getElementById("txt_contacto").value;
    var orden = document.getElementById("txt_orden").value;
    var access = document.getElementById("txt_accessid").value;
    var bucket = document.getElementById("txt_bucket").value;
    var id_central = document.getElementById("lbl_idcentral").innerText;
    var empresa = document.getElementById("txt_empresa").value;
    var segmento = document.getElementById("txt_segmento").value;
    var tecnologia = document.getElementById("txt_tecno").value;
    //Fechas
    var fecha_encuesta = document.getElementById("dat_encuesta").value;
    fecha_encuesta = fecha_encuesta.replace("-", "");
    fecha_encuesta = fecha_encuesta.replace("-", "");
    fecha_encuesta = fecha_encuesta.replace("/", "");
    fecha_encuesta = fecha_encuesta.replace("/", "");
    //Calificacion
    var nps = document.getElementById("cbo_nps").value;
    var tecnico = document.getElementById("cbo_tecnico").value;
    var puntualidad = document.getElementById("cbo_puntu").value;
    var profesionalidad = document.getElementById("cbo_profe").value;
    var conocimiento = document.getElementById("cbo_conocimiento").value;
    var calidad = document.getElementById("cbo_calidad").value;
    var comunicacion = document.getElementById("cbo_comunica").value;
    //ESTADO - MOTIVO - CONCEPTO
    var motivo_detractor = document.getElementById("cbo_motivo_detraccion").value;
    var concepto = document.getElementById("cbo_concepto").value;
    var subconcepto = document.getElementById("cbo_sub_concepto").value;
    var detalle = document.getElementById("cbo_detalle").value;
    var estado = document.getElementById("cbo_estado").value;
    //ACCION EJECUTADA - GESTION CLOOPER
    var accion = document.getElementById("cbo_accion").value;
    var gest_clooper = document.getElementById("cbo_gest_clooper").value;
    //RESPUESTAS CLIENTE Y SUPERVISOR
    var respuesta = document.getElementById("cbo_resp_2").value;
    var comentarios_cliente = document.getElementById("txt_comentarios_cliente").value;
    var respuesta_final_cliente = 1 //document.getElementById("cbo_resp_final_cliente").value; YA NO VA?????????????
    var respuesta_supervisor = document.getElementById("txt_resp_supervisor").value;
    var cbo_respuesta_supervisor = document.getElementById("cbo_resp_supervisor").value;

    var chequeo_total = 0;
    
    if (motivo == "0" || contexto == "0") {
        alert("Debe seleccionar el motivo Medallia y Contexto");
        chequeo_total = 1;
    }
    if (id_cliente == "" && id_encuesta == "" && id_recurso == "") {
        alert("Debe cargar una encuesta llenando los campos ID del cliente, ID del t\u00E9cnico e ID de encuesta");
        chequeo_total = 1;
    }
    if (fecha_encuesta == "") {
        alert("Debe ingresar la fecha en que se realiz\u00F3 la encuesta Medallia");
        chequeo_total = 1;
    }
    if (motivo_detractor == "0" || concepto == "0" || subconcepto == "0" || detalle == "0") {
        alert("Debe seleccionar todos los combos de MOTIVO");
        chequeo_total = 1;
    }
    if (estado == "0" || accion == "0") {
        alert("Debe seleccionar ACCION EJECUTADA y ESTADO");
        chequeo_total = 1;
    }
    else {
        if (accion == "4" && gest_clooper  == "0") {
            alert("Debe seleccionar GESTION DEL CLOOPER");
            chequeo_total = 1;
        }
    }
    if (comentarios_cliente == "" || respuesta == "0") {
        alert("Debe completar los comentarios del cliente en Medallia y la Respuesta del cliente");
        chequeo_total = 1;
    }

    if (chequeo_total == 0) {
        /*
        alert(motivo + "-" + contexto);
        alert("ID Clooper: " + id_clooper + " - ID Cliente: " + id_cliente + " - ID recurso: " + id_recurso + " - ID encuesta: " + id_encuesta);
        alert(fecha_encuesta);
        alert(nombre);
        alert(direccion);
        alert(localidad);
        alert(tel_contacto);
        alert(orden);
        alert(bucket);
        alert(empresa);
        alert("nps: " + nps);
        alert("tecnico: " + tecnico);
        alert("puntualidad: " + puntualidad);
        alert("profesionalidad: " + profesionalidad);
        alert("conocimiento" + conocimiento);
        alert("calidad" + calidad);
        alert("comunica: " + comunicacion);
        alert("Mot.detractor: " + motivo_detractor);
        alert("concepto: " + concepto);
        alert("subconcepto" + subconcepto);
        alert("concepto: " + detalle);
        alert("accion: " + accion);
        alert("estado: " + estado);
        alert("gest. clooper: " + gest_clooper);
        alert("comentarios cli: " + comentarios_cliente);
        alert("respuesta" + respuesta);
        alert("resp final cliente" + respuesta_final_cliente);
        */
        $.ajax({
            url: "servicios_medallia.asmx/guardado_1",
            method: 'post',
            data: { mot: motivo,
                contex: contexto,
                id_clooper: id_clooper,
                id_cliente: id_cliente,
                id_recurso: id_recurso,
                id_encu: id_encuesta,
                fecha: fecha_encuesta,
                nom: nombre,
                dire: direccion,
                loca: localidad,
                tel: tel_contacto,
                orden: orden,
                access_id: access,
                bucket: bucket,
                central: id_central,
                segmento: segmento,
                tecno: tecnologia,
                ctta: empresa,
                nps: nps,
                tec: tecnico,
                puntu: puntualidad,
                profe: profesionalidad,
                conocimiento: conocimiento,
                calidad: calidad,
                comu: comunicacion,
                motivo: motivo_detractor,
                concepto: concepto,
                sub: subconcepto,
                detalle: detalle,
                accion: accion,
                estado: estado,
                gestion_clooper: gest_clooper,
                comentarios_cliente: comentarios_cliente,
                resp_cliente: respuesta,
                resp_final_cliente: respuesta_final_cliente
            },
            dataType: "json",
            success: function (datos) {
                $(datos).each(function (index, item) {
                    alert(item.ctta);
                    setTimeout("redireccionar_inicio()", 500);
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
    else {
        alert("Falta completar algun campo!");
    }
}
//////////////////////////////////////////FIN FORMULARIO PRINCIPAL///////////////////////////////////////////77

//////////////////////////////////////////////BANDEJA CERRADOS///////////////////////////////////////////77////
function lista_cerrados(user, centro) {
    var resultados = $('#t1');

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    resultados.append('<thead><tr><th align="center">CLOOPER</th><th align="center">ID ENCUESTA</th><th align="center">ACCESS ID</th><th align="center">TECNICO</th><th align="center">EMPRESA</th><th align="center">FECHA INICIO</th><th align="center">FECHA CIERRE</th></tr></thead>');

    $.ajax({
        url: "servicios_medallia.asmx/medallia_lista_casos", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { parametro_user: user, parametro_centro: centro, id_caso: 0, opcion: 0 },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tbody>');
            $(datos).each(function (index, item) {
                //resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);">' + item.tecnico + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><a href="medallia_formload.aspx?param=' + item.instalaciones + '&opc=0">' + item.garantias + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.fecha_inicio + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.fecha_fin + '</td></tr>');
                resultados.append('<tr><td>' + item.tecnico + '</td><td align="center"><a href="medallia_formload.aspx?param=' + item.instalaciones + '&opc=0">' + item.garantias + '</a></td><td align="center">' + item.access + '</td><td>' + item.calificacion + '</td><td>' + item.empresa + '</td><td align="center">' + item.fecha_inicio + '</td><td align="center">' + item.fecha_fin + '</td></tr>');
            });
            resultados.append('</tbody>');
        }
    });
}
///////////////////////////////////////////FIN BANDEJA CERRADOS///////////////////////////////////////////77///

/////////////////////////////////////////////BANDEJA ESCALADOS///////////////////////////////////////////77////
function lista_escalados(user, centro) {
    var resultados = $('#t1');

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    resultados.append('<thead><tr><th align="center">CLOOPER</th><th align="center">ID ENCUESTA</th><th align="center">ACCESS ID</th><th align="center">TECNICO</th><th align="center">EMPRESA</th><th align="center">FECHA INICIO</th><th align="center">FECHA CIERRE</th></tr></thead>');

    $.ajax({
        url: "servicios_medallia.asmx/medallia_lista_casos", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { parametro_user: user, parametro_centro: centro, id_caso: 0, opcion: 1 },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tbody>');
            $(datos).each(function (index, item) {
                //resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);">' + item.tecnico + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><a href="medallia_formload.aspx?param=' + item.instalaciones + '&opc=1">' + item.garantias + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.access + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.calificacion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.fecha_inicio + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.fecha_fin + '</td></tr>');
                resultados.append('<tr><td>' + item.tecnico + '</td><td align="center"><a href="medallia_formload.aspx?param=' + item.instalaciones + '&opc=1">' + item.garantias + '</a></td><td align="center">' + item.access + '</td><td>' + item.calificacion + '</td><td>' + item.empresa + '</td><td align="center">' + item.fecha_inicio + '</td><td align="center">' + item.fecha_fin + '</td></tr>');
            });
            resultados.append('</tbody>');
        }
    });
}

function guardar_escalado() {
    var id_caso = document.getElementById("lbl_idrecurso").innerHTML;
    //RESPUESTAS CLIENTE Y SUPERVISOR
    var respuesta_supervisor = document.getElementById("txt_resp_supervisor").value;
    var cbo_respuesta_supervisor = document.getElementById("cbo_resp_supervisor").value;
    var txt_sn_anterior = document.getElementById("txt_sn_anterior").value;
    var txt_sn_actual = document.getElementById("txt_sn_actual").value;

    if (respuesta_supervisor == "" || cbo_respuesta_supervisor == 0) {
        alert("Debe completar el campo de texto encabezando su nombre y apellido y debe seleccionar la gesti\u00F3n del combo ");
    }
    else {
        $.ajax({
            url: "servicios_medallia.asmx/guardado_2",
            method: 'post',
            data: { id_caso: id_caso, resp_sup: respuesta_supervisor, cbo_resp_sup: cbo_respuesta_supervisor, sn_anterior: txt_sn_anterior, sn_actual: txt_sn_actual },
            dataType: "html",
            success: function (datos) {
                alert("Guardado exitoso");
                setTimeout("redireccionar_inicio()", 1000);
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

function reagenda_escalado() {
    var id_caso = document.getElementById("lbl_idrecurso").innerHTML;
    
    if (document.getElementById('chk_reagenda').checked) {
        var chk_reagendado = 1;
    }
    else {
        var chk_reagendado = 0;
    }

    if (confirm("Seguro desea guardar regendado?")) {
        //alert ("Valor CHK: " + chk_reagendado + " - ID caso: " + id_caso)
        $.ajax({
            url: "servicios_medallia.asmx/guardado_2_reagenda",
            method: 'post',
            data: { id_caso: id_caso, chk_reagenda: chk_reagendado },
            dataType: "html",
            success: function (datos) {
                alert("Reagendado exitoso");
                //setTimeout("redireccionar_inicio()", 500);
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
/////////////////////////////////////////FIN BANDEJA ESCALADOS///////////////////////////////////////////77////

///////////////////////////////////////////BANDEJA PENDIENTES///////////////////////////////////////////77/////
function lista_pendientes(user, centro) {
    var resultados = $('#t1');

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    //resultados.append('<tr><td style="background-color:rgba(165, 23, 23, 0.5);" align="center" colspan="11"><b>BANDEJA PENDIENTES CLOOPER</b></td></tr>');
    //resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>CLOOPER</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>ID ENCUESTA</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>EMPRESA</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>FECHA INICIO</b></td><td style="background-color:rgba(41, 97, 132, 0.7);" align="center"><b>FECHA CIERRE CONTRATISTA</b></td></tr>');
    resultados.append('<thead><tr><th align="center">CLOOPER</th><th align="center">ID ENCUESTA</th><th align="center">ACCESS ID</th><th align="center">TECNICO</th><th align="center">EMPRESA</th><th align="center">FECHA INICIO</th><th align="center">FECHA CIERRE</th></tr></thead>');

    $.ajax({
        url: "servicios_medallia.asmx/medallia_lista_casos", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { parametro_user: user, parametro_centro: centro, id_caso: 0, opcion: 2 },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tbody>');
            $(datos).each(function (index, item) {
                resultados.append('<tbody><tr><td>' + item.tecnico + '</td><td align="center"><a href="medallia_formload.aspx?param=' + item.instalaciones + '&opc=2">' + item.garantias + '</a></td><td align="center">' + item.access + '</td><td align="center">' + item.calificacion + '</td><td align="center">' + item.empresa + '</td><td align="center">' + item.fecha_inicio + '</td><td align="center">' + item.fecha_fin + '</td></tr></tbody>');
            });
            resultados.append('</tbody>');
        }
    });
}

function guardar_pendientes() {
    //Datos de busqueda
    var id_caso = document.getElementById("lbl_idrecurso").innerText;
    //ESTADO - MOTIVO - CONCEPTO
    var motivo_detractor = document.getElementById("cbo_motivo_detraccion").value;
    var concepto = document.getElementById("cbo_concepto").value;
    var subconcepto = document.getElementById("cbo_sub_concepto").value;
    var detalle = document.getElementById("cbo_detalle").value;
    var estado = document.getElementById("cbo_estado").value;
    //ACCION EJECUTADA - GESTION CLOOPER
    var accion = document.getElementById("cbo_accion").value;
    var gest_clooper = document.getElementById("cbo_gest_clooper").value;
    //RESPUESTAS CLIENTE Y SUPERVISOR
    var respuesta = document.getElementById("cbo_resp_2").value;
    var respuesta_final_cliente = document.getElementById("cbo_resp_final_cliente").value;
    //RESPUESTA DEL CLOOPER
    var respuesta_clooper = document.getElementById("txt_comentarios_clooper").value;

    var chequeo_total = 0;

    if (motivo_detractor == "0" || concepto == "0" || subconcepto == "0" || detalle == "0" || estado == "0" || accion == "0") {
        alert("Debe seleccionar todos los combos de MOTIVO, ACCION EJECUTADA y ESTADO");
        chequeo_total = 1;
    }
    if (respuesta_final_cliente == "0") {
        alert("Debe seleccionar la Respuesta final del cliente");
        chequeo_total = 1;
    }

    if (chequeo_total == 0) {
        $.ajax({
            url: "servicios_medallia.asmx/guardado_3",
            method: 'post',
            data: { id_recurso: id_caso,
                motivo: motivo_detractor,
                concepto: concepto,
                sub: subconcepto,
                detalle: detalle,
                accion: accion,
                estado: estado,
                gestion_clooper: gest_clooper,
                resp_cliente: respuesta,
                resp_final_cliente: respuesta_final_cliente,
                resp_clooper: respuesta_clooper
            },
            dataType: "html",
            success: function (datos) {
                alert("Guardado exitoso");
                setTimeout("redireccionar_inicio()", 500);
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
}
/////////////////////////////////////////FIN BANDEJA PENDIENTES///////////////////////////////////////////77///

////////////////////////////////////////BANDEJA SOPORTE SISTEMAS///////////////////////////////////////////77//
function lista_soporte(user, centro) {
    var resultados = $('#t1');

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    resultados.append('<thead><tr><th align="center">CLOOPER</th><th align="center">ID ENCUESTA</th><th align="center">ACCESS ID</th><th align="center">TECNICO</th><th align="center">EMPRESA</th><th align="center">FECHA INICIO</th><th align="center">FECHA CIERRE</th></tr></thead>');

    $.ajax({
        url: "servicios_medallia.asmx/medallia_lista_casos", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { parametro_user: user, parametro_centro: centro, id_caso: 0, opcion: 3 },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tbody>');
            $(datos).each(function (index, item) {
                //resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);">' + item.tecnico + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><a href="medallia_formload.aspx?param=' + item.instalaciones + '&opc=3">' + item.garantias + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.fecha_inicio + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.fecha_fin + '</td></tr>');
                resultados.append('<tr><td>' + item.tecnico + '</td><td align="center"><a href="medallia_formload.aspx?param=' + item.instalaciones + '&opc=3">' + item.garantias + '</a></td><td align="center">' + item.access + '</td><td>' + item.calificacion + '</td><td>' + item.empresa + '</td><td align="center">' + item.fecha_inicio + '</td><td align="center">' + item.fecha_fin + '</td></tr>');
            });
            resultados.append('</tbody>');
        }
    });
}

function guardar_soporte() {
    //Datos de busqueda
    var id_caso = document.getElementById("lbl_idrecurso").innerText;
    var accion_soporte = document.getElementById("cbo_gest_clooper").value;
    var respuesta_clooper = document.getElementById("txt_comentarios_clooper").value;

    if (accion_soporte != 0) {
        $.ajax({
            url: "servicios_medallia.asmx/guardado_4",
            method: 'post',
            data: { id_recurso: id_caso, accion: accion_soporte, respuesta_cloop: respuesta_clooper },
            dataType: "html",
            success: function (datos) {
                alert("Guardado exitoso. Derivado a Clooper");
                setTimeout("redireccionar_inicio()", 500);
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
    else {
        alert("Debe seleccionar el combo -Gestion sistemas-");
    }
}
//////////////////////////////////////FIN BANDEJA SOPORTE SISTEMAS///////////////////////////////////////////7/

///////////////////////////////////////BANDEJA ESCALADO REFUERZOS////////////////////////////////////////77////
function lista_refuerzos(user, centro) {
    var resultados = $('#t1');

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    resultados.append('<thead><tr><th align="center">CLOOPER</th><th align="center">ID ENCUESTA</th><th align="center">ACCESS ID</th><th align="center">TECNICO</th><th align="center">EMPRESA</th><th align="center">FECHA INICIO</th><th align="center">FECHA CIERRE</th></tr></thead>');

    $.ajax({
        url: "servicios_medallia.asmx/medallia_lista_casos", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { parametro_user: user, parametro_centro: centro, id_caso: 0, opcion: 4 },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tbody>');
            $(datos).each(function (index, item) {
                //resultados.append('<tr><td style="background-color:rgba(41, 97, 132, 0.3);">' + item.tecnico + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center"><a href="medallia_formload.aspx?param=' + item.instalaciones + '&opc=4">' + item.garantias + '</a></td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.access + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.calificacion + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.empresa + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.fecha_inicio + '</td><td style="background-color:rgba(41, 97, 132, 0.3);" align="center">' + item.fecha_fin + '</td></tr>');
                resultados.append('<tr><td>' + item.tecnico + '</td><td align="center"><a href="medallia_formload.aspx?param=' + item.instalaciones + '&opc=4">' + item.garantias + '</a></td><td align="center">' + item.access + '</td><td>' + item.calificacion + '</td><td>' + item.empresa + '</td><td align="center">' + item.fecha_inicio + '</td><td align="center">' + item.fecha_fin + '</td></tr>');
            });
            resultados.append('</tbody>');
        }
    });
}

//function guardar_refuerzos() es igual a function guardar_escalado()
/////////////////////////////////////FIN BANDEJA ESCALADO REFUERZOS////////////////////////////////////////77//

////////////////////////////////////////////////BUSCADOR////////////////////////////////////////77/////////////

function buscador_medallia() {
    var id_cliente = document.getElementById("txt_cliente").value;
    var tecnico = document.getElementById("txt_tecnico").value;
    var id_encuesta = document.getElementById("txt_idencuesta").value;
    var valor_cbo = document.getElementById('cbo_ctta').value;
    var texto_cbo = document.getElementById('cbo_ctta').options[document.getElementById('cbo_ctta').selectedIndex].text;

    var fecha_1 = document.getElementById("fecha_inicio").value;
    fecha_1 = fecha_1.replace("-", "");
    fecha_1 = fecha_1.replace("-", "");
    fecha_1 = fecha_1.replace("/", "");
    fecha_1 = fecha_1.replace("/", "");
    var fecha_2 = document.getElementById("fecha_fin").value;
    fecha_2 = fecha_2.replace("-", "");
    fecha_2 = fecha_2.replace("-", "");
    fecha_2 = fecha_2.replace("/", "");
    fecha_2 = fecha_2.replace("/", "");
    var resultados = $('#t_resultados_medallia');
    var sw = 0;

    if (isNaN(id_cliente) && id_cliente != "") { sw = 1; alert("El ID cliente debe ser un num\u00E9rico."); }
    if (id_cliente == "") { id_cliente = 0; }
    if (isNaN(id_encuesta) && id_encuesta != "") { sw = 1; alert("El ID de encuesta debe ser un num\u00E9rico."); }
    if (id_encuesta == "") { id_encuesta = 0; }
    if ((fecha_1 == "" && fecha_2 != "") || (fecha_1 != "" && fecha_2 == "")) {
        sw = 1;
        alert("Debe completar ambos campos de fecha.");
    }
    if (id_cliente == "" && id_encuesta == "" && tecnico == "" && fecha_1 == "" && fecha_2 == "") {
        sw = 1;
        alert("Debe completar alg\u00FAn campo.");
    }

    if (sw == 0) {
        //alert ("ID cliente: " + id_cliente + " - Tecnico: " + tecnico + " - ID encuesta: " + id_encuesta + " - Fecha 1: " + fecha_1 + " - Fecha 2: " + fecha_2);
        document.getElementById('div_ctta').style.display = 'none';
        document.getElementById('div_tabla_res').style.display = 'block';
        $('#t_resultados_medallia').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
        resultados.append('<thead><tr><th align="center">CLOOPER</th><th align="center">ID ENCUESTA</th><th align="center">FECHA ENCUESTA</th><th align="center">FECHA CARGA</th><th align="center">FECHA CIERRE</th><th align="center">TECNICO</th><th align="center">EMPRESA</th><th align="center">ACCION EJECUTADA</th><th align="center">ESTADO</th></tr></thead>');

        $.ajax({
            url: "servicios_medallia.asmx/buscador_medallia",
            method: 'post',
            data: { cliente: id_cliente, tecnico: tecnico, ctta: texto_cbo, encuesta: id_encuesta, f1: fecha_1, f2: fecha_2 },
            dataType: "json",
            success: function (datos) {
                resultados.append('<tbody>');
                $(datos).each(function (index, item) {
                    resultados.append('<tr><td>' + item.clooper + '</td><td align="center"><a href="medallia_formload.aspx?param=' + item.id_caso + '&opc=0" target="_blank">' + item.id_encuesta + '</a></td><td align="center">' + item.fecha_encuesta + '</td><td align="center">' + item.fecha_mail + '</td><td align="center">' + item.fecha_fin + '</td><td>' + item.nombre_tecnico + '</td><td align="center">' + item.nombre_cliente + '</td><td>' + item.serial_anterior + '</td><td>' + item.serial_actual + '</td></tr>');
                });
                resultados.append('</tbody>');
            }
        });
    }
}

function buscador_ctta_medallia(valor_cbo) {
    var valor_cbo = document.getElementById('cbo_ctta').value;
    var texto_cbo = document.getElementById('cbo_ctta').options[document.getElementById('cbo_ctta').selectedIndex].text;
    //alert("Valor: " + valor_cbo + " - Texto: " + texto_cbo);
    document.getElementById('div_ctta').style.display = 'block';
    document.getElementById('div_tabla_res').style.display = 'none';

    $.ajax({
        url: "servicios_medallia.asmx/contador_casos",
        method: 'post',
        data: { parametro_user: valor_cbo, parametro_centro: texto_cbo },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (item.pend_clooper == "") { $("#span1").text("0"); } else { $("#span1").text(item.pend_clooper); }
                if (item.escalados == "") { $("#span2").text("0"); } else { $("#span2").text(item.escalados); }
                if (item.refuerzos == "") { $("#span3").text("0"); } else { $("#span3").text(item.refuerzos); }
                if (item.cerrados == "") { $("#span4").text("0"); } else { $("#span4").text(item.cerrados); }
            });
        }
    });
}

//////////////////////////////////////////////FIN BUSCADOR////////////////////////////////////////77///////////

////////////////////////////////////////////METRICAS MANUALES////////////////////////////////////////////77////

function carga_mes() {
    var cbo_mes = $('#cbo_fecha_manual');
    
    $.ajax({
        url: "servicios_indicadores.asmx/obtener_fechas_metrica_manual",
        method: 'post',
        dataType: "json",
        success: function (datos) {
            cbo_mes.empty();
            cbo_mes.append($('<option/>', { value: 0, text: "- Seleccione Mes -" }));
            $(datos).each(function (index, item) {
                cbo_mes.append($('<option/>', { value: item.valor, text: item.texto }));
            });
        }
    });
}

function carga_ultimas_metrica_acelerador() {
    var cbo_empresa = document.getElementById("cbo_ctta").value;
    
    $.ajax({
        url: "servicios_indicadores.asmx/metrica_manual_lectura",
        method: 'post',
        data: { opcion: cbo_empresa },
        dataType: "json",
        success: function (datos) {
            $("#txt_acelerador_1").val("");
            $("#txt_acelerador_2").val("");
            $("#txt_acelerador_3").val("");
            $("#txt_date1").val("");
            $("#txt_date2").val("");
            $("#txt_date3").val("");
            var cont = 1;

            $(datos).each(function (index, item) {
                //alert("Cont: " + cont + " / " + "Fecha: " + item.texto + " / Valor: " + item.valor);
                if (cont == 1) { $("#txt_acelerador_3").val(item.valor); $("#txt_date3").val((item.texto).slice(0,9)); }
                if (cont == 2) { $("#txt_acelerador_2").val(item.valor); $("#txt_date2").val((item.texto).slice(0,9)); }
                if (cont == 3) { $("#txt_acelerador_1").val(item.valor); $("#txt_date1").val((item.texto).slice(0,9)); }
                
                cont = cont + 1;
            });
        }
    });
}

function guarda_acelerador() {
    var cbo_empresa = document.getElementById("cbo_ctta").value;
    var cbo_fecha = document.getElementById("cbo_fecha_manual").value;
    var valor = document.getElementById("num_ingreso").value;

    if (cbo_fecha != "0") {
        //cbo_fecha = cbo_fecha.replace("-","");
        //cbo_fecha = cbo_fecha + "01";
        
        if (cbo_empresa != "0") {
            $.ajax({
                url: "servicios_indicadores.asmx/guarda_acelerador",
                method: 'post',
                data: { val: valor, empresa: cbo_empresa, fecha: cbo_fecha },
                dataType: "json",
                success: function (datos) {
                    $(datos).each(function (index, item) {
                        alert(item.texto);
                        setTimeout("redireccionar_inicio()", 500);
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
        else {
            alert("Debe seleccionar una empresa.");
        }
    }
    else {
        alert("Debe seleccionar una fecha.");
    }
}

//////////////////////////////////////////FIN METRICAS MANUALES///////////////////////////////////////////77///

function medallia_carga_form(id_encu, opcion) {
    //Datos clooper
    var id_clooper = $("#lbl_id_user");
    var clooper = $("#lbl_clooper");
    //Datos de busqueda
    var id_cliente = $("#txt_cliente");
    var id_recurso = $("#lbl_idrecurso");
    var dni_tecnico = $("#txt_dni_tecnico");
    var nombre_tecnico = $("#txt_tecnico");
    var id_encuesta = $("#txt_idencuesta");
    var nombre_cliente = $("#txt_nombre");
    var segmento = $("#txt_segmento");
    var tecnologia = $("#txt_tecno");
    var direccion = $("#txt_direccion");
    var localidad = $("#txt_localidad");
    var tel_contacto = $("#txt_contacto");
    var orden = $("#txt_orden");
    var access = $("#txt_accessid");
    var bucket = $("#txt_bucket");
    var id_central = $("#lbl_idcentral");
    var gerencia = $("#txt_gerencia");
    var distrito = $("#txt_distrito");
    var central = $("#txt_central");
    var empresa = $("#txt_empresa");
    //Fechas
    var fecha_encuesta = $("#dat_encuesta");
    var fecha_clooper = $("#dat_mail");
    var fecha_fin = $("#dat_cierre");
    //CONCEPTO - SUBCONCEPTO - DETALLE - GESTION CLOOPER
    var concepto = $("#cbo_concepto");
    var subconcepto = $("#cbo_sub_concepto");
    var detalle = $("#cbo_detalle");
    var gest_clooper = $("#cbo_gest_clooper");
    //RESPUESTAS CLIENTE Y SUPERVISOR
    var comentarios_cliente = $("#txt_comentarios_cliente");
    var comentarios_clooper = $("#txt_comentarios_clooper");
    var respuesta_supervisor = $("#txt_resp_supervisor");
    var cbo_resp_sup = document.getElementById("cbo_resp_supervisor");
    var sn_anterior = $("#txt_sn_anterior");
    var sn_actual = $("#txt_sn_actual");
    //alert("Param: " + id_encu + " - Opcion: " + opcion);

    //CERRADOS
    if (opcion == 0) {
        document.getElementById("btn_guardar_escalado").style.display = "none";
        document.getElementById("btn_guardar_pendiente").style.display = "none";
        document.getElementById("btn_guardar_soporte").style.display = "none";
    }
    //ESCALADO CONTRATA Y REFUERZOS (1=CTTA, 4=REFUERZO)
    if (opcion == 1 || opcion == 4) {
        document.getElementById("txt_resp_supervisor").disabled = false;
        document.getElementById("chk_reagenda").disabled = false;
        cbo_resp_sup.disabled = false;
        document.getElementById("btn_guardar_pendiente").style.display = "none";
        document.getElementById("btn_guardar_soporte").style.display = "none";
    }
    //PENDIENTE CLOOPER
    if (opcion == 2) {
        document.getElementById("cbo_motivo_detraccion").disabled = false;
        document.getElementById("cbo_concepto").disabled = false;
        document.getElementById("cbo_sub_concepto").disabled = false;
        document.getElementById("cbo_detalle").disabled = false;
        document.getElementById("cbo_accion").disabled = false;
        document.getElementById("cbo_estado").disabled = false;
        document.getElementById("cbo_resp_final_cliente").disabled = false;
        document.getElementById("btn_guardar_escalado").style.display = "none";
        document.getElementById("btn_guardar_soporte").style.display = "none";
        document.getElementById("txt_comentarios_clooper").disabled = false;
        document.getElementById("txt_comentarios_cliente").disabled = false;
    }
    //SOPORTE SISTEMAS
    if (opcion == 3) {
        document.getElementById("btn_guardar_escalado").style.display = "none";
        document.getElementById("btn_guardar_pendiente").style.display = "none";
        document.getElementById("txt_comentarios_clooper").disabled = false;
        document.getElementById("cbo_gest_clooper").disabled = false;
        document.getElementById("cbo_accion").disabled = false;
        document.getElementById("cbo_estado").disabled = false;
    }

    $.ajax({
        url: "servicios_medallia.asmx/cargar_formulario",
        method: 'post',
        data: { id_encuesta: id_encu, opcion: opcion },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                $("#cbo_motivo option[value='" + item.motivo + "']").attr("selected", true);
                $("#cbo_contexto option[value='" + item.contexto + "']").attr("selected", true);
                clooper.html(item.clooper);
                id_cliente.val(item.id_cliente);
                dni_tecnico.val(item.dni_tecnico);
                id_encuesta.val(item.id_encuesta);
                id_recurso.html(item.id_caso);
                nombre_cliente.val(item.nombre_cliente);
                direccion.val(item.direccion);
                localidad.val(item.localidad);
                tel_contacto.val(item.contacto);
                segmento.val(item.segmento);
                nombre_tecnico.val(item.nombre_tecnico);
                empresa.val(item.ctta);
                orden.val(item.nro_orden);
                access.val(item.access);
                bucket.val(item.bucket);
                id_central.html(item.id_central);
                gerencia.val(item.gerencia);
                distrito.val(item.distrito_atc);
                central.val(item.central);
                fecha_encuesta.val(item.fecha_encuesta);
                fecha_clooper.val(item.fecha_mail);
                fecha_fin.val(item.fecha_fin);
                tecnologia.val(item.tecnologia);
                //CALIFICACION
                $("#cbo_nps option[value='" + item.nps + "']").attr("selected", true);
                $("#cbo_tecnico option[value='" + item.tecnico + "']").attr("selected", true);
                $("#cbo_puntu option[value='" + item.puntualidad + "']").attr("selected", true);
                $("#cbo_profe option[value='" + item.profesionalidad + "']").attr("selected", true);
                $("#cbo_conocimiento option[value='" + item.conocimiento + "']").attr("selected", true);
                $("#cbo_calidad option[value='" + item.calidad + "']").attr("selected", true);
                $("#cbo_comunica option[value='" + item.comuniccion + "']").attr("selected", true);
                //MOTIVO - CONCEPTO - SUBCONCEPTO - DETALLE
                $("#cbo_motivo_detraccion option[value='" + item.mot_detractor + "']").attr("selected", true);
                concepto.empty();
                concepto.append($('<option/>', { value: item.id_concepto, text: item.concepto }));
                $("#cbo_concepto option[value='" + item.id_concepto + "']").attr("selected", true);
                subconcepto.empty();
                subconcepto.append($('<option/>', { value: item.id_subconcepto, text: item.subconcepto }));
                $("#cbo_sub_concepto option[value='" + item.id_subconcepto + "']").attr("selected", true);
                detalle.empty();
                detalle.append($('<option/>', { value: item.id_detalle, text: item.detalle }));
                $("#cbo_detalle option[value='" + item.id_detalle + "']").attr("selected", true);
                //ACCION EJECUTADA, ESTADO Y ACCION CLOOPER
                $("#cbo_accion option[value='" + item.accion + "']").attr("selected", true);
                $("#cbo_gest_clooper option[value='" + item.id_accion_clooper + "']").attr("selected", true);
                $("#cbo_estado option[value='" + item.estado + "']").attr("selected", true);
                //RESPUESTAS CLIENTE, SUPERVISOR Y CLOOPER
                comentarios_cliente.html(item.comentarios_cliente);
                comentarios_clooper.html(item.resp_clooper);
                $("#cbo_resp_2 option[value='" + item.resp_cliente + "']").attr("selected", true);
                respuesta_supervisor.html(item.resp_supervisor);
                $("#cbo_resp_supervisor option[value='" + item.id_resp_sup + "']").attr("selected", true);
                $("#cbo_resp_final_cliente option[value='" + item.resp_final_cliente + "']").attr("selected", true);
                sn_anterior.val(item.serial_anterior);
                sn_actual.val(item.serial_actual);
                //REAGENDADO
                if(item.reagenda == 1) {
                    document.getElementById('chk_reagenda').checked = true;
                }
                else {
                    document.getElementById('chk_reagenda').checked = false;
                }
            });
        }
    });
}

function OpenMailWindow() {
    window.open("mailto:cesar.farias@telefonica.com?cc=maximiliano@sifuentes.com&&subject=Titulo del mensaje&body=Contenido del correo");
    return false;
}

function redireccionar_inicio() {
    window.locationf = "index.aspx";
    location.href = "index.aspx";
}

function volver_atras() {
    javascript: history.go(-1);
}

//////////////////////////////////////////////// GRAFICOS 1 /////////////////////////////////////////////////
function dibuja_motivos_empresa_fecha(centro) {
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
            document.getElementById('div_row_barras').style.display = 'none';
            document.getElementById('div_row_barras_detalle').style.display = 'none';
            document.getElementById('div_row_circulos_1').style.display = 'none';
            document.getElementById('div_conceptos').style.display = 'none';
            dibuja_motivos_detractor(0, texto_cbo_empresa, fecha_inicio, fecha_fin, '', '', '');
        }
    }
    else {
        if ((fecha_inicio == "" && fecha_fin != "") || (fecha_inicio != "" && fecha_fin == "")) {
            alert("Debe completar ambos campos de fecha.");
        }
        else {
            document.getElementById('div_row_barras').style.display = 'none';
            document.getElementById('div_row_barras_detalle').style.display = 'none';
            document.getElementById('div_row_circulos_1').style.display = 'none';
            document.getElementById('div_conceptos').style.display = 'none';
            dibuja_motivos_detractor(0, centro, fecha_inicio, fecha_fin, '', '', '');
        }
    }
}

function dibuja_motivos_detractor(opcion, centro, f1, f2, motivo, concepto, subconcepto) {
    var total = 0;
    var total_cliente = 0;
    var total_comercial = 0;
    var total_despacho = 0;
    var total_tecnico = 0;
    var fecha = new Date();
    var mes_actual = fecha.getMonth() + 1;
    var anio_actual = fecha.getFullYear();

    switch(mes_actual) {
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

    if (f1 == '' && f2 == '') {
        document.getElementById("lbl_fecha").innerHTML = "Se encuentra visualizando el mes de " + mes_actual + " del " + anio_actual;
    }
    else {
        document.getElementById("lbl_fecha").innerHTML = "Se encuentra visualizando las fechas seleccionadas";
    }

    if (motivo == '' && concepto == '' && subconcepto == '') {
        $.ajax({
            url: "servicios_medallia.asmx/obtener_motivos_detractor",
            method: 'post',
            data: { opc: opcion, centro: centro, fecha1: f1, fecha2: f2, mot: motivo, concep: concepto, sub: subconcepto },
            dataType: "json",
            success: function (datos) {
                $(datos).each(function (index, item) {
                    //alert("Motivo: " + item.motivo + " - " + item.cantidad);
                    if (item.motivo == 'Cliente' && item.cantidad != 0) { $("#str_cliente").html('(' + item.cantidad + ')'); total = total + item.cantidad; total_cliente = item.cantidad }
                    else if (total_cliente == 0) { $("#str_cliente").html(0); }
                    if (item.motivo == 'Comercial' && item.cantidad != 0) { $("#str_comercial").html('(' + item.cantidad + ')'); total = total + item.cantidad; total_comercial = item.cantidad }
                    else if (total_comercial == 0) { $("#str_comercial").html(0); }
                    if (item.motivo == 'Despacho provisión' && item.cantidad != 0) { $("#str_despacho").html('(' + item.cantidad + ')'); total = total + item.cantidad; total_despacho = item.cantidad }
                    else if (total_despacho == 0) { $("#str_despacho").html(0); }
                    if (item.motivo == 'Técnico' && item.cantidad != 0) { $("#str_tecnico").html('(' + item.cantidad + ')'); total = total + item.cantidad; total_tecnico = item.cantidad }
                    else if (total_tecnico == 0) { $("#str_tecnico").html(0); }
                });

                if (total_cliente != 0) { $("#txt_cliente").val(parseFloat((total_cliente / total) * 100).toFixed(1)); } else { $("#txt_cliente").val(0); }
                if (total_comercial != 0) { $("#txt_comercial").val(parseFloat((total_comercial / total) * 100).toFixed(1)); } else { $("#txt_comercial").val(0); }
                if (total_despacho != 0) { $("#txt_despacho").val(parseFloat((total_despacho / total) * 100).toFixed(1)); } else { $("#txt_despacho").val(0); }
                if (total_tecnico != 0) { $("#txt_tecnico").val(parseFloat((total_tecnico / total) * 100).toFixed(1)); } else { $("#txt_tecnico").val(0); }
                if (total == 0) { $("#str_cliente").html(0); $("#str_comercial").html(0); $("#str_despacho").html(0); $("#str_tecnico").html(0); }
                $("input.knob").trigger('change'); // Actualiza el grafico del dial luego del cambio
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
}

function dibuja_motivos_tecnico(centro, motivo) {
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

    var fecha = new Date();
    var mes_actual = fecha.getMonth() + 1;
    var anio_actual = fecha.getFullYear();

    switch(mes_actual) {
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
    
    var total = 0;
    var total_conectividad = 0;
    var total_tecnico = 0;

    if (fecha_inicio == '' && fecha_fin == '') {
        document.getElementById("lbl_fecha").innerHTML = "Se encuentra visualizando el mes de " + mes_actual + " del " + anio_actual;
    }
    else {
        document.getElementById("lbl_fecha").innerHTML = "Se encuentra visualizando las fechas seleccionadas";
    }

    if (valor_cbo_empresa != 0) {
        if ((fecha_inicio == "" && fecha_fin != "") || (fecha_inicio != "" && fecha_fin == "")) {
            alert("Debe completar ambos campos de fecha.");
        }
        else {
            document.getElementById('div_row_barras').style.display = 'none';
            document.getElementById('div_row_barras_detalle').style.display = 'none';
            document.getElementById('div_row_circulos_1').style.display = 'block';
            document.getElementById('div_conceptos').style.display = 'block';
            //dibuja_barras_1(texto_cbo_empresa, fecha_inicio, fecha_fin, motivo);
            $.ajax({
                url: "servicios_medallia.asmx/obtener_motivos_detractor",
                method: 'post',
                data: { opc: 1, centro: texto_cbo_empresa, fecha1: fecha_inicio, fecha2: fecha_fin, mot: motivo, concep: '', sub: '' },
                dataType: "json",
                success: function (datos) {
                    $(datos).each(function (index, item) {
                        //alert("Motivo: " + item.motivo + " - " + item.cantidad);
                        if (item.motivo == 'Conectividad' && item.cantidad != 0) { $("#str_conectividad").html('(' + item.cantidad + ')'); total = total + item.cantidad; total_conectividad = item.cantidad }
                        else if (item.motivo == 'Conectividad') { $("#str_conectividad").html(0); }
                        if (item.motivo == 'Contexto técnico' && item.cantidad != 0) { $("#str_contexto_tecnico").html('(' + item.cantidad + ')'); total = total + item.cantidad; total_tecnico = item.cantidad }
                        else if (item.motivo == 'Contexto técnico') { $("#str_contexto_tecnico").html(0); }
                    });

                    if (total_conectividad != 0) { $("#txt_conectividad").val(parseFloat((total_conectividad / total) * 100).toFixed(1)); } else { $("#txt_conectividad").val(0); }
                    if (total_tecnico != 0) { $("#txt_contexto_tecnico").val(parseFloat((total_tecnico / total) * 100).toFixed(1)); } else { $("#txt_contexto_tecnico").val(0); }
                    if (total == 0) { $("#str_conectividad").html(0); $("#str_contexto_tecnico").html(0); }
                    $("input.knob").trigger('change'); // Actualiza el grafico del dial luego del cambio
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
    }
    else {
        if ((fecha_inicio == "" && fecha_fin != "") || (fecha_inicio != "" && fecha_fin == "")) {
            alert("Debe completar ambos campos de fecha.");
        }
        else {
            document.getElementById('div_row_barras').style.display = 'none';
            document.getElementById('div_row_barras_detalle').style.display = 'none';
            document.getElementById('div_row_circulos_1').style.display = 'block';
            document.getElementById('div_conceptos').style.display = 'block';
            //dibuja_barras_1(centro, fecha_inicio, fecha_fin, motivo);
            $.ajax({
                url: "servicios_medallia.asmx/obtener_motivos_detractor",
                method: 'post',
                data: { opc: 1, centro: centro, fecha1: fecha_inicio, fecha2: fecha_fin, mot: motivo, concep: '', sub: '' },
                dataType: "json",
                success: function (datos) {
                    $(datos).each(function (index, item) {
                        //alert("Motivo: " + item.motivo + " - " + item.cantidad);
                        if (item.motivo == 'Conectividad' && item.cantidad != 0) { $("#str_conectividad").html('(' + item.cantidad + ')'); total = total + item.cantidad; total_conectividad = item.cantidad }
                        else if (item.motivo == 'Conectividad') { $("#str_conectividad").html(0); }
                        if (item.motivo == 'Contexto técnico' && item.cantidad != 0) { $("#str_contexto_tecnico").html('(' + item.cantidad + ')'); total = total + item.cantidad; total_tecnico = item.cantidad }
                        else if (item.motivo == 'Contexto técnico') { $("#str_contexto_tecnico").html(0); }
                    });

                    if (total_conectividad != 0) { $("#txt_conectividad").val(parseFloat((total_conectividad / total) * 100).toFixed(1)); } else { $("#txt_conectividad").val(0); }
                    if (total_tecnico != 0) { $("#txt_contexto_tecnico").val(parseFloat((total_tecnico / total) * 100).toFixed(1)); } else { $("#txt_contexto_tecnico").val(0); }
                    if (total == 0) { $("#str_conectividad").html(0); $("#str_contexto_tecnico").html(0); }
                    $("input.knob").trigger('change'); // Actualiza el grafico del dial luego del cambio
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
    }
}

function dibuja_barra_motivos(centro, motivo, concepto) {
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
            document.getElementById('div_row_barras').style.display = 'block';
            if (concepto == "") {
                document.getElementById('div_row_barras_detalle').style.display = 'none';
                document.getElementById('div_row_circulos_1').style.display = 'none';
                document.getElementById('div_conceptos').style.display = 'none';
            }
            dibuja_barras_1(texto_cbo_empresa, fecha_inicio, fecha_fin, motivo, concepto);
        }
    }
    else {
        if ((fecha_inicio == "" && fecha_fin != "") || (fecha_inicio != "" && fecha_fin == "")) {
            alert("Debe completar ambos campos de fecha.");
        }
        else {
            document.getElementById('div_row_barras').style.display = 'block';
            if (concepto == "") {
                document.getElementById('div_row_barras_detalle').style.display = 'none';
                document.getElementById('div_row_circulos_1').style.display = 'none';
                document.getElementById('div_conceptos').style.display = 'none';
            }
            dibuja_barras_1(centro, fecha_inicio, fecha_fin, motivo, concepto);
        }
    }
}

function dibuja_barras_1(empresa, fecha1, fecha2, motivo, concepto) {
    var datitos = [];
    var objetos;
    var opcion;
    
    if (concepto != "") {
        opcion = 2;
    }
    else {
        opcion = 1;
    }

    $.ajax({
        url: "servicios_medallia.asmx/obtener_motivos_detractor",
        method: 'post',
        data: { opc: opcion, centro: empresa, fecha1: fecha1, fecha2: fecha2, mot: motivo, concep: concepto, sub: '' },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                /*objetos = {
                    "name": item.motivo,
                    "data": [item.cantidad],
                    "key": item.motivo
                };*/
                objetos = {
                    "y": item.cantidad,
                    "name": item.motivo,
                    "key": item.motivo
                };
                datitos.push(objetos);
            });

            var myJsonString = JSON.stringify(datitos);
            var jsonArray = JSON.parse(myJsonString);

            //alert(myJsonString); // MUESTRA EL JSON

            if (opcion == 2) {
                dibuja_barras_2(empresa, jsonArray, concepto, opcion);
            }
            if (opcion == 1) {
                dibuja_barras_2(empresa, jsonArray, motivo, opcion);
            }
        },
        error: function () {
            alert("Hubo un error al consultar!.");
        }
    });            //FIN AJAX
}

function dibuja_barras_1_detalle(empresa, motivo, opc) {
    //alert(motivo);
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

    if (opc == 1) {
        var opcion = 2;
        var concepto = motivo;
        var subconcepto = "";
    }
    if (opc == 2) {
        var opcion = 3;
        var concepto = "";
        var subconcepto = motivo;

    }
    // Por defecto le pasaba opc = 3
    //alert("Subconcepto: " + subconcepto + " - Centro: " + empresa);

    if ((fecha_inicio == "" && fecha_fin != "") || (fecha_inicio != "" && fecha_fin == "")) {
        alert("Debe completar ambos campos de fecha.");
    }
    else {
        document.getElementById('div_row_barras_detalle').style.display = 'block';

        var datitos = [];
        var objetos;

        $.ajax({
            url: "servicios_medallia.asmx/obtener_motivos_detractor",
            method: 'post',
            data: { opc: opcion, centro: empresa, fecha1: fecha_inicio, fecha2: fecha_fin, mot: '', concep: concepto, sub: subconcepto },
            dataType: "json",
            success: function (datos) {
                $(datos).each(function (index, item) {
                    objetos = {
                        "y": item.cantidad,
                        "name": item.motivo,
                        "key": item.motivo
                    };
                    datitos.push(objetos);
                });

                var myJsonString = JSON.stringify(datitos);
                var jsonArray = JSON.parse(myJsonString);

                //alert(myJsonString); // MUESTRA EL JSON
                dibuja_barras_2_detalle(jsonArray, empresa, motivo, opc);
            },
            error: function () {
                alert("Hubo un error al consultar!.");
            }
        });            //FIN AJAX
    }
}

function dibuja_barras_2(empresa, serie, motivo, opc) {
    //alert(serie);
    $('#contenedor').highcharts({
        chart: {
            type: 'column'
        },

        title: {
            text: 'Cantidad de casos para el motivo/concepto: ' + motivo
        },

        subtitle: {
            text: 'Fuente: Medallia'
        },

        xAxis: {
            type: 'category'
            //crosshair: true
        },

        yAxis: {
            //min: 0,
            //max: 15,
            title: {
                text: 'Cantidad de casos'
            }
        },

        legend: {
            enabled: false
        },

        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            },
            series: {
                cursor: 'pointer',
                point: {
                    events: {
                        click: function () {
                            dibuja_barras_1_detalle(empresa,
                                this.options.key, opc);
                        }
                    }
                }
            }
        },

        series: [{ data: serie }]
    });
}

function dibuja_barras_2_detalle(serie, empresa, subconcep, opc) {
    //alert(serie);
    $('#contenedor_2').highcharts({
        chart: {
            type: 'column'
        },

        title: {
            text: 'Detalle para el submotivo: ' + subconcep
        },

        subtitle: {
            text: 'Fuente: Medallia'
        },

        xAxis: {
            type: 'category'
            //crosshair: true
        },

        yAxis: {
            //min: 0,
            //max: 15,
            title: {
                text: 'Cantidad de casos'
            }
        },

        legend: {
            enabled: false
        },

        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            },
            series: {
                cursor: 'pointer',
                colorByPoint: true,
                point: {
                    events: {
                        click: function () {
                            detalle1_series(subconcep,
                                this.options.key, empresa, opc);
                        }
                    }
                }
            }
        },

        series: [{ data: serie }]
    });
}

function detalle1_series(sub, detalle, empresa, opc) {
    //alert("Submotivo: " + sub + " / Detalle: " + detalle + " / Empresa: " + empresa + " / Opcion: " + opc);

    var tabla_detalles = $('#tbl_detalles');
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
    
    tabla_detalles.empty();
    tabla_detalles.append('<thead><tr><th>&nbsp;</th><th>EMPRESA</th><th>TECNICO</th><th>FECHA ENCUESTA</th><th>FECHA CIERRE</th><th>COMENTARIO CLIENTE</th><th>RESPUESTA SUPERVISOR</th><th>ACCION EJECUTADA</th></tr></thead>');
    
    if (valor_cbo_empresa == 0) {
        $.ajax({
            url: "servicios_medallia.asmx/medallia_dibuja_grafico1_detalle",
            method: 'post',
            data: { centro: empresa, fecha1: fecha_inicio, fecha2: fecha_fin, subconcepto: sub, detalle: detalle, opcion: opc },
            dataType: "json",
            success: function (datos) {
                tabla_detalles.append('<tbody>');
                $(datos).each(function (index, item) {
                    tabla_detalles.append('<tr><td><a href="medallia_formload.aspx?param=' + item.id_caso + '&opc=0" class="btn btn-info" target="_blank">Ver</a></td><td align="center">' + item.ctta + '</td><td align="center">' + item.nombre_tecnico + '</td><td align="center">' + item.fecha_encuesta + '</td><td align="center">' + item.fecha_fin + '</td><td>' + item.comentarios_cliente + '</td><td>' + item.resp_supervisor + '</td><td><strong>' + item.accion_ejecutada + '</strong></td></tr>');
                });
                tabla_detalles.append('</tbody>');
            }
        });
    }
    else {
        $.ajax({
            url: "servicios_medallia.asmx/medallia_dibuja_grafico1_detalle",
            method: 'post',
            data: { centro: texto_cbo_empresa, fecha1: fecha_inicio, fecha2: fecha_fin, subconcepto: sub, detalle: detalle, opcion: opc },
            dataType: "json",
            success: function (datos) {
                tabla_detalles.append('<tbody>');
                $(datos).each(function (index, item) {
                    tabla_detalles.append('<tr><a href="medallia_formload.aspx?param=' + item.id_caso + '&opc=0" class="btn btn-info" target="_blank">Ver</a><td align="center">' + item.ctta + '</td><td align="center">' + item.nombre_tecnico + '</td><td align="center">' + item.fecha_encuesta + '</td><td align="center">' + item.fecha_fin + '</td><td>' + item.comentarios_cliente + '</td><td>' + item.resp_supervisor + '</td></tr>');
                });
                tabla_detalles.append('</tbody>');
            }
        });
    }
}
///////////////////////////////////////////////FIN GRAFICOS 1 ///////////////////////////////////////////////

//////////////////////////////////////////////// GRAFICOS 2 /////////////////////////////////////////////////
function dibuja_lista_fecha(centro, fecha1, fecha2) {
    var tabla_top10 = $('#tbl_top10');
    var tabla_pendientes = $('#tbl_pendiente');
    var pos = 1;
    var fecha = new Date();
    var mes_actual = fecha.getMonth() + 1;
    var anio_actual = fecha.getFullYear();

    switch(mes_actual) {
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

    tabla_top10.empty();
    tabla_pendientes.empty();

    tabla_top10.append('<thead><tr><th style="width: 10px">#</th><th>T&eacute;cnico</th><th>Empresa</th><th style="width: 40px">Encuestas</th></tr></thead>');
    tabla_pendientes.append('<thead><tr><th style="width: 10px">#</th><th>Empresa</th><th style="width: 40px">Encuestas</th><th style="width: 40px">Dias Antig.</th></tr></thead>');

    $.ajax({
        url: "servicios_medallia.asmx/obtener_top10_encuestas", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { opc: 1, valor_centro: centro, fecha1: fecha1, fecha2: fecha2 },
        dataType: "json",
        success: function (datos) {
            tabla_top10.append('<tbody>');
            $(datos).each(function (index, item) {
                tabla_top10.append('<tr><td>' + pos + '</td><td>' + item.Nombre + '</td><td>' + item.ctta + '</td><td align="center">' + item.Ingresante + '</td></tr>');
                pos = pos + 1;
            });
            tabla_top10.append('</tbody>');
        }
    });

    $.ajax({
        url: "servicios_medallia.asmx/obtener_pendiente_encuestas", //Llama al webmethod "obtener_gerencia" del lado servidor
        method: 'post',
        data: { opc: 2, valor_centro: centro, fecha1: fecha1, fecha2: fecha2 },
        dataType: "json",
        success: function (datos) {
            tabla_pendientes.append('<tbody>');
            pos = 1;
            $(datos).each(function (index, item) {
                tabla_pendientes.append('<tr><td>' + pos + '</td><td>' + item.ctta + '</td><td align="center">' + item.Ingresante + '</td><td align="center">' + item.ID_TOA + '</td></tr>');
                pos = pos + 1;
            });
            tabla_pendientes.append('</tbody>');
        }
    });
}

function dibuja_lista_seleccion(empresa) {    
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
            dibuja_lista_fecha(texto_cbo_empresa, fecha_inicio, fecha_fin)
        }
    }
    else {
        if ((fecha_inicio == "" && fecha_fin != "") || (fecha_inicio != "" && fecha_fin == "")) {
            alert("Debe completar ambos campos de fecha.");
        }
        else {
            dibuja_lista_fecha(empresa, fecha_inicio, fecha_fin)
        }
    }
}
///////////////////////////////////////////////FIN GRAFICOS 2 ///////////////////////////////////////////////

//////////////////////////////////////////////// GRAFICOS 3 /////////////////////////////////////////////////
function barras_historico(fecha, tecnologia, centro) {
    var resultados = $('#t_historico');
    //var cbo_fecha = $('#cbo_periodo_historico');
    resultados.empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    var datitos = [];
    var objetos;

    $.ajax({
        url: "servicios_indicadores.asmx/obtener_barras_historico",
        method: 'post',
        data: { fecha: fecha, tecno: tecnologia, valor_centro: centro },
        dataType: "json",
        success: function (datos) {
            $(datos).each(function (index, item) {
                if (item.febrero != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero]
                    };
                }
                if (item.marzo != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero, item.marzo]
                    };
                }
                if (item.abril != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero, item.marzo, item.abril]
                    };
                }
                if (item.mayo != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero, item.marzo, item.abril, item.mayo]
                    };
                }
                if (item.junio != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero, item.marzo, item.abril, item.mayo, item.junio]
                    };
                }
                if (item.julio != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero, item.marzo, item.abril, item.mayo, item.junio, item.julio]
                    };
                }
                if (item.agosto != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero, item.marzo, item.abril, item.mayo, item.junio, item.julio, item.agosto]
                    };
                }
                if (item.septiembre != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero, item.marzo, item.abril, item.mayo, item.junio, item.julio, item.agosto, item.septiembre]
                    };
                }
                if (item.octubre != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero, item.marzo, item.abril, item.mayo, item.junio, item.julio, item.agosto, item.septiembre, item.octubre]
                    };
                }
                if (item.noviembre != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero, item.marzo, item.abril, item.mayo, item.junio, item.julio, item.agosto, item.septiembre, item.octubre, item.noviembre]
                    };
                }
                if (item.diciembre != 0) {
                    objetos = {
                        "name": item.empresa,
                        "data": [item.enero, item.febrero, item.marzo, item.abril, item.mayo, item.junio, item.julio, item.agosto, item.septiembre, item.octubre, item.noviembre, item.diciembre]
                    };
                }
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
    });
    /*
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
    */
}

function dibuja_barras(serie) {
    $('#t_historico').highcharts({
        chart: {
            type: 'line'
            //type: 'line'
        },
        title: {
            text: ''
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
                text: 'Estrellas'
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
///////////////////////////////////////////////FIN GRAFICOS 3 ///////////////////////////////////////////////

//////////////////////////////////////////INDICADORES ESTRELLAS///////////////////////////////////////////77/
function combo_fechas(){
    var cbo_fechas = $('#cbo_periodo');

    $.ajax({
        url: "servicios_indicadores.asmx/obtener_fechas_metricas",
        method: 'post',
        dataType: "json",
        success: function (datos) {
            cbo_fechas.empty();
            cbo_fechas.append($('<option/>', { value: 0, text: "--Seleccione--" }));
            $(datos).each(function (index, item) {
                cbo_fechas.append($('<option/>', { value: item.valor, text: item.texto }));
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

function indicador_estrellas(empresa){
    var tabla_performance = $('#t_performance');
    var fecha_ingreso = document.getElementById("cbo_periodo").value;
    var valor_cbo_gerencia = $('.cbo_region').val();
    var valor_cbo_distrito = $('.cbo_distrito').val();
    var chk_ftth = document.getElementById("rd_tecno_ftth");
    var chk_cobre = document.getElementById("rd_tecno_cu");
    var starPercentage = 0;
    var starPercentageRounded = 0;
    var fecha_cal = new Date();
    var mes_actual = fecha_cal.getMonth();
    var mes_a_texto = 0;
    // total number of stars
    const starTotal = 5;

    if (chk_ftth.checked) {
        var tecno = chk_ftth.value;
    }
    if (chk_cobre.checked) {
        var tecno = chk_cobre.value;
    }

    if (fecha_ingreso == '' || fecha_ingreso == 0) {
        //alert(mes_actual);
        fecha_ingreso = "";
        
        switch(mes_actual) {
            case 0: mes_actual = "Enero"; break;
            case 1: mes_actual = "Febrero"; break;
            case 2: mes_actual = "Marzo"; break;
            case 3: mes_actual = "Abril"; break;
            case 4: mes_actual = "Mayo"; break;
            case 5: mes_actual = "Junio"; break;
            case 6: mes_actual = "Julio"; break;
            case 7: mes_actual = "Agosto"; break;
            case 8: mes_actual = "Septiembre"; break;
            case 9: mes_actual = "Octubre"; break;
            case 10: mes_actual = "Noviembre"; break;
            case 11: mes_actual = "Diciembre"; break;
        }
    }
    else {
        mes_a_texto = fecha_ingreso.substr(4,2);
        switch(mes_a_texto) {
            case '01': mes_actual = "Enero"; break;
            case '02': mes_actual = "Febrero"; break;
            case '03': mes_actual = "Marzo"; break;
            case '04': mes_actual = "Abril"; break;
            case '05': mes_actual = "Mayo"; break;
            case '06': mes_actual = "Junio"; break;
            case '07': mes_actual = "Julio"; break;
            case '08': mes_actual = "Agosto"; break;
            case '09': mes_actual = "Septiembre"; break;
            case '10': mes_actual = "Octubre"; break;
            case '11': mes_actual = "Noviembre"; break;
            case '12': mes_actual = "Diciembre"; break;
        }
    }

    if (tecno == '2') {
        document.getElementById("lbl_fecha_consulta").innerHTML = "Performance mes de " + mes_actual + " (FTTH)";
    }
    else {
        document.getElementById("lbl_fecha_consulta").innerHTML = "Performance mes de " + mes_actual + " (COBRE)";
    }

    tabla_performance.empty();
    //alert("Antes de AJAX: " + fecha_ingreso + " / Tecnologia: " + tecno + " / Empresa: " + empresa);
    
    if ((valor_cbo_gerencia == "0" || valor_cbo_gerencia == "") && (valor_cbo_distrito == "" || valor_cbo_distrito == "0")) {
        $.ajax({
            url: "servicios_indicadores.asmx/performance",
            method: 'post',
            data: { fecha: fecha_ingreso, opc: 1, tec: tecno, centro: empresa },
            dataType: "json",
            success: function (datos) {
                tabla_performance.append('<tbody>');
                $(datos).each(function (index, item) {
                    //starPercentageRounded = `${(Math.round(item.estrellas / 1) * 1)}%`;
                    starPercentageRounded = `${(Math.round((item.estrellas / 5) * 100))}%`;
                    tabla_performance.append('<tr><td><a href="index_metricas.aspx?mes='+ mes_actual +'&fecha='+ fecha_ingreso +'&opc=1&tec='+ tecno +'&ctta='+ item.empresa +'"><strong>' + item.empresa + '</strong></a></td><td style="font-size: 36px"><div class="stars-outer"><div class="stars-inner" style="width: '+ starPercentageRounded +';"></div></div></td><td align="left">(' + (item.estrellas).toFixed(2) + ')</td></tr>');
                });
                tabla_performance.append('</tbody>');
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
    else {
        //alert("Gerencia: " + valor_cbo_gerencia.toString() + " / Distrito: " + valor_cbo_distrito.toString());

        $.ajax({
            url: "servicios_indicadores.asmx/performance_por_gerencia_distrito",
            method: 'post',
            data: { fecha: fecha_ingreso, opc: 1, tec: tecno, centro: empresa, gerencia: (valor_cbo_gerencia.toString()), distrito: (valor_cbo_distrito.toString()) },
            dataType: "json",
            success: function (datos) {
                tabla_performance.append('<tbody>');
                $(datos).each(function (index, item) {
                    //starPercentageRounded = `${(Math.round(item.estrellas / 1) * 1)}%`;
                    starPercentageRounded = `${(Math.round((item.estrellas / 5) * 100))}%`;
                    tabla_performance.append('<tr><td><a href="index_metricas.aspx?mes='+ mes_actual +'&fecha='+ fecha_ingreso +'&opc=1&tec='+ tecno +'&ctta='+ item.empresa +'"><strong>' + item.empresa + '</strong></a></td><td style="font-size: 36px"><div class="stars-outer"><div class="stars-inner" style="width: '+ starPercentageRounded +';"></div></div></td><td align="left">(' + (item.estrellas).toFixed(2) + ')</td></tr>');
                });
                tabla_performance.append('</tbody>');
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
}

function indicador_estrellas_metricas(mes_actual, fecha, opcion, tecno, empresa){
    var tabla_metricas = $('#t_metricas');
    var tabla_tecnicos = $('#t_tecnicos');
    var aviso_cumplidas = "";
    var aviso_garantias = "";
    var aviso_garantias_7d = "";
    var aviso_monitoreos = "";
    var aviso_presentismo = "";
    var aviso_diarias = "";
    var aviso_citas = "";
    var comodin = "'";
    //alert(fecha);
    //opcion 1 CTTA - opcion 2 TECNICO
    if (opcion == 1) {
        tabla_metricas.empty();
        tabla_metricas.append('<thead><tr><th class="align-baseline text-center">EMPRESA</th><th class="align-baseline text-center">METRICA</th><th class="align-baseline text-center" colspan="2">CUMPLIMIENTO</th><th class="align-baseline text-center">OBJETIVO</th></tr></thead>');
        //alert("Mes actual: " + mes_actual + " / Fecha: " + fecha);
    
        $.ajax({
            url: "servicios_indicadores.asmx/performance",
            method: 'post',
            data: { fecha: fecha, opc: opcion, tec: tecno, centro: empresa },
            dataType: "json",
            success: function (datos) {
                tabla_metricas.append('<tbody>');
                $(datos).each(function (index, item) {
                    // OBJETIVO CUMPLIDAS 60%
                    if (item.metrica_cumplidas * 0.6 >= 0.6){
                        tabla_metricas.append('<tr><td rowspan="7" class="align-middle text-center"><label style="cursor: hand;" onclick="indicador_estrellas_metricas(' + comodin + mes_actual + comodin + ', ' + comodin + fecha + comodin + ', 2, ' + tecno + ', ' + comodin + empresa + comodin + ');">' + item.empresa + '</label>&nbsp;&nbsp;'+ item.estrellas.toFixed(2) +'&nbsp;<i class="nav-icon fa fa-star"></i></td><td>Cumplidas</td><td style="width: 200px"><div class="progress progress-xs"><div class="progress-bar bg-success" style="width: ' + item.metrica_cumplidas * 0.6 * 100 + '%"></div></div></td><td><span class="badge bg-success">' + (item.metrica_cumplidas * 0.6 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">60%</td></tr>');
                    }
                    if (item.metrica_cumplidas * 0.6 >= 0.55 && item.metrica_cumplidas * 0.6 < 0.6){
                        tabla_metricas.append('<tr><td rowspan="7" class="align-middle text-center"><label style="cursor: hand;" onclick="indicador_estrellas_metricas(' + comodin + mes_actual + comodin + ', ' + comodin + fecha + comodin + ', 2, ' + tecno + ', ' + comodin + empresa + comodin + ');">' + item.empresa + '</label>&nbsp;&nbsp;'+ item.estrellas.toFixed(2) +'&nbsp;<i class="nav-icon fa fa-star"></i></td><td>Cumplidas</td><td style="width: 200px"><div class="progress progress-xs"><div class="progress-bar bg-warning" style="width: ' + item.metrica_cumplidas * 0.6 * 100 + '%"></div></div></td><td><span class="badge bg-warning">' + (item.metrica_cumplidas * 0.6 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">60%</td></tr>');
                    }
                    if (item.metrica_cumplidas * 0.6 < 0.55){
                        tabla_metricas.append('<tr><td rowspan="7" class="align-middle text-center"><label style="cursor: hand;" onclick="indicador_estrellas_metricas(' + comodin + mes_actual + comodin + ', ' + comodin + fecha + comodin + ', 2, ' + tecno + ', ' + comodin + empresa + comodin + ');">' + item.empresa + '</label>&nbsp;&nbsp;'+ item.estrellas.toFixed(2) +'&nbsp;<i class="nav-icon fa fa-star"></i></td><td>Cumplidas</td><td style="width: 200px"><div class="progress progress-xs"><div class="progress-bar bg-danger" style="width: ' + item.metrica_cumplidas * 0.6 * 100 + '%"></div></div></td><td><span class="badge bg-danger">' + (item.metrica_cumplidas * 0.6 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">60%</td></tr>');
                    }
                    // OBJETIVO GARANTIAS 4%
                    if ((1 - item.metrica_garantias * 0.96) <= 0.04){
                        tabla_metricas.append('<tr><td>Garant&iacute;as (30 d&iacute;as)</td><td><div class="progress progress-xs"><div class="progress-bar bg-success" style="width: ' + (1 - item.metrica_garantias * 0.96) * 100 + '%"></div></div></td><td><span class="badge bg-success">' + ((1 - item.metrica_garantias * 0.96) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">4%</td></tr>');
                    }
                    if ((1 - item.metrica_garantias * 0.96) > 0.04 && (1 - item.metrica_garantias * 0.96) <= 0.05){
                        tabla_metricas.append('<tr><td>Garant&iacute;as (30 d&iacute;as)</td><td><div class="progress progress-xs"><div class="progress-bar bg-warning" style="width: ' + (1 - item.metrica_garantias * 0.96) * 100 + '%"></div></div></td><td><span class="badge bg-warning">' + ((1 - item.metrica_garantias * 0.96) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">4%</td></tr>');
                    }
                    if ((1 - item.metrica_garantias * 0.96) > 0.05){
                        tabla_metricas.append('<tr><td>Garant&iacute;as (30 d&iacute;as)</td><td><div class="progress progress-xs"><div class="progress-bar bg-danger" style="width: ' + (1 - item.metrica_garantias * 0.96) * 100 + '%"></div></div></td><td><span class="badge bg-danger">' + ((1 - item.metrica_garantias * 0.96) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">4%</td></tr>');
                    }
                    // OBJETIVO GARANTIAS A 7 DIAS 1%
                    if ((1 - item.metrica_garantias_7d * 0.99) <= 0.01){
                        tabla_metricas.append('<tr><td>Garant&iacute;as (7 d&iacute;as)</td><td><div class="progress progress-xs"><div class="progress-bar bg-success" style="width: ' + (1 - item.metrica_garantias_7d * 0.99) * 100 + '%"></div></div></td><td><span class="badge bg-success">' + ((1 - item.metrica_garantias_7d * 0.99) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">1%</td></tr>');
                    }
                    if ((1 - item.metrica_garantias_7d * 0.99) > 0.01 && (1 - item.metrica_garantias_7d * 0.99) <= 0.025){
                        tabla_metricas.append('<tr><td>Garant&iacute;as (7 d&iacute;as)</td><td><div class="progress progress-xs"><div class="progress-bar bg-warning" style="width: ' + (1 - item.metrica_garantias_7d * 0.99) * 100 + '%"></div></div></td><td><span class="badge bg-warning">' + ((1 - item.metrica_garantias_7d * 0.99) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">1%</td></tr>');
                    }
                    if ((1 - item.metrica_garantias_7d * 0.99) > 0.025){
                        tabla_metricas.append('<tr><td>Garant&iacute;as (7 d&iacute;as)</td><td><div class="progress progress-xs"><div class="progress-bar bg-danger" style="width: ' + (1 - item.metrica_garantias_7d * 0.99) * 100 + '%"></div></div></td><td><span class="badge bg-danger">' + ((1 - item.metrica_garantias_7d * 0.99) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">1%</td></tr>');
                    }
                    // OBJETIVO MONITOREOS 95%
                    /*
                    if (item.metrica_monitoreos == 0) {
                        tabla_metricas.append('<tr><td>Monitoreos</td><td colspan="2">Sin monitoreos</td><td class="align-baseline text-center">95%</td></tr>');
                    }
                    else {
                        if (item.metrica_monitoreos * 0.95 >= 1){
                            tabla_metricas.append('<tr><td>Monitoreos</td><td><div class="progress progress-xs"><div class="progress-bar bg-success" style="width: ' + item.metrica_monitoreos * 0.95 * 100 + '%"></div></div></td><td><span class="badge bg-success">' + (item.metrica_monitoreos * 0.95 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">95%</td></tr>');
                        }
                        if (item.metrica_monitoreos * 0.95 >= 0.85 && item.metrica_monitoreos * 0.95 < 1){
                            tabla_metricas.append('<tr><td>Monitoreos</td><td><div class="progress progress-xs"><div class="progress-bar bg-warning" style="width: ' + item.metrica_monitoreos * 0.95 * 100 + '%"></div></div></td><td><span class="badge bg-warning">' + (item.metrica_monitoreos * 0.95 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">95%</td></tr>');
                        }
                        if (item.metrica_monitoreos * 0.95 < 0.85){
                            tabla_metricas.append('<tr><td>Monitoreos</td><td><div class="progress progress-xs"><div class="progress-bar bg-danger" style="width: ' + item.metrica_monitoreos * 0.95 * 100 + '%"></div></div></td><td><span class="badge bg-danger">' + (item.metrica_monitoreos * 0.95 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">95%</td></tr>');
                        }
                    }
                    */
                    // PRESENTISMO 90%
                    if (item.metrica_presentismo * 0.9 >= 0.9){
                        tabla_metricas.append('<tr><td>Presentismo</td><td><div class="progress progress-xs"><div class="progress-bar bg-success" style="width: ' + item.metrica_presentismo * 0.9 * 100 + '%"></div></div></td><td><span class="badge bg-success">' + (item.metrica_presentismo * 0.9 * 100).toFixed(1) + '</span></td><td class="align-baseline text-center">90%</td></tr>');
                    }
                    if (item.metrica_presentismo * 0.9 >= 0.8 && item.metrica_presentismo * 0.9 < 0.9){
                        tabla_metricas.append('<tr><td>Presentismo</td><td><div class="progress progress-xs"><div class="progress-bar bg-warning" style="width: ' + item.metrica_presentismo * 0.9 * 100 + '%"></div></div></td><td><span class="badge bg-warning">' + (item.metrica_presentismo * 0.9 * 100).toFixed(1) + '</span></td><td class="align-baseline text-center">90%</td></tr>');
                    }
                    if (item.metrica_presentismo * 0.9 < 0.8){
                        tabla_metricas.append('<tr><td>Presentismo</td><td><div class="progress progress-xs"><div class="progress-bar bg-danger" style="width: ' + item.metrica_presentismo * 0.9 * 100 + '%"></div></div></td><td><span class="badge bg-danger">' + (item.metrica_presentismo * 0.9 * 100).toFixed(1) + '</span></td><td class="align-baseline text-center">90%</td></tr>');
                    }
                    // OBJETIVO 2 INSTALACIONES POR DIA
                    if (item.metrica_diarias * 2 >= 2){
                        tabla_metricas.append('<tr><td>Inst. diarias</td><td><div class="progress progress-xs"><div class="progress-bar bg-success" style="width: ' + item.metrica_diarias * 100 + '%"></div></div></td><td><span class="badge bg-success">' + (item.metrica_diarias * 2).toFixed(1) + '</span></td><td class="align-baseline text-center">2 x d&iacute;a</td></tr>');
                    }
                    if (item.metrica_diarias * 2 >= 1.8 && item.metrica_diarias * 2 < 2){
                        tabla_metricas.append('<tr><td>Inst. diarias</td><td><div class="progress progress-xs"><div class="progress-bar bg-warning" style="width: ' + item.metrica_diarias * 100 + '%"></div></div></td><td><span class="badge bg-warning">' + (item.metrica_diarias * 2).toFixed(1) + '</span></td><td class="align-baseline text-center">2 x d&iacute;a</td></tr>');
                    }
                    if (item.metrica_diarias * 2 < 1.8){
                        tabla_metricas.append('<tr><td>Inst. diarias</td><td><div class="progress progress-xs"><div class="progress-bar bg-danger" style="width: ' + item.metrica_diarias * 100 + '%"></div></div></td><td><span class="badge bg-danger">' + (item.metrica_diarias * 2).toFixed(1) + '</span></td><td class="align-baseline text-center">2 x d&iacute;a</td></tr>');
                    }
                    // OBJETIVO CITAS 99,5%
                    if (item.metrica_citas * 0.995 >= 0.995){
                        tabla_metricas.append('<tr><td>Cumplimiento cita</td><td><div class="progress progress-xs"><div class="progress-bar bg-success" style="width: ' + item.metrica_citas * 0.995 * 100 + '%"></div></div></td><td><span class="badge bg-success">' + (item.metrica_citas * 0.995 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">99,5%</td></tr>');
                    }
                    if (item.metrica_citas * 0.995 >= 0.95 && item.metrica_citas * 0.995 < 0.995){
                        tabla_metricas.append('<tr><td>Cumplimiento cita</td><td><div class="progress progress-xs"><div class="progress-bar bg-warning" style="width: ' + item.metrica_citas * 0.995 * 100 + '%"></div></div></td><td><span class="badge bg-warning">' + (item.metrica_citas * 0.995 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">99,5%</td></tr>');
                    }
                    if (item.metrica_citas * 0.995 < 0.95){
                        tabla_metricas.append('<tr><td>Cumplimiento cita</td><td><div class="progress progress-xs"><div class="progress-bar bg-danger" style="width: ' + item.metrica_citas * 0.995 * 100 + '%"></div></div></td><td><span class="badge bg-danger">' + (item.metrica_citas * 0.995 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">99,5%</td></tr>');
                    }
                });
                tabla_metricas.append('</tbody>');
                semanal(mes_actual, fecha, empresa, tecno); // Dibuja el gráfico semanal según la empresa y tecnología seleccionada
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

    if (opcion == 2) {
        tabla_tecnicos.empty();
        tabla_tecnicos.append('<thead><tr><th class="align-baseline text-center">TECNICO</th><th class="align-baseline text-center">CUMPLIDAS</th><th class="align-baseline text-center">G.30DIAS</th><th class="align-baseline text-center">G.7DIAS</th><th class="align-baseline text-center">PRESENTISMO</th><th class="align-baseline text-center">INST. DIARIAS</th><th class="align-baseline text-center">CUMPL. CITA</th></tr></thead>');
        
        $.ajax({
            url: "servicios_indicadores.asmx/performance",
            method: 'post',
            data: { fecha: fecha, opc: opcion, tec: tecno, centro: empresa },
            dataType: "json",
            success: function (datos) {
                tabla_tecnicos.append('<tbody>');
                $(datos).each(function (index, item) {
                    // OBJETIVO CUMPLIDAS 60%
                    if (item.metrica_cumplidas * 0.6 >= 0.6){
                        aviso_cumplidas = "success";
                    }
                    if (item.metrica_cumplidas * 0.6 >= 0.55 && item.metrica_cumplidas * 0.6 < 0.6){
                        aviso_cumplidas = "warning";
                    }
                    if (item.metrica_cumplidas * 0.6 < 0.55){
                        aviso_cumplidas = "danger";
                    }
                    // OBJETIVO GARANTIAS 4%
                    if ((1 - item.metrica_garantias * 0.96) <= 0.04){
                        aviso_garantias = "success";
                    }
                    if ((1 - item.metrica_garantias * 0.96) > 0.04 && (1 - item.metrica_garantias * 0.96) <= 0.05){
                        aviso_garantias = "warning";
                    }
                    if ((1 - item.metrica_garantias * 0.96) > 0.05){
                        aviso_garantias = "danger";
                    }
                    // OBJETIVO GARANTIAS A 7 DIAS 1%
                    if ((1 - item.metrica_garantias_7d * 0.99) <= 0.01){
                        aviso_garantias_7d = "success";
                    }
                    if ((1 - item.metrica_garantias_7d * 0.99) > 0.01 && (1 - item.metrica_garantias_7d * 0.99) <= 0.025){
                        aviso_garantias_7d = "warning";
                    }
                    if ((1 - item.metrica_garantias_7d * 0.99) > 0.025){
                        aviso_garantias_7d = "danger";
                    }
                    // OBJETIVO MONITOREOS 95%
                    /*
                    if (item.metrica_monitoreos * 0.95 >= 0.95){
                        aviso_monitoreos = "success";
                    }
                    if (item.metrica_monitoreos * 0.95 >= 0.85 && item.metrica_monitoreos * 0.95 < 0.95){
                        aviso_monitoreos = "warning";
                    }
                    if (item.metrica_monitoreos * 0.95 < 0.85){
                        aviso_monitoreos = "danger";
                    }
                    */
                    // PRESENTISMO 90%
                    if (item.metrica_presentismo * 0.9 >= 0.9){
                        aviso_presentismo = "success";
                    }
                    if (item.metrica_presentismo * 0.9 >= 0.8 && item.presentismo * 0.9 < 0.9){
                        aviso_presentismo = "warning";
                    }
                    if (item.metrica_presentismo * 0.9 < 0.8){
                        aviso_presentismo = "danger";
                    }
                    // OBJETIVO 2 INSTALACIONES POR DIA
                    if (item.metrica_diarias * 2 >= 2){
                        aviso_diarias = "success";
                    }
                    if (item.metrica_diarias * 2 >= 1.8 && item.metrica_diarias * 2 < 2){
                        aviso_diarias = "warning";
                    }
                    if (item.metrica_diarias * 2 < 1.8){
                        aviso_diarias = "danger";
                    }
                    // OBJETIVO CITAS 99,5%
                    if (item.metrica_citas * 0.995 >= 0.995){
                        aviso_citas = "success";
                    }
                    if (item.metrica_citas * 0.995 >= 0.95 && item.metrica_citas * 0.995 < 0.995){
                        aviso_citas = "warning";
                    }
                    if (item.metrica_citas * 0.995 < 0.95){
                        aviso_citas = "danger";
                    }

                    tabla_tecnicos.append('<tr><td><label>' + item.empresa + '</label>&nbsp;&nbsp;'+ item.estrellas.toFixed(2) +'&nbsp;<i class="nav-icon fa fa-star"></i></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_cumplidas +'">' + (item.metrica_cumplidas * 0.6 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_garantias +'">' + ((1 - item.metrica_garantias * 0.96) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_garantias_7d +'">' + ((1 - item.metrica_garantias_7d * 0.99) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_presentismo +'">' + (item.metrica_presentismo * 0.9 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_diarias +'">' + (item.metrica_diarias * 2).toFixed(1) + '</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_citas +'">' + (item.metrica_citas * 0.995 * 100).toFixed(1) + '%</span></td></tr>');
                    /*
                    if (item.metrica_monitoreos == 0) {
                        tabla_tecnicos.append('<tr><td><label>' + item.empresa + '</label>&nbsp;&nbsp;'+ item.estrellas +'&nbsp;<i class="nav-icon fa fa-star"></i></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_cumplidas +'">' + (item.metrica_cumplidas * 0.6 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_garantias +'">' + ((1 - item.metrica_garantias * 0.96) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center">Sin monitoreos</td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_diarias +'">' + (item.metrica_diarias * 2).toFixed(1) + '</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_citas +'">' + (item.metrica_citas * 0.995 * 100).toFixed(1) + '%</span></td></tr>');
                    }
                    else {
                        tabla_tecnicos.append('<tr><td><label>' + item.empresa + '</label>&nbsp;&nbsp;'+ item.estrellas +'&nbsp;<i class="nav-icon fa fa-star"></i></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_cumplidas +'">' + (item.metrica_cumplidas * 0.6 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_garantias +'">' + ((1 - item.metrica_garantias * 0.96) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_monitoreos +'">' + (item.metrica_monitoreos * 0.95 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_diarias +'">' + (item.metrica_diarias * 2).toFixed(1) + '</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_citas +'">' + (item.metrica_citas * 0.995 * 100).toFixed(1) + '%</span></td></tr>');
                    }
                    */
                });
                
                tabla_tecnicos.append('</tbody>');
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
}
////////////////////////////////////////FIN INDICADORES ESTRELLAS////////////////////////////////////////////

////////////////////////////////////////BUSCADOR GLOBAL TECNICOS////////////////////////////////////////////
function buscador_global_tecnicos() {
    var resultados = $('#t_resultado_tecnicos');
    var boton = document.getElementById('btn_ver');
    var texto_busca = document.getElementById("txt_nombre").value;
    var comodin = "'";
    var verificador = 0;

    boton.disabled = true;
    boton.innerHTML = "Buscando...";

    if (texto_busca != "" || texto_busca != null) {
        $.ajax({
            url: "servicios_indicadores.asmx/buscador_tecnicos",
            method: 'post',
            data: { fecha: 0, opc: 1, tecnico: texto_busca, ingreso: 0 },
            dataType: "json",
            success: function (datos) {
                $('#t_resultado_tecnicos').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
                document.getElementById('div_tabla_res').style.display = 'block';
                document.getElementById('div_tabla_res2').style.display = 'none';
                document.getElementById('div_lista_detalles').style.display = 'none';
                document.getElementById('row_metricas').style.display = 'none';
                document.getElementById('row_metricas2').style.display = 'none';
                resultados.append('<thead><tr><th>NOMBRE</th><th class="text-center">EMPRESA</th><th class="text-center">DNI</th><th class="text-center">ACTIVO</th><th class="text-center">INGRESANTE</th></thead></tr></thead>');
                $(datos).each(function (index, item) {
                    resultados.append('<tr><td><label style="cursor: hand;" onclick="buscador_global_tecnicos2(' + item.ID_RECURSO + ',' + comodin + item.Ingresante + comodin + ')"><u>' + item.Nombre + '</u></label></td><td align="center">' + item.ctta + '</td><td align="center">' + item.ID_TOA + '</td><td align="center">' + item.activo + '</td><td align="center">' + item.Ingresante + '</td></tr>');
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
        alert("Completar el campo con apellido o dni");
    }

    boton.disabled = false;
    boton.innerHTML = "Buscar";
}

function buscador_global_tecnicos2(id_tecnico, ingresante) {
    var fecha_ingreso = document.getElementById("cbo_periodo").value;
    var boton = document.getElementById('btn_ver');
    var resultados = $('#t_resultado_tecnico2');
    var h3 = $('#h3_nombre_resultado_tecnico');
    var h3_estrellas = $('#h3_estrellas');
    var h3_cumplimiento = $('#h3_cumplimiento');
    var h3_garantias = $('#h3_garantias');
    var h3_garantias_7d = $('#h3_garantias_7d');
    var h3_presentismo = $('#h3_presentismo');
    var h3_efcita = $('#h3_efcita');

    var sw = 0;
    var comodin = "'";
    var sw = 0;

    $('#t_resultado_tecnico2').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    h3.empty();
    h3_estrellas.empty();
    h3_cumplimiento.empty();
    h3_garantias.empty();
    h3_garantias_7d.empty();
    h3_presentismo.empty();
    h3_efcita.empty();

    boton.disabled = true;
    boton.innerHTML = "Buscando...";

    if(fecha_ingreso != "0") {
        if(ingresante == "NO") {
            $.ajax({
                url: "servicios_indicadores.asmx/buscador_tecnicos",
                method: 'post',
                data: { fecha: fecha_ingreso, opc: 2, tecnico: id_tecnico, ingreso: 0 },
                dataType: "json",
                success: function (datos) {
                    document.getElementById('div_tabla_res2').style.display = 'block';
                    document.getElementById('div_lista_detalles').style.display = 'none';
                    document.getElementById('row_metricas').style.display = 'flex';
                    document.getElementById('row_metricas2').style.display = 'flex';
                    resultados.append('<thead><tr><th class="text-center">CUMPLIDAS</th><th class="text-center">NO REALIZADA</th><th class="text-center">SUSPENDIDO</th><th class="text-center">GTIAS.30D</th><th class="text-center">GTIAS.7D</th><th class="text-center">MONITOREOS</th><th class="text-center">MEDALLIAS</th><th class="text-center">DIAS TRAB.</th><th class="text-center">PRODUCCION</th></tr></thead>');
                    resultados.append('<tbody>');
                    $(datos).each(function (index, item) {
                        h3.append("Resultados de " + item.tecnico);
                        h3_estrellas.append((item.estrellas).toFixed(2));
                    
                        // OBJETIVO CUMPLIDAS 60%
                        if (item.metrica_cumplidas * 0.6 >= 0.6){
                            document.getElementById("div_cumplidas").className += " bg-success";
                        }
                        if (item.metrica_cumplidas * 0.6 >= 0.55 && item.metrica_cumplidas * 0.6 < 0.6){
                            document.getElementById("div_cumplidas").className += " bg-warning";
                        }
                        if (item.metrica_cumplidas * 0.6 < 0.55){
                            document.getElementById("div_cumplidas").className += " bg-danger";
                        }
                        // OBJETIVO GARANTIAS 4%
                        if ((1 - item.metrica_garantias * 0.96) <= 0.04){
                            document.getElementById("div_garantias").className += " bg-success";
                        }
                        if ((1 - item.metrica_garantias * 0.96) > 0.04 && (1 - item.metrica_garantias * 0.96) <= 0.05){
                            document.getElementById("div_garantias").className += " bg-warning";
                        }
                        if ((1 - item.metrica_garantias * 0.96) > 0.05){
                            document.getElementById("div_garantias").className += " bg-danger";
                        }
                        // OBJETIVO GARANTIAS A 7 DIAS 1%
                        if ((1 - item.metrica_garantias_7d * 0.99) <= 0.01){
                            document.getElementById("div_garantias_7d").className += " bg-success";
                        }
                        if ((1 - item.metrica_garantias_7d * 0.99) > 0.01 && (1 - item.metrica_garantias_7d * 0.99) <= 0.025){
                            document.getElementById("div_garantias_7d").className += " bg-warning";
                        }
                        if ((1 - item.metrica_garantias_7d * 0.99) > 0.025){
                            document.getElementById("div_garantias_7d").className += " bg-danger";
                        }
                        // PRESENTISMO 90%
                        if (item.metrica_presentismo * 0.9 >= 0.9){
                            document.getElementById("div_presentismo").className += " bg-success";
                        }
                        if (item.metrica_presentismo * 0.9 >= 0.8 && item.presentismo * 0.9 < 0.9){
                            document.getElementById("div_presentismo").className += " bg-warning";
                        }
                        if (item.metrica_presentismo * 0.9 < 0.8){
                            document.getElementById("div_presentismo").className += " bg-danger";
                        }

                        // OBJETIVO 2 INSTALACIONES POR DIA
                        /*
                        if (item.metrica_diarias * 2 >= 2){
                            aviso_diarias = "success";
                        }
                        if (item.metrica_diarias * 2 >= 1.8 && item.metrica_diarias * 2 < 2){
                            aviso_diarias = "warning";
                        }
                        if (item.metrica_diarias * 2 < 1.8){
                            aviso_diarias = "danger";
                        }
                        */
                        // OBJETIVO CITAS 99,5%
                        if (item.metrica_citas * 0.995 >= 0.995){
                            document.getElementById("div_efcita").className += " bg-success";
                        }
                        if (item.metrica_citas * 0.995 >= 0.95 && item.metrica_citas * 0.995 < 0.995){
                            document.getElementById("div_efcita").className += " bg-warning";
                        }
                        if (item.metrica_citas * 0.995 < 0.95){
                            document.getElementById("div_efcita").className += " bg-danger";
                        }

                        h3_presentismo.append((item.metrica_presentismo * 90).toFixed(1));
                        h3_presentismo.append('<sup style="font-size: 20px">%</sup>');

                        h3_efcita.append((item.metrica_citas * 99.5).toFixed(1));
                        h3_efcita.append('<sup style="font-size: 20px">%</sup>');

                        h3_cumplimiento.append((item.metrica_cumplidas * 60).toFixed(1));
                        h3_cumplimiento.append('<sup style="font-size: 20px">%</sup>');
                    
                        // OBJETIVO GARANTIAS 30D 4%
                        if (item.metrica_garantias >= 1) {
                            h3_garantias.append(0);
                        }
                        else {
                            h3_garantias.append(((1 - item.metrica_garantias * 0.96) * 100).toFixed(1));
                        }
                        h3_garantias.append('<sup style="font-size: 20px">%</sup>');

                        // OBJETIVO GARANTIAS 7D 1%
                        if (item.metrica_garantias_7d >= 1) {
                            h3_garantias_7d.append(0);
                        }
                        else {
                            h3_garantias_7d.append(((1 - item.metrica_garantias_7d * 0.99) * 100).toFixed(1));
                        }
                        h3_garantias_7d.append('<sup style="font-size: 20px">%</sup>');

                        //resultados.append('<tr><td><label>' + item.empresa + '</label>&nbsp;&nbsp;'+ item.estrellas.toFixed(2) +'&nbsp;<i class="nav-icon fa fa-star"></i></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_cumplidas +'">' + (item.metrica_cumplidas * 0.6 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_garantias +'">' + ((1 - item.metrica_garantias * 0.96) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_garantias_7d +'">' + ((1 - item.metrica_garantias_7d * 0.99) * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_presentismo +'">' + (item.metrica_presentismo * 0.9 * 100).toFixed(1) + '%</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_diarias +'">' + (item.metrica_diarias * 2).toFixed(1) + '</span></td><td class="align-baseline text-center"><span class="badge bg-'+ aviso_citas +'">' + (item.metrica_citas * 0.995 * 100).toFixed(1) + '%</span></td></tr>');
                        resultados.append('<tr><td align="center">' + item.instalaciones + '</td><td align="center">' + item.no_realizado + '</td><td align="center">' + item.suspendido + '</td><td align="center">' + item.garantias + '</td><td align="center">' + item.garantias_7d + '</td><td align="center"><label style="cursor: hand;" onclick="buscador_global_monitoreos(' + id_tecnico + ')"><u>' + item.monitoreos + '</u></label></td><td align="center"><label style="cursor: hand;" onclick="buscador_global_medallias(' + id_tecnico + ')"><u>' + item.medallas + '</u></label></td><td align="center">' + item.dias_trabajados + '</td><td align="center">' + item.produ + '</td></tr>');
                        sw = sw + 1;
                    });
                    resultados.append('</tbody>');
                    if (sw == 0) {
                        document.getElementById('row_metricas').style.display = 'none';
                        document.getElementById('row_metricas2').style.display = 'none';
                        resultados.empty();
                        resultados.append('<thead><tr><th align="center"><b>NO SE ENCONTRARON RESULTADOS DE METRICAS</b></th></tr></thead>');
                    }
                },
                error: function (data) {
                    alert("Hubo un error al consultar! ");
                }
            });
        }
        else {
            $.ajax({
                url: "servicios_indicadores.asmx/buscador_tecnicos",
                method: 'post',
                data: { fecha: fecha_ingreso, opc: 2, tecnico: id_tecnico, ingreso: 1 },
                dataType: "json",
                success: function (datos) {
                    document.getElementById('div_tabla_res2').style.display = 'block';
                    document.getElementById('div_lista_detalles').style.display = 'none';
                    document.getElementById('row_metricas').style.display = 'none';
                    document.getElementById('row_metricas2').style.display = 'none';
                    resultados.append('<thead><tr><th class="text-center">MONITOREOS</th><th class="text-center">ULTIMA CALIFICACION</th></tr></thead>');
                    resultados.append('<tbody>');
                    $(datos).each(function (index, item) {
                        h3.empty();
                        h3.append("Resultados de " + item.tecnico + " (Ingresante - Sin M&eacute;tricas)");
                        if (item.calificacion == "Apto") {
                            resultados.append('<tr><td align="center"><label style="cursor: hand;" onclick="buscador_global_monitoreos(' + id_tecnico + ')"><u>' + item.monitoreos + '</u></label></td><td align="center"><div class="alert alert-success"><i class="icon fas fa-check"></i>' + item.calificacion + '</div></td></tr>');
                        }
                        if (item.calificacion == "Provisorio") {
                            resultados.append('<tr><td align="center"><label style="cursor: hand;" onclick="buscador_global_monitoreos(' + id_tecnico + ')"><u>' + item.monitoreos + '</u></label></td><td align="center"><div class="alert alert-warning"><i class="icon fas fa-exclamation-triangle"></i>' + item.calificacion + '</div></td></tr>');
                        }
                        if (item.calificacion == "No Apto") {
                            resultados.append('<tr><td align="center"><label style="cursor: hand;" onclick="buscador_global_monitoreos(' + id_tecnico + ')"><u>' + item.monitoreos + '</u></label></td><td align="center"><div class="alert alert-danger"><i class="icon fas fa-ban"></i>' + item.calificacion + '</div></td></tr>');
                        }
                        sw = sw + 1;
                    });
                    resultados.append('</tbody>');
                    if (sw == 0) {
                        document.getElementById('row_metricas').style.display = 'none';
                        document.getElementById('row_metricas2').style.display = 'none';
                        resultados.empty();
                        resultados.append('<thead><tr><th align="center"><b>NO SE ENCONTRARON MONITOREOS</b></th></tr></thead>');
                    }
                },
                error: function (data) {
                    alert("Hubo un error al consultar! ");
                }
            });
        }
    }
    else {
        alert("Debe seleccionar una fecha");
    }

    boton.disabled = false;
    boton.innerHTML = "Buscar";
}

function buscador_global_medallias(id_tecnico) {
    var resultado_detalle = $('#t_resultado_detalles');
    var h3_titulo_detalle = $('#h3_nombre_detalles');
    
    resultado_detalle.empty();
    h3_titulo_detalle.empty();

    $.ajax({
        url: "servicios_indicadores.asmx/buscador_tecnicos_medallias",
        method: 'post',
        data: { id_recurso: id_tecnico },
        dataType: "json",
        success: function (datos) {
            document.getElementById('div_lista_detalles').style.display = 'flex';
            h3_titulo_detalle.append("Detalle Medallias");
            resultado_detalle.append('<thead><tr><th class="text-center">CLOOPER</th><th class="text-center">ID ENCUESTA</th><th class="text-center">FECHA ENCUESTA</th><th class="text-center">FECHA CARGA</th><th class="text-center">FECHA CIERRE</th><th class="text-center">ACCION EJECUTADA</th><th class="text-center">ESTADO</th></tr></thead>');
            resultado_detalle.append('<tbody>');
            $(datos).each(function (index, item) {
                resultado_detalle.append('<tr><td>' + item.clooper + '</td><td align="center"><a href="medallia_formload.aspx?param=' + item.id_caso + '&opc=0" target="_blank">' + item.id_encuesta + '</a></td><td align="center">' + item.fecha_encuesta + '</td><td align="center">' + item.fecha_mail + '</td><td align="center">' + item.fecha_fin + '</td><td align="center">' + item.accion_ejecutada + '</td><td align="center">' + item.central + '</td></tr>');
            });
            resultados.append('</tbody>');
        },
        error: function (data) {
            alert("Hubo un error al consultar! ");
        }
    });
}

function buscador_global_monitoreos(id_tecnico) {
    var resultados = $('#t_resultado_detalles')
    var h3 = $('#h3_nombre_detalles');
    resultados.empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
    h3.empty();
    var comodin = "'";

    $.ajax({
        url: "servicios_monitoreos.asmx/detalle_tecnico1",
        method: 'post',
        data: { tecnico: id_tecnico },
        dataType: "json", //SE USA POST CUANDO EL WEB SERVICE ME DEVUELVE DATOS. USAR HTML PARA QUE EL SUCCESS FUNCIONE
        success: function (datos) {
            document.getElementById('div_lista_detalles').style.display = 'block';
            h3.append("Monitoreos/Calibraciones");

            resultados.append('<thead><tr><th class="text-center">CALIFICACION</th><th class="text-center">FECHA</th><th></th></tr></thead>');

            $(datos).each(function (index, item) {
                if (item.calificacion == "Apto") {
                    resultados.append('<tr><td><div class="alert alert-success"><i class="icon fas fa-check"></i>' + item.calificacion + '</div></td><td class="text-center">' + item.fecha_inicio.substring(0, 10) + '</td><td><a href="monitoreos_formload.aspx?param=' + item.fecha_inicio.substring(0, 10) + '&tec=' + id_tecnico + '" target="_blank" class="btn btn-primary">VER</a></td></tr>');
                }
                if (item.calificacion == "Provisorio") {
                    resultados.append('<tr><td><div class="alert alert-warning"><i class="icon fas fa-exclamation-triangle"></i>' + item.calificacion + '</div></td><td class="text-center">' + item.fecha_inicio.substring(0, 10) + '</td><td><a href="monitoreos_formload.aspx?param=' + item.fecha_inicio.substring(0, 10) + '&tec=' + id_tecnico + '" target="_blank" class="btn btn-primary">VER</a></td></tr>');
                }
                if (item.calificacion == "No Apto") {
                    resultados.append('<tr><td><div class="alert alert-danger"><i class="icon fas fa-ban"></i>' + item.calificacion + '</div></td><td class="text-center">' + item.fecha_inicio.substring(0, 10) + '</td><td><a href="monitoreos_formload.aspx?param=' + item.fecha_inicio.substring(0, 10) + '&tec=' + id_tecnico + '" target="_blank" class="btn btn-primary">VER</a></td></tr>');
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
//////////////////////////////////////FIN BUSCADOR GLOBAL TECNICOS//////////////////////////////////////////
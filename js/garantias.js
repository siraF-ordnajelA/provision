////////////////////////////////////////////////FORMULARIO DESCARGOS////////////////////////////////////////////////
function carga_combo_motivos(opc) {
    if (opc == 1) {
        var cbo_motivo = $('#cbo_motivo');
        var combo_submotivo = document.getElementById("cbo_detalle");
    }
    if (opc == 2) {
        var cbo_motivo = $('#cbo_motivo_gestor');
        var combo_submotivo = document.getElementById("cbo_submotivo_gestor");
    }
    
    combo_submotivo.disabled = true;

    $.ajax({
        url: "servicios_garantia.asmx/obtener_cbo_motivos",
        method: 'post',
        data: { opcion: opc },
        dataType: "json",
        success: function (datos) {
            cbo_motivo.empty();
            cbo_motivo.append($('<option/>', { value: 0, text: "--Seleccione Motivo--" }));

            $(datos).each(function (index, item) {
                cbo_motivo.append($('<option/>', { value: item.valor, text: item.texto }));
            });
        }
    });
}

function carga_combo_submotivo(opc) {
    if (opc == 1) {
        var valor_combo_motivo = document.getElementById("cbo_motivo").value;
        var combo_submotivo_A = $('#cbo_detalle');
        var combo_submotivo_B = document.getElementById("cbo_detalle");
    }
    if (opc == 2) {
        var valor_combo_motivo = document.getElementById("cbo_motivo_gestor").value;
        var combo_submotivo_A = $('#cbo_submotivo_gestor');
        var combo_submotivo_B = document.getElementById("cbo_submotivo_gestor");
    }

    if (valor_combo_motivo == 0) {
        combo_submotivo_A.empty();
        combo_submotivo_A.append($('<option/>', { value: 0, text: "-- Debe seleccionar Motivo --" }));
        combo_submotivo_B.disabled = true;
    }
    else {
        $.ajax({
            url: "servicios_garantia.asmx/obtener_cbo_submotivo",
            method: 'post',
            data: { opcion: opc, motivo_id: valor_combo_motivo },
            dataType: "json",
            success: function (datos) {
                combo_submotivo_A.empty();
                combo_submotivo_A.append($('<option/>', { value: 0, text: "--Seleccione Submotivo--" }));

                $(datos).each(function (index, item) {
                    combo_submotivo_A.append($('<option/>', { value: item.valor, text: item.texto }));
                });
                combo_submotivo_B.disabled = false;
            }
        });
    }
}

function buscar_gtia() {
    document.getElementById("btn_busca").disabled = true;
    var boton_buscar = document.getElementById('btn_busca');
    boton_buscar.innerText = "Buscando...";

    var nro_peticion = document.getElementById("txt_peticion").value;

    var sintoma = $('#txt_sintoma');

    var tecnico = $('#txt_tecnico');
    var id_rec = $('#lbl_idrecurso');
    var empresa = $('#txt_empresa');
    var access_id = $('#txt_accessid');
    var estado = $('#txt_estado');

    var actividad = $('#txt_subtipo');
    var distrito = $('#txt_distrito');
    var gerencia = $('#txt_gerencia');
    var central = $('#txt_central');
    var id_central = $('#lbl_idcentral');
    
    var segmento = $('#txt_segmento');
    var tecnologia = $('#txt_tecno');
    var fecha_ingreso = $('#txt_fingreso');
    var fecha_cumplimiento = $('#txt_fcumpl');
    var sw = 0;

    if (nro_peticion != "") {
        $.ajax({
            url: "servicios_garantia.asmx/busca_toa",
            method: 'post',
            data: { peticion: nro_peticion },
            dataType: "json",
            success: function (datos) {
                sintoma.empty();

                tecnico.empty();
                id_rec.empty();
                empresa.empty();
                access_id.empty();
                estado.empty();

                actividad.empty();
                distrito.empty();
                gerencia.empty();
                id_central.empty();
                central.empty();

                segmento.empty();
                tecnologia.empty();
                fecha_ingreso.empty();
                fecha_cumplimiento.empty();

                $(datos).each(function (index, item) {
                    sintoma.val(item.Sintoma);

                    tecnico.val(item.tecnico);
                    id_rec.html(item.id_recurso);
                    empresa.val(item.ctta);
                    access_id.val(item.access);
                    estado.val(item.estado);

                    actividad.val(item.subtipo_actividad);
                    distrito.val(item.distrito);
                    gerencia.val(item.gerencia);
                    id_central.html(item.id_central);
                    central.val(item.central);

                    segmento.val(item.segmento);
                    tecnologia.val(item.tecno);
                    fecha_ingreso.val(item.fecha_toa);
                    fecha_cumplimiento.val(item.fecha_cierre);
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
        alert("Debe completar el n\u00FAmero de petici\u00F3n");
        document.getElementById("btn_busca").disabled = false;
        boton_buscar.innerHTML = "Buscar";
    }
}

function guardar_descargo() {
    //Datos clooper
    var id_clooper = document.getElementById("lbl_id_user").innerText;
    var nro_peticion = document.getElementById("txt_peticion").value;

    //Datos de busqueda
    var sintoma = document.getElementById("txt_sintoma").value;
    
    var id_recurso = document.getElementById("lbl_idrecurso").innerText;
    var empresa = document.getElementById("txt_empresa").value;
    var access = document.getElementById("txt_accessid").value;
    var estado = document.getElementById("txt_estado").value;

    var subtipo_actividad = document.getElementById("txt_subtipo").value;
    var id_central = document.getElementById("lbl_idcentral").innerText;
    
    var segmento = document.getElementById("txt_segmento").value;
    var tecnologia = document.getElementById("txt_tecno").value;
    var f_ingreso = document.getElementById("txt_fingreso").value;
    var f_cierre = document.getElementById("txt_fcumpl").value;

    // RESPUESTA SUPERVISOR
    var motivo = document.getElementById("cbo_motivo").value;
    var submotivo = document.getElementById("cbo_detalle").value;
    var respuesta_supervisor = document.getElementById("txt_resp_supervisor").value;

    // SERIAL EQUIPO
    var sn_anterior = document.getElementById("txt_sn_anterior").value;
    var sn_actual = document.getElementById("txt_sn_actual").value;

    var chequeo_total = 0;

    if (motivo == "0" || submotivo == "0") {
        alert("Debe seleccionar el motivo y submotivo de la devoluci\u00F3n");
        chequeo_total = 1;
    }
    if (nro_peticion == "") {
        alert("Debe completar el n\u00FAmero de petici\u00F3n");
        chequeo_total = 1;
    }
    if (respuesta_supervisor == "") {
        alert("Debe completar el comentario del supervisor");
        chequeo_total = 1;
    }
    if (id_recurso == "" || subtipo_actividad == "" || tecnologia == "") {
        alert("No se encontr\u00F3 una b\u00FAsqueda realizada, no se puede guardar.");
        chequeo_total = 1;
    }
    if (motivo == 4 || motivo == 8) {
        if (submotivo == 52 || submotivo == 16 || submotivo == 17 || submotivo == 18 || submotivo == 30 || submotivo == 31 || submotivo == 32 || submotivo == 33 || submotivo == 34) {
            if (sn_actual == "" || sn_anterior == "") {
                alert("Debe completar los n\u00FAmeros de serie de los equipos");
                chequeo_total = 1;
            }
        }
    }

    if (chequeo_total == 0) {
        /*
        alert(motivo + "-" + contexto);
        */
        $.ajax({
            url: "servicios_garantia.asmx/guardado_descargo",
            method: 'post',
            data: { clooper: id_clooper,
                    peticion: nro_peticion,
                    //Datos de busqueda
                    sinto: sintoma,
                    recurso: id_recurso,
                    ctta: empresa,
                    access_id: access,
                    estado_orden: estado,
                    subtipo: subtipo_actividad,
                    id_central: id_central,
                    seg_cliente: segmento,
                    tecno: tecnologia,
                    fecha_in: f_ingreso,
                    fecha_out: f_cierre,
                    // RESPUESTA SUPERVISOR
                    mot: motivo,
                    submot: submotivo,
                    respuesta_sup: respuesta_supervisor,
                    // SERIAL NUMBERS
                    sn_ant: sn_anterior,
                    sn_act: sn_actual
            },
            dataType: "json",
            success: function (datos) {
                $(datos).each(function (index, item) {
                    alert(item.ctta);
                    setTimeout("redireccionar_lista_descargos_gestor()", 250);
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
}

function habilita_sn_averia() {
    var valor_cbo_submotivo = document.getElementById("cbo_detalle").value;
    var serial_anterior = document.getElementById("txt_sn_anterior");
    var serial_actual = document.getElementById("txt_sn_actual");

    if (valor_cbo_submotivo == 16 || valor_cbo_submotivo == 17 || valor_cbo_submotivo == 18 || valor_cbo_submotivo == 30 || valor_cbo_submotivo == 31 || valor_cbo_submotivo == 32 || valor_cbo_submotivo == 33 || valor_cbo_submotivo == 34 || valor_cbo_submotivo == 52) {
        serial_actual.disabled = false
        serial_anterior.disabled = false;
    }
    else {
        serial_actual.disabled = true;
        serial_actual.value = "";
        serial_anterior.disabled = true;
        serial_anterior.value = "";
    }
}
//////////////////////////////////////////////FIN FORMULARIO DESCARGOS//////////////////////////////////////////////

////////////////////////////////////////////////BANDEJA DE DESCARGOS////////////////////////////////////////////////
function lista_garantias_gestor() {
    var resultados = $('#t1');
    var contador = 1;

    $('#t1').empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA

    resultados.append('<thead><tr><th class="text-center">MOTIVO</th><th class="text-center">SUB MOTIVO</th><th class="text-center">CLASIFICACION</th><th class="text-center">EMPRESA</th><th>TECNICO</th><th>FECHA EMISION</th><th>FECHA CIERRE</th><th>FECHA DESCARGO</th><th>&nbsp;</th></tr></thead>');

    $.ajax({
        url: "servicios_garantia.asmx/garantias_lista_descargos",
        method: 'post',
        data: { opc: 1, id_descargo: 0 },
        dataType: "json",
        success: function (datos) {
            resultados.append('<tbody>');
            $(datos).each(function (index, item) {
                resultados.append('<tr><td class="align-baseline text-center">' + item.motivo + '</td><td class="align-baseline text-center">' + item.submotivo + '</td><td class="align-baseline text-center"><button type="button" class="btn btn-warning" data-toggle="modal" data-target="#modal-info_' + contador + '">Observaciones</button></td><td class="align-baseline text-center">' + item.ctta + '</td><td class="align-baseline">' + item.tecnico + '</td><td class="align-baseline text-center">' + item.fecha_toa.substring(0, 10) + '</td><td class="align-baseline text-center">' + item.fecha_cierre.substring(0, 10) + '</td><td class="align-baseline text-center">' + item.fecha_descargo + '</td><td class="align-baseline"><a href="garantias_formload.aspx?id_descargo=' + item.id_descargo + '" class="btn btn-primary">Trabajar</a></td></tr>');
                inserta_modal(contador);
                $("#modal-info_" + contador + " .modal-body").html(item.comentarios_ctta);
                contador = ++contador;
            });
            resultados.append('</tbody>');
        }
    });
}

function carga_detalle_descargo(id_descargo) {
    var id_clooper = document.getElementById("lbl_id_user").innerText;
    document.getElementById("lbl_id_descargo").innerHTML = id_descargo;

    var nro_peticion = $("#txt_peticion");
    var sintoma = $("#txt_sintoma");
    var f_descargo = $("#txt_fdescargo");
    
    var tecnico = $("#txt_tecnico");
    var empresa = $("#txt_empresa");
    var access = $("#txt_accessid");
    var estado = $("#txt_estado");

    var subtipo_actividad = $("#txt_subtipo");
    var distrito = $("#txt_distrito");
    var gerencia = $("#txt_gerencia");
    var central = $("#txt_central");

    var segmento = $("#txt_segmento");
    var tecnologia = $("#txt_tecno");
    var f_ingreso = $("#txt_fingreso");
    var f_cierre = $("#txt_fcumpl");
    

    // RESPUESTA SUPERVISOR
    var motivo = $("#cbo_motivo");
    var submotivo = $("#cbo_detalle");
    var respuesta_supervisor = $("#txt_resp_supervisor");

    // SERIAL NUMBERS
    var sn_anterior = $("#txt_sn_anterior");
    var sn_actual = $("#txt_sn_actual");

    //alert (id_descargo);

    $.ajax({
        url: "servicios_garantia.asmx/garantias_lista_descargos",
        method: 'post',
        data: { opc: 2, id_descargo: id_descargo },
        dataType: "json", //SE USA POST CUANDO EL WEB SERVICE ME DEVUELVE DATOS. USAR HTML PARA QUE EL SUCCESS FUNCIONE
        success: function (datos) {
            $(datos).each(function (index, item) {
                nro_peticion.val(item.peticion);
                sintoma.val(item.sintoma);
                f_descargo.val(item.fecha_descargo);

                tecnico.val(item.tecnico);
                empresa.val(item.ctta);
                access.val(item.access);
                estado.val(item.estado);

                subtipo_actividad.val(item.subtipo_actividad);
                distrito.val(item.distrito);
                gerencia.val(item.gerencia);
                central.val(item.central);

                segmento.val(item.segmento);
                tecnologia.val(item.tecnologia);
                f_ingreso.val(item.fecha_toa);
                f_cierre.val(item.fecha_cierre);

                respuesta_supervisor.val(item.comentarios_ctta);
                motivo.append($('<option/>', { value: 0, text: item.motivo }));
                submotivo.append($('<option/>', { value: 0, text: item.submotivo }));

                sn_anterior.val(item.sn_anterior);
                sn_actual.val(item.sn_actual);
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

function buscador_descargos_gestor() {
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

    var resultados = $('#t1');
    var contador = 1;
    var sw = 0;

    if (valor_cbo == 0) {
        sw = 1;
        alert("Debe seleccionar empresa.");
    }
    if (fecha_1 == "" || fecha_2 == "") {
        sw = 1;
        alert("Debe completar ambos campos de fecha.");
    }

    if (sw == 0) {
        resultados.empty(); //VACIA LA TABLA ANTES DE CARGAR UNA NUEVA
        resultados.append('<thead><tr><th class="text-center">MOTIVO</th><th class="text-center">SUB MOTIVO</th><th class="text-center">CLASIFICACION</th><th class="text-center">EMPRESA</th><th>TECNICO</th><th>FECHA EMISION</th><th>FECHA CIERRE</th><th>FECHA DESCARGO</th><th>&nbsp;</th></tr></thead>');

        $.ajax({
            url: "servicios_garantia.asmx/garantias_busca_lista_descargos",
            method: 'post',
            data: { empresa: texto_cbo, fecha1: fecha_1, fecha2: fecha_2 },
            dataType: "json",
            success: function (datos) {
                resultados.append('<tbody>');
                $(datos).each(function (index, item) {
                    resultados.append('<tr><td class="align-baseline text-center">' + item.motivo + '</td><td class="align-baseline text-center">' + item.submotivo + '</td><td class="align-baseline text-center"><button type="button" class="btn btn-warning" data-toggle="modal" data-target="#modal-info_' + contador + '">Observaciones</button></td><td class="align-baseline text-center">' + item.ctta + '</td><td class="align-baseline">' + item.tecnico + '</td><td class="align-baseline text-center">' + item.fecha_toa.substring(0, 10) + '</td><td class="align-baseline text-center">' + item.fecha_cierre.substring(0, 10) + '</td><td class="align-baseline text-center">' + item.fecha_descargo + '</td><td class="align-baseline"><a href="garantias_formload.aspx?id_descargo=' + item.id_descargo + '" class="btn btn-primary">Trabajar</a></td></tr>');
                    inserta_modal(contador);
                    $("#modal-info_" + contador + " .modal-body").html(item.comentarios_ctta);
                    contador = ++contador;
                });
                resultados.append('</tbody>');
            }
        });
    }
}

function guardar_descargo_gestor() {
    //Datos clooper
    var id_clooper = document.getElementById("lbl_id_user").innerText;
    var id_descargo = document.getElementById("lbl_id_descargo").innerText;

    // RESPUESTA GESTOR
    var motivo_gestor = document.getElementById("cbo_motivo_gestor").value;
    var submotivo_gestor = document.getElementById("cbo_submotivo_gestor").value;
    var respuesta_gestor = document.getElementById("txt_resp_gestor").value;

    var chequeo_total = 0;

    if (motivo_gestor == "0" || submotivo_gestor == "0") {
        alert("Debe seleccionar el motivo y submotivo de la devoluci\u00F3n");
        chequeo_total = 1;
    }
    if (respuesta_gestor == "") {
        alert("Debe completar el comentario del gestor");
        chequeo_total = 1;
    }

    if (chequeo_total == 0) {
        $.ajax({
            url: "servicios_garantia.asmx/actualiza_descargo",
            method: 'post',
            data: { clooper: id_clooper,
                id_descargo: id_descargo,
                mot: motivo_gestor,
                submot: submotivo_gestor,
                respuesta_gestor: respuesta_gestor
            },
            dataType: "json",
            success: function (datos) {
                $(datos).each(function (index, item) {
                    alert(item.ctta);
                    setTimeout("redireccionar_lista_descargos_gestor()", 500);
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
}
//////////////////////////////////////////////FIN BANDEJA DE DESCARGOS//////////////////////////////////////////////

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
    document.getElementById("h4_modal_" + id_modal).innerHTML = 'Observaciones de la devoluci&oacute;n';
}

function redireccionar_inicio() {
    window.locationf = "index.aspx";
    location.href = "index.aspx";
}

function redireccionar_lista_descargos_gestor() {
    window.locationf = "garantias_lista_gestor.aspx";
    location.href = "garantias_lista_gestor.aspx";
}
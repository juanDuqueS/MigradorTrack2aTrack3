var graf_clientes;
var graf_camiones;
var graf_conductores;

//$(function () {

function eventosCamiones(tipoEvento, flota) {

    var fechas = $("#start").val();

    if (fechas == "") {
        alert('Debe seleccionar un intervalo de fechas válido');
        return;
    }

    var fech_split = fechas.split(" - ")
    var inicio = fechaBD(fech_split[0].replace(" ", ""));
    var fin = fechaBD(fech_split[1].replace(" ", ""));
    var str_flotas = $("#multiselect").val();
    console.log('tipo de evento')
    console.log(tipoEvento)
    //console.log("tipoEvento: " + tipoEvento)
    $.ajax({
        type: "POST",
        url: "frmGraficos.aspx/wmCargarCamiones",
        data: '{"Evento": "' + tipoEvento + '","NomFlota":"' + flota + '","FechaInicio":"' + inicio + '","FechaTermino":"' + fin + '","Flotas":"' + str_flotas + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json", // dataType is json format
        success: function (arg) {
            console.log(arg)
            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;

            
            
            graf_camiones.xAxis.categories = objeto[0]['data'];
            graf_camiones.series[0] = objeto[1];
            
     
            chart = new Highcharts.Chart(graf_camiones);

        }
    });
}

function inicializargraficos() {
    graf_clientes = {
        colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
        chart: {
            renderTo: 'graf_clientes',
            type: 'column'
        },
        title: {
            text: 'Eventos por Flota'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: [],
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Cantidad Eventos'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.0f} eventos</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            series: {
                cursor: 'pointer',
                events: {
                    click: function (event) {
                        eventosCamiones(this.name, event.point.category);

                    }
                }
            },
            column: {
                pointPadding: 0.2,
                borderWidth: 0,
                colorByPoint: false
            }
        },
        series: []
    }




    graf_camiones = {
        colors: ['#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
        chart: {
            renderTo: 'graf_camiones',
            type: 'column'
        },
        title: {
            text: 'Eventos por Camiones'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: [],
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Cantidad de Eventos'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.0f} eventos</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: []
    }



    graf_camiones = {
        colors: ['#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
        chart: {
            renderTo: 'graf_camiones',
            type: 'column'
        },
        title: {
            text: 'Eventos por Vehiculo'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: [],
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Cantidad de Eventos'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.0f} eventos</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: []
    }
}
//});

function cargarClientes() {

    // console.log('into cargarCliente');
    //var IdUsuario = 563; //6780 = lleiva.gpschile ;// $("#hdnCod_Usuario").val();
    var IdUsuario = $("#hdnCod_Usuario").val();

    $.ajax({
        async: true,
        type: 'POST',
        url: "frmInforme.aspx/wmCargarClienteporUsuario",
        data: "{'IdUsuario':" + IdUsuario + "}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {
            // console.log(arg);
            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;
            for (var i = 0; i < objeto.length; i++) {
                if (i == 0) cargarFlotas(objeto[i].Id_Cliente);

                $('#listaCliente').append($('<option>', {
                    value: objeto[i].Id_Cliente,
                    text: objeto[i].NomCliente
                }));
            }
            $('#listaCliente').selectpicker('refresh');
        }
    });
}
function cambioFlota(sel) {

    $('#multiselect')
        .find('option')
        .remove()
        .end()
        .empty();

    var sel_;
    $("#listaCliente").each(function () {

        procesarSeleccionado($(this).val())
    });
    //cargarFlotas(sel.value);
}

function procesarSeleccionado(seleccionados) {
    console.log(seleccionados);

    for (var i = 0; i < seleccionados.length; i++) {
        console.log(seleccionados[i]);
        cargarFlotas(seleccionados[i]);
    }

}

function cargarFlotas(idcliente) {
    var id;
    //console.log('id cliente');
    //console.log(idcliente);
    if (idcliente != null) {
        id = idcliente;
    } else {
        id = $("#listaCliente").val();
    }

    //var IdUsuario = 5999; //6780 = lleiva.gpschile ;// $("#hdnCod_Usuario").val();
    var IdUsuario = $("#hdnCod_Usuario").val();
    // console.log(IdUsuario);
    $.ajax({
        async: false,
        type: 'POST',
        url: "frmInforme.aspx/wmCargarFlotasCliente",
        data: "{'IdUsuario':" + id + "}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;
            console.log(objeto)
            for (var i = 0; i < objeto.length; i++) {
                $('#multiselect').append($('<option>', {
                    value: objeto[i].Cod_Flota,
                    text: objeto[i].NomFlota
                }));
            }
            $('#multiselect').selectpicker('refresh');

        }
    });

}
/*
function cargarFlotas() {
   var IdUsuario = $("#hdnCod_Usuario").val();
   // var IdUsuario = 6780;
    $.ajax({
        async: false,
        type: 'POST',
        url: "frmGraficos.aspx/wmCargarFlotasCliente",
        data: "{'IdUsuario':" + IdUsuario + "}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;
            for (var i = 0; i < objeto.length; i++) {
                $('#multiselect').append($('<option>', {
                    value: objeto[i].Cod_Flota,
                    text: objeto[i].NomFlota
                }));
            }

        }
    });

}
*/

$(document).ready(function () {
    $('#start').daterangepicker({
        format: "DD/MM/YYYY",
        language: "es"
    });

    $('#multiselect').selectpicker({
        //style: 'btn-info',
        size: 10
    });
    $('#listaCliente').selectpicker({
        //style: 'btn-info',
        size: 10
    });
    $('#listaCliente').change(function () {
        var str = "";
    })

    $("#toggleButtonBarraNavegacion").css('marginTop', '-29px');
    $("#barraNavegacion").addClass('hidden');

    $('.box-container').sortable({
        connectWith: '.box-container',
        items: '> .box',
        opacity: 0.8,
        revert: true,
        forceHelperSize: false,
        placeholder: 'box-placeholder',
        forcePlaceholderSize: true,
        tolerance: 'pointer',
        cursor: "move",
        containment: "document"
    }).disableSelection();
    diasValidos();
    numFlotasValidas();
    inicializargraficos();
    //cargarGrafClientes();
});


function diasValidos() {
    $.ajax({
        async: true,
        type: 'POST',
        url: "frmGraficos.aspx/wmDiasValidos",
        data: "{}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                $("#diasValidos").val(1);
            }
            else {
                var objeto = arg.d;
                $("#diasValidos").val(objeto);
            }

        }
    });
}

function numFlotasValidas() {
    $.ajax({
        async: true,
        type: 'POST',
        url: "frmGraficos.aspx/wmNumFlotasValidas",
        data: "{}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                $("#numFlotasValidas").val(1);
            }
            else {
                var objeto = arg.d;
                $("#numFlotasValidas").val(objeto);
            }

        }
    });
}

function fechaBD(fecha) {
    var parseo = fecha.split("/");
    return parseo[2] + parseo[1] + parseo[0];
}
function animar() {
    if ($("#barraNavegacion").hasClass('hidden')) {
        $("#toggleButtonBarraNavegacion").animate({ marginTop: '0px' }, 300);
        $("#barraNavegacion").animate({ marginTop: '0px' }, 300);
        $("#barraNavegacion").removeClass('hidden');
        $("#textoSolapaSuperior").html('<img src="../img/navBarOcultar.png"> Ocultar');
    } else {
        $("#toggleButtonBarraNavegacion").animate({ marginTop: '-29px' }, 300);
        $("#barraNavegacion").animate({ marginTop: '-29px' }, 300);
        $("#barraNavegacion").addClass('hidden');
        $("#textoSolapaSuperior").html('<img src="../img/navBarMostrar.png"> Ver m&oacute;dulos');
    }
}

function generarGraficos() {
    var fechas = $("#start").val();
    var str_flotas = $("#multiselect").val();
    $("#listaFlotas").val($("#multiselect").val());
    var str_flotas2 = $("#listaFlotas").val();

    if (str_flotas == null) {
        alert('Debe seleccionar al menos una flota.');
        return;
    }
    if (fechas == '') {
        alert('Debe seleccionar fechas de consulta.');
        return;
    }

    flotas_ = str_flotas2.split(",");
    if (flotas_.length > numFlotasValidas) {
        alert("El número de flotas seleccionadas, supera el límite permitido para consultar (" + numFlotasValidas + ").");
        return;
    }

    var fech_split = fechas.split(" - ")
    var fecha1 = fech_split[0].split("/");
    var fecha2 = fech_split[1].split("/");
    var diasValidos = $("#diasValidos").val();

    var inicio = fechaBD(fech_split[0].replace(" ", ""));
    var fin = fechaBD(fech_split[1].replace(" ", ""));

    var inicio = fechaBD(fech_split[0].replace(" ", ""));
    var fin = fechaBD(fech_split[1].replace(" ", ""));

    var anyo1 = inicio.substr(0, 4);
    var mes1 = inicio.substr(4, 2);
    var dia1 = inicio.substr(6, 2);

    var anyo2 = fin.substr(0, 4);
    var mes2 = fin.substr(4, 2);
    var dia2 = fin.substr(6, 2);

    var nuevafecha1 = new Date(anyo1 + "," + mes1 + "," + dia1);
    var nuevafecha2 = new Date(anyo2 + "," + mes2 + "," + dia2);

    var Dif = nuevafecha2.getTime() - nuevafecha1.getTime();
    var dias = Math.floor(Dif / (1000 * 24 * 60 * 60));


    if (dias > diasValidos) {
        alert("El rango de fechas seleccionado, supera el límite permitido para consultar (" + diasValidos + ").");
        return;
    }
    cargarGrafClientes(fecha1[2] + fecha1[1] + fecha1[0], fecha2[2] + fecha2[1] + fecha2[0]);
}


function cargarGrafClientes(fecha1,fecha2) {

    var str_flotas = $("#multiselect").val();
    $.ajax({
        type: "POST",
        url: "frmGraficos.aspx/wmCargarClientes", 
        data: '{"FechaInicio":"' + fecha1 + '","FechaTermino":"' + fecha2 + '","Flotas":"' + str_flotas + '" }',
        contentType: "application/json; charset=utf-8",
        dataType: "json", // dataType is json format
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                 return;
            }
            
            var objeto = arg.d;
 
            graf_clientes.xAxis.categories = objeto[0]['data'];
            graf_clientes.series[0] = objeto[1];
            graf_clientes.series[1] = objeto[2];
             chart = new Highcharts.Chart(graf_clientes);
            
        },
        error: OnErrorCall
    });
   
    
    function OnErrorCall(response) {
        console.log(error);
        alert(error);
    }

    
}


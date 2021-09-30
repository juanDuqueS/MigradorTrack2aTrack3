
var datatable;
var informe;
var compass;
var refreshId;
var resultSitio;

$(document).ready(function () {

    $('#start').daterangepicker({
        "format": "DD/MM/YYYY",
        
        language: "es"
    });
    $('#start2').daterangepicker({
        "format": "DD/MM/YYYY hh:mm:ss",
        "timePicker": true,
        "timePickerIncrement": 1,
        "timePicker12Hour": true,
        "drops": "up",
        timePicker24Hour: false,
        language: "es"
    });
    $('#fecha_edits').daterangepicker({
        "format": "DD/MM/YYYY hh:mm:ss",
        "timePicker": true,
        "timePickerIncrement": 1,
        "timePicker12Hour": true,
        "drops": "up",
        timePicker24Hour: false,
        language: "es"
    });
    
    $('#multiselect2').selectpicker({
        //style: 'btn-info',
        size: 10
    });

    $('#multiselect').selectpicker({
        //style: 'btn-info',
        size: 10
    });
    $('#multiselect').change(function () {
        var str = "";
    })
    $('#sitio').selectpicker({
        //style: 'btn-info',
        size: 10
    });
    $('#sitio2').selectpicker({
        //style: 'btn-info',
        size: 10
    });
    $('#listaEventos').selectpicker({
        //style: 'btn-info',
        size: 10
    });
    

    
  
    function limpiarObjetosCapacho() {

        $("#identificador_capacho").val('')
        $("#serie_agorabee").val('');
        $("#descripcion_capacho").val('');
        $("#serie_agorabee_editar").val('');
        $("#descripcion_capacho_editar").val('');
    }

    $("#toggleButtonBarraNavegacion").css('marginTop', '-29px');
    $("#barraNavegacion").addClass('hidden');

    datatable = $('#example1').dataTable({
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": false,
        "bSort": false,
        "bInfo": true,
        "bAutoWidth": false,
        "order": [[4, "asc"]]
    });

    informe = $('#dtcapachos').dataTable({
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": false,
        "bSort": false,
        "bInfo": true,
        "bAutoWidth": false,
        "bDeferRender": true
    });

    diasValidos();
    numFlotasValidas();

    $("#example1").on('click', 'tbody tr', function (e) {

        if ($(this).hasClass('row_selected')) {
            $(this).removeClass('row_selected');
        } else {
            datatable.$('tr.row_selected').removeClass('row_selected');
            $(this).addClass('row_selected');

            // Get the data from the selected row

            var flota = datatable.fnGetData(this, 0);
            var patente = datatable.fnGetData(this, 1);
            var refvehiculo = datatable.fnGetData(this, 2);
            var fecha = datatable.fnGetData(this, 3);
            var evento = datatable.fnGetData(this, 4);
            var desevento = datatable.fnGetData(this, 5);
            var velocidad = datatable.fnGetData(this, 6);
            var ubicacion = datatable.fnGetData(this, 7);

        }
    });


    $("#example1 tbody").click(function (event) {
        $(datatable.fnSettings().aoData).each(function () {

            $(this.nTr).removeClass();
        });
        $(event.target.parentNode).addClass('even_td');
    });
});


function diasValidos() {
    $.ajax({
        async: true,
        type: 'POST',
        url: "MantenedorPeaje.aspx/wmDiasValidos",
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
        url: "MantenedorPeaje.aspx/wmNumFlotasValidas",
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


//$("#sitio").change(function () {

//    var sitio = [];
//    $("#sitio").each(function () {
//        console.log($(this).text());
////        alert($(this).text());
//        sitio.push($(this).text());
//    });
//    var result = sitio.join(",");
//    resultSitio = result;
//    console.log(resultSitio);
//   // result =null;
//});

var Res_Sitios;


$("#sitio").change(function () {
    //Flotas = null
    //$("#sitio").each(function () {
    //    //console.log($(this).val());
    //    var Res_Sitios = $(this).val();

    //});
    Res_Sitios = $(this).val();
    console.log('Ressitios'+ Res_Sitios);
});





var resultFlotas = null;

//var Flotas = [];

$("#multiselect").change(function () {
   
    //Flotas = null
    $("#multiselect").each(function () {
        console.log($(this).val());
        cambiarSitio($(this).val());
    });
  
});

$('#editarcapacho').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget) // Button that triggered the modal
    var recipient = button.data('whatever') // Extract info from data-* attributes
    console.log('mostrando en modal editar')
    console.log(recipient)
    var res = recipient.split(",");

    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    var modal = $(this)
    //modal.find('.modal-title').text('New message to ' + recipient)
    $("#NomFlota").val(res[2]);
    $("#cod_peaje").val(res[0]);
    $("#codflota_edit").val(res[1]);
    $("#sitio_edit").val(res[3]);
    $("#fecha_edits").val(res[4] + " - " + res[5]);
    //$("#fecha_edit").val(res[3]);
    $("#valorp_edit").val(res[6]);
});

function generarExcel() {

    //var sitio_1 = $("#sitio option:selected").text();
    var sitio_1 = Res_Sitios;
    console.log('mostrando sitio formateado')
    console.log(sitio_1);
    var str_flotas = $("#multiselect").val();
    $("#listaFlotas").val($("#multiselect").val());
    
    var str_eventos = $("#listadoEvento").val();
    var str_flotas2 = $("#listaFlotas").val();
    var fechas = $("#start").val();
    var diasValidos = $("#diasValidos").val();
    var numFlotasValidas = $("#numFlotasValidas").val();

    if (str_flotas == null) {
        alert('Debe seleccionar al menos una flota.');
        return;
    }
    if (fechas == '') {
        alert('Debe seleccionar fechas de consulta.');
        return;
    }

    fechas_ = fechas.split("-");
    flotas_ = str_flotas2.split(",");
    if (flotas_.length > numFlotasValidas) {
        alert("El número de flotas seleccionadas, supera el límite permitido para consultar (" + numFlotasValidas + ").");
        return;
    }

    var inicio = fechaBD(fechas_[0].replace(" ", ""));
    console.log('fecha_ini'+ inicio)
    var fin = fechaBD(fechas_[1].replace(" ", ""));
    console.log('fecha_fin' + fin);

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

    $("#loading").append("<div id='cargando' class='overlay'></div><div class='loading-img'></div>");
    
    $.ajax({
        async: true,
        type: 'POST',
        url: "MantenedorPeaje.aspx/wmVisualizarMantenedor",
        //data: "{'Flotas':'" + str_flotas + "','Fechas':'" + inicio + "-" + fin + "','Filtros':'" + str_eventos + "','Todos':' }",
        data: "{cod_flota:'" + str_flotas + "',sitio:'" + sitio_1 + "','Fechas':'" + inicio + "-" + fin + "'}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {
            
            if (arg.d == "{}" | arg.d == "") {

                informe.fnClearTable();
                $(".overlay").remove();
                $(".loading-img").remove();
                return;
            }
            var objeto = arg.d;
            console.log('objeto mostrando ');
            console.log(objeto);
            informe.fnClearTable();
            for (var i = 0; i < objeto.length; i++) {
                var url =
                    
                    informe.fnAddData([
                        //objeto[i].cod_flota,
                        objeto[i].nomflota,
                        //objeto[i].cod_peaje,
                        objeto[i].sitio,
                        objeto[i].fecha_fin,
                        objeto[i].fecha_ini,
                        objeto[i].valor_peaje,
                        '<div class="btn-group">' +
                        '<button type="button" class="btn btn-default" title="Editar" data-toggle="modal" data-target="#editarcapacho" data-whatever="' + objeto[i].cod_peaje + ',' + objeto[i].cod_flota + ',' + objeto[i].nomflota + ',' + objeto[i].sitio + ',' + objeto[i].fecha_ini + ',' + objeto[i].fecha_fin + ',' + objeto[i].valor_peaje + '"><i class="fa fa-edit"></i></button>' +
                        '<button type="button" class="btn btn-default" onclick="eliminarM(' + "'" + objeto[i].cod_peaje + "'" + ');" title="Eliminar"><i class="fa fa-trash-o"></i></button>' +
                        '</div>'                     
                    ]);
            }
            $(".overlay").remove();
            $(".loading-img").remove();
        }
    });
}

function eliminarM(cod_peaje) {

    var r = confirm("Está seguro desea eliminar este Registro?");
    if (r == true) {
        $.ajax({
            async: true,
            type: 'POST',
            url: "MantenedorPeaje.aspx/wmEliminar",
            data: "{'cod_peaje':'" + cod_peaje + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (arg) {
                if (arg.d == "{}" | arg.d == "") {
                    return;
                }
                var objeto = arg.d;
                if (objeto == 1) {
                    alert("Registro Eliminado");
                } else {
                    alert("No se ha eliminado el Registro");
                }
            }
       });
    }
    //location.reload();
    ///*Forzamos la recarga*/
    //location.reload(true);
}



function fechaBD(fecha) {
    var parseo = fecha.split("/");
    return parseo[2] + parseo[1] + parseo[0];
}

function fechaBD2(fechax) {
    var parseo2 = fechax.split("|");
    return parseo2[2] + parseo2[1] + parseo2[0];
}

function nuevaalerta(hora) {
    var horaanterior = $("#ultimahora").val();    
}


function cargarFlotas() {

    // var IdUsuario = 6780; //6780 = lleiva.gpschile ;// $("#hdnCod_Usuario").val();
    var IdUsuario = $("#hdnCod_Usuario").val();
    //console.log(IdUsuario);
    $.ajax({
        async: false,
        type: 'POST',
        url: "MantenedorPeaje.aspx/wmCargarFlotasCliente",
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


function cambiarSitio(resultFlotas) {
    $('#sitio').empty();
    
    console.log('entrando en cambiarSitio')
    var codFlota = resultFlotas;
    console.log('imprime resultFlotas ' + codFlota);
   
    //var IdUsuario = $("#hdnCod_Usuario").val();
 
    $.ajax({
        async: false,
        type: 'POST',
        url: "MantenedorPeaje.aspx/wmCargarSitiosFlota",
        data: "{cod_flota:'" + codFlota + "'}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            //if (arg.d == "{}" | arg.d == "") {
            //    return;
            //}
            var objeto = arg.d;
            console.log(objeto);
            for (var i = 0; i < objeto.length; i++) {
                
                $('#sitio').append($('<option>', {
                                //value: objeto[i].cod_flota,
                                text: objeto[i].sitio
                }));
            }
            $('#sitio').selectpicker('refresh');
        }
    });    
}


function cargarFlotas2() {
    // var IdUsuario = 6780; //6780 = lleiva.gpschile ;// $("#hdnCod_Usuario").val();
    var IdUsuario = $("#hdnCod_Usuario").val();

    $.ajax({
        async: false,
        type: 'POST',
        url: "MantenedorPeaje.aspx/wmCargarFlotasCliente",
        data: "{'IdUsuario':" + IdUsuario + "}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;
            for (var i = 0; i < objeto.length; i++) {
                $('#multiselect2').append($('<option>', {
                    value: objeto[i].Cod_Flota,
                    text: objeto[i].NomFlota
                }));
            }
        }
    });
}


function cambioSitio2(sel2) {
    console.log('cambioSitio2(sel2)')
    $('#sitio2')
        .find('option')
        .remove()
        .end()
        .empty();

    var sel_;

    $("#multiselect2").each(function () {

        procesarSeleccionado2($(this).val())
    });
    //cargarFlotas(sel.value);
}

function procesarSeleccionado2(seleccionados2) {
    //console.log(seleccionados);

    for (var i = 0; i < seleccionados2.length; i++) {
        console.log('seleccinados')
        console.log(seleccionados2[i]);
        cambiarSitio2(seleccionados2[i]);
    }
}

function cambiarSitio2(cod_flota) {

    console.log('cambiarSitio2(cod_flota)')
    var codFlota;
    console.log('cod_flota');
    console.log(cod_flota);
    if (cod_flota != null) {
        codFlota = cod_flota;
    } else {
        id = $("#multiselect2").val();
    }
    var IdUsuario = $("#hdnCod_Usuario").val();

    $.ajax({
        async: false,
        type: 'POST',
        url: "MantenedorPeaje.aspx/wmCargarSitiosFlota",
        data: "{'cod_flota':" + codFlota + "}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {
            console.log(arg);
            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;

            for (var i = 0; i < objeto.length; i++) {
                $('#sitio2').append($('<option>', {
                    value: objeto[i].cod_flota,
                    text: objeto[i].sitio
                }));
            }
            
           $('#sitio2').selectpicker('refresh');

        }
    });
}

function validaPeaje() {

    var identificadorCapachoEntrante = $("#identificador_capacho").val();
    var serieAgorabeeEntrante;
    var editar = false;

    if ($("#serie_agorabee").val().length > 0) {
        serieAgorabeeEntrante = $("#serie_agorabee").val().trim();
    } else {
        serieAgorabeeEntrante = $("#serie_agorabee_editar").val().trim();
        editar = true;
    }

    var MyRows = $('#dtcapachos').find('tbody').find('tr');

    for (var i = 0; i < MyRows.length; i++) {

        var identificadorCapacho = $(MyRows[i]).find('td:eq(0)').html();
        var agorabee = $(MyRows[i]).find('td:eq(1)').html();
        var des = $(MyRows[i]).find('td:eq(2)').html();


        if (identificadorCapachoEntrante === identificadorCapacho) {

            alert("Ya existe un identificador de capacho con el registro " + identificadorCapachoEntrante);
            return;
        }

        if (!editar) {


            if (serieAgorabeeEntrante === agorabee) {

                alert("Ya existe una serie de Agorabee con el registro " + serieAgorabeeEntrante);
                return;
            }
        }
    }
    return true;
}


function guardarCapacho() {

    var flota_p = $("#multiselect2").val();
    var serie_p =$("#sitio2 option:selected").text();
    var fechas_p = $("#start2").val();
    var valor_p = $("#valor_peaje").val();
    var fechas_ = fechas_p;
    fechas_p = fechas_p.replace(" - ", "-");
    console.log(fechas_p);
    fechas_p = fechas_p.split("-");
    var fecha_ini = fechas_p[0];
    var fecha_fin = fechas_p[1];
    console.log('fecha inicial: ' + fecha_ini)
    console.log('fecha_final: ' + fecha_fin)

    

    //if (validaPeaje()) {

    $.ajax({
        async: true,
        type: 'POST',
        url: "MantenedorPeaje.aspx/wmGuardaMantenedor",
        data: "{'cod_flota':'" + flota_p + "','sitio':'" + serie_p + "','Fechas':'" + fecha_ini + "-" + fecha_fin + "','valor_peaje':'" + valor_p + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (arg) {
            
            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;
            console.log(objeto);
            if (objeto == 1) {
                alert("Capacho registrado exitosamente.");
                
                $('#nuevoCapacho').modal('hide');
            } else {
                alert("Ha ocurrido un error al registrar Capacho");
            }
        }
    });
    //location.reload();
    ///*Forzamos la recarga*/
    //location.reload(true);
}

function guardarCambios() {

    var cod_peaje = $("#cod_peaje").val();
    console.log('cod_peaje.. ' + cod_peaje);
    var sitio_edit = $("#sitio_edit").val();
    console.log('sitio ' + sitio_edit)
    var fecha_edit = $("#fecha_edits").val();
    console.log(fecha_edit);
    var valor_peajeEdit = $("#valorp_edit").val();
    
    fecha_ = fecha_edit.replace(' - ', '-')
    fechas_ = fecha_.split("-");
    //fechas_ = fecha_.split(" ");
    //console.log('mostrando fechas v3 ' + fechas_)
    //console.log('Fecha_Inicial '+fechas_[0])
    
    var inicio = fechas_[0];
    console.log(inicio)
    var fin = fechas_[1];
    console.log(fin)
    //console.log('fechas y hiras separadas ' + fechaini +' - '+ horaini)
    
    //var date = inicio.split('/');
    //console.log('split '+date)
    //console.log('parseaos ' + date[2]);
    //console.log('fecha_ini ' + inicio)
    //var fin = fechas_[1];
    //console.log('fecha_fin ' + fin);

    //if (validacionCapacho()) {

        //if (sitio_edit == "") {
        //    alert("Debe ingresar la Serie del Agorabee");
        //    return;
        //}

        //if (fecha_edit == "") {
        //    alert("Debe ingresar la descripción del Capacho");
        //    return;
        //}
        $.ajax({
            async: true,
            type: 'POST',
            url: "MantenedorPeaje.aspx/wmUpdateMantenedor",
            data: "{'cod_peaje':'" + cod_peaje + "','sitio':'" + sitio_edit + "','Fechas':'" + inicio + "-" + fin + "','valorPeaje':'" + valor_peajeEdit + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (arg) {

                if (arg.d == "{}" | arg.d == "") {
                    return;
                }
                var objeto = arg.d;
                console.log('mostrando objeto')
                console.log(objeto)
                if (objeto == 1) {

                    alert("Actualizado.");
                    //limpiarObjetosCapacho();
                   
                    $('#editarcapacho').modal('hide');
                } else {
                    alert("Ha ocurrido un error al Actualizar Capacho. Por favor Revise los datos");
                }
            }

        });
        //location.reload();
    /*Forzamos la recarga*/
        //location.reload(true);
    //}
}


function cargarEventos() {

    $.ajax({
        async: false,
        type: 'POST',
        url: "MantenedorPeaje.aspx/wmCargarEventos",
        data: "{}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;

            for (var i = 0; i < objeto.length; i++) {
                $('#listaEventos').append($('<option>', {
                    value: objeto[i].CodEvento,
                    text: objeto[i].NomEvento
                }));
            }
        }
    });
}

function ParseFecha(Fecha) {
    var fecha = Fecha.replace(' ', '');
    var date = fecha.split('/');
    return date[2] + date[0] + date[1];
}

function Excel() {
    alert('into funcion excel');
}
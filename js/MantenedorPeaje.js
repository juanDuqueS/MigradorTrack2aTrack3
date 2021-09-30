
var datatable;
var informe;
var compass;
var refreshId;
var resultSitio;
var sitioAntiguo;
var fechainiAntiguo;
var fechafinAntiguo;
var valorPeajeAntiguo;
var codFlotaEdit;


$(document).ready(function () {

    $('#start').daterangepicker({
        format: "DD/MM/YYYY",
        timePicker: false,
        timePicker24Hour: true,
        timePickerIncrement: 1  ,
 
    });
    $('#start2').daterangepicker({
        format: "DD/MM/YYYY H:mm:ss",
        timePicker: true,
        "timePickerIncrement": 1,
        timePicker12Hour: false,
        "drops": "up",
        timePicker24Hour: true,
        language: "es"
    });
    $('#fecha_edits').daterangepicker({
        format: "DD/MM/YYYY H:mm:ss",
        timePicker: true,
        "timePickerIncrement": 1,
        timePicker12Hour: false,
        "drops": "up",
        timePicker24Hour: true,
        language: "es"
    });
    $('#start3').daterangepicker({
        "format": "DD/MM/YYYY H:mm:ss",
        timePicker: true,
        "timePickerIncrement": 1,
        timePicker12Hour: false,
        "drops": "up",
        timePicker24Hour: true,
        language: "es"
    });

    $('#multiselect3').selectpicker({
        //style: 'btn-info',
        size: 10
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
    $("#multiselect2").change(
        
        function () {
            console.log('into function');
            $("#sitio2").empty();
            cambiarSitio2();
            $("#sitio2").selectpicker('refresh');
        }
    );
    cambiarSitio2();    

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
        "select": true,
        "bDeferRender": true,
        "order": [[4, "asc"]]
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

function limpiar() {

    $("#multiselect2").val('')
    $("#sitio2").val('');
    $("#start2").val('');
    $("#valor_peaje").val('');
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


var Res_Sitios;


$("#sitio").change(function () {
     Res_Sitios = $(this).val();
    console.log('Ressitios'+ Res_Sitios);
});

var resultFlotas = null;

$("#multiselect").change(function () {
   
    //Flotas = null
    $("#multiselect").each(function () {
        console.log($(this).val());
        cambiarSitio($(this).val());
    });
  
});

$('#editarPeajes').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget) // Button that triggered the modal
    var recipient = button.data('whatever') // Extract info from data-* attributes
    //console.log('mostrando en modal editar')
    //console.log(recipient)
    var res = recipient.split(",");
    var modal = $(this);
     
    $("#NomFlota").val(res[2]);
    $("#cod_peaje").val(res[0]);
    $("#codflota_edit").val(res[1]);
    $("#sitio_edit").val(res[3]);
    $("#fecha_edits").val(res[4] + " - " + res[5]);
    $("#valorp_edit").val(res[6]);
    codFlotaEdit = res[1];
    sitioAntiguo = res[3];
    fechainiAntiguo = res[4];
    fechafinAntiguo = res[5];
    valorPeajeAntiguo = res[6];
    
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
                var fechaInicial = objeto[i].fecha_ini.replace("-","/");
                fechaInicial = fechaInicial.replace("-", "/");
                //console.log("FECHAS: " + fechaInicial);
                var fechaFinal = objeto[i].fecha_fin.replace("-", "/");
                fechaFinal = fechaFinal.replace("-", "/");
                //console.log("FECHAS2: " + fechaFinal);

                var url =
                    informe.fnAddData([
                        //objeto[i].cod_flota,
                        objeto[i].nomflota,
                        //objeto[i].cod_peaje,
                        objeto[i].sitio,
                        fechaInicial,
                        fechaFinal,
                        
                        objeto[i].valor_peaje,
                        '<div class="btn-group">' +
                        '<button type="button" class="btn btn-default" title="Editar" data-toggle="modal" data-target="#editarPeajes" data-whatever="' + objeto[i].cod_peaje + ',' + objeto[i].cod_flota + ',' + objeto[i].nomflota + ',' + objeto[i].sitio + ',' + fechaInicial + ',' + fechaFinal + ',' + objeto[i].valor_peaje + '"><i class="fa fa-edit"></i></button>' +
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
                console.log('eliminando ');
                if (objeto == 1) {
                    alert("Registro Eliminado");
                    generarExcel();
                    $('#sitio').selectpicker('refresh');
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
function cargarFlotas3() {
 
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
                $('#multiselect3').append($('<option>', {
                    value: objeto[i].Cod_Flota,
                    text: objeto[i].NomFlota
                }));
            }
        }
    });
}
$("#sitio2").change(function () {

    console.log($(this).val());

});


function cambiarSitio2() {
    
   // $("#sitio2").empty();
    var codFlota = $("#multiselect2").val();
    console.log(codFlota);
    
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

//NUEVO REGISTRO
function guardarNuevo() {
    console.log('into guardar Nuevo')
    console.log($("#multiselect3").val() + ' ' + $("#sitio_n").val() + ' ' + $("#start3").val())


    if ($("#multiselect3").val() != null && $("#sitio_n").val().length > 0 && $("#start3").val().length > 0) {
        console.log('entra guardarNuevo')
        var flota_p = $("#multiselect3").val();
        var serie_pa = $("#sitio_n").val();

        console.log('flota' + flota_p + '' + 'sitio' + sitio_n)
        var fechas_p = $("#start3").val();
        var valor_p2 = $("#valor_peaje2").val();
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
            data: "{'cod_flota':'" + flota_p + "','sitio':'" + serie_pa + "','Fechas':'" + fecha_ini + "-" + fecha_fin + "','valor_peaje':'" + valor_p2 + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (arg) {

                if (arg.d == "{}" | arg.d == "") {
                    return;
                }
                var objeto = arg.d;
                console.log('INSERT EN TABLA');
                console.log(objeto);
                if (objeto == 'Registro insertado con éxito') {
                    alert(objeto);
                    
                    $('#nuevo2').modal('hide');
                    //limpiar();
                    $("#multiselect3 option:selected").val('default');
                    $("#multiselect3").selectpicker("refresh");
                    $("#sitio_n").val('');
                    $("#start3").val('');
                    $("#valor_peaje2").val('');
                   
                   // location.reload();
        /*Forzamos la recarga*/
        //location.reload(true);
                } else {
                    alert("Ha ocurrido un error al registrar, " + objeto);
                    limpiar();
                }
            }
        }
        );
        
    } else return alert('Por favor verificar campos modal nuevo')
    limpiar();
}

function limpiar2() {

    $("#multiselect2").val('')
    $("#sitio2").val('');
    $("#start2").val('');
    $("#valor_peaje").val('');
}
//GUARDAR EN TABLA
function guardarEnTabla() {
    console.log('into guardarEnTabla')

    if ($("#multiselect2").val() != null && $("#sitio2 option:selected").text().length > 0 && $("#start2").val().length > 0) {
        var flota_p = $("#multiselect2").val();
        var serie_p = $("#sitio2 option:selected").text();

        console.log('flota' + flota_p + '' + 'sitio' + serie_p)
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
                //console.log('arg ' + arg.d);
                //if (arg.d == "{}" | arg.d == "") {
                //    console.log('into asdasdsad')
                //    return;
                //}
                var objeto = arg.d;
                console.log('insert 222');
                console.log(objeto);
                if (objeto == 'Registro insertado con éxito') {
                    alert(objeto);
                    generarExcel();
                    limpiar2();
                    $('#nuevoRegTbl').modal('hide');
                } else {
                    alert("Ha ocurrido un error al registrar **asdas, " + objeto);

                    $("#multiselect2 option:selected").val('default');
                    $("#multiselect2").selectpicker("refresh");

                    $("#sitio2").empty();
                    cambiarSitio2();
                    $("#sitio2").selectpicker('refresh');

                }
            }
        });

    } else return alert('Por favor verificar campos');
    limpiar2();
}
//UPDATE
function guardarCambios() {

    //sitioAntiguo
    //fechainiAntiguo
    //fechafinAntiguo
    //valorPeajeAntiguo

    var codFlota = codFlotaEdit;
    console.log('MOSTRANDO VALORES ANTIGUOS: ' + codFlota+ sitioAntiguo+' '+ fechainiAntiguo+' ' + fechafinAntiguo+' ' + valorPeajeAntiguo);

    var cod_peaje = $("#cod_peaje").val();
    var sitio_new = $("#sitio_edit").val();
    var fechaNew = $("#fecha_edits").val();
    var valorPeaje_new = $("#valorp_edit").val();
    console.log('MOSTRANDO VALORES NUEVOS: ' + cod_peaje + ' ' + sitio_new + ' ' + fechaNew + ' ' + valorPeaje_new);
    
    fecha_ = fechaNew.replace(' - ', '-')
    fechas_ = fecha_.split("-");
    
    var FechainicioNew = fechas_[0];
    var FechafinNew = fechas_[1];
 
        $.ajax({
            async: true,
            type: 'POST',
            url: "MantenedorPeaje.aspx/wmUpdateMantenedor",
            data: "{'codFlota':'" + codFlota + "','cod_peaje':'" + cod_peaje + "','sitio_new':'" + sitio_new + "','Fechas_new':'" + FechainicioNew + "-" + FechafinNew + "','valorPeaje_new':'"
            + valorPeaje_new + "','sitioAntiguo':'" + sitioAntiguo + "','Fechas_ant':'" + fechainiAntiguo + "-" + fechafinAntiguo + "','valorPeajeAntiguo':'" + valorPeajeAntiguo + "'}",
             
            contentType: "application/json; charset=utf-8",
            success: function (arg) {

                if (arg.d == "{}" | arg.d == "") {
                    return;
                }
                var objeto = arg.d;
                console.log('mostrando objeto')
                console.log(objeto)
                if (objeto == 'Registro modificado con éxito') {

                    alert(objeto);
                    
                    generarExcel();
                    limpiar();
                    cambiarSitio(resultFlotas)
                    generarExcel();
                    $('#editarPeajes').modal('hide');
                } else {
                    alert(objeto);
                    
                }
               }

    });
       
    //    location.reload();
    ///*Forzamos la recarga*/
    //    location.reload(true);
    
}



function ParseFecha(Fecha) {
    var fecha = Fecha.replace(' ', '');
    var date = fecha.split('/');
    return date[2] + date[0] + date[1];
}
function prueba() {

    var MyRows = $('#dtcapachos').find('tbody').find('tr');
    console.log('mostrando tabla ' + MyRows.length)

    for (var i = 0; i < MyRows.length; i++) {
        var a = $(MyRows[i]).find('td:eq(2)').html();
        var b = $(MyRows[i]).find('td:eq(3)').html();
        console.log('show :'+a + ' ' + b);
    }

}
function Excel2() {
    
    
}
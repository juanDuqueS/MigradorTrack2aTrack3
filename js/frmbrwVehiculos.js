
var datatable;
var grilla_izquierda;
var grilla_derecha;
var informe;
var compass;
var refreshId;
var senso;
var sitio;

$(document).ready(function () {
    
   

    $("#toggleButtonBarraNavegacion").css('marginTop', '-29px');
    $("#barraNavegacion").addClass('hidden');

    
    datatable = $('#example2').dataTable({
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": true,
        "bSort": false,
        "bInfo": true,
        "bAutoWidth": false,
        "bDeferRender": true
    });

    grilla_izquierda = $('#grilla_izquierda').dataTable({
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": true,
        "bSort": false,
        "bInfo": true,
        "bAutoWidth": false,
        "bDeferRender": true
    });

    grilla_derecha = $('#grilla_derecha').dataTable({
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": true,
        "bSort": false,
        "bInfo": true,
        "bAutoWidth": false,
        "bDeferRender": true
    });


    $('#myModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var recipient = button.data('whatever') // Extract info from data-* attributes
  var destinatarios = button.data('destinatarios');
  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
  var modal = $(this)
  //modal.find('.modal-title').text('New message to ' + recipient)
  modal.find('.modal-body input').val(destinatarios)
  $("#id_correo").val(recipient);
})

   
    cargarVehiculosAsignados();

});

function procesarCheckBox(nombrecheck) {
    
    //if (nombrecheck == 'chkderecha[]') {
    if (nombrecheck == 'chkizquierda[]') {
        console.log('1', nombrecheck);
        //recorremos todos los checkbox seleccionados con .each
        $('input[name="' + nombrecheck + '"]:checked').each(function () {
            //$(this).val() es el valor del checkbox correspondiente
            desAsignarVehiculos($(this).val());
        });

    } else {
        console.log('2',nombrecheck);
        //recorremos todos los checkbox seleccionados con .each
        $('input[name="' + nombrecheck + '"]:checked').each(function () {
            //$(this).val() es el valor del checkbox correspondiente
            console.log($(this).val());
            asignarVehiculosGerencia($(this).val());
           
        });

    }


}

function desAsignarVehiculos(Cod_Vehiculo) {
    var Cod_Procesador = $("#select_analizadores").val();
    var Cod_Usuario = $("#hdnCod_Usuario").val();


    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMantenedorVehiculos.aspx/wmDesAsignarVehiculos",
        data: "{'Cod_Vehiculo':'" + Cod_Vehiculo + "','Cod_Procesador':'" + Cod_Procesador + "','Cod_Usuario':'" + Cod_Usuario + "'}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {

                return;
            }
            var objeto = arg.d;
            if (objeto == 1) {
                cargarVehiculos();
                cargarVehiculosAsignados();
            } else {
                alert("Error al Asignar vehículo. Intente Nuevamente");
            }
        }

    });
}

function asignarVehiculosGerencia(Cod_Vehiculo) {
    var Cod_Procesador = $("#select_analizadores").val();
    var Cod_Usuario = $("#hdnCod_Usuario").val();

    
    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMantenedorVehiculos.aspx/wmAsignarVehiculos",
        data: "{'Cod_Vehiculo':'" + Cod_Vehiculo + "','Cod_Procesador':'"+Cod_Procesador+"','Cod_Usuario':'"+Cod_Usuario+"'}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {

                return;
            }
            var objeto = arg.d;
            if (objeto == 1) {
                cargarVehiculos();
                cargarVehiculosAsignados();
            } else {
                alert("Error al Asignar vehículo. Intente Nuevamente");
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







function cargarFlotas() {

    var IdUsuario = $("#hdnCod_Usuario").val();
    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMantenedorVehiculos.aspx/wmCargarFlotasCliente",
        data: "{'IdUsuario':" + IdUsuario + "}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;
            for (var i = 0; i < objeto.length; i++) {
                $('#flotas_user').append($('<option>', {
                    value: objeto[i].Cod_Flota,
                    text: objeto[i].NomFlota
                }));
            }

        }
    });
   

}

function cargarGrupos() {

    var Cod_Flota = $("#flotas_user").val();

    $.ajax({
        async: false,
        type: 'POST',
        url: "frmMantenedorVehiculos.aspx/wmCargarGruposFlotas",
        data: "{'Cod_Flota':" + Cod_Flota + "}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;
            $('#grupos_user').empty();
            for (var i = 0; i < objeto.length; i++) {
                $('#grupos_user').append($('<option>', {
                    value: objeto[i].Cod_GrupoVehiculo,
                    text: objeto[i].NomGrupoVehiculo
                }));
            }

        }
    });
    cargarVehiculos();

}

function cargarVehiculos() {
    var Cod_Grupo = $("#grupos_user").val();
    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMantenedorVehiculos.aspx/wmCargarVehiculosGrupos",
        data: "{'Cod_Grupo':" + Cod_Grupo + "}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                grilla_izquierda.fnClearTable();
                return;
            }
            var objeto = arg.d;
            grilla_izquierda.fnClearTable();
            for (var i = 0; i < objeto.length; i++) {



                grilla_izquierda.fnAddData([
                       objeto[i].Cod_Vehiculo,
                       objeto[i].RefVehiculo,
                       objeto[i].Rego,
                 '<input type="checkbox" value="' + objeto[i].Cod_Vehiculo + '" name="chkderecha[]"/>'

                ]);



            } // End For
        }
    });
}

function cargarAnalizadores() {
    $('#select_analizadores').append($('<option>', {
        value: '1',
        text: 'Procesador 1'
    }));
   
}

function cargarVehiculosAsignados() {
    var Cod_Procesador = $("#select_analizadores").val();
    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMantenedorVehiculos.aspx/wmVehiculosAsignados",
        data: "{'Cod_Procesador':'"+Cod_Procesador+"'}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                grilla_derecha.fnClearTable();
                return;
            }
            var objeto = arg.d;
            grilla_derecha.fnClearTable();
            for (var i = 0; i < objeto.length; i++) {



                grilla_derecha.fnAddData([
                       objeto[i].Cod_Vehiculo,
                       objeto[i].RefVehiculo,
                       objeto[i].Rego,
                 '<input type="checkbox" value="' + objeto[i].Cod_Vehiculo + '" name="chkizquierda[]"/>'

                ]);



            } // End For
        }
    });
}



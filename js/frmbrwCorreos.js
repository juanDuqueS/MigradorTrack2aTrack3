
var datatable;
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
        "bLengthChange": true,
        "bFilter": true,
        "bSort": false,
        "bInfo": true,
        "bAutoWidth": true,
        "bDeferRender": true
    });

    datatable.fnSetColumnVis(0, false);
    datatable.fnSetColumnVis(1, false);

    cargarTabla();

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

   


});

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
        url: "frmInforme.aspx/wmCargarFlotasCliente",
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

function agregarNuevo() {
    var destinatarios = $("#destinatarios").val();
    var Cod_Flota = $("#multiselect option:selected").val();
    var NomFlota = $("#multiselect option:selected").text();
    var IdUsuario = $("#hdnCod_Usuario").val();

    if (destinatarios == "") {
        alert('Debe ingresar al menos 1 correo');
        return;
    }

    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMantenedorCorreos.aspx/wmAgregarNuevoCorreo",
        data: "{'IdUsuario':" + IdUsuario + ",'Cod_Flota':" + Cod_Flota + ",'Destinatarios':'" + destinatarios + "'}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {
            
            if (arg.d == 1) {
                cargarTabla();
            } else {
                alert("Flota ya configurada, revisar listado.");
            }
            if (arg.d == "{}" | arg.d == "") {
                return;
            }
            var objeto = arg.d;

            

          
        }
    });


   
}

function cargarTabla() {
    $("#loading").append("<div id='cargando' class='overlay'></div><div class='loading-img'></div>");

    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMantenedorCorreos.aspx/wmCargarCorreo",
        data: "{}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {
           
            if (arg.d == "{}" | arg.d == "") {
                datatable.fnClearTable();
                $(".overlay").remove();
                $(".loading-img").remove();
                return;
            }
            var objeto = arg.d;
            datatable.fnClearTable();
            for (var i = 0; i < objeto.length; i++) {


                var url =
                datatable.fnAddData([
                   objeto[i].Id_Correo,
                   objeto[i].Cod_Flota,
                   objeto[i].NomFlota,
                   objeto[i].Destinatarios,
                   '<a href="#" data-toggle="modal" data-target="#myModal" data-whatever="' + objeto[i].Id_Correo + '" data-destinatarios="' + objeto[i].Destinatarios + '">Modificar</a>',
                    '<a href="#" onclick="eliminar(' + objeto[i].Id_Correo + ');">Eliminar</a>',

                ]);



            } // End For

            $(".overlay").remove();
            $(".loading-img").remove();




        }
    });
}

function eliminar(Id_Correo) {
    
    var x;
    if (confirm("Está seguro de eliminar el registro?") == true) {
        $.ajax({
            async: true,
            type: 'POST',
            url: "frmMantenedorCorreos.aspx/wmEliminarCorreo",
            data: "{'Id_Correo':'" + Id_Correo + "'}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (arg) {
                if (arg.d > 0) {
                    cargarTabla();
                } else {
                    alert('No se ha eliminado ningun registro');
                }
                if (arg.d == "{}" | arg.d == "") {
                    return;
                }

            },

        });
    } else {
        return;
    }
   
}

function actualizarCorreo() {
    var id_correo = $("#id_correo").val();
    var destinatariosNuevos = $("#recipient-name").val();

    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMantenedorCorreos.aspx/wmActualizarCorreo",
        data: "{'Id_Correo':'" + id_correo + "','Destinatarios':'" + destinatariosNuevos + "'}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {
            if (arg.d > 0) {
                cargarTabla();
                $('#myModal').modal('hide');
            } else {
                alert('No se ha actualizado ningun registro');
            }
            if (arg.d == "{}" | arg.d == "") {
                return;
            }

        },

    });

    
}

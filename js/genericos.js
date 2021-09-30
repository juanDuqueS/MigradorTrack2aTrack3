var datatable;
var dt_vehiculos;
var compass;
var refreshId;
var objeto_full;
var dt_aux;
 
var sitios_cliente;
var markerClusterer;
var cTodos = false;

$(document).ready(function () {
    cargarFlotas();
   
    
    var alto_izquierdo = $('.sidebar-offcanvas').height();
    var barra_breadcums = $('.content-header').height()
    $('.content').css('height', alto_izquierdo - ((barra_breadcums*2.9)) + "px");

    $('#fecha').datepicker({
        format: "dd/mm/yyyy",
        language: "es",
        todayHighlight: true
    });

    var d = new Date();

    var month = d.getMonth() + 1;
    var day = d.getDate();

    var fechaActual = (day < 10 ? '0' : '') + day + '/' +
        (month < 10 ? '0' : '') + month + '/' +
        d.getFullYear();

    $("#fecha").val(fechaActual);

    $("#toggleButtonBarraNavegacion").css('marginTop','-29px');
    $("#barraNavegacion").addClass('hidden');
    
    var alto_content = $('.content').height()
    
    $("#map-canvas").css('height', alto_content+"px");
    
    //cargarAlertas();
    
    datatable = $('#example1').DataTable({
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": false,
        "bSort": false,
        "bInfo": false,
        "bAutoWidth": true,
        "PagingType":"simple",
        "order": [[4, "asc"]],
        
    });

    dt_vehiculos = $('#tbl_vehiculos').DataTable({
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": false,
        "bSort": false,
        "bInfo": false,
        "bAutoWidth": true,
        "PagingType": "simple",
        "order": [[1, "asc"]],

    });




    $("#tbl_vehiculos").on('click', 'tbody tr', function (e) {

        if ($(this).hasClass('row_selected')) {
            $(this).removeClass('row_selected');
        } else {
            dt_vehiculos.$('tr.row_selected').removeClass('row_selected');
            $(this).addClass('row_selected');

            var Cod_Vehiculo = dt_vehiculos.fnGetData(this, 0);
            $("#ctl00_hdnCodVehiculo").val(Cod_Vehiculo);
            cargarAlertas(Cod_Vehiculo);
            
        }
    });
   
    $("#example1").on('click', 'tbody tr', function (e) {

        if ($(this).hasClass('row_selected')) {
            $(this).removeClass('row_selected');
        } else {
            datatable.$('tr.row_selected').removeClass('row_selected');
            $(this).addClass('row_selected');

            var nombre = datatable.fnGetData(this, 0);
            var patente = datatable.fnGetData(this, 1);
            var codigo = datatable.fnGetData(this, 2);
            var latitud = datatable.fnGetData(this, 3);
            var longitud = datatable.fnGetData(this, 4);
            var ubicacion = datatable.fnGetData(this, 5);
            var fecha = datatable.fnGetData(this, 6);
            var velocidad = datatable.fnGetData(this, 7);
            var evento = datatable.fnGetData(this, 8);
            var desevento = datatable.fnGetData(this, 9);

            centrarMapa(map, latitud, longitud);
            deleteMarkers();
            
            setMarker(latitud, longitud, nombre, patente, fecha, ubicacion, codigo, evento, desevento,velocidad);
            setAllMap(map);
            clearInterval(refreshId);
           
        }
    });



    $("#tbl_vehiculos tbody").click(function (event) {
        $(dt_vehiculos.fnSettings().aoData).each(function () {
            
            $(this.nTr).removeClass();
        });
        $(event.target.parentNode).addClass('even_td');
    });

    $("#example1 tbody").click(function (event) {
        $(datatable.fnSettings().aoData).each(function () {

            $(this.nTr).removeClass();
        });
        $(event.target.parentNode).addClass('even_td');
    });

    // cTodos = false;
    cA= false;
    cD = false;
 

    $('#Todos').change(function () {
        cTodos = $(this).prop('checked');
    })
 
    $('#A').change(function () {
        cA = $(this).prop('checked');
    })

    $('#D').change(function () {
        cD = $(this).prop('checked');
    })
    
    datatable.fnSetColumnVis(0, false);
    datatable.fnSetColumnVis(1, false);
    datatable.fnSetColumnVis(2, false);
    datatable.fnSetColumnVis(3, false);
    datatable.fnSetColumnVis(4, false);
    datatable.fnSetColumnVis(5, false);
    datatable.fnSetColumnVis(6, true);
    datatable.fnSetColumnVis(7, true);
    datatable.fnSetColumnVis(8, true);
    datatable.fnSetColumnVis(9, true);
    dt_vehiculos.fnSetColumnVis(0, false);

    

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


function setRosa(hdg) {
   
    $(".imgB1").css('-webkit-transform', 'rotate(' + hdg + 'deg)');
    
}

function nuevaalerta(hora) {
    var horaanterior = $("#ultimahora").val();

    if (hora != horaanterior) {
        var audio = document.getElementById("audio-alert");
        //audio.play();
    }

}

function cargarFlotas() {
    
   var IdUsuario = $('input[name="ctl00$hdnCod_Usuario"]').val();// $("#hdnCod_Usuario").val(); 
  //  var IdUsuario = 6780;

    $.ajax({
        async: false,
        type: 'POST',
        url: "frmMapa.aspx/wmCargarFlotasCliente",
        data: "{'IdUsuario':'"+IdUsuario+"'}",
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
    
    cargarVehiculos();
    sitiosCliente();
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

function sitiosCliente() {
    setMapNull(null);
    var Cod_Flota = $("#flotas_user").val();
 
    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMapa.aspx/SitiosClientePorFlota",
        data: "{'Cod_Flota':" + Cod_Flota + "}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                
                return;
            }
            sitios_cliente = [];
            var objeto = arg.d;
            
            sitios_cliente = objeto;
            deletePoligonos();
            DibujarSitios(sitios_cliente);


            objeto = undefined;
        }
    });
}

function cargarVehiculos() {
    sitiosCliente();
    var Cod_Flota = $("#flotas_user").val();
 
    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMapa.aspx/wmCargarVehiculosGrupos",
        data: "{'Cod_Flota':" + Cod_Flota + "}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                dt_vehiculos.fnClearTable();
                return;
            }
            var objeto = arg.d;
            dt_vehiculos.fnClearTable();
            for (var i = 0; i < objeto.length; i++) {
                if (i == 0) {
                    $('input[name="ctl00$hdnCodVehiculo"]').val(objeto[i].Cod_Vehiculo);
                    cargarAlertas(objeto[i].Cod_Vehiculo);
                }
               

                dt_vehiculos.fnAddData([
                       objeto[i].Cod_Vehiculo,
                       objeto[i].RefVehiculo,
                       objeto[i].Rego              

                ]);



            } // End For
        }
    });
    
}

function cargarAlertas(Cod_Vehiculo)
{
    if (markerClusterer) {
        markerClusterer.clearMarkers();
    }
    
    var Fecha = $("#fecha").val();
    var Cod_Vehiculo = Cod_Vehiculo;//$('input[name="ctl00$hdnCodVehiculo"]').val()
    var Cod_Flota = $("#flotas_user").val();
    console.log('Cod_flota: ' + Cod_Flota);

    if (Cod_Vehiculo == undefined) Cod_Vehiculo = $('input[name="ctl00$hdnCodVehiculo"]').val();
    var str_eventos = ""
    $("#listadoEvento").val($("#filtros").val());
    var str_eventos = $("#listadoEvento").val();
    eventos_ = str_eventos.split(",");
    var todos = true;
 
    $.ajax({
        async: true,
        type: 'POST',
        url: "frmMapa.aspx/wmCargarAlertas",
        data: "{'Cod_Vehiculo':" + Cod_Vehiculo + ",'FechaHora':'"+Fecha+"','Filtros':'" + str_eventos + "','Todos':'" + todos + "','Flota':" + Cod_Flota +"}",
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (arg) {

            if (arg.d == "{}" | arg.d == "") {
                datatable.fnClearTable();
                heatdata = [];
                heatmap.set('data', heatdata);
                return;
            }
            var objeto = arg.d;
            datatable.fnClearTable();
            dt_aux = objeto;
            for (var i = 0; i < objeto.length; i++) {
                if (i == 0) {
                    heatMap(objeto[i].Latitud, objeto[i].Longitud, objeto);
     
                    deleteMarkers();
                    centrarMapa(map,objeto[i].Latitud, objeto[i].Longitud);
                    setAllMap(map);
                    $("#ultimahora").val(objeto[i].Hora);
                }
                
                setMarker(objeto[i].Latitud, objeto[i].Longitud, objeto[i].RefVehiculo, objeto[i].Rego, objeto[i].FechaHoraActividad, objeto[i].Ubicacion, objeto[i].Cod_Vehiculo, objeto[i].Evento, objeto[i].DescEvento, objeto[i].Velocidad);


                datatable.fnAddData([
               objeto[i].RefVehiculo,
               objeto[i].Rego,
               objeto[i].Cod_Vehiculo,
               objeto[i].Latitud,
               objeto[i].Longitud,
               objeto[i].Ubicacion,
               objeto[i].FechaHoraActividad,               
               objeto[i].Velocidad + ' Km/Hrs',
               objeto[i].Evento,
                objeto[i].DescEvento

                ]);
                

               
            } // End For
            //clearClusters();
            var options = {
                imagePath: './img/m'
            };


            markerClusterer = new MarkerClusterer(map, markers, options);

        }
    });

    clearInterval(refreshId);
    refreshId = setInterval(cargarAlertas, 60000);
}

function clearClusters() {
   
    markerClusterer.clearMarkers();
}

function setIcono(Cod_TipoEvento) {
    var icono;
    if (Cod_TipoEvento == 29) {
        icono = './img/ball_off.png'
    } else {
        icono = './img/ball_on.png'
    }

    return icono
}

function aplicarFiltros() {
    
    var oTable = $('#example1').dataTable();
    oTable.fnClearTable();
    
    var data = [];
    oTable.fnClearTable();
    for (var i = 0; i < dt_aux.length; i++) {
           if ((cTodos == true) ) {
               oTable.fnAddData([
               dt_aux[i].RefVehiculo,
               dt_aux[i].Rego,
               dt_aux[i].Cod_Vehiculo,
               dt_aux[i].Latitud,
               dt_aux[i].Longitud,
               dt_aux[i].Ubicacion,
               dt_aux[i].FechaHoraActividad,               
               dt_aux[i].Velocidad + ' Km/Hrs',
               dt_aux[i].Evento,
               dt_aux[i].DescEvento]);
               data.push(dt_aux[i]);
           }
           else
           {
              if ((cA== true) && (dt_aux[i].Evento == "A"))
              {
                  oTable.fnAddData([
                  dt_aux[i].RefVehiculo,
                  dt_aux[i].Rego,
                  dt_aux[i].Cod_Vehiculo,
                  dt_aux[i].Latitud,
                  dt_aux[i].Longitud,
                  dt_aux[i].Ubicacion,
                  dt_aux[i].FechaHoraActividad,               
                  dt_aux[i].Velocidad + ' Km/Hrs',
                  dt_aux[i].Evento,
                  dt_aux[i].DescEvento]);
                  data.push(dt_aux[i]);
              }
              else
              {
                  if ((cD== true) && (dt_aux[i].Evento == "D"))
                  {
                      oTable.fnAddData([
                      dt_aux[i].RefVehiculo,
                      dt_aux[i].Rego,
                      dt_aux[i].Cod_Vehiculo,
                      dt_aux[i].Latitud,
                      dt_aux[i].Longitud,
                      dt_aux[i].Ubicacion,
                      dt_aux[i].FechaHoraActividad,               
                      dt_aux[i].Velocidad + ' Km/Hrs',
                      dt_aux[i].Evento,
                      dt_aux[i].DescEvento]);
                      data.push(dt_aux[i]);
                  }
              }
           }

    }
}

function marcarTodos() {

    var formulario = eval(Form1)
    if (formulario.elements[7].checked)  //elemento checkbox #Todos
    {
        for (var i = 8, len = formulario.elements.length; i < len ; i++) {
            if (formulario.elements[i].type == "checkbox")
            {
                formulario.elements[i].checked = 1
            }
        }
    }
    else
    {
        for (var i = 8, len = formulario.elements.length; i < len ; i++) {
            if (formulario.elements[i].type == "checkbox")
            {
                formulario.elements[i].checked = 0
            }
        }
    }
}
function restaurarFiltros() {
    var oTable = $('#example1').dataTable();
    oTable.fnClearTable();
    if (dt_aux.length > 0) {
        for (var i = 0; i < dt_aux.length; i++) {
   
            oTable.fnAddData([
            dt_aux[i].RefVehiculo,
            dt_aux[i].Rego,
	        dt_aux[i].Cod_Vehiculo,
            dt_aux[i].Latitud,
            dt_aux[i].Longitud,
            dt_aux[i].Ubicacion,
            dt_aux[i].FechaHoraActividad,
            dt_aux[i].Velocidad + ' Km/Hrs',
            dt_aux[i].Evento,
            dt_aux[i].DescEvento

            ]);

        }
    }

}



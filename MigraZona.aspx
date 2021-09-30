<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MigraZona.aspx.cs" Inherits="MigraZona" %>
<%@ Register Src="controles/frmModuloUsuario.ascx" TagName="moduloUsuario" TagPrefix="userMod" %>

<!DOCTYPE html>

<html>
    <head runat="server">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>GPS Chile | Migración</title>

<script src="https://maps.googleapis.com/maps/api/js?v=3&key=AIzaSyDgTowdv2ICP4HziGi0IYS0tRyogis8Phs&language=es&libraries=drawing,geometry"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <!-- Bootstrap 3.3.7 -->
        <link rel="stylesheet" href="./layout/bower_components/bootstrap/dist/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="./layout/bower_components/font-awesome/css/font-awesome.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="./layout/bower_components/Ionicons/css/ionicons.min.css">
        <!-- DataTables -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.18/af-2.3.3/b-1.5.6/b-colvis-1.5.6/b-flash-1.5.6/b-html5-1.5.6/cr-1.5.0/fc-3.2.5/fh-3.1.4/kt-2.5.0/r-2.2.2/rg-1.1.0/rr-1.2.4/sc-2.0.0/sl-1.3.0/datatables.min.css"/>
 
       <%-- <!-- Select2 -->
        <link rel="stylesheet" href="./layout/bower_components/select2/dist/css/select2.min.css">--%>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
        <!-- daterange picker -->
        <link rel="stylesheet" href="./layout/bower_components/bootstrap-daterangepicker/daterangepicker.css">
        <!-- bootstrap datepicker -->
        <link rel="stylesheet" href="./layout/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
        <!-- Custom -->
        <link rel="stylesheet" href="./layout/custom/estilo.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="./layout/dist/css/AdminLTE.min.css">
        <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
        <link rel="stylesheet" href="./layout/dist/css/skins/skin-pantone-blue.css">


        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
       
        
        <link rel="stylesheet" href="./css/style.css">

        <style type="text/css">
            .select2-selection__choice {
                float: none !important;
                display: inline-block !important;
            }

            .bootstrap-select > .dropdown-toggle.bs-placeholder, .bootstrap-select > .dropdown-toggle.bs-placeholder:active, .bootstrap-select > .dropdown-toggle.bs-placeholder:focus, .bootstrap-select > .dropdown-toggle.bs-placeholder:hover, .bootstrap-select > btn.dropdown-toggle.btn-light {
                color: #555 !important;
                background: white !important;
                border: 1px solid #ccc
            }

            button[data-toggle="dropdown"].btn-default,
            button[data-toggle="dropdown"] {
                background-color: white !important;
                color: #555 !important;
                border: 1px solid #ccc
            }

            .btn-group > .btn:first-child:not(:last-child):not(.dropdown-toggle) {
                border-top-right-radius: 0;
                border-bottom-right-radius: 0;
                color: whitesmoke;
                background-color: #173472;
            }

        </style>

        <!-- Google Font -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Asap:300,400,600,700,300italic,400italic,600italic">
   </head>

    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <!-- Sidebar -->
            <nav id="sidebar" class="active">
                <div class="sidebar-header">
                    <h3>&nbsp&nbsp</h3>
                </div>

                <ul class="list-unstyled components">
                   <%-- <p>Dummy Heading</p>--%>
                     <li>
                        <a href="MigraEquipos.aspx"><i class="fa fa-truck"></i> Equipos</a>
                    </li>                 
                    <li class="active">
                        <a href=# > <i class="fa fa-map-o"></i> Zona</a>
                    </li>
                    <li>
                        <a href="MigraConductores.aspx"><i class="fa fa-id-card-o"></i> Conductores</a>
                    </li>

                </ul>
            </nav>

       
             <!-- Page Content  -->
            <div id="content">
            <header class="main-header">
                <%--<!-- Logo -->
                <a href="frmMapa.aspx" class="logo" style="background-color:#3c8dbc !important;">
                    <span class="logo-lg"><img src="./img/logo.png" height="45" style="margin-top:-8px" /></span>
                </a>
                <!-- Header Navbar: style can be found in header.less -->
                <nav class="navbar navbar-static-top">
                </nav>--%>
             

                <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
		            <div class="container" style="margin-left:0">
			            <div class="navbar-header">
				            <!-- Logo -->
                               <a href="#" class="logo" style="margin-top:5px; width:0; margin-bottom:10px;" id="sidebarCollapse" data-toggle="dropdown" data-target="#account">
			                  <span class="logo-lg"><i class="fa fa-bars"></i></span>
			                </a>
			                <a href="#" class="logo" style="margin-top:5px; margin-bottom:10px;">
			                  <span class="logo-lg"><img src="./img/logo.png" height="45"/></span>
			                </a>
 			            </div>
		            </div>
                </nav>
            </header>

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper" ">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Migración de Zonas
                    </h1>
                </section>
                <!-- Main content -->
		<section class="content">

<form role="form" method="post"  id="formMigraZonas">
			<!-- Default box -->
			<div class="box box-solid">
<%--				<div class="box-header with-border">
					<h3 class="box-title">Seleccione los datos</h3>&nbsp;&nbsp;&nbsp;
				</div>--%>

				<div class="box-body">
					<div class="row">
                        <div class="col-md-12">
                        		<div class="col-md-12">
                                     
                                    <div class="col-md-6">
			                                <div class="box box-solid">
				                                <div class="box-header with-border">
					                                <h3 class="box-title">Seleccione datos de Origen</h3>&nbsp;&nbsp;&nbsp;
				                                </div>
                                            </div>
                                    </div>

                                               <div class="col-md-12">
                                                        <div class="col-md-2">
	                        				                <div class="form-group">
												                <label for="idPlataforma">Plataforma</label>
											                </div>
	                        			                </div>

                                                        <div class="col-md-3">
	                        				                <div class="form-group">
												                <select  name="idPlataforma" class="form-control" id="idPlataforma" data-size="8" style="width: 100%;">
													                <option value="">Seleccionar Plataforma</option>
                                                                    <option value="1">Integración/Navman</option>
                                                                    <option value="2">Track2</option>
												                </select>
                                                <div style="display:none;">
                                                    <select id="idUsuario" name="idUsuario">
                                                        <asp:PlaceHolder ID="sIdUsario" runat="server" />
                                                    </select>
                                                </div>
											                </div>
	                        			                </div>
                                                         <div class="col-md-2">
	                        				                <div class="form-group">
												                <label for="idFlota" id="idCodPlat" >Plataforma</label> <%--style="color:white"--%>
											                </div>
	                        			                </div>
                                                </div>

                                                <div class="col-md-12">
                                                        <div class="col-md-2">
	                        				                <div class="form-group">
												                <label for="idRUT">RUT Cliente / Cliente</label>
											                </div>
	                        			                </div>
                                                        <div class="col-md-3">
	                        				                <div class="form-group">
                                                                  <select  name="idRUT" class="form-control selectpicker" data-size="8" id="idRUT" style="width: 100%;" data-live-search="true">
												                </select>
											                </div>
                                                        </div>
                                                        <div class="col-md-2">
	                        				                <div class="form-group">
												                <label for="idRUT" id="idCodRUT">RUT</label><label for="idRUT" id="idCodCliente">idCliente</label>
											                </div>
	                        				                <div class="form-group">
												                
											                </div>
	                        			                </div>
                                                </div>

                                                <div class="col-md-12">
                        				                <div class="col-md-2">
	                        				                <div class="form-group">
												                <label for="idFlota">Flota / Cliente / RUT Cliente</label>
											                </div>
	                        			                </div>
	                        				            <div class="col-md-3">
	                        				                <div class="form-group">
                                                                  <select  name="idFlota" class="form-control selectpicker" data-size="8" id="idFlota" style="width: 100%;" data-live-search="true">
												                </select>
											                </div>
	                        			                </div>
                        				                <div class="col-md-2">
	                        				                <div class="form-group">
												                <label for="idFlota" id="idCodFlota">Flota</label>
											                </div>
	                        			                </div>
                        	                    </div>
                        		</div>
                        </div>
                        
                        <div class="col-md-12 text-right" id="botones-exp" style="margin-top:10px;"></div>
                        
                        <div class="col-md-12" style="padding-top:20px !important;">
                            
                            <table id="tablaZonas" class="table table-bordered table-hover nowrap" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>Nombre Geocerca</th>
                                        <th>Tipo Zona</th>
                                        <th>Vehículos Asociados</th>
                                        <th>Estado</th>
                                        <th>Visualizar</th>
                                        <th>Mensajes</th>
                                        <th>Migrar</th>
                                        <th>Mensaje</th>
                                        <th>Ref</th>
                                        <th>Polígono</th>
                                    </tr>
                                </thead>
                                <tbody>
                                   
                                </tbody>
                            </table>

                            <br />
                             <div style="overflow: auto;">
                                <div style="float: left; width: 200px;">
                                    <button name="idValidar" id="idLimpiar" type="button" class="btn btn-default">
                                    <span class="glyphicon  glyphicon-check"></span> Limpiar
                                    </button>
                                </div>

                                <div style="float: right; width: 200px;">
                                    <button name="idValidar" id="idValidar" type="button" class="btn btn-default">
                                    <span class="glyphicon  glyphicon-check"></span> Validar
                                    </button>
                                    &nbsp;&nbsp;&nbsp;
                                    <button name="idMigrar" id="idMigrar" type="button" class="btn btn-default">
                                    <span class="glyphicon glyphicon-export" ></span> Migrar
                                    </button>
                                </div>
                            </div>

                        </div> <%--de la tabla--%>

                          <!-- Modal errores Validación-->
                          <div class="modal fade" id="myModal" role="dialog">
                            <div class="modal-dialog modal-lg">

                              <!-- Modal content-->
                              <div class="modal-content">
                                <div class="modal-header">
                                  <!-- modal header  -->
                                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                                  <h4 class="modal-title">Errores de validación</h4>
                                </div>
                                <div class="modal-body">
                                <!-- begin modal body content  -->
                                  <section class="stage">
                                    Datos...
                                  </section>
                                <!-- end modal body content  -->
                                </div>
                                <div class="modal-footer">
                                  <!-- modal footer  -->
                                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                              </div>

                            </div>
                          </div><!-- Modal -->

                          <!-- Modal errores Migración-->
                          <div class="modal fade" id="MigModal" role="dialog">
                            <div class="modal-dialog modal-lg">

                              <!-- Modal content-->
                              <div class="modal-content">
                                <div class="modal-header">
                                  <!-- modal header  -->
                                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                                  <h4 class="modal-title">Errores de migración</h4>
                                </div>
                                <div class="modal-body">
                                <!-- begin modal body content  -->
                                  <section class="stage">
                                    Datos...
                                  </section>
                                <!-- end modal body content  -->
                                </div>
                                <div class="modal-footer">
                                  <!-- modal footer  -->
                                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                              </div>

                            </div>
                          </div><!-- Modal -->

 
                        <!-- Modal mapa-->

                              <div class="modal fade" id="VizModal" tabindex="-1" role="dialog" aria-labelledby="VizModalLabel">
                                <div class="modal-dialog modal-lg" role="document">
                                  <div class="modal-content">
                                    <div class="modal-header">
                                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                      <h4 class="modal-title" id="VizModalLabel">Modal title</h4>
                                    </div>
                                    <div class="modal-body">
<%--                                      <div class="row">
                                        <div class="col-md-12 modal_body_content">
                                          <p>Some contents...</p>
                                        </div>
                                      </div>--%>
                                      <div class="row">
                                        <div class="col-md-12 modal_body_map">
                                          <div class="location-map" id="location-map">
                                            <div style="width: 600px; height: 400px;" id="map_canvas"></div>
                                          </div>
                                        </div>
                                      </div>
<%--                                      <div class="row">
                                        <div class="col-md-12 modal_body_end">
                                          <p>Else...</p>
                                        </div>
                                      </div>--%>
                                    </div>
                                  </div>
                                </div>
                              </div>
                        <!-- Modal -->                        
                        
                        <div class="col-md-10" id="divResultados" hidden>
			                <div class="box box-solid">
				                <div class="box-header with-border">
                                    <br /><br />
					                <h3 class="box-title">Resultados de la migración</h3>&nbsp;&nbsp;&nbsp;
				                </div>
                            </div>
                            <div class="col-md-12 text-right" id="botonesR-exp" style="margin-top:10px;"></div>
                            <div class="col-md-12" style="padding-top:20px !important;">
                                <table id="tablaResultado" class="table table-bordered table-hover nowrap" >
	                                <thead>
		                                <tr>
			                                <th>Nombre Geocerca</th>
			                                <th>Estado</th>
			                                <th>Fecha Migración</th>
			                                <th>Tipo Zona</th>
			                                <th>Vehículos Asociados</th>
			                                <th>Error</th>
                                            <th>Mensaje</th>
		                                </tr>
	                                </thead>
	                                <tbody>
	                                </tbody>
                                </table>
                            </div>    
                        </div>

                        </div>
			    </div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->

            <div id="spinLoad">
                <span id="mensajeLoading"><i class="fa fa-spin fa-fw fa-refresh "></i> Procesando ...</span>
                <span id="mensajeLoading_2" style="display:none"><i class="fa fa-spin fa-fw fa-refresh "></i> Información obtenida, escribiendo registros en la tabla..</span>
            </div>
        </form>
		</section>
		<!-- /.content -->

            </div>
            <!-- /.content-wrapper -->
        </div>
        </div>
        <!-- ./wrapper -->
        

       <!-- jQuery 3 -->
        <script src="./layout/bower_components/jquery/dist/jquery.min.js"></script>

        <!-- Popper.JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
    
        <!-- Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

        <!-- SlimScroll -->
        <script src="./layout/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
       
        <!-- FastClick -->
<%--        <script src="./layout/bower_components/fastclick/lib/fastclick.js"></script>--%>
        
        <!-- DataTables -->
        <script type="text/javascript" src="./layout/bower_components/datatables/datatables.min.js"></script>

        <!-- Select2 -->
        <script src="./layout/bower_components/select2/dist/js/select2.full.min.js"></script>
        <!--SelecPicker-->
       

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>

        <!-- (Optional) Latest compiled and minified JavaScript translation files -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/i18n/defaults-es_ES.min.js"></script>
        <!---->
        <!-- date-range-picker -->
        <script src="./layout/bower_components/moment/min/moment.min.js"></script>
        <script src="./layout/bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>

        <!-- Validation -->
        <script src="./layout/plugins/validation/jquery.validate.js"></script>
        <script src="./layout/plugins/validation/additional-methods.js"></script>
        <script src="./layout/plugins/validation/mensajes-val.js"></script>

        <!-- AdminLTE App -->
        <script src="./layout/dist/js/adminlte.min.js"></script>
        <!-- AdminLTE for demo purposes -->
        <script src="./layout/dist/js/demo.js"></script>
        <script src="./js/blockui.js"></script>

        <script>

            $(document).ajaxStop($.unblockUI);
            $(document).ready(function () {
                var timeoutID;
                $("#idMigrar").prop("disabled", true);

                $("#idCodPlat").hide();
                $("#idCodFlota").hide();
                $("#idCodRUT").hide();
                $("#idCodUsuario").hide();
                $("#idCodCliente").hide();

                function startBlocking() {
                    // do your stuff...
                    $.blockUI({ message: '<p><IMG height="10%" width="20%"  SRC="./img/pin.gif"></p><p><h4 id="myMessage">Procesando...</h4></p>' });
                }

                function stopBlocking() {
                    // This is called whenever your processing is done
                    clearTimeout(timeoutID);
                }

                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });

                //Initialize Date range picker
                var endDate = moment();

                $('#tablaZonas').DataTable({
                    columns: [
                        { "data": "Zona" },
                        { "data": "TipoZona" },
                        { "data": "NumVehiculos" },
                        { "data": "EstadoZona" },
                        { "data": "Ver"},
                        { "data": "Error"},
                        { "data": "Migrar" },
                        { "data": "Mensaje", visible: false} ,// visible: false
                        { "data": "Referencia", visible: false}, // visible: false
                        { "data": "Poligono", visible: false } // visible: false
                    ],

                    bProcessing: true,
                    deferRender: true,
                    dom: '<"html5buttons">Blfrtip',
                    select: true,
                    searching: true,
                    paging: true,
                    ordering: true,
                    responsive: false,
                    scrollX: true,
                    aaSorting: [[0, 'asc']],
                    destroy: true,

                    columnDefs: [
                          { targets: 0, orderable: true }
                        , { targets: 1, className: 'text-center'}
                        , { targets: 2, className: 'text-right' }
                        , { targets: 3, className: 'text-center' }
                        , { targets: 4, orderable: false, className: 'text-center'}
                        , { targets: 5, orderable: false, className: 'text-center' }
                        , { targets: 6, orderable: false, className: 'text-center' }
                        , { targets: 7, orderable: false }
                        , { targets: 8, orderable: false }
                        , { targets: 9, orderable: false }
                    ],

                    buttons: [
                        {
                            text: 'Copiar',
                            extend: 'copy',
                            className: 'btn-sm',
                            exportOptions: {
                                //columns: ':visible'
                            }
                        },
                        {
                            text: 'CSV',
                            extend: 'csv',
                            className: 'btn-sm',
                            title: 'Migración_Zonas_' + endDate.format('YYYY-MM-DD'),
                            fieldSeparator: ';',
                            fieldBoundary: '',
                            exportOptions: {
                                //columns: ':visible'
                            }
                        },

                        {
                            text: 'PDF',
                            extend: 'pdf',
                            //title: 'Título',
                            orientation: 'landscape',
                            filename: 'Migración_Zonas_' + endDate.format('YYYY-MM-DD'),
                            className: 'btn-sm',
                            exportOptions: {
                                //columns: ':visible'
                            },
                            customize: function (doc) {
                                doc.defaultStyle.fontSize = 6;
                                doc.styles.tableHeader.fontSize = 6;
                                doc.pageMargins = [10, 5, 10, 5]; //[left,top,right,bottom]
                            }
                        },

                        {
                            text: 'Imprimir',
                            extend: 'print',
                            customize: function (win) {
                                $(win.document.body).addClass('white-bg');
                                $(win.document.body).css('font-size', '10px');

                                $(win.document.body).find('table')
                                    .addClass('compact')
                                    .css('font-size', 'inherit');
                            },
                            className: 'btn-sm',
                            exportOptions: {
                                //columns: ':visible'
                            }
                        }
                    ],

                    "language": {
                        "lengthMenu": "Mostrar _MENU_ filas",
                        "zeroRecords": "Sin registros",
                        "info": "Mostrando registros _START_ a _END_ de _TOTAL_",
                        "infoEmpty": "Sin registros disponibles",
                        "infoFiltered": "(filtrados de un total de _MAX_ registros)",
                        "sSearch": "Buscar:",
                        "oPaginate": {
                            "sFirst": "Primero",
                            "sLast": "Último",
                            "sNext": "Sig",
                            "sPrevious": "Ant"
                        },
                        "buttons": {
                            "copyTitle": "Copiado al portapapeles",
                            "copySuccess": {
                                _: "Copiadas %d filas",
                                1: "Copiada 1 fila"
                            }
                        }
                    },
                    "initComplete": function (settings, json) {
                        $(this).DataTable().buttons().container().appendTo($('#botones-exp'));
                    },

                    "aaSorting": [[0, 'asc']]

                });//DataTable

                $('#tablaResultado').DataTable({
                    columns: [
                        { "data": "Geocerca" },
                        { "data": "Estado" },
                        { "data": "FechaMig" },
                        { "data": "TipoZona" },
                        { "data": "NumVehiculos" },
                        { "data": "Error" },
                        { "data": "Mensaje", visible: false } //, visible: false 
                    ],

                    bProcessing: true,
                    deferRender: true,
                    searching: true,
                    paging: true,
                    ordering: true,
                    responsive: false,
                    scrollX: true,
                    dom: '<"html5buttons">lTfgitp',
                    select: true,

                    buttons: [
                        {
                            text: 'Copiar',
                            extend: 'copy',
                            className: 'btn-sm',
                            exportOptions: {
                                //columns: ':visible'
                            }
                        },
                        {
                            text: 'CSV',
                            extend: 'csv',
                            className: 'btn-sm',
                            title: 'Migración_Zonas_' + endDate.format('YYYY-MM-DD'),
                            fieldSeparator: ';',
                            fieldBoundary: '',
                            exportOptions: {
                                //columns: ':visible'
                            }
                        },

                        {
                            text: 'PDF',
                            extend: 'pdf',
                            //title: 'Título',
                            orientation: 'landscape',
                            filename: 'Migración_Zonas_' + endDate.format('YYYY-MM-DD'),
                            className: 'btn-sm',
                            exportOptions: {
                                //columns: ':visible'
                            },
                            customize: function (doc) {
                                doc.defaultStyle.fontSize = 6;
                                doc.styles.tableHeader.fontSize = 6;
                                doc.pageMargins = [10, 5, 10, 5]; //[left,top,right,bottom]
                            }
                        },

                        {
                            text: 'Imprimir',
                            extend: 'print',
                            customize: function (win) {
                                $(win.document.body).addClass('white-bg');
                                $(win.document.body).css('font-size', '10px');

                                $(win.document.body).find('table')
                                    .addClass('compact')
                                    .css('font-size', 'inherit');
                            },
                            className: 'btn-sm',
                            exportOptions: {
                                //columns: ':visible'
                            }
                        }
                    ],


                    "language": {
                        "lengthMenu": "Mostrar _MENU_ filas",
                        "zeroRecords": "Sin registros",
                        //"info": "Página _PAGE_ de _PAGES_",
                        "info": "Mostrando _TOTAL_ registros",
                        //"info": "Showing _START_ to _END_ of _TOTAL_ entries"
                        "infoEmpty": "Sin registros disponibles",
                        "infoFiltered": "(filtrados de un total de _MAX_ registros)",
                        "sSearch": "Buscar:",
                        "oPaginate": {
                            "sFirst": "Primero",
                            "sLast": "Último",
                            "sNext": "Sig",
                            "sPrevious": "Ant"
                        },
                        "buttons": {
                            "copyTitle": "Copiado al portapapeles",
                            "copySuccess": {
                                _: "Copiadas %d filas",
                                1: "Copiada 1 fila"
                            }
                        }
                    },
                    "initComplete": function (settings, json) {
                        $(this).DataTable().buttons().container().appendTo($('#botonesR-exp'));
                    },
                });//DataTable

                $("#idFlota").change(function () {
                    var selectedItem = $('#idFlota.selectpicker').val();
                    var selectedPlataforma = $('#idPlataforma').val();
                    $("#idCodFlota").text(selectedItem);
                    cargaZonas(selectedPlataforma, selectedItem); //Carcar geocercas x cliente
                });

                $("#idRUT").change(function () { //idCodcliente
                    var selectedRut = $('#idRUT.selectpicker').val();
                    var selectedPlataforma = $('#idPlataforma').val();
                    var tmpCli = $('#idRUT option:selected').text().split("/");

                    tmpCli = tmpCli[0].trim().replace('-', '');

                    if (tmpCli.length == 8) {
                        tmpCli="0" + tmpCli;
                    }

                    $("#idCodCliente").text(tmpCli);
                    $("#idCodRUT").text(selectedRut);
                });

                $("#idPlataforma").change(function () {
                    var plat = $(this).val();
                    var tablaInf = $('#tablaZonas').DataTable();
                    tablaInf.clear().draw();
                    $("#idCodFlota").text("");
                    $("#idCodRUT").text("");
                    $("#idCodPlat").text(plat);
                    cargaClientes(plat);
                    cargaFlotas(plat);
                });

                 $.fn.select2.amd.require([
                    'select2/utils',
                    'select2/dropdown',
                    'select2/dropdown/attachBody'
                ], function (Utils, Dropdown, AttachBody) {
                    function SelectAll() { }
                });

                //function cargaFlotas(idPlat, idUsu) {
                function cargaFlotas(idPlat) {
                    $("#idFlota").empty();
                    var idPlataf = idPlat;
                    var myVar;
                    //var IdUsuario = $("#hdnCod_Usuario").val();
                    if (idPlataf != null) {
                        $.ajax({
                            async: true,
                            type: 'POST',
                            url: "MigraZona.aspx/cargarFlotas",
                            data: "{'IdPlataforma':'" + idPlataf + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',

                            beforeSend: function () {
                                startBlocking();
                                var seg = 0;
                                myVar = setInterval(function () {
                                    seg++;
                                    if (seg == 15) {
                                        $.blockUI({ message: '<p><IMG height="10%" width="20%"  SRC="./img/pin.gif"></p><p><h4 id="myMessage">Esta tomando mas tiempo de lo normal, espere...</h4></p>' });
                                        clearInterval(myVar);
                                    }
                                }, 1000);
                            },

                            success: function (arg) {
                                clearInterval(myVar);
                                stopBlocking();
                                var objeto = arg.d;
                                for (var i = 0; i < objeto.length; i++) {
                                    $('#idFlota').append($('<option>', {
                                        value: objeto[i].Cod_Flota,
                                        text: objeto[i].NomFlota
                                    }));
                                }
                                $('#idFlota').selectpicker('refresh');
                            },

                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            clearInterval(myVar);
                            stopBlocking();
                                var error = eval("(" + XMLHttpRequest.responseText + ")");
                                alert(error.Message);
                            }
                        });
                    }
                }

                function cargaClientes(idPlat) {
                    $("#idRUT").empty();

                    var idPlataf = idPlat;
                    //var idUser = idUsu;

                    //var IdUsuario = $("#hdnCod_Usuario").val();
                    if (idPlataf != null) {
                        $.ajax({
                            async: false,
                            type: 'POST',
                            url: "MigraZona.aspx/cargarClientes",
                            data: "{'IdPlataforma':'" + idPlataf + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (arg) {

                                var objeto = arg.d;
                                for (var i = 0; i < objeto.length; i++) {
                                    $('#idRUT').append($('<option>', {
                                        value: objeto[i].Cl_ID,
                                        text: objeto[i].Cl_Nombre
                                    }));
                                }
                                $('#idRUT').selectpicker('refresh');
                            }
                        });
                    }
                }

                function cargaZonas(idPlat, idFlota) {
                    var idFl = idFlota;
                    var idPlataf = idPlat;
                    var indxD = [];
                    //var IdUsuario = $("#hdnCod_Usuario").val();

                    if (idPlataf != null) {
                        $.ajax({
                            async: false,
                            type: 'POST',
                            url: "MigraZona.aspx/generarInforme",
                            data: "{'idPlataforma':'" + idPlataf + "', 'idFlota':'" + idFl + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (arg) {
                                var objeto = arg.d;
                                if (objeto.length > 0) {
                                    var tablaInf = $('#tablaZonas').DataTable();
                                    tablaInf.column('0:visible').order('asc');
                                    tablaInf.clear().draw();
                                    tablaInf.columns.adjust().draw();
                                    tablaInf.rows.add(objeto).draw();
                                }
                                else {
                                    var tablaInf = $('#tablaZonas').DataTable();
                                    tablaInf.clear().draw();
                                }
                            }
                        });
                    }
                    $("#idValidar").prop("disabled", false);
                }

                $('#idValidar').on('click', function () {
                    var dtTable = $('#tablaZonas').DataTable();
                    var msgValida = "";
                    var datosSelectores = true;
                    var flag = false;
                    var ArrFila = []; var myFila = 0;

                    $("#divResultados").prop("hidden", true);
                    $("#idMigrar").prop("disabled", true);

                    if ($('#idFlota').val() == "0" || $('#idFlota').val() == null) {
                        datosSelectores = false;
                        msgValida = msgValida + "Seleccione flota de origen.\n";
                    }
                    if ($('#idRUT').val() == "0" || $('#idRUT').val() == null) {
                        datosSelectores = false;
                        msgValida = msgValida + "Seleccione cliente.";
                    }

                    if (datosSelectores) {//validación de selectores
 
                        $('#tablaZonas').DataTable().rows({ search: 'applied', order: 'applied', page: 'current' }).eq(0).each(function (index) {
                            var ArgFila;
                            var NFlota = $('#idFlota option:selected').text().split("/");
                            var fila = dtTable.row(index).data();
                            var CodCliente = $("#idCodRUT").text();
                            var lineaCruzada = false;

                            ArNombre = fila['Zona'];

                            if (fila['TipoZona'] == "Sitio") {
                                ArTipo = 1;
                            } else {
                                ArTipo = 2;
                            }

                            var msg = fila['Mensaje'];
                            var estado = fila['EstadoZona'];

                            lineaCruzada = validaLineas(cierraPoligono(fila['Poligono'].split(',')).split(','));

                            if (msg == '-' && estado != 'Migrado' && lineaCruzada <= 0) {
                                msg = '';
                                ArrFila[myFila] = CodCliente + "|" + ArNombre + "|" + ArTipo;
                                myFila++;
                            }

                        })
                        validaZona(ArrFila); // llamada ajax
                        //dtTable.row(index).data(fila).draw(false);
                        $("#idValidar").prop("disabled", false);
                    }// Validación de selectores
                    else {
                        alert(msgValida);
                        datosSelectores = true;
                    }
                    
                });

                 function validaZona (strFila) {
                    //var idUser = idUsu;
                    //var IdUsuario = $("#hdnCod_Usuario").val();
                     var Res = []; var myVar; var c = 0;
                    $.ajax({
                        async: true,
                        type: 'POST',
                        url: "MigraZona.aspx/validarZona",
                        data: "{fila:" + JSON.stringify(strFila) + "}",
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',

                        beforeSend: function () {
                            startBlocking();
                            var seg = 0;
                            myVar = setInterval(function () {
                                seg++;
                                if (seg == 15) {
                                    $.blockUI({ message: '<p><IMG height="10%" width="20%"  SRC="./img/pin.gif"></p><p><h4 id="myMessage">Esta tomando mas tiempo de lo normal, espere...</h4></p>' });
                                    clearInterval(myVar);
                                }
                            }, 1000);
                        },

                        success: function (arg) {
                            var objeto = arg.d;
                            if (objeto.length > 0) {
                                Res = objeto;
                            }
                            //procesar respuesta
                            var dtTable = $('#tablaZonas').DataTable();
                            var msgValida = "";
                            var datosSelectores = true;
                            var flag = false; 


                            $('#tablaZonas').DataTable().rows({ search: 'applied', order: 'applied', page: 'current' }).eq(0).each(function (index) {
                                var ArgFila;
                                var NFlota = $('#idFlota option:selected').text().split("/");
                                var fila = dtTable.row(index).data();
                                var CodCliente = $("#idCodRUT").text();
                                var lineaCruzada = false;

                                ArNombre = fila['Zona'];

                                if (fila['TipoZona'] == "Sitio") {
                                    ArTipo = 1;
                                } else {
                                    ArTipo = 2;
                                }

                                ArgFila = CodCliente + "|" + ArNombre + "|" + ArTipo;

                                var msg = fila['Mensaje'];
                                var estado = fila['EstadoZona'];

                                lineaCruzada = validaLineas(cierraPoligono(fila['Poligono'].split(',')).split(','));

                                if (lineaCruzada > 0) {
                                    vTxt = '<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>';
                                    msg = msg + '<tr><td>Error en polígono </td><td>' + fila['TipoZona'] + ' : ' + ArNombre + ' tiene líneas superpuestas.</td></tr>';

                                    fila['Error'] = vTxt; //"Error";
                                    fila['Migrar'] = '<input type=\"checkbox\"  disabled>';
                                    fila['Mensaje'] = msg;
                                }

                                if (msg == '-' && estado != 'Migrado' && lineaCruzada <= 0) {
                                    msg = '';

                                    if (Res[c].contZona > 0) {

                                        if (Res[c].MigUser != '') {
                                            msg = msg + '<tr><td>La Zona de destino ya fue migrada</td><td>' + fila['TipoZona'] + ' : ' + Res[c].MigUser + ' </td></tr>';
                                            flag = true;
                                        } else {
                                            msg = msg + '<tr><td>Error! La Zona de destino ya existe en cliente</td><td>' + fila['TipoZona'] + ' : ' + ArNombre + ' </td></tr>';
                                            flag = true;
                                        }
                                    }

                                    if (flag) {
                                        vTxt = '<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>';

                                        fila['Error'] = vTxt; //"Error";
                                        fila['Migrar'] = '<input type=\"checkbox\"  disabled>';
                                        fila['Mensaje'] = msg;

                                        msg = "";
                                        flag = false;
                                    }
                                    else {
                                        if (fila['Mensaje'] == '-') {
                                            fila['Error'] = '';
                                            fila['Migrar'] = '<input type=\"checkbox\" name=\"idMig\" class=\"chkMigra\" checked=\"true\">';
                                            $("#idMigrar").prop("disabled", false);
                                        }
                                        else {
                                            fila['Migrar'] = '<input type=\"checkbox\" disabled>';
                                        }
                                    }
                                    c++;
                                }
                                dtTable.row(index).data(fila).draw(false);
                            })

                            clearInterval(myVar);
                            stopBlocking();
                        },

                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            clearInterval(myVar);
                            stopBlocking();
                            var error = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(error.Message);
                        }	

                    });
                }

                var validaLineas = function (ArrCor) {
                    var p = []; var p2 = []; var q = []; var q2 = [];
                    var respuesta = false;
                    let c = -2;
                    for (let i = 0; i < ArrCor.length - 1; i = i + 2) {
                        p.push({
                            x: (parseFloat(ArrCor[i])),
                                y : (parseFloat(ArrCor[i + 1]))
                        });
                    }

                    p2 = p; q = p; q2 = p;

                    for (let i = 0; i < p.length-1; i++) {

                        for (let j = 0; j < q.length-1; j++) {

                            if ((i != j) && (Math.abs(i-j) > 1)) {

                                cruce = punto_interseccion(p[i],p2[i+1],q[j],q2[j+1]);

                                if (cruce) {
                                    respuesta = true; c++;
                                }
                            }
                        }

                    }
                    return c;
                }


                function punto_interseccion(p, p2, q, q2) {
                    var r = subtractPoints(p2, p);
                    var s = subtractPoints(q2, q);

                    var uNumerator = crossProduct(subtractPoints(q, p), r);
                    var denominator = crossProduct(r, s);

                    if (uNumerator == 0 && denominator == 0) {

                        if (equalPoints(p, q) || equalPoints(p, q2) || equalPoints(p2, q) || equalPoints(p2, q2)) {
                            return true
                        }
                        return !allEqual(
                            (q.x - p.x < 0),
                            (q.x - p2.x < 0),
                            (q2.x - p.x < 0),
                            (q2.x - p2.x < 0)) ||
                            !allEqual(
                                (q.y - p.y < 0),
                                (q.y - p2.y < 0),
                                (q2.y - p.y < 0),
                                (q2.y - p2.y < 0));
                    }

                    if (denominator == 0) {
                        return false;
                    }

                    var u = uNumerator / denominator;
                    var t = crossProduct(subtractPoints(q, p), s) / denominator;

                    return (t >= 0) && (t <= 1) && (u >= 0) && (u <= 1);
                }

                var crossProduct = function (point1, point2) {
                    return point1.x * point2.y - point1.y * point2.x;
                }

                var subtractPoints = function (point1, point2) {
                    var result = {};
                    result.x = point1.x - point2.x;
                    result.y = point1.y - point2.y;

                    return result;
                }

                var equalPoints = function (point1, point2) {
                    return (point1.x == point2.x) && (point1.y == point2.y)
                }

                var allEqual  = function (args) {
                    var firstValue = arguments[0],
                        i;
                    for (i = 1; i < arguments.length; i += 1) {
                        if (arguments[i] != firstValue) {
                            return false;
                        }
                    }
                    return true;
                }

                $('#idLimpiar').on('click', function () {
                    $('#formMigraZonas')[0].reset();

                    var tablaInf = $('#tablaZonas').DataTable();
                    tablaInf.clear().draw();
                    var tablaRes = $('#tablaResultado').DataTable();
                    tablaRes.clear().draw();

                    $("#idFlota").empty().val('default').selectpicker("refresh");
                    $("#idRUT").empty().val('default').selectpicker("refresh");

                    $("#idCodRUT").text("");
                    $("#idCodFlota").text("");
                    $("#idCodPlat").text("");

                    $("#idMigrar").prop("disabled", true);
                    $("#idValidar").prop("disabled", false);
                    $("#divResultados").prop("hidden", true);
                });


                $('#tablaZonas tbody').on('change', 'input[class="chkMigra"]', function (e) {
                    var RowSelected = $(this).parent().parent()[0].firstElementChild.firstChild.parentElement._DT_CellIndex.row
                    var dtTable = $('#tablaZonas').DataTable();
                    var fila = dtTable.row(RowSelected).data();

                    //if (!this.checked) {
                    if (this.attributes[3].ownerElement.checked == true) {

                        fila['Migrar'] = '<input type=\"checkbox\" name=\"idMig\" class=\"chkMigra\" checked=\"true\">';
                    }
                    else {
                        fila['Migrar'] = '<input type=\"checkbox\" name=\"idMig\" class=\"chkMigra\" checked=\"false\">';
                    }
                    //dtTable.row(RowSelected).data(fila).draw(false);
                });


                $('#idMigrar').on('click', function () {
                    var flag = true;
                    var mensaje = "";
                    var NFlota = $('#idFlota option:selected').text().split("/");
                    var NCliente = $('#idRUT option:selected').text().split("/");
                    var Resultado = [];
                    var tablaRes = $('#tablaResultado').DataTable();
                    tablaRes.clear().draw();
                    var ArrFila = []; myFila = 0;
                    
                    var OK = false;
                    var vacio = true;

                    if ($('#idPlataforma').val() == "" || $('#idPlataforma').val() == null) {
                        mensaje = mensaje + "Seleccione plataforma de origen.";
                        flag = false;
                    }
                    if ($('#idFlota').val() == "0" || $('#idFlota').val() == null) {
                        mensaje = mensaje + "\nSeleccione flota de origen.";
                        flag = false;
                    }
                    if ($('#idRUT').val() == "0" || $('#idRUT').val() == null) {
                        mensaje = mensaje + "\nSeleccione cliente de destino.";
                        flag = false;
                    }


                    if (flag) { // Si están todos los datos en los selectores

                        $('#tablaZonas').DataTable().rows({ search: 'applied', order: 'applied', page: 'current' }).eq(0).each(function (index) {
                            var node = $(this.row(index).node());
                            var dtTable = $('#tablaZonas').DataTable();
                            var fila = dtTable.row(index).data();

                            if (fila['Migrar'].lastIndexOf('true') >= 0) {
                                OK = true; vacio = false;
                            }

                            if (OK) { // Si la fila tiene check!
                                var ArgFila;

                                var NFlota = $('#idFlota option:selected').text().split("/");
                                var EstadoMig = '-';
                                var FechaMig = '-';
                                var ErrorMig = '-';
                                var ErrorFilas;
                                var ErrorMsg = '';
                                var polCerrado = [];

                                ArNombre = node[0].childNodes[0].childNodes[0].data; //Nombre zona
                                ArTipo = node[0].childNodes[1].childNodes[0].data;
                                ArCli = $('#idRUT').val();
                                ArRUT = NCliente[0].trim();
                                ArRef = fila['Referencia'];
                                Coords = fila['Poligono']; //.split(',');

                                ArGeom = tipoGeometria(Coords.split(','));

                                if (ArGeom == 2 || ArGeom == 4) {
                                    polCerrado = Coords.split(',');
                                } else {
                                    polCerrado = cierraPoligono(Coords.split(',')).split(',');
                                }

                                if (ArGeom == 1 || ArGeom == 3) {
                                    var ArJSON = generaCoorJSON(polCerrado);
                                } else {
                                    var ArJSON = fila['Poligono'].trim().replace(/,/g, ';');
                                }
                               
                                if (ArTipo == "Sitio") { ArTipo = 1; }
                                    else {ArTipo = 2;}

                                ArrFila[myFila] = ArCli + "/" + ArNombre + "/" + ArTipo + "/" + ArRef + "/" + ArGeom + "/" + ArJSON //+ "|" + ArUsr;
                                myFila++;


                            }// filas seleccionadas
                            OK = false;
                        });// Fin de recorrido de la tabla
                        if (vacio) {
                            alert('Debe tener por lo menos un registro validado para migrar.');
                        } else {
                            MigZona(ArrFila);
                        }
                    }
                    else {
                        alert(mensaje); // Errores de datos en selectores
                    }
                });// Migración

                function MigZona(strFila) {
                    //var idUser = idUsu;
                    //var IdUsuario = $("#hdnCod_Usuario").val();
                    var Resultado = [];
                    var myVar;
                    $.ajax({
                        async: true,
                        type: 'POST',
                        url: "MigraZona.aspx/migraZona",
                        data: "{fila:" + JSON.stringify(strFila) + ", idPlataforma:" + $('#idPlataforma').val() + "}",
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',

                        beforeSend: function () {
                            startBlocking();
                            var seg = 0;
                            myVar = setInterval(function () {
                                seg++;
                                if (seg == 15) {
                                    $.blockUI({ message: '<p><IMG height="10%" width="20%"  SRC="./img/pin.gif"></p><p><h4 id="myMessage">Esta tomando mas tiempo de lo normal, espere...</h4></p>' });
                                    clearInterval(myVar);
                                }
                            }, 1000);
                        },

                        success: function (arg) {
                            Resultado = arg.d;
                            var flag = true;
                            var mensaje = "";
                            var NFlota = $('#idFlota option:selected').text().split("/");
                            var NCliente = $('#idRUT option:selected').text().split("/");
                            //var Resultado = [];
                            var tablaRes = $('#tablaResultado').DataTable();
                            tablaRes.clear().draw();
                            var OK = false;
                            var vacio = true;
                            var cont = 0;

                            $('#tablaZonas').DataTable().rows({ search: 'applied', order: 'applied', page: 'current' }).eq(0).each(function (index) {
                                var node = $(this.row(index).node());
                                var dtTable = $('#tablaZonas').DataTable();
                                var fila = dtTable.row(index).data();

                                if (fila['Migrar'].lastIndexOf('true') >= 0) {
                                    OK = true; vacio = false;
                                }

                                if (OK) { // Si la fila tiene check!
                                    var ArgFila;

                                    var NFlota = $('#idFlota option:selected').text().split("/");
                                    var EstadoMig = '-';
                                    var FechaMig = '-';
                                    var ErrorMig = '-';
                                    var ErrorFilas;
                                    var ErrorMsg = '';
                                    var polCerrado = [];

                                    ArNombre = node[0].childNodes[0].childNodes[0].data; //Nombre zona
                                    ArTipo = node[0].childNodes[1].childNodes[0].data;
                                    ArCli = $('#idRUT').val();
                                    ArRUT = NCliente[0].trim();
                                    ArRef = fila['Referencia'];
                                    Coords = fila['Poligono']; //.split(',');

                                    ArGeom = tipoGeometria(Coords.split(','));

                                    if (ArGeom == 2 || ArGeom == 4) {
                                        polCerrado = Coords.split(',');
                                    } else {
                                        polCerrado = cierraPoligono(Coords.split(',')).split(',');
                                    }

                                    if (ArGeom == 1 || ArGeom == 3) {
                                        var ArJSON = generaCoorJSON(polCerrado);
                                    } else {
                                        var ArJSON = fila['Poligono'].trim().replace(/,/g, ';');
                                    }

                                    if (ArTipo == "Sitio") { ArTipo = 1; }
                                    else { ArTipo = 2; }

                                    ArgFila = ArCli + "/" + ArNombre + "/" + ArTipo + "/" + ArRef + "/" + ArGeom + "/" + ArJSON //+ "|" + ArUsr;

                                    $("#idMigrar").prop("disabled", true);
                                    $("#divResultados").prop("hidden", false);

                                    ErrorFilas = Resultado[cont].Err.split('|')

                                    if (Resultado[cont].Err.search('OK') == 0) {
                                        EstadoMig = 'Migrado';
                                        FechaMig = moment().format("DD/MM/YYYY"); //(new Date()).toISOString().split('T')[0];
                                        //ErrorMig = Resultado[0].Err;
                                    }
                                    else {
                                        EstadoMig = 'No Migrado';
                                        ErrorMig = '<a href=\"#\" data-toggle=\"modal\" data-target=\"#MigModal\"><i class=\"fa fa-exclamation-triangle\" aria-hidden=\"true\"></i></a>';
                                        for (var c = 0; c < ErrorFilas.length; c++) {
                                            if (ErrorFilas[c] != '') {
                                                ErrorMsg = ErrorMsg + '<tr><td>' + ErrorFilas[c] + '</td></tr>';
                                            }
                                        }
                                    }

                                    tablaRes.columns.adjust().draw();
                                    tablaRes.row.add({
                                        "Geocerca": ArNombre,
                                        "Estado": EstadoMig,
                                        "FechaMig": FechaMig,
                                        "TipoZona": node[0].childNodes[1].childNodes[0].data,
                                        "NumVehiculos": node[0].childNodes[2].childNodes[0].data,
                                        "Error": ErrorMig,
                                        "Mensaje": ErrorMsg
                                    }).draw();
                                }
                                OK = false;
                            });// Fin de recorrido de la tabla


                            clearInterval(myVar);
                            stopBlocking();
                        },

                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            clearInterval(myVar);
                            stopBlocking();
                            var error = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(error.Message);
                        }

                    });
                }


                var tipoGeometria = function (coordenadas) {
                    const s = new Set(coordenadas);
                    switch (coordenadas.length) {
                        case 2:
                            return 4; //Punto
                            break;
                        case 3:
                            return 2; //circulo
                            break;
                        case 8:
                            {
                                if (s.size == 4) {
                                    return 3; // rectángulo
                                    break;
                                }
                                else {
                                    return 1; // polígono}
                                    break;
                                }
                            }
                        default:
                            return 1;
                            break;
                    }
                }

                var generaCoorJSON = function (coordenadas) {
                    var puntos = [];
                    var cJSON = "";
                    for (var i = 0; i < coordenadas.length; i = i + 2) {
                        puntos.push({
                            lat: (coordenadas[i]),
                            lng: (coordenadas[i + 1])
                        });
                    }

                    for (var i = 0; i < puntos.length; i++) {
                        if (i == puntos.length - 1) {
                            cJSON = cJSON + puntos[i].lat + ";" + puntos[i].lng
                        } else {
                            cJSON = cJSON + puntos[i].lat + ";" + puntos[i].lng + "|"
                        }
                    }
                    return cJSON;
                }

                var cierraPoligono = function (poligono) {

                    if (poligono[0] != poligono[poligono.length - 1] || poligono[1] != poligono[poligono.length]) {
                        poligono = poligono + "," + poligono[0] + "," + poligono[1];
                    } 
                    return poligono;
                }


                $('#myModal').on('show.bs.modal', function (e) {
                    Idx = e.relatedTarget.parentNode._DT_CellIndex.row;
                    myTable = $('#tablaZonas').DataTable();

                    varHTML_1 = '<table id="modalZona" class="table table-bordered table-hover"><thead><tr><th>Tipo de Mensaje</th><th>Detalle Mensaje</th></tr></thead><tbody>';
                    varHTML_2 = '</tbody></table>';

                    varMSG = myTable.cells({ row: Idx, column: 7 }).data()[0];
                    $('#myModal .modal-title').html("Mensajes de validación : " + myTable.cells({ row: Idx, column: 1 }).data()[0] +" - "+ myTable.cells({ row: Idx, column: 0 }).data()[0]);
                    $('#myModal .modal-body').html(varHTML_1 + varMSG + varHTML_2);
                });

                $('#MigModal').on('show.bs.modal', function (e) {
                    Idx = e.relatedTarget.parentNode._DT_CellIndex.row;
                    myTable = $('#tablaResultado').DataTable();

                    varHTML_1 = '<table id="modalResultado" class="table table-bordered table-hover"><thead><tr><th>Detalle Mensaje</th></tr></thead><tbody>';
                    varHTML_2 = '</tbody></table>';

                    varMSG = myTable.cells({ row: Idx, column: 6 }).data()[0];
                    $('#MigModal .modal-title').html("Mensajes de Migración : " + myTable.cells({ row: Idx, column: 3 }).data()[0] + ' ' + myTable.cells({ row: Idx, column: 0 }).data()[0]);
                    $('#MigModal .modal-body').html(varHTML_1 + varMSG + varHTML_2);
                });

                var map = null;
                var myLatlng;
                function initializeGMap(lat, lng, rad, pol) {
                    map = null;
                    var myMarker;

                    if (rad > 0) {
                        myLatlng = new google.maps.LatLng(lat, lng);
                        var myOptions = {
                            zoom: 12,
                            zoomControl: true,
                            center: myLatlng,
                            mapTypeId: google.maps.MapTypeId.ROADMAP
                        };

                        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

                        myMarker = new google.maps.Marker({
                            position: myLatlng
                        });
                        myMarker.setIcon('http://maps.gstatic.com/mapfiles/markers2/measle.png');
                        myMarker.setMap(map);

                        var circuloEnMapa = new google.maps.Circle({
                            strokeColor: '#FF0000',
                            strokeOpacity: 0.8,
                            strokeWeight: 2,
                            fillColor: '#FFFF00',
                            fillOpacity: 0.35,
                            center: myLatlng,
                            radius: parseInt(rad),
                        });
                        circuloEnMapa.setMap(map);
                    }
                    else {

                        myLatlng = new google.maps.LatLng(lat, lng);
                        var myOptions = {
                            zoom: 12,
                            zoomControl: true,
                            center: myLatlng,
                            mapTypeId: google.maps.MapTypeId.ROADMAP
                        };

                        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

                        var poligono = pol.split(",");
                        var points = [];
                        for (var i = 0; i < poligono.length; i=i+2) {
                            points.push({
                                lat: parseFloat(poligono[i]),
                                lng: parseFloat(poligono[i+1])
                            });
                        }
                        // Construct the polygon.
                        var poligonoEnMapa = new google.maps.Polygon({
                            paths: points,
                            strokeColor: '#FF0000',
                            strokeOpacity: 0.8,
                            strokeWeight: 2,
                            fillColor: '#FFFF00',
                            fillOpacity: 0.35
                        });
                        poligonoEnMapa.setMap(map);

                        var c = 1;
                        $(points).each(function () {
                            Punto = new google.maps.LatLng(this);
                            myMarker = new google.maps.Marker({
                                position: Punto,
                                label: {
                                    text: c.toString(),
                                    fontSize: '20px'
                                },
                                
                            });
                            //myMarker.setIcon('http://maps.gstatic.com/mapfiles/markers2/measle.png');
                            myMarker.setMap(map);
                            c++;
                        });
                    }
                }

                // Re-init map before show modal
                $('#VizModal').on('show.bs.modal', function (event) {
                    var Idx = event.relatedTarget.parentNode._DT_CellIndex.row;
                    var link = $(event.relatedTarget);
                    var myTable = $('#tablaZonas').DataTable();

                    initializeGMap(link.data('lat'), link.data('lng'),link.data('rad'),link.data('pol'));

                    $("#location-map").css("width", "100%");
                    $("#map_canvas").css("width", "100%");
                    $('#VizModal .modal-title').html("Zona: " + myTable.cells({ row: Idx, column: 0 }).data()[0] + " - " + myTable.cells({ row: Idx, column: 1 }).data()[0]);

                });

                $('#VizModal').on('shown.bs.modal', function () {
                    google.maps.event.trigger(map, "resize");
                    map.setCenter(myLatlng);
                });

            }); //$(Document).ready

        </script>
    </body>
</html>


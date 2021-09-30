<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MigraEquipos.aspx.cs" Inherits="MigraEquipos" %>
<%@ Register Src="controles/frmModuloUsuario.ascx" TagName="moduloUsuario" TagPrefix="userMod" %>

<!DOCTYPE html>

<html>
    <head runat="server">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>GPS Chile | Migración</title>


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

            #tablaEquipos span{
              display:none;
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
                     <li  class="active">
                        <a href="#"><i class="fa fa-truck"></i> Equipos</a>
                    </li>                 
                    <li >
                        <a href="MigraZona.aspx" > <i class="fa fa-map-o"></i> Zona</a>
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
                        Migración de Equipos
                    </h1>
                </section>
                <!-- Main content -->
		<section class="content">

<form role="form" method="post"  id="formMigraEquipos">
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
                                                                        <asp:PlaceHolder ID="PlaceHolder1" runat="server" />
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

                                    <div class="col-md-6">
			                                <div class="box box-solid">
				                                <div class="box-header with-border">
					                                <h3 class="box-title">Seleccione datos de Destino</h3>&nbsp;&nbsp;&nbsp;
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
												    <label for="idRUT" id="idCodRUT">RUT</label>
											    </div>
	                        			    </div>
                                    </div>




                                    <div class="col-md-12">
                        				    <div class="col-md-2">
	                        				    <div class="form-group">
												    <label for="idOwner">Usuario / Nombre </label>
											    </div>
	                        			    </div>
	                        			    <div class="col-md-3">
	                        				    <div class="form-group">
												    <select  name="idOwner" class="form-control selectpicker" data-size="8" id="idOwner" style="width: 100%;" data-live-search="true" data-actions-box="true">
												    </select>
											    </div>
	                        			    </div>
                                            <div class="col-md-2">
	                        				    <div class="form-group">
												    <label for="idOwner" id="idCodUsuario">Usuario</label>
											    </div>
	                        			    </div>
                        	        </div>


                        		</div>
                        </div>
                        
                        <div class="col-md-12 text-right" id="botones-exp" style="margin-top:10px;"></div>
                        
                        <div class="col-md-12" style="padding-top:20px !important;">
                            
                            <table id="tablaEquipos" class="table table-bordered table-hover nowrap" >
                                <thead>
                                    <tr>
                                        <th>Patente</th>
                                        <th>P</th>
                                        <th>V</th>
                                        <th>id AVL</th>
                                        <th>Estado</th>
                                        <th>Fecha Última Transmisión</th>
                                        <th>Nro Serie GPS</th>
                                        <th>Marca GPS</th>
                                        <th>Modelo GPS</th>
                                        <th>IMEI GPS</th>
                                        <th>Nro SIM</th>
                                        <th>Tipo SIM</th>
                                        <th>CIA SIM</th>
                                        <th>Mensajes</th>
                                        <th>Migrar</th>
                                        <th>Mensaje</th>
                                        <th>Referencia</th>
                                        <th>cod_vehiculo</th>
                                        <th>cod_conductor</th>
                                        <th>Conductor</th>
                                        <th>EmailConductor</th>
                                        <th>Id Asignado Conductor</th>
                                        <th>Cod Ref Asignado Conductor</th>
                                        <th>Cod Pin Conductor</th>
                                    </tr>
                                </thead>
                                <tbody>
                                   
                                </tbody>
                            </table>

                            <br />
                             <div style="overflow: auto;">
                                <div style="float: left; width: 200px;">
                                    <button name="idLimpiar" id="idLimpiar" type="button" class="btn btn-default">
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

                          <!-- Modal -->
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

                          <!-- Modal -->
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
			                                <th>Vehículo</th>
			                                <th>Estado</th>
			                                <th>Fecha Migración</th>
			                                <th>Nro Serie GPS</th>
			                                <th>Marca GPS</th>
			                                <th>Modelo GPS</th>
			                                <th>IMEI GPS</th>
			                                <th>Nro SIM</th>
			                                <th>Tipo SIM</th>
			                                <th>CIA SIM</th>
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


            <div id='myHiddeDiv' style='display:none'> 
                <p><IMG height="10%" width="20%"  SRC="./img/pin.gif" id='myAnimatedImage'></p><p><h4 id="myMessage">Procesando...</h4></p>
            </div> 

            <div id="spinLoad">
                <span id="mensajeLoading"><i class="fa fa-spin fa-fw fa-refresh "></i> Procesando datos ...</span>
            </div>
            <div id="spinMigra">
                <span id="mensajeLoading_2" style="display:none"><i class="fa fa-spin fa-fw fa-refresh "></i> Migrando datos ...</span>
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

                $("#idCodPlat").show();
                $("#idCodFlota").show();
                $("#idCodRUT").show();
                $("#idCodUsuario").show();

                function startBlocking() {
                    $.blockUI({ message: '<p><IMG height="10%" width="20%"  SRC="./img/pin.gif"></p><p><h4 id="myMessage">Procesando...</h4></p>' });
                }

                function stopBlocking() {
                    clearTimeout(timeoutID);
                }

                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });

                //Initialize Date range picker
                var endDate = moment();

                $('#tablaEquipos').DataTable({
                    columns: [
                        { "data": "RefVehiculo" },
                        { "data": "Patente" },
                        { "data": "VIN" },
                        { "data": "idAVL" },
                        { "data": "Estado" },
                        { "data": "FechaUltTr" },
                        { "data": "NroSerieGPS" },
                        { "data": "MarcaGPS" },
                        { "data": "ModeloGPS" },
                        { "data": "IMEIGPS" },
                        { "data": "NroSIM" },
                        { "data": "TipoSIM" },
                        { "data": "CiaSIM" },
                        { "data": "Error" },
                        { "data": "Migrar" },
                        { "data": "Mensaje" },
                        { "data": "Referencia" },
                        { "data": "cod_vehiculo"},
                        { "data": "cod_conductor" },
                        { "data": "conductor" },
                        { "data": "email_conductor" },
                        { "data": "id_asignado_conductor" },
                        { "data": "cod_ref_asignado_conductor" },
                        { "data": "pin_conductor" }
                    ],

                    bProcessing: true,
                    deferRender: true,
                    destroy: true,
                    select: true,
                    //dom: '<"html5buttons">lTfgitp',
                    dom: '<"html5buttons">Blfrtip',
                    searching: true,
                    paging: true,
                    ordering: true,
                    responsive: false,
                    scrollX: true,

                    columnDefs: [
                        { targets: 0, orderable: true },
                        { targets: 1, orderable: false },
                        { targets: 2, orderable: false },
                        { targets: 5, type: 'date-eu', className: 'text-center' },
                        { targets: 13, orderable: false, className: 'text-center' },
                        { targets: 14, orderable: false }
                        , { targets: 15, orderable: false, visible: false }
                        , { targets: 16, orderable: false, visible: false }
                        , { targets: 17, orderable: false, visible: false }
                        , { targets: 18, orderable: false, visible: false }
                        , { targets: 20, orderable: false, visible: false }
                        , { targets: 21, orderable: false, visible: false }
                        , { targets: 22, orderable: false, visible: false }
                        , { targets: 23, orderable: false, visible: false }
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
                            title: 'Migración_Equipos_' + endDate.format('YYYY-MM-DD'),
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
                            filename: 'Migración_Equipos_' + endDate.format('YYYY-MM-DD'),
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
                                columns: ':visible'
                            }
                        }
                    ],


                    "language": {
                        "lengthMenu": "Mostrar _MENU_ filas",
                        "zeroRecords": "Sin registros",
                        //"info": "Página _PAGE_ de _PAGES_",
                        //"info": "Mostrando _TOTAL_ registros",
                        "info": "Mostrando registros _START_ al _END_ de _TOTAL_",
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
                        { "data": "RefVehiculo" },
                        { "data": "Estado" },
                        { "data": "FechaMig" },
                        { "data": "NroSerieGPS" },
                        { "data": "MarcaGPS" },
                        { "data": "ModeloGPS" },
                        { "data": "IMEIGPS" },
                        { "data": "NroSIM" },
                        { "data": "TipoSIM" },
                        { "data": "CiaSIM" },
                        { "data": "Error" },
                        { "data": "Mensaje", visible: false }
                    ],

                    bProcessing: true,
                    deferRender: true,

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
                            title: 'Migración_Equipos_' + endDate.format('YYYY-MM-DD'),
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
                            filename: 'Migración_Equipos_' + endDate.format('YYYY-MM-DD'),
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

                    searching: true,
                    paging: true,
                    ordering: true,
                    responsive: false,
                    scrollX: true,
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

                $("#idOwner").change(function () {
                    var selectedItem = $('#idOwner.selectpicker').val();
                    $("#idCodUsuario").text(selectedItem);
                });

                $("#idFlota").change(function () {
                    var selectedItem = $('#idFlota.selectpicker').val();
                    var selectedPlataforma = $('#idPlataforma').val();
                    $("#idCodFlota").text(selectedItem);
                    // Cod_Flota = 0
                    cargaEquipos(selectedPlataforma, selectedItem);
                    $("#idMigrar").prop("disabled", true);
                    $("#divResultados").prop("hidden", true);
                });

                $("#idRUT").change(function () {
                    var selectedRut = $('#idRUT.selectpicker').val();
                    var selectedPlataforma = $('#idPlataforma').val();
                    $("#idCodRUT").text(selectedRut);
                    cargaUsuarios(selectedPlataforma, selectedRut);
                    $("#idCodUsuario").text("");
                });

                $("#idPlataforma").change(function () {
                    var plat = $(this).val();
                    //var user = $("#idUsuario").val();
                    //cargaFlotas(plat, user);
                    var tablaInf = $('#tablaEquipos').DataTable();
                    $('#tablaEquipos tbody').empty();
                    tablaInf.clear().draw();
                    $("#idCodFlota").text("");
                    $("#idCodRUT").text("");
                    $("#idCodUsuario").text("");
                    $("#idCodPlat").text(plat);
                    cargaClientes(plat);
                    cargaFlotas(plat);
                    cargaUsuarios(0, 0);
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
                    //console.log('entrando en cargaGrupos')
                    var idPlataf = idPlat;
                    //var idUser = idUsu;
                    var myVar;

                    //var IdUsuario = $("#hdnCod_Usuario").val();
                    if (idPlataf != null) {
                        $.ajax({
                            async: true,
                            type: 'POST',
                            url: "MigraEquipos.aspx/cargarFlotas",
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
                                var objeto = arg.d;
                                for (var i = 0; i < objeto.length; i++) {
                                    $('#idFlota').append($('<option>', {
                                        value: objeto[i].Cod_Flota,
                                        text: objeto[i].NomFlota
                                    }));
                                }
                                $('#idFlota').selectpicker('refresh');
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
                }

                function cargaClientes(idPlat) {
                    $("#idRUT").empty();

                    //console.log('entrando en cargaGrupos')
                    var idPlataf = idPlat;
                    //var idUser = idUsu;
                    var myVar;

                    //var IdUsuario = $("#hdnCod_Usuario").val();
                    if (idPlataf != null) {
                        $.ajax({
                            async: true,
                            type: 'POST',
                            url: "MigraEquipos.aspx/cargarClientes",
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
                                var objeto = arg.d;
                                for (var i = 0; i < objeto.length; i++) {
                                    $('#idRUT').append($('<option>', {
                                        value: objeto[i].Cl_ID,
                                        text: objeto[i].Cl_Nombre
                                    }));
                                }
                                $('#idRUT').selectpicker('refresh');
                                stopBlocking();
                            }
                        });
                    }
                }

                function cargaUsuarios(idPlat, idCliente) {
                    $("#idOwner").empty();

                    var idPlataf = idPlat;
                    var idCli = idCliente;
                    //var idUser = idUsu;
                    var myVar;

                    //var IdUsuario = $("#hdnCod_Usuario").val();
                    if (idPlataf != null) {
                        $.ajax({
                            async: true,
                            type: 'POST',
                            url: "MigraEquipos.aspx/cargarUsuarios",
                            data: "{'IdPlataforma':'" + idPlataf + "', 'idCliente':'" + idCli + "'}",
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
                                    $('#idOwner').append($('<option>', {
                                        value: objeto[i].ID_User,
                                        text: objeto[i].Nombre_User
                                    }));
                                }
                                $('#idOwner').selectpicker('refresh');
                            }
                        });
                    }
                }

                function cargaEquipos(idPlat, idFlota) {
                    var idFl = idFlota;
                    var idPlataf = idPlat;
                    var indxD = [];
                    //var idUser = idUsu;
                    //var IdUsuario = $("#hdnCod_Usuario").val();

                    if (idPlataf != null) {
                        $.ajax({
                            async: true,
                            type: 'POST',
                            url: "MigraEquipos.aspx/generarInforme",
                            data: "{'idPlataforma':'" + idPlataf + "', 'idFlota':'" + idFl + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',

                            beforeSend: function () {
                                //startBlocking();
                                $("#spinLoad").show();
                            },

                            success: function (arg) {
                                var objeto = arg.d;
                                if (objeto.length > 0) {
                                    var tablaInf = $('#tablaEquipos').DataTable();
                                    tablaInf.column('0:visible').order('asc');
                                    tablaInf.clear().draw();
                                    tablaInf.columns.adjust().draw();
                                    tablaInf.rows.add(objeto).draw();

                                    buscaMigrados(idPlataf, $("#idCodRUT").text());

                                    buscaDuplicados(0);
                                    buscaDuplicados(3);
                                    buscaDuplicados(6);
                                    buscaDuplicados(9);
                                    buscaDuplicados(10);
                                    
                                }
                                else {
                                    var tablaInf = $('#tablaEquipos').DataTable();
                                    tablaInf.clear().draw();
                                    //stopBlocking();
                                    $("#spinLoad").hide();
                                }
                                //stopBlocking();
                                $("#spinLoad").hide();
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                //stopBlocking();
                                $("#spinLoad").hide();
								var error = eval("(" + XMLHttpRequest.responseText + ")");
								alert(error.Message);
                            }
                        });
                    }
                    
                    $("#idValidar").prop("disabled", false);
                }

                var buscaDuplicados = function (index) {
                    var tablaInf = $('#tablaEquipos').DataTable();
                    var arr = [];
                    var arrIndex = [];
                    var result = false;
                    arr = tablaInf.column(index).data().toArray();

                    for (let i = 0; i < arr.length; i++) {
                        for (let j = 0; j < arr.length; j++) {
                            if (i !== j) {
                                if (arr[i] === arr[j]) {
                                    arrIndex.push(i);
                                    arrIndex.push(j);
                                    result = true;
                                }
                            }
                        }
                    }

                    if (result) {
                        indxD = Array.from(new Set(arrIndex));
                        var dtTable = $('#tablaEquipos').DataTable();

                        for (let c = 0; c < indxD.length; c++) {
                            var tmp = dtTable.cell({ row: indxD[c], column: index }).data();
                            var msgTmp = dtTable.cell({ row: indxD[c], column: 15 }).data();

                            if (msgTmp == '-') { msgTmp = ''; }

                            dtTable.cell({ row: indxD[c], column: index }).data('<b style="color:red;">' + tmp + '</b>');
                            switch (index) {

                                case 0:
                                    dtTable.cell({ row: indxD[c], column: 15 }).data(msgTmp + '<tr><td>Problemas con datos de Vehículo &nbsp</td><td>Patente/VIN Repetida</td></tr>');
                                    dtTable.cell({ row: indxD[c], column: 13 }).data('<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>');
                                    break;

                                case 3:
                                    dtTable.cell({ row: indxD[c], column: 15 }).data(msgTmp + '<tr><td>Problemas con datos de Vehículo&nbsp</td><td>id AVL Repetido</td></tr>');
                                    dtTable.cell({ row: indxD[c], column: 13 }).data('<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>');
                                    break;

                                case 6:
                                    dtTable.cell({ row: indxD[c], column: 15 }).data(msgTmp + '<tr><td>Problemas con datos de GPS&nbsp</td><td>Nro de serie Repetido</td></tr>');
                                    dtTable.cell({ row: indxD[c], column: 13 }).data('<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>');
                                    break;

                                case 9:
                                    dtTable.cell({ row: indxD[c], column: 15 }).data(msgTmp + '<tr><td>Problemas con datos de GPS&nbsp</td><td>IMEI Repetido</td></tr>');
                                    dtTable.cell({ row: indxD[c], column: 13 }).data('<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>');
                                    break;

                                case 10:
                                    dtTable.cell({ row: indxD[c], column: 15 }).data(msgTmp + '<tr><td>Problemas con datos de SIM&nbsp</td><td>Nro SIM Repetido</td></tr>');
                                    dtTable.cell({ row: indxD[c], column: 13 }).data('<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>');
                                    break;

                                default:
                                    break;
                            }
                        }
                    }
                }

                var cargaMigrados = function (idPlat, idCliente) {
                    var idPlataf = idPlat;
                    var idCli = idCliente;
                    //var idUser = idUsu;
                    var ArrVh = [];
                    var ArrDat = [];
                    var Res = [];

                    //var IdUsuario = $("#hdnCod_Usuario").val();
                    if (idPlataf != null) {
                        $.ajax({
                            async: false,
                            type: 'POST',
                            url: "MigraEquipos.aspx/cargarMig",
                            data: "{'IdPlataforma':'" + idPlataf + "', 'idCliente':'" + idCli + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (arg) {
                                var objeto = arg.d;
                                for (var i = 0; i < objeto.length; i++) {
                                    ArrVh.push(objeto[i].migVehiculo);
                                    ArrDat.push(objeto[i].migDatos);
                                }
                            }
                        });
                        Res.push(ArrVh);
                        Res.push(ArrDat);
                        return Res;
                    }
                }

                var buscaMigrados = function (idPlat, idCliente) {
                    var tablaInf = $('#tablaEquipos').DataTable();
                    var arrTMP = [];
                    var result = false;
                    var ArrVhMig = [];
                    var ArrDatMig = [];
                    var c = 0;

                    arrIndex = cargaMigrados(idPlat, idCliente);
                    ArrVhMig = arrIndex[0]; // vehículos migradas
                    ArrDatMig = arrIndex[1]; // Usuario/fecha migración
                    var largo = ArrVhMig.length; // total de elementos migrados

                    for (c = 0; c < tablaInf.rows()[0].length; c++) { // de la columna patentes
                        arrTMP = Array.from(ArrVhMig);
                        arrTMP.push(tablaInf.cell({ row: c, column: 0 }).data());
                        const s = new Set(arrTMP);
                        if (s.size == largo) {
                            result = true;
                            var msg = tablaInf.cell({ row: c, column: 15 }).data();
                            var idx = $.inArray(tablaInf.cell({ row: c, column: 0 }).data(), ArrVhMig);
                            if (msg = '-') { msg = ''; }
                            tablaInf.cell({ row: c, column: 15 }).data(msg + '<tr><td>No es posible migrar el Vehículo&nbsp</td><td>Vehículo ya migrado por: ' + ArrDatMig[idx] + '</td></tr>');
                            tablaInf.cell({ row: c, column: 4 }).data('Migrado');
                            vTxt = '<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>';

                            tablaInf.cell({ row: c, column: 13 }).data(vTxt); //"Error";
                            tablaInf.cell({ row: c, column: 14 }).data('<input type=\"checkbox\"  disabled>');
                        }

                    }
                }

                $('#idValidar').on('click', function () {
                    var msgValida = "";
                    var datosSelectores = true;
                    var flag = false;
                    var dtTable = $('#tablaEquipos').DataTable();
                    var vehiculoSerie = false;
                    var ArrFila = []; var MyFila = 0;

                    $("#divResultados").prop("hidden", true);
                    $("#idMigrar").prop("disabled", true);
                    if ($('#idFlota').val() == "0" || $('#idFlota').val() == null) {
                        datosSelectores = false;
                        msgValida = msgValida + "Seleccione flota de origen.\n";
                        $('#idFlota').focus();
                    }
                    if ($('#idRUT').val() == "0" || $('#idRUT').val() == null) {
                        datosSelectores = false;
                        msgValida = msgValida + "Seleccione cliente de destino.";
                        $('#idRUT').focus();
                    }

                    $("#divResultados").prop("hidden", true);
                    $("#idMigrar").prop("disabled", true);
                    if ($('#idFlota').val() == "0" || $('#idFlota').val() == null) {
                        datosSelectores = false;
                        msgValida = msgValida + "Seleccione flota de origen.\n";
                        $('#idFlota').focus();
                    }
                    if ($('#idRUT').val() == "0" || $('#idRUT').val() == null) {
                        datosSelectores = false;
                        msgValida = msgValida + "Seleccione cliente de destino.";
                        $('#idRUT').focus();
                    }
                    if (datosSelectores) {//validación de selectores

                        //Recorrido de la tabla
                        $('#tablaEquipos').DataTable().rows({ search: 'applied', order: 'applied', page: 'current' }).eq(0).each(function (index) {
                            var node = $(this.row(index).node());
                            var ArgFila;

                            var NFlota = $('#idFlota option:selected').text().split("/");
                            var NCliente = $('#idRUT option:selected').text().split("/");

                            var dtTable = $('#tablaEquipos').DataTable();
                            var fila = dtTable.row(index).data();

                            if (fila['Error'] == "") { // Solo las filas sin errores
                                ArFlota = NFlota[0].trim();
                                ArVehiculo = fila['RefVehiculo'];
                                ArGPS = fila['NroSerieGPS'];
                                ArIMEI = fila['IMEIGPS'];
                                ArSIM = fila['NroSIM'];
                                ArRUT = NCliente[0].trim();
                                ArMarca = fila['MarcaGPS'];
                                ArModelo = fila['ModeloGPS'];

                                var msg = fila['Mensaje'];
                                var estado = fila['Estado'];

                                ArrFila[MyFila] = ArFlota + "|" + ArVehiculo + "|" + ArGPS + "|" + ArIMEI + "|" + ArSIM + "|" + ArRUT;
                                MyFila++;
                            }
                        })// Fin de recorrido de la tabla

                        validaArreglo(ArrFila);


                    }
                    else {
                        alert(msgValida);
                        datosSelectores = true;
                    }
                
                })

                function validaArreglo (strFila) {
                    var Mensaje = [];
                    var myVar;
                    $.ajax({
                        async: true,
                        type: 'POST',
                        url: "MigraEquipos.aspx/validarEquipos",
                        data: "{ fila:" + JSON.stringify(strFila) +" }",
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',

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

                        success: function (resultado) {
                            clearInterval(myVar);
                            var objeto = resultado.d;
                            if (objeto.length > 0) {
                                Mensaje = objeto;
                            } else {
                                Mensaje = "";
                            }
                            var msgValida = "";
                            var datosSelectores = true;
                            var flag = false;
                            var dtTable = $('#tablaEquipos').DataTable();
                            var vehiculoSerie = false;
                            var c = 0;

                            $('#tablaEquipos').DataTable().rows({ search: 'applied', order: 'applied', page: 'current' }).eq(0).each(function (index) {
                                var node = $(this.row(index).node());
                                var ArgFila;

                                var NFlota = $('#idFlota option:selected').text().split("/");
                                var NCliente = $('#idRUT option:selected').text().split("/");

                                var dtTable = $('#tablaEquipos').DataTable();
                                var fila = dtTable.row(index).data();

                                if (fila['Error'] == "") { // Solo las filas sin errores
                                    ArFlota = NFlota[0].trim();
                                    ArVehiculo = fila['RefVehiculo'];
                                    ArGPS = fila['NroSerieGPS'];
                                    ArIMEI = fila['IMEIGPS'];
                                    ArSIM = fila['NroSIM'];
                                    ArRUT = NCliente[0].trim();
                                    ArMarca = fila['MarcaGPS'];
                                    ArModelo = fila['ModeloGPS'];

                                    var msg = fila['Mensaje'];
                                    var estado = fila['Estado'];

                                    if (msg == '-' && estado != 'Migrado') {
                                        msg = '';

                                        if (ArMarca == '-' || ArModelo == '-') {
                                            msg = msg + '<tr><td>Problemas con datos de GPS&nbsp</td><td>' + ArMarca + '/' + ArModelo + ' no son datos de válidos</td></tr>';
                                            flag = true;
                                        };

                                        if (ArVehiculo == ArGPS) {
                                            vehiculoSerie = true;
                                        } else { vehiculoSerie= false}

                                        if (((ArVehiculo.length != 6 && ArVehiculo.length != 17) || $.isNumeric(ArVehiculo)) && vehiculoSerie == false) {
                                            msg = msg + '<tr><td>Problemas con datos de vehículo&nbsp</td><td>' + ArVehiculo + ' no es una patente o Nro Vin válido</td></tr>';
                                            flag = true;
                                        };

                                        if (Mensaje[c].FlotaPatente != "") {
                                            msg = msg + '<tr><td>Vehículo ya se encuentra creado&nbsp</td><td>Vehículo de destino ya existe Patente: ' + ArVehiculo + '.<br> Flota: ' + Mensaje[c].FlotaPatente + '<br>Cliente : ' + Mensaje[c].CliPatente + '.</td></tr>';
                                            //flag = true;
                                        };
                                        if (Mensaje[c].FlotaVIN != "") {
                                            msg = msg + '<tr><td>Vehículo ya se encuentra creado&nbsp</td><td>Vehículo de destino ya existe VIN: ' + ArVehiculo + '.<br> Flota: ' + Mensaje[c].FlotaVIN + '<br>Cliente : ' + Mensaje[c].CliVin + '.</td></tr>';
                                            //flag = true;
                                        };
                                        if (Mensaje[c].CliSerie != "") {
                                            msg = msg + '<tr><td>Nro de Serie GPS ya se encuentra creado&nbsp</td><td>El Nro de serie ' + ArGPS + ' ya se encuntra creado <br> Cliente: ' + Mensaje[c].NomCliSerie + ' (' + Mensaje[c].CliSerie + ')</td></tr>';
                                            //flag = true;
                                        };
                                        if (Mensaje[c].CliIMEI != "") {
                                            msg = msg + '<tr><td>IMEI ya se encuentra creado&nbsp</td><td>El Nro de IMEI ' + ArIMEI + ' ya se encuntra creado <br> Cliente: ' + Mensaje[c].NomCliIMEI + ' (' + Mensaje[c].CliIMEI + ')</td></tr>';
                                            //flag = true;
                                        };

                                        if (Mensaje[c].CliSIM != "") { // Sim Creado

                                            if (Mensaje[c].CliSIM == '16707636-K') { // Sim Creado en GPS Asociado 
                                                if (Mensaje[c].SimAsociado != '') {
                                                    vSIM = "";
                                                    if (Mensaje[c].PatenteSIM != "") {
                                                        vSIM = '<br> Vehículo asociado: ' + Mensaje[c].PatenteSIM;
                                                    }
                                                    if (Mensaje[c].VinSIM != "") {
                                                        vSIM = '<br> Vehículo asociado: ' + Mensaje[c].VinSIM;
                                                    }
                                                    msg = msg + '<tr><td>Nro SIM ya se encuentra creado&nbsp</td><td>El Nro de SIM ' + ArSIM + ' ya se encuntra creado <br> Cliente: ' + Mensaje[c].NomCliSIM + ' (' + Mensaje[c].CliSIM + ')' + vSIM + '</td></tr>';
                                                    //flag = true;
                                                }

                                            } else { // Sim creado no GPS

                                                vSIM = "";
                                                if (Mensaje[c].PatenteSIM != "") {
                                                    vSIM = '<br> Vehículo asociado: ' + Mensaje[c].PatenteSIM;
                                                }
                                                if (Mensaje[c].VinSIM != "") {
                                                    vSIM = '<br> Vehículo asociado: ' + Mensaje[c].VinSIM;
                                                }

                                                msg = msg + '<tr><td>Nro SIM ya se encuentra creado&nbsp</td><td>El Nro de SIM ' + ArSIM + ' ya se encuntra creado <br> Cliente: ' + Mensaje[c].NomCliSIM + ' (' + Mensaje[c].CliSIM + ')' + vSIM + '</td></tr>';
                                                //flag = true;
                                            }

                                        };

                                        if (flag) {
                                            //Código para Popover o modal
                                            vTxt = '<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>';

                                            fila['Error'] = vTxt //"Error";
                                            fila['Migrar'] = '<input type=\"checkbox\"  disabled>';
                                            fila['Mensaje'] = msg;

                                            msg = "";
                                            flag = false;
                                        }
                                        else {
                                            if (fila['Mensaje'] == '-') {
                                                if (msg != '') {
                                                    vTxt = '<a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-bell" aria-hidden="true"></i></a>';
                                                    fila['Error'] = vTxt;
                                                    fila['Mensaje'] = msg
                                                }

                                                fila['Migrar'] = '<input type=\"checkbox\" name=\"idMig\" class=\"chkMigra\" checked=\"true\">';
                                                $("#idMigrar").prop("disabled", false);
                                            }
                                            else {
                                                fila['Migrar'] = '<input type=\"checkbox\"  disabled>';
                                            }
                                        }
                                    }

                                c++;
                                }
                                dtTable.row(index).data(fila).draw(false);
                            })// Fin de recorrido de la tabla
                            
                            stopBlocking();
                        },

                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            clearInterval(myVar);
                            stopBlocking();
                            var error = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(error.Message);
                        }

                    })
                }

                $('#idLimpiar').on('click', function () {
                    $('#formMigraEquipos')[0].reset();

                    $('#tablaEquipos tbody').empty();
                    var tablaInf = $('#tablaEquipos').DataTable();
                    tablaInf.clear().draw();
                    $('#tablaResultado tbody').empty();
                    var tablaRes = $('#tablaResultado').DataTable();
                    tablaRes.clear().draw();

                    $("#idFlota").empty().val('default').selectpicker("refresh");
                    $("#idRUT").empty().val('default').selectpicker("refresh");
                    $("#idOwner").empty().val('default').selectpicker("refresh");

                    $("#idCodUsuario").text("");
                    $("#idCodRUT").text("");
                    $("#idCodFlota").text("");
                    $("#idCodUsuario").text("");
                    $("#idCodPlat").text("");

                    $("#idMigrar").prop("disabled", true);
                    $("#idValidar").prop("disabled", false);
                    $("#divResultados").prop("hidden", true);
                });

                $('#tablaEquipos tbody').on('change', 'input[class="chkMigra"]', function (e) {
                    var RowSelected = $(this).parent().parent()[0].firstElementChild.firstChild.parentElement._DT_CellIndex.row
;
                    var dtTable = $('#tablaEquipos').DataTable();
                    var fila = dtTable.row(RowSelected).data();

                    if (this.attributes[3].ownerElement.checked == true) {
                        
                        fila['Migrar'] = '<input type=\"checkbox\" name=\"idMig\" class=\"chkMigra\" checked=\"true\">';
                    }
                    else {
                        fila['Migrar'] = '<input type=\"checkbox\" name=\"idMig\" class=\"chkMigra\" checked=\"false\">';
                    }
                });

                $('#idMigrar').on('click', function () {
                    var flag = true;
                    var mensaje = "";
                    var NFlota = $('#idFlota option:selected').text().split("/");
                    var NCliente = $('#idRUT option:selected').text().split("/");
                    var OK = false;
                    var vacio = true;
                    var ArrFila = []; var MyFila = 0;

                    $('#tablaResultado tbody').empty();
                    var tablaRes = $('#tablaResultado').DataTable();
                    tablaRes.clear().draw();

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
                    if ($('#idOwner').val() == "" || $('#idOwner').val() == null) {
                        mensaje = mensaje + "\nSeleccione usuario dueño de destino.";
                        flag = false;
                    }

                    if (flag) { // Si están todos los datos en los selectores

                        $('#tablaEquipos').DataTable().rows({ search: 'applied', order: 'applied', page: 'current' }).eq(0).each(function (index) {
                            var node = $(this.row(index).node());
                            var dtTable = $('#tablaEquipos').DataTable();
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

                                ArFlota = NFlota[0].trim(); 
                                ArVehiculo = node[0].childNodes[0].childNodes[0].data;
                                ArGPS = node[0].childNodes[6].childNodes[0].data;
                                ArIMEI = node[0].childNodes[9].childNodes[0].data;
                                ArSIM = node[0].childNodes[10].childNodes[0].data;
                                ArRUT = NCliente[0].trim();
                                ArCli = $('#idRUT').val();
                                ArUsu = $("#idCodUsuario").text();
                                ArMod = node[0].childNodes[8].childNodes[0].data;
                                ArCia = node[0].childNodes[12].childNodes[0].data;
                                ArTipoSim = node[0].childNodes[11].childNodes[0].data;
                                ArAVL = node[0].childNodes[3].childNodes[0].data;
                                ArRef = fila['Referencia'];
                                ArCodVehiculo = fila['cod_vehiculo'];
                                ArCodConductor = fila['cod_conductor'];
                                ArNomConductor = fila['conductor'];
                                ArEmailConductor = fila['email_conductor'];
                                ArIdAsignadoConductor = fila['id_asignado_conductor'];
                                ArCodRefAsignadoConductor = fila['cod_ref_asignado_conductor'];
                                ArPinConductor = fila['pin_conductor'];

                                ArgFila = ArFlota + "|" + ArVehiculo + "|" + ArGPS + "|" + ArIMEI + "|" + ArSIM + "|" + ArRUT + "|" + ArCli + "|" + ArUsu + "|" + ArMod + "|" + ArCia + "|"
                                    + ArTipoSim + "|" + ArAVL + "|" + ArRef + "|" + ArCodVehiculo + "|" + ArCodConductor + "|" + ArNomConductor
                                    + "|" + ArEmailConductor + "|" + ArIdAsignadoConductor + "|" + ArCodRefAsignadoConductor + "|" + ArPinConductor;

                                ArrFila[MyFila] = ArFlota + "|" + ArVehiculo + "|" + ArGPS + "|" + ArIMEI + "|" + ArSIM + "|" + ArRUT + "|" + ArCli + "|" + ArUsu + "|" + ArMod + "|" + ArCia + "|"
                                    + ArTipoSim + "|" + ArAVL + "|" + ArRef + "|" + ArCodVehiculo + "|" + ArCodConductor + "|" + ArNomConductor
                                    + "|" + ArEmailConductor + "|" + ArIdAsignadoConductor + "|" + ArCodRefAsignadoConductor + "|" + ArPinConductor;

                                OK = false;
                                MyFila++;
                            }
                        });// Fin de recorrido de la tabla
                        //prompt("",ArrFila);
                        // Llamado a fn migracion ajax con arreglo
                        MigEquipo(ArrFila);

                        if (vacio) {
                            alert('Debe tener por lo menos un registro validado para migrar.');
                        }
                    }
                    else {
                        alert(mensaje); // Errores de datos en selectores
                    }
                });

                
                function MigEquipo(strFila) {
                    //var idUser = idUsu;
                    //var IdUsuario = $("#hdnCod_Usuario").val();
                    var myVar;
                    var Resultado = [];

                    $.ajax({
                        async: true,
                        type: 'POST',
                        url: "MigraEquipos.aspx/migraEquipo",
                        data: "{fila: " + JSON.stringify(strFila) + " ,  idPlataforma : " + $('#idPlataforma').val() + " }",
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
                                Resultado = objeto;
                            }
                            else {
                                Resultado = "";
                            }

                            var mensaje = "";
                            var NFlota = $('#idFlota option:selected').text().split("/");
                            var NCliente = $('#idRUT option:selected').text().split("/");
                            var OK = false;
                            var cont = 0;

                            $('#tablaResultado tbody').empty();
                            var tablaRes = $('#tablaResultado').DataTable();
                            tablaRes.clear().draw();

                            $('#tablaEquipos').DataTable().rows({ search: 'applied', order: 'applied', page: 'current' }).eq(0).each(function (index) {
                                var node = $(this.row(index).node());
                                var dtTable = $('#tablaEquipos').DataTable();
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

                                    ArFlota = NFlota[0].trim();
                                    ArVehiculo = node[0].childNodes[0].childNodes[0].data;
                                    ArGPS = node[0].childNodes[6].childNodes[0].data;
                                    ArIMEI = node[0].childNodes[9].childNodes[0].data;
                                    ArSIM = node[0].childNodes[10].childNodes[0].data;
                                    ArRUT = NCliente[0].trim();
                                    ArCli = $('#idRUT').val();
                                    ArUsu = $("#idCodUsuario").text();
                                    ArMod = node[0].childNodes[8].childNodes[0].data;
                                    ArCia = node[0].childNodes[12].childNodes[0].data;
                                    ArTipoSim = node[0].childNodes[11].childNodes[0].data;
                                    ArAVL = node[0].childNodes[3].childNodes[0].data;
                                    ArRef = fila['Referencia'];
                                    ArCodVehiculo = fila['cod_vehiculo'];
                                    ArCodConductor = fila['cod_conductor'];
                                    ArNomConductor = fila['conductor'];
                                    ArEmailConductor = fila['email_conductor'];
                                    ArIdAsignadoConductor = fila['id_asignado_conductor'];
                                    ArCodRefAsignadoConductor = fila['cod_ref_asignado_conductor'];
                                    ArPinConductor = fila['pin_conductor'];


                                    ArgFila = ArFlota + "|" + ArVehiculo + "|" + ArGPS + "|" + ArIMEI + "|" + ArSIM + "|" + ArRUT + "|" + ArCli + "|" + ArUsu + "|" + ArMod + "|" + ArCia + "|"
                                        + ArTipoSim + "|" + ArAVL + "|" + ArRef + "|" + ArCodVehiculo + "|" + ArCodConductor + "|" + ArNomConductor
                                        + "|" + ArEmailConductor + "|" + ArIdAsignadoConductor + "|" + ArCodRefAsignadoConductor + "|" + ArPinConductor;;

                                    $("#idMigrar").prop("disabled", true);
                                    $("#divResultados").prop("hidden", false);

                                    ErrorFilas = Resultado[cont].Err.split('|')

                                    if (Resultado[cont].Err == 'OK') {
                                        EstadoMig = 'Migrado';
                                        FechaMig = moment().format("DD/MM/YYYY"); //(new Date()).toISOString().split('T')[0];
                                    }
                                    else {
                                        if (Resultado[cont].Err.search('OK') == 0) {
                                            EstadoMig = 'Migración parcial';
                                            FechaMig = moment().format("DD/MM/YYYY"); //(new Date()).toISOString().split('T')[0];
                                            ErrorMig = '<a href="#" data-toggle="modal" data-target="#MigModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>';
                                            for (var c = 0; c < ErrorFilas.length; c++) {
                                                if (ErrorFilas[c] != '')
                                                    ErrorMsg = ErrorMsg + '<tr><td>' + ErrorFilas[c] + '</td></tr>';
                                            }
                                        }
                                        else {
                                            EstadoMig = 'No Migrado';
                                            ErrorMig = '<a href="#" data-toggle="modal" data-target="#MigModal"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></a>';
                                            for (var c = 0; c < ErrorFilas.length; c++) {
                                                if (ErrorFilas[c] != '')
                                                    ErrorMsg = ErrorMsg + '<tr><td>' + ErrorFilas[c] + '</td></tr>';
                                            }
                                        }
                                    }

                                    tablaRes.columns.adjust().draw();
                                    tablaRes.row.add({
                                        "RefVehiculo": ArVehiculo,
                                        "Estado": EstadoMig,
                                        "FechaMig": FechaMig,
                                        "NroSerieGPS": ArGPS,
                                        "MarcaGPS": node[0].childNodes[7].childNodes[0].data,
                                        "ModeloGPS": node[0].childNodes[8].childNodes[0].data,
                                        "IMEIGPS": ArIMEI,
                                        "NroSIM": ArSIM,
                                        "TipoSIM": node[0].childNodes[11].childNodes[0].data,
                                        "CiaSIM": node[0].childNodes[12].childNodes[0].data,
                                        "Error": ErrorMig,
                                        "Mensaje": ErrorMsg
                                    }).draw();

                                    OK = false; cont++;
                                }
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

                $('#myModal').on('show.bs.modal', function (e) {
                    Idx = e.relatedTarget.parentNode._DT_CellIndex.row;
                    myTable = $('#tablaEquipos').DataTable();

                    varHTML_1 = '<table id="modalEquipos" class="table table-bordered table-hover"><thead><tr><th>Tipo de Mensaje</th><th>Detalle Mensaje</th></tr></thead><tbody>';
                    varHTML_2 = '</tbody></table>';

                    varMSG = myTable.cells({ row: Idx, column: 15 }).data()[0];
                    $('#myModal .modal-title').html("Mensajes de validación : " + myTable.cells({ row: Idx, column: 0 }).data()[0]);
                    $('#myModal .modal-body').html(varHTML_1 + varMSG + varHTML_2);
                });


                $('#MigModal').on('show.bs.modal', function (e) {
                    Idx = e.relatedTarget.parentNode._DT_CellIndex.row;
                    myTable = $('#tablaResultado').DataTable();

                    varHTML_1 = '<table id="modalResultado" class="table table-bordered table-hover"><thead><tr><th>Detalle Mensaje</th></tr></thead><tbody>';
                    varHTML_2 = '</tbody></table>';

                    varMSG = myTable.cells({ row: Idx, column: 11 }).data()[0];
                    $('#MigModal .modal-title').html("Mensajes de Migración : " + myTable.cells({ row: Idx, column: 0 }).data()[0]);
                    $('#MigModal .modal-body').html(varHTML_1 + varMSG + varHTML_2);
                });

            }); //$(Document).ready

        </script>
    </body>
</html>


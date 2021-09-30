<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MigraConductores.aspx.cs" Inherits="MigraConductores" %>
<%@ Register Src="controles/frmModuloUsuario.ascx" TagName="moduloUsuario" TagPrefix="userMod" %>

<!DOCTYPE html>

<html>
    <head runat="server">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>GPS Chile | Migración</title>
         
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
                    <li >
                        <a href="MigraZona.aspx" > <i class="fa fa-map-o"></i> Zona</a>
                    </li>
                    <li class="active">
                        <a href="#"><i class="fa fa-id-card-o"></i> Conductores</a>
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
                        Migración de Conductores
                    </h1>
                </section>

                <!-- Main content -->
		<section class="content">

			<!-- Default box -->
			<div class="box box-solid">
				<div class="box-header with-border">
					<h3 class="box-title">Seleccione los datos</h3>
				</div>

                    

				<div class="box-body">
					<div class="row">
                        
                        <div class="col-md-12">
                        	<form role="form" method="post"  id="formInformePeajes">
                        		<div class="col-md-12">
                                    <div class="col-md-12">
                                            <div class="col-md-2">
	                        				    <div class="form-group">
												    <label for="idPlataforma">Plataforma Origen</label>
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
                                    </div>

                                    <div class="col-md-12">
                        				    <div class="col-md-2">
	                        				    <div class="form-group">
												    <label for="idFlota">Flota</label>
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
												    <label for="idFlota" id="idCodFlota"></label>
											    </div>
	                        			    </div>
                        	        </div>
                        		</div>
                        	</form>
                        </div>
                        
                        <div class="col-md-12 text-right" id="botones-exp" style="margin-top:10px;"></div>
                        
                        <div class="col-md-12" style="padding-top:20px !important;">
                            <table id="tablaConductor" class="table table-bordered table-hover" >
                                <thead>
                                    <tr>
                                        <th>RUT*</th>
                                        <th>Nombre*</th>
                                        <th>ApellidoPaterno*</th>
                                        <th>ApellidoMaterno*</th>
                                        <th>Referencia</th>
                                        <th>CorreoElectrónico*</th>
                                        <th>TelefonoCelular*</th>
                                        <th>CodigoAutorizacion</th>
                                        <th>FechaNacimiento*</th>
                                        <th>VencimientoCedula</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->

            <div id="spinLoad">
                <span id="mensajeLoading"><i class="fa fa-spin fa-fw fa-refresh "></i> Buscando su información...</span>
                <span id="mensajeLoading_2" style="display:none"><i class="fa fa-spin fa-fw fa-refresh "></i> Información obtenida, escribiendo registros en la tabla..</span>
            </div>

		</section>
		<!-- /.content -->

            </div>
            <!-- /.content-wrapper -->
        </div>
        </div>
        <!-- ./wrapper -->
        
        <%--<asp:HiddenField ID="hdnCod_Usuario" runat="server" />--%>

        <%--<div id='ajax_loader' class="blockUI blockMsg blockPage">
            <div id="loader-wrapper">
                <div id="loader"></div>
            </div>
        </div>--%>
        

        <!-- jQuery 3 -->
        <script src="./layout/bower_components/jquery/dist/jquery.min.js"></script>
        <!-- Popper.JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
    
        <!-- Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

        <!-- SlimScroll -->
        <script src="./layout/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
        <!-- FastClick -->
        <script src="./layout/bower_components/fastclick/lib/fastclick.js"></script>
        <!-- DataTables -->
        <script type="text/javascript" src="./layout/bower_components/datatables/datatables.min.js"></script>

         <!-- RUT MASK -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.4/inputmask/inputmask.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.4/jquery.inputmask.bundle.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.4/css/inputmask.min.css" rel="stylesheet"/>



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
        <script src=".//js/blockui.js"></script>
      <%--   <script id="jsbin-javascript">
             $.fn.select2.amd.require([
                 'select2/utils',
                 'select2/dropdown',
                 'select2/dropdown/attachBody'
             ], function (Utils, Dropdown, AttachBody) {
                 function SelectAll() { }

                 SelectAll.prototype.render = function (decorated) {
                     var self = this,
                         $rendered = decorated.call(this),
                         $selectAll = $(
                             '<button class="btn btn-xs btn-default" type="button" style="margin-left:6px;"><i class="fa fa-check-square-o"></i> Seleccionar Todos</button>'
                         ),
                         $unselectAll = $(
                             '<button class="btn btn-xs btn-default" type="button" style="margin-left:6px;"><i class="fa fa-square-o"></i> Deseleccionar Todos</button>'
                         ),
                         $btnContainer = $('<div style="margin-top:3px;">').append($selectAll).append($unselectAll);
                     if (!this.$element.prop("multiple")) {
                         // this isn't a multi-select -> don't add the buttons!
                         return $rendered;
                     }
                     $rendered.find('.select2-dropdown').prepend($btnContainer);
                     $selectAll.on('click', function (e) {
                         var $results = $rendered.find('.select2-results__option[aria-selected=false]');
                         $results.each(function () {
                             self.trigger('select', {
                                 data: $(this).data('data')
                             });
                         });
                         self.trigger('close');
                     });
                     $unselectAll.on('click', function (e) {
                         var $results = $rendered.find('.select2-results__option[aria-selected=true]');
                         $results.each(function () {
                             self.trigger('unselect', {
                                 data: $(this).data('data')
                             });
                         });
                         self.trigger('close');
                     });
                     return $rendered;
                 };

                 $("#idPeaje").select2({
                     placeholder: "Select Option(s)...",
                     dropdownAdapter: Utils.Decorate(
                         Utils.Decorate(
                             Dropdown,
                             AttachBody
                         ),
                         SelectAll
                     ),
                 });
             });
</script>--%>
        <script>
            $(document).ajaxStop($.unblockUI);

            var expTitle = "";  
            $(document).ready(function () {

                var timeoutID;

                function startBlocking() {
                    $.blockUI({ message: '<p><IMG height="10%" width="20%"  SRC="./img/pin.gif"></p><p><h4 id="myMessage">Procesando...</h4></p>' });
                }

                function stopBlocking() {
                    clearTimeout(timeoutID);
                }

                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });

                var endDate = moment();

                $('#tablaConductor').DataTable({
                    columns: [
                        { "data": "RUT_Cond" },
                        { "data": "Nombre_Cond" },
                        { "data": "Paterno_Cond" },
                        { "data": "Materno_Cond" },
                        { "data": "Referncia_Cond" },
                        { "data": "Correo_Cond" },
                        { "data": "Celular_Cond" },
                        { "data": "Autoriza_Cond" },
                        { "data": "Nacimiento_Cond" },
                        { "data": "Vencimiento_Cond" },
                    ],

                    bProcessing: true,
                    deferRender: true,

                    columnDefs: [
                        { "width": "10%", targets: 0 },
                        { "width": "10%", targets: 1 },
                        { "width": "10%", targets: 2 },
                        { "width": "10%", targets: 3 },
                        { "width": "10%", targets: 4 },
                        { "width": "10%", targets: 5 },
                        { "width": "10%", targets: 6 },
                        { "width": "10%", targets: 7 },
                        { "width": "10%", targets: 8 },
                        { "width": "10%", targets: 9 }
                    ],

                    dom: '<"html5buttons"B>lTfgitp',
                    buttons: [
                        {
                            text: 'Copiar',
                            extend: 'copy',
                            className: 'btn-sm',
                            exportOptions: {
                                columns: ':visible'
                            }
                        },
                        {
                            text: 'CSV',
                            extend: 'csv',
                            title: 'Migración_Conductores_' + endDate.format('YYYY-MM-DD'),
                            className: 'btn-sm',
                            fieldSeparator: ';',
                            fieldBoundary: '',
                            exportOptions: {
                                columns: ':visible'
                            }
                        },
                        //{
                        //    //text: '<i class="fa fa-file-excel-o"></i>',
                        //    text: 'Excel',
                        //    extend: 'excel',
                        //    title: 'Informe_Conductores_' + endDate.format('YYYY-MM-DD'),
                        //    className: 'btn-sm',
                        //    exportOptions: {
                        //        columns: ':visible'
                        //    }
                        //},
                        {
                            text: 'PDF',
                            extend: 'pdf',
                            //orientation: 'landscape',
                            filename: 'Migración_Conductores_' + endDate.format('YYYY-MM-DD'),
                            className: 'btn-sm',
                            exportOptions: {
                                columns: ':visible'
                            },
                            customize: function (doc) {
                                doc.defaultStyle.fontSize = 6;
                                doc.styles.tableHeader.fontSize = 6;
                                doc.pageMargins = [10, 30, 10, 30]; //[left,top,right,bottom]
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

                    searching: false,
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
                        $(this).DataTable().buttons().container().appendTo($('#botones-exp'));
                    },
                });

                $('#idFlota').change(function () {
                    var selectedItem = $('.selectpicker').val();
                    var expTitle = $('#idFlota option:selected').text();
                    var plataf = $("#idPlataforma").val();
                    $("#idCodFlota").text(selectedItem);
                    cargaConductores(plataf,selectedItem);
                });

                $("#idPlataforma").change(function () {
                    var plat = $(this).val();
                    //var user = $("#idUsuario").val();
                    //cargaFlotas(plat, user);
                    var tablaInf = $('#tablaConductor').DataTable();
                    tablaInf.clear().draw();
                    cargaFlotas(plat);
                    $("#idCodFlota").text("");
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
                    var myVar;
                    //console.log('entrando en cargaGrupos')
                    var idPlataf = idPlat;
                    //var idUser = idUsu;

                    //var IdUsuario = $("#hdnCod_Usuario").val();
                    if (idPlataf != null) {
                        $.ajax({
                            async: true,
                            type: 'POST',
                            url: "MigraConductores.aspx/cargarFlotas",
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

                                var objeto = arg.d;
                                for (var i = 0; i < objeto.length; i++) {
                                    $('#idFlota').append($('<option>', {
                                        value: objeto[i].Cod_Flota,
                                        text: objeto[i].NomFlota
                                    }));
                                }
                                $('#idFlota').selectpicker('refresh');
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
                }

                function cargaConductores(idPlat, idFlota) {
                    var idFl = idFlota;
                    var idPlataf = idPlat;
                    //var idUser = idUsu;

                    //var IdUsuario = $("#hdnCod_Usuario").val();
                    if (idPlataf != null) {
                        $.ajax({
                            async: false,
                            type: 'POST',
                            url: "MigraConductores.aspx/generarInforme",
                            data: "{'idPlataforma':'" + idPlataf + "', 'idFlota':'" + idFl + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (arg) {
                                var objeto = arg.d;
                                //alert("Filas: "+objeto.length);
                                if (objeto.length > 0) {
                                    var tablaInf = $('#tablaConductor').DataTable();
                                    tablaInf.clear().draw();
                                    tablaInf.rows.add(objeto).draw();
                                }
                                else {
                                    //alert("borra!!!");
                                    var tablaInf = $('#tablaConductor').DataTable();
                                    tablaInf.clear().draw();
                                }
                            }
                        });
                    }
                }





            });





        </script>
        
    </body>

</html>


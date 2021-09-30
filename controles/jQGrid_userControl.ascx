<%@ Control Language="C#" AutoEventWireup="true" CodeFile="jQGrid_userControl.ascx.cs" Inherits="jQGrid_userControl" %>
<table id="jQGrid_<%=this.ID%>" style="width:<%=this.Ancho%>;height:<%=this.Alto%>%>"></table>
<div id="Pager_<%=this.ID%>"></div>
<div id="Search_<%=this.ID%>"></div>



<script language="javascript" type="text/javascript">
    var idCliente;
    
jQuery(document).ready(iniciarComponentes);
    
    var activa_<%=this.ID%> = false;
    
    function iniciarComponentes(idCliente)
	{
	    if("<%=ColumnasCampo%>"=="")
	    {alert('No se puede iniciar Grid <%=this.ID%>, falta Propiedad: ColumnasCampo');
	    return;}
	    
	    if("<%=MetodoCargaDatos%>"=="")
	    {alert('No se puede iniciar Grid <%=this.ID%>, falta Propiedad: MetodoCargaDatos');
	    return;
	    }
		
		//iniciarGridClientes('');
		//<%=MetodoInicio%>
	}
	
	function iniciarGrid<%=this.ID%>(filtro, flota)
      {
        $('#jQGrid_<%=this.ID%>').jqGrid({
            //
            jsonReader : //Set the jsonReader to the JQGridJSonResponse squema to bind the data.
            {
                
                root: "Items",//array containing actual data  
                page: "CurrentPage",//current page  
                total: "PageCount", //total pages for the query  
                records: "RecordCount",//total number of records  
                repeatitems: false,
                cell: "",
                //id: "0" //index of the column with the PK in it       
                id: '<%=ColumnaID%>' //Indice o Nombre de la columna que es PK
            },
            colModel: <%=mapeoColumnas%>,
            pager: '#Pager_<%=this.ID%>', //Pager.
            loadtext: 'Cargando datos...', //Texto de Carga
            loadui: 'block',
            recordtext: "{0} - {1} de {2} elementos",
            emptyrecords: '<%=TextoSinRegistros%>', //Texto cuando no hay registros para mostrar
            pgtext : 'P&aacute;g: {0} de {1}', //Paging input control text format.
            rowNum: <%=TamanoPagina%>, // Tamaño de Página.
            rowList: <%=FilasPorPagina%>, //Variable PageSize DropDownList.
            viewrecords: true, //Show the RecordCount in the pager.
            multiselect: false,
            sortname: "<%=ColumnaOrden%>", //Columna de Orden, default: La primera
            sortorder: "<%=DireccionOrden%>", //Dirección del orden, default: asc
            width: "<%=Ancho%>", //Ancho
            height: "<%=Alto%>", //Alto
            editurl: 'WS_JQGRID.aspx?gridId=<%=this.ID%>', //Url de edición indicando el ID del componente para poder ser identificado por querystring
            cellEdit:false,
            caption: <%=Titulo%>, //Define el título de la Grid
            datatype: function() {
                    //Parámetros de espera mientras carga
                    var x = $("#jQGrid_<%=this.ID%>").getGridParam("loadui");
                    var loadUi = $("#lui_jQGrid_<%=this.ID%>");
                    loadUi.show();
                    var load = $("#load_jQGrid_<%=this.ID%>");
                    load.css({'position':'absolute','left':'94%','top':'-1%','backgroundImage': 'url(img/load.gif)','backgroundRepeat': 'no-repeat','backgroundPosition': 'center','backgroundColor': '#72a9d3','width':'8px','height':'8px','border':'none'});
		            load.text("");
                    load.show();
                    
                    //Parámetros de búsqueda
                    var _search = $("#jQGrid_<%=this.ID%>").getGridParam("search");
                    var searchOptions;
                    var searchField;
                    var searchOper;
                    var searchString;
                    
                    if(_search==true)
                    { //Obtiene los parámetros de busqueda en caso de que la variable _search sea true
                    searchOptions = $("#jQGrid_<%=this.ID%>").getPostData();
                    searchField = searchOptions.searchField;
                    searchOper = searchOptions.searchOper;
                    searchString = searchOptions.searchString;
                    var limpia = "{\"PageCount\": 0, \"CurrentPage\": 1, \"RecordCount\": 0}";
                    var json = eval("(" + limpia + ")");
                    var thegrid = $("#jQGrid_<%=this.ID%>")[0];
                    thegrid.addJSONData(limpia);
                    }
                    //Carga de datos
                    $.ajax(
                    {                    
                    async: true,
                    type: 'POST',
                    url: 'WS_JQGRID.aspx/'+'<%=MetodoCargaDatos%>', //Envia el post al WS indicando el WebMethod que trae los datos
                    data: "{'ColumnasCampos': '"+<%=ColumnasCampos%>+  //Indica todas las variables requeridas para poder traer datos
                    "','Page':'" + $("#jQGrid_<%=this.ID%>").getGridParam("page") +
                    "','numRow':'" + $("#jQGrid_<%=this.ID%>").getGridParam("rowNum") +
                    "','sortname':'" + $("#jQGrid_<%=this.ID%>").getGridParam("sortname") +
                    "','sortorder':'" + $("#jQGrid_<%=this.ID%>").getGridParam("sortorder") +
                    "','_search':'" + _search +
                    "','searchField':'" + searchField +
                    "','searchString':'" + searchString +
                    "','codUsuario':'" + filtro +
                    "','codFlota':'" + flota +
                    "','searchOper':'" + searchOper + "'}",
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function(jsondata) {
                    jsondata = jsondata.d ? jsondata.d : jsondata;
                    var json1 = eval("(" + jsondata + ")");  //Convierte el String JSON en objeto
                    var thegrid = $("#jQGrid_<%=this.ID%>")[0];
                        //Agrega el objeto JSON con los datos al objeto JQGrid
                        thegrid.addJSONData(json1);
                        //Desaparece los Divs de carga
                        loadUi.hide();
                        load.hide();
                 }
                 
               });},    
           // OnCellSelect:
            //function(rowid,iCol,cellcontent,e)
            //{
            //   alert(e);
           // },
            onSelectRow:
            function(rowid)
           {     
               // alert('asdasdas');
                //$('#jQGrid_Sitios').GridUnload('jQGrid_Sitios');
                //iniciarGridSitios(rowid);
                
                
              //  jQuery('#jQGrid_Clientes').getCellValue(rowid, 'NomTipoMantencion');
                   // var val = getCellValue(cont);
                    
                //    alert(getCellValue);
                
               // jQuery('#jQGrid_Clientes').jqGrid(rowid, cellcontent);//,NomTipoMantencion, 'getRowData');
                //alert(rowid)

                
                
                //jQuery('#jQGrid_Clientes').jqGrid('getCell', rowid, NomTipoMantencion);
                //alert(nomTipoMantencion);
                //  jQuery('#jQGrid_Clientes').jqGrid('getRowData', rowid);
                //  alert(getRowData);
                
                
                jQuery('#jQGrid_Clientes').jqGrid('getCell', rowid);
                $('[id$=hdnCodUnidadMantencion]').val(rowid);
                //alert($('[id$=hdnCodUnidadMantencion]').val());
                
                //alert(rowid);
            },
            ondblClickRow:
            function(rowid)
            {
                
               // jQuery('#jQGrid_Clientes').jqGrid('editGridRow', rowid);
                  //   $('#jQGrid_Clientes').jqGrid.editGridRow(rowid);
             //   if (rowid != null) {
              //     jQuery('#jQGrid_Clientes').jqGrid('editGridRow', rowid);
              // }
                //   $('#editmodjQGrid_<%=this.ID%>').show();
                 //  $('#edithdjQGrid_Clientes<%=this.ID%>').show();
                  // $('#editcntjQGrid_Clientes<%=this.ID%>').show();
                 //  $(this).jQGrid_Clientes('editGridRow',rowid);
                 
                 /* var sr = $t.p.selrow;
                                               if (sr) {
                                                       if(typeof o.editfunc == 'function') {
                                                               o.editfunc(sr);
                                                       } else {
                                                               $($t).jqGrid_Clientes("editGridRow",sr,pEdit);
                                                       }
                                               } else {
                                                       viewModal("#"+alertIDs.themodal,{gbox:"#gbox_"+$t.p.id,jqm:true});
                                                       $("#jqg_alrt").focus();
                                               }
                                               return false;*/
                // alert(rowid);
               // updateNav(0, 0, rowid);
             // $.fn.fmatter.rowactions(rowid,'editcntjQGrid_Clientes'),'edit','asdasd');
            
                //$('#jQGrid_Sitios').GridUnload('jQGrid_Sitios');
                //iniciarGridSitios(rowid);
            }
             //Evento de celda Seleccionada
            }).navGrid('#Pager_<%=this.ID%>',
            {edit:<%=Edicion%>, //Indica si las filas de la grilla son editables
            add:<%=Insercion%>, //Indica si las filas de la grilla son insertables
            search:<%=Busqueda%>, //Indica si las filas de la grilla son buscables
            del:<%=Eliminacion%>} //Indica si las filas de la grilla son eliminables
            );}  
            
            function highlight (cellvalue, options, rowObject)
            {
                
                var url;
                var string;
                if(cellvalue == 'Normal')
                    //color = "green";
               //    backgroundImage =  "/img/load.gif)"
                 //background = "green";
                 url = "http://online.gpschile.com/img/pVerde.png";
                    
                else if (cellvalue == 'Alerta')
                //background = "orange";
                url = "http://online.gpschile.com/img/pAmarillo.png";
                else if(cellvalue == 'Mantencion')
               // background = "red";
               url = "http://online.gpschile.com/img/pRojo.png";
               else if(cellvalue == 'Realizar Mantencion')
               // background = "red";
               url = "http://online.gpschile.com/img/iconMaintenance.png";
                else
                    return "";//cellvalue;
               // var cellHtml = "<span style='color:" + color + "' originalValue='" + cellvalue + "'>" + cellvalue + "</span>";
               var cellHtml = "<span style='background-image:url("+url+"); background-repeat: no-repeat; background-position: left' originalValue='" + cellvalue + "'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + cellvalue + "</span>";
                //var cellHtml = "<span style='color:" + color + "' originalValue='" + cellvalue + "'>" + cellvalue + "</span>";
                
            return cellHtml;
            } 
</script>
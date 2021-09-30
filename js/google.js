var map2;
var marker;
var markers = [];
var infowindow;
var sitios_cliente;
var markersitios = [];
var markergeocercas = [];
var poligonos = [];
var poligonosgeocercas = [];
var drawingManager = [];
var pathpoligono = "";
var valores = [];
var tipo;
var all_overlays = [];
var Latitud

function initialize() {

    var position = new google.maps.LatLng(-33.459, -70.651); //Mapa se inicaliza en GPS
    var mapOptions = {
        zoomControl: true,
        zoomControlOptions: {
            position: google.maps.ControlPosition.RIGHT_CENTER
        },
        keyboardShortcuts: true,
        zoom: 10,
        center: position,
        mapTypeControl: true,
        mapTypeControlOptions: {
            style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
            position: google.maps.ControlPosition.RIGHT_TOP
        },
        mapTypeId: google.maps.MapTypeId.ROAD //HYBRID
    };
    map2 = new google.maps.Map(document.getElementById('map2'), mapOptions);
    drawingManager = new google.maps.drawing.DrawingManager({
        drawingControl: false
    });

    var mapTrafficLayer = new google.maps.TrafficLayer();
    mapTrafficLayer.setMap(map2);

    //COntrol personalizado
    var centerControlDiv = document.createElement('div');
    var centerControl = new CenterControl(centerControlDiv, map2);

    centerControlDiv.index = 1;
    map2.controls[google.maps.ControlPosition.RIGHT_CENTER].push(centerControlDiv);

    showMarkers();
    var coords = new google.maps.LatLng(-33.459, -70.651); //Mapa se inicaliza en GPS
    centrarMapa(map2, coords);

    google.maps.event.addListener(map2, 'center_changed', function () {
        RegistrarLatLonMap(map2.getCenter(), map2.getZoom());
    });

}


google.maps.event.addDomListener(window, 'load', initialize);


function CenterControl(controlDiv, map2) {
    // from the edge of the map2
    controlDiv.style.padding = '5px';

    // Set CSS for the control border
    var controlUI = document.createElement('div');
    controlUI.style.backgroundColor = 'white';
    controlUI.style.borderStyle = 'solid';
    controlUI.style.borderWidth = '1px';
    controlUI.style.cursor = 'pointer';
    controlUI.style.textAlign = 'center';
    controlUI.title = 'Click para buscar coordenadas';
    controlDiv.appendChild(controlUI);

    // Set CSS for the control interior
    var controlText = document.createElement('div');
    controlText.style.fontFamily = 'Arial,sans-serif';
    controlText.style.fontSize = '10px';
    controlText.style.paddingLeft = '4px';
    controlText.style.paddingRight = '4px';
    controlText.innerHTML = '<img src="../img/botonBusqueda2.png" alt="Buscar"/><b>Buscar Coordenadas</b>';
    controlUI.appendChild(controlText);

    var legend = '<input type="text" id="btn_buscar_puntos" placeholder="En formato Decimal" /><button type="button"  onclick="buscar();" > Buscar</button>';

    var controlLegend = document.createElement('DIV');
    $(controlLegend).html(legend);
    $(controlLegend).hide();
    $(controlUI).append(controlLegend);

    $(controlUI).mouseenter(function () {
        $(controlLegend).show();
    }).mouseleave(function () {
        $(controlLegend).hide();
    });
}



function buscar() {
    var find_points = $("#btn_buscar_puntos").val();
    var puntos = find_points.split(',');
    var g_coord = new google.maps.LatLng(puntos[0], puntos[1]);
    centrarMapa(map2, g_coord);


    var marker = new google.maps.Marker({
        position: g_coord,
        map: map2,
        animation: google.maps.Animation.DROP,
        title: 'Lugar Buscado!'
    });


}


function BuscarCalle(address) {
    // I create a new google maps object to handle the request and we pass the address to it
    var geoCoder = new google.maps.Geocoder(address)
    var request = { address: address };
    // I make the request 
    geoCoder.geocode(request, function (result, status) {
        if (status == "OK") {
            var find_points = result[0].geometry.location.lat() + "," + result[0].geometry.location.lng();
            var puntos = find_points.split(',');
            var g_coord = new google.maps.LatLng(puntos[0], puntos[1]);
            map2.setCenter(g_coord);
            map2.setZoom(15);
            var marker = new google.maps.Marker({
                position: g_coord,
                map: map2,
                animation: google.maps.Animation.DROP,
                title: 'Lugar Buscado!'
            });
        }
    })
}


function setMarker(latitud, longitud, nombre, icono, patente, conductor, fecha, ubicacion, codigo, velocidad) {
    var myLatLng = new google.maps.LatLng(latitud, longitud);

    var marker = new MarkerWithLabel({
        position: myLatLng,
        map: map2,
        draggable: true,
        raiseOnDrag: true,
        labelContent: patente,
        labelAnchor: new google.maps.Point(-10, 20),
        labelClass: "labels", // the CSS class for the label
        labelInBackground: false,
        icon: icono
    });

    marker.metadata = { type: "point", id: codigo };
    var chHtml = "<div><label>" + nombre + "</label></div>"
        + "<div>Patente:" + patente + "</div>"
        + "<div>Conductor:" + conductor + "</div>"
        + "<div>Fecha Hora:" + fecha + "</div>"
        + "<div>Ubicación:" + ubicacion + "</div>"
        + "<div>Latitud:" + latitud + "</div>"
        + "<div>Longitud:" + longitud + "</div>"
        + "<div>Coordenadas: " + latitud + "," + longitud + "</div>"
        + "<div>Velocidad: " + velocidad + " KM/H</div>";
    // Se agrega infoWindows

    var chInfoWindow = new google.maps.InfoWindow({
        content: chHtml,
        maxWidth: 250
    });
    //Se abre infowindows al hacer click
    google.maps.event.addListener(marker, 'click', function () {

        chInfoWindow.open(map2, marker);
        //console.log(markers);
    });

    markers.push(marker);
}

function setMarkerRepetirDia(latitud, longitud, nombre, icono, patente, conductor, fecha, ubicacion, codigo) {
    var myLatLng = new google.maps.LatLng(latitud, longitud);
    var marker = new google.maps.Marker({
        position: myLatLng,
        title: nombre,
        icon: icono
    });
    marker.metadata = { type: "point", id: codigo };

    var chHtml = "<div><label>Hora: " + fecha + "</label></div>"
        + "<div>Ubicación:" + ubicacion + "</div>";

    var chInfoWindow = new google.maps.InfoWindow({
        content: chHtml,
        maxWidth: 250
    });
    //Se abre infowindows al hacer click
    google.maps.event.addListener(marker, 'click', function () {

        chInfoWindow.open(map2, marker);
        //console.log(markers);
    });

    markers.push(marker);
}


function centrarMapa(map2, coordenadas) {
    map2.setCenter(coordenadas);
}

function UnidadcentrarMapa(map2, coordenadas) {
    map2.setCenter(pt);
    map2.setZoom(18);
}

function UnidadcentrarMapaRepetirDia(map2, coordenadas) {
    map2.setCenter(pt);
    //map2.setZoom(18);
}


// Quita los markers del mapa pero los mantiene en el arreglo
function clearMarkers() {
    setMapOnAll(null);

}

// Muestra los markers que estan actualmente en el arreglo
function showMarkers() {

    setMapOnAll(map2);
}

// Elimina todos los markers del arreglo, quitando la referencia a ellos.
function deleteMarkers() {
    clearMarkers();
    markers = [];

}

function deletePoligonos() {
    clearPoligonos();
    markersitios = [];
    poligonos = [];
}

function deleteSitios() {
    clearPoligonos();
    markersitios = [];
    poligonos = [];
}

function deleteGeocercas() {
    clearPoligonosGeocerca();
    markergeocercas = [];
    poligonosgeocercas = [];
}

function clearPoligonos() {
    setMapNull(null);
}


function clearPoligonosGeocerca() {
    setMapNullGeocercas(null);
}

function setMapNull(map2) {
    for (var i = 0; i < markersitios.length; i++) {
        markersitios[i].setMap(map2);
    }
    for (var i = 0; i < poligonos.length; i++) {
        poligonos[i].setMap(map2);
    }

}

function setMapNullGeocercas(map2) {
    for (var i = 0; i < markergeocercas.length; i++) {
        markergeocercas[i].setMap(map2);
    }
    for (var i = 0; i < poligonosgeocercas.length; i++) {
        poligonosgeocercas[i].setMap(map2);
    }

}

// Se setean en el mapa todos los markers del arreglo
function setMapOnAll(map2) {
    for (var i = 0; i < markers.length; i++) {

        markers[i].setMap(map2);
    }

}

function findMarker(Id) {
    for (var i = 0; i < markers.length; i++) {
        var ico = markers[i].getIcon();
        var largo = ico.length;
        var res = ico.substring(16, largo);
        var ruta = "../img/";
        markers[i].setIcon(ico);
        markers[i].setIcon(ico);
        if (markers[i].metadata.id == Id) {
            pt = markers[i].getPosition();
            newpt = new google.maps.LatLng(pt.lat(), pt.lng());

            map2.setCenter(newpt);
            var icon = markers[i].getIcon();


            var largo = icon.length;
            var res = icon.substring(16, largo);
            var ruta = "../img/";
            var ico_new = icon;
            var newicon = icon;
            markers[i].setZIndex(999999);
            markers[i].setIcon(newicon);
            UnidadcentrarMapa(map2, markers[i].latitud + ',' + markers[i].longitud, Id);
            google.maps.event.trigger(markers[i], 'click');
        }
    }
}

function findMarkerRepetirDia(Id, srcI) {

    for (var i = 0; i < markers.length; i++) {
        var ico = markers[i].getIcon();
        var largo = ico.length;
        var res = ico.substring(16, largo);
        var ruta = "../img/";
        markers[i].setIcon(ico);
        markers[i].setIcon(ico);
        if (markers[i].metadata.id == Id) {
            pt = markers[i].getPosition();
            newpt = new google.maps.LatLng(pt.lat(), pt.lng());

            map2.setCenter(newpt);
            var icon = srcI;


            var largo = icon.length;
            var res = icon.substring(16, largo);
            var ruta = "../img/";
            var ico_new = icon;
            var newicon = icon;
            markers[i].setZIndex(999999);
            markers[i].setIcon(newicon);
            UnidadcentrarMapaRepetirDia(map2, markers[i].latitud + ',' + markers[i].longitud, Id);
        }
    }
}

function newPositionMarker(Id, latitud, longitud) {
    var coords = new google.maps.LatLng(latitud, longitud);
    for (var i = 0; i < markers.length; i++) {
        if (markers[i].metadata.id == Id) {
            markers[i].setPosition(coords);
            centrarMapa(map2, coords);

        }
    }
}

function DibujarSitios(Sitios) {
    try {
        var largo = Sitios.length;
        var bounds = map2.getBounds();
        //console.log("getNorthEast() " + bounds.getNorthEast());

        var NECorner = bounds.getNorthEast();
        var SWCorner = bounds.getSouthWest();

        var corner1 = new google.maps.LatLng(NECorner.lat(), NECorner.lng());
        var corner2 = new google.maps.LatLng(NECorner.lat(), SWCorner.lng());
        var corner3 = new google.maps.LatLng(SWCorner.lat(), SWCorner.lng());
        var corner4 = new google.maps.LatLng(SWCorner.lat(), NECorner.lng());

        var mapsCoords = [
            { lat: SWCorner.lat(), lng: SWCorner.lng() },
            { lat: SWCorner.lat(), lng: NECorner.lng() },
            { lat: NECorner.lat(), lng: NECorner.lng() },
            { lat: NECorner.lat(), lng: SWCorner.lng() }
        ];


        var limitesMapa = new google.maps.Polygon({ paths: mapsCoords });

        setMapNull(null);
        //console.log(limitesMapa);

        //console.log(Sitios);

        for (var i = 0; i < largo; i++) {

            var coordenadas = Sitios[i][6];
            var NomSitio = Sitios[i][1];
            var Codigo = Sitios[i][0];
            var TipoSitio = Sitios[i][7];
            var Radio = Sitios[i][5];
            var Latitud = Sitios[i][3];
            var Longitud = Sitios[i][4];
            var CodRefSitioCliente = Sitios[i][1];

            /*
            punto = new google.maps.LatLng(Latitud, Longitud);
            var result = (google.maps.geometry.poly.containsLocation(punto, limitesMapa) ? true : false);
            if (result == true) {
                dibujo(coordenadas, NomSitio, Codigo, TipoSitio, Radio, Latitud, Longitud, CodRefSitioCliente);
            } 
            */
            dibujo(coordenadas, NomSitio, Codigo, TipoSitio, Radio, Latitud, Longitud, CodRefSitioCliente);

        }

        setMapNull(map2);
    }
    catch (ex) {
        console.log(ex.message);
        return false;
    }
}

function DibujarGeocercas(Geocercas) {
    try {
        var largo = Geocercas.length;

        var bounds = map2.getBounds();
        //console.log("getNorthEast() " + bounds.getNorthEast());

        var NECorner = bounds.getNorthEast();
        var SWCorner = bounds.getSouthWest();

        var corner1 = new google.maps.LatLng(NECorner.lat(), NECorner.lng());
        var corner2 = new google.maps.LatLng(NECorner.lat(), SWCorner.lng());
        var corner3 = new google.maps.LatLng(SWCorner.lat(), SWCorner.lng());
        var corner4 = new google.maps.LatLng(SWCorner.lat(), NECorner.lng());

        var mapsCoords = [
            { lat: SWCorner.lat(), lng: SWCorner.lng() },
            { lat: SWCorner.lat(), lng: NECorner.lng() },
            { lat: NECorner.lat(), lng: NECorner.lng() },
            { lat: NECorner.lat(), lng: SWCorner.lng() }
        ];


        var limitesMapa = new google.maps.Polygon({ paths: mapsCoords });

        setMapNullGeocercas(null);

        for (var i = 0; i < largo; i++) {

            var coordenadas = Geocercas[i][6];
            var NomSitio = Geocercas[i][1];
            var Codigo = Geocercas[i][0];
            var TipoSitio = "P";
            var Radio = Geocercas[i][5];
            var Latitud = Geocercas[i][3];
            var Longitud = Geocercas[i][4];
            var CodRefSitioCliente = Geocercas[i][1];

            /*
            punto = new google.maps.LatLng(Latitud, Longitud);
            var result = (google.maps.geometry.poly.containsLocation(punto, limitesMapa) ? true : false);
            if (result == true) {
                dibujoGeocerca(coordenadas, NomSitio, Codigo, TipoSitio, Radio, Latitud, Longitud, CodRefSitioCliente);
            }
            */
            dibujoGeocerca(coordenadas, NomSitio, Codigo, TipoSitio, Radio, Latitud, Longitud, CodRefSitioCliente);
        }

        setMapNullGeocercas(map2);
    } catch (ex) {
        console.log(ex.message);
    }

}


function dibujo(puntos, NomSitio, Codigo, TipoSitio, Radio, Latitud, Longitud, CodRefSitioCliente) {

    try {
        var color;
        var flag
        var linea;


        if ((TipoSitio == 1) || (TipoSitio == "CASA MATRIZ")) {
            color = 'LIGHTBLUE'; //Rojo
            linea = '#000000';
            flag = PINTIPOSITIO_CASAMATRIZ;
        }

        if ((TipoSitio == 2) || (TipoSitio == "PLANTA O BASE")) {
            color = 'RED'; //Rojo
            linea = '#000000'; //Negro
            flag = PINTIPOSITIO_PLANTAOBASE;
        }
        if ((TipoSitio == 3) || (TipoSitio == "PUNTO DE ATENCION")) {
            color = 'BLUE'; //Azul
            linea = '#FF0000'; //Rojo
            flag = PINTIPOSITIO_PUNTODEATENCION;
        }
        if ((TipoSitio == 4) || (TipoSitio == "PUNTO DE CONTROL")) {
            color = 'YELLOW'; //Amarillo
            linea = '#FF0000'; //Rojo
            flag = PINTIPOSITIO_PUNTODECONTROL;
        }
        var bounds = new google.maps.LatLngBounds();



        if (parseInt(Radio) > 0) { //CIRCULO

            var centro = new google.maps.LatLng(Latitud, Longitud);

            var cityCircle;
            var circuloEnMapa = new google.maps.Circle({
                id: "sitio_" + Codigo,
                strokeColor: linea,
                strokeOpacity: 1,
                strokeWeight: 1,
                fillColor: color,
                fillOpacity: 0.4,
                center: centro,
                radius: parseInt(Radio),
                //map2: map2
            });



            circuloEnMapa.metadata = { id: "sitio_" + Codigo, tipo: TipoSitio };

            circuloEnMapa.setMap(map2);

            poligonos.push(circuloEnMapa);

            google.maps.event.addListener(circuloEnMapa, "rightclick", function (event) {
                var lat = event.latLng.lat();
                var lng = event.latLng.lng();

                alert("Lat=" + lat + "; Lng=" + lng);
            });

            google.maps.event.addListener(circuloEnMapa, 'radius_changed', function () {
                var radius = circuloEnMapa.getRadius();
                radius = Math.round(radius);
                var latt = circuloEnMapa.getCenter().lat();
                var longg = circuloEnMapa.getCenter().lng();
                $("[id$=coordenadas]").html(latt + ',' + longg);
                $("[id$=txtRadio]").val(radius);
            });


            var markersitio = new google.maps.Marker({
                position: centro,
                //map2: map2,
                title: NomSitio,
                icon: flag,
            });
            markersitio.metadata = { id: "sitio_mk" + Codigo, tipo: TipoSitio };
            var MHtml = "<div><label>" + NomSitio + "</label></div>"
                + "<div>Código:" + CodRefSitioCliente + "</div>";

            var MInfoWindow = new google.maps.InfoWindow({
                content: MHtml,
                maxWidth: 250
            });
            //open infowindow on click event on marker.
            google.maps.event.addListener(markersitio, 'click', function () {

                MInfoWindow.open(map2, markersitio);
            });
            markersitios.push(markersitio);

        } else { //POLIGONO

            var lat_lng = puntos.split(',');
            var coordenadasPoligono = [];
            var x = 0;
            for (var i = 0; i < lat_lng.length; i = i + 2) {
                coordenadasPoligono[x] = (new google.maps.LatLng(lat_lng[i], lat_lng[i + 1]));
                x++;
            }


            var markersitio = new google.maps.Marker({
                position: coordenadasPoligono[1],
                //map2: map2,
                title: NomSitio,
                icon: flag,
            });
            markersitio.metadata = { id: "sitio_mk" + Codigo, tipo: TipoSitio };
            var MHtml = "<div><label>" + NomSitio + "</label></div>"
                + "<div>Código:" + CodRefSitioCliente + "</div>";
            // add an infowindow
            var MInfoWindow = new google.maps.InfoWindow({
                content: MHtml,
                maxWidth: 250
            });
            //open infowindow on click event on marker.
            google.maps.event.addListener(markersitio, 'click', function () {

                MInfoWindow.open(map2, markersitio);
            });

            markersitios.push(markersitio);

            var poligonoEnMapa = new google.maps.Polygon({
                id: "sitio_" + Codigo,
                paths: coordenadasPoligono,
                strokeColor: linea,
                strokeOpacity: 1,
                strokeWeight: 1,
                fillColor: color,
                fillOpacity: 0.4
            });


            poligonoEnMapa.metadata = { id: "sitio_" + Codigo, tipo: TipoSitio };
            poligonos.push(poligonoEnMapa);

            google.maps.event.addListener(poligonoEnMapa, "rightclick", function (event) {
                var lat = event.latLng.lat();
                var lng = event.latLng.lng();
                console.log(event);
                alert("Lat=" + lat + "; Lng=" + lng);
            });
            //google.maps.event.trigger(flightPath, "click", {});
            poligonoEnMapa.addListener('click', ObtenerCoordenadasDelPoligono);
        }



    } catch (Exception) {
        //console.log(Exception);
    }


}

function dibujoGeocerca(puntos, NomGeocerca, Codigo, TipoSitio, Radio, Latitud, Longitud, CodRefSitioCliente) {

    try {
        var color;
        var flag
        var linea;
        color = '(1.1.1)'; //Amarillo
        linea = '#FF0000'; //'#FF0000'; //Rojo
        flag = PINTIPOGEOCERCA;

        var numPuntos = puntos.split(',').length;
        var bounds = new google.maps.LatLngBounds();

        //console.log("dibujando geocerca desde google");

        if (parseInt(Radio) > 0) { //CIRCULO

            tipo = 'circulo';
            var centro = new google.maps.LatLng(Latitud, Longitud);

            var cityCircle;
            var circuloEnMapa = new google.maps.Circle({
                id: "geocerca_" + Codigo,
                strokeColor: linea,
                strokeOpacity: 1,
                strokeWeight: 1,
                fillColor: color,
                fillOpacity: 0.4,
                center: centro,
                radius: parseInt(Radio),
                //map2: map2
            });



            circuloEnMapa.metadata = { id: "geocerca_" + Codigo, tipo: TipoSitio };
            circuloEnMapa.setMap(map2);
            poligonosgeocercas.push(circuloEnMapa);

            google.maps.event.addListener(circuloEnMapa, "rightclick", function (event) {
                var lat = event.latLng.lat();
                var lng = event.latLng.lng();

                alert("Lat=" + lat + "; Lng=" + lng);
            });

            var markerGeocerca = new google.maps.Marker({
                position: centro,
                //map2: map2,
                title: NomGeocerca,
                icon: flag,
            });
            markerGeocerca.metadata = { id: "geocerca_mk" + Codigo, tipo: TipoSitio };
            var MHtml = "<div><label>" + NomGeocerca + "</label></div>"
                + "<div>Código:" + CodRefSitioCliente + "</div>";

            var MInfoWindow = new google.maps.InfoWindow({
                content: MHtml,
                maxWidth: 250
            });
            //open infowindow on click event on marker.
            google.maps.event.addListener(markerGeocerca, 'click', function () {

                MInfoWindow.open(map2, markerGeocerca);
            });
            markergeocercas.push(markerGeocerca);
            //console.log(markerGeocerca);
        } else if (numPuntos == 4) {
            tipo = 'rectangulo';
            var lat_lng = puntos.split(',');
            var rectanguloEnMapa = new google.maps.Rectangle({
                id: "geocerca_" + Codigo,
                bounds: {
                    south: parseFloat(lat_lng[0]),
                    west: parseFloat(lat_lng[1]),
                    north: parseFloat(lat_lng[2]),
                    east: parseFloat(lat_lng[3]),
                },
                strokeColor: linea,
                strokeOpacity: 1,
                strokeWeight: 2,
                fillColor: color,
                fillOpacity: 0
            });
            rectanguloEnMapa.metadata = { id: "geocerca_" + Codigo, tipo: TipoSitio };
            rectanguloEnMapa.setMap(map2);
            poligonosgeocercas.push(rectanguloEnMapa);

            google.maps.event.addListener(rectanguloEnMapa, "rightclick", function (event) {
                var lat = event.latLng.lat();
                var lng = event.latLng.lng();
                alert("Lat=" + lat + "; Lng=" + lng);
            });
            var myLatLng = (new google.maps.LatLng((parseFloat(lat_lng[0]) + parseFloat(lat_lng[2])) / 2, (parseFloat(lat_lng[1]) + parseFloat(lat_lng[3]))/2));
            var markerGeocerca = new google.maps.Marker({
                position: myLatLng ,
                title: NomGeocerca,
                icon: flag,
            });
            markerGeocerca.metadata = { id: "geocerca_mk" + Codigo, tipo: TipoSitio };
            var MHtml = "<div><label>" + NomGeocerca + "</label></div>"
                + "<div>Código:" + CodRefSitioCliente + "</div>";

            var MInfoWindow = new google.maps.InfoWindow({
                content: MHtml,
                maxWidth: 250
            });
            //open infowindow on click event on marker.
            google.maps.event.addListener(markerGeocerca, 'click', function () {
                MInfoWindow.open(map2, markerGeocerca);
            });
            markergeocercas.push(markerGeocerca);
            //console.log(markerGeocerca);

        } else { //POLIGONO

            tipo = 'poligono';
            var lat_lng = puntos.split(',');
            var coordenadasPoligono = [];
            var x = 0;
            for (var i = 0; i < lat_lng.length; i = i + 2) {
                coordenadasPoligono[x] = (new google.maps.LatLng(lat_lng[i], lat_lng[i + 1]));
                x++;
            }

            var poligonoEnMapa = new google.maps.Polygon({
                id: "geocerca_" + Codigo,
                paths: coordenadasPoligono,
                strokeColor: linea,
                strokeOpacity: 1,
                strokeWeight: 2,
                fillColor: color,
                fillOpacity: 0
            });


            poligonoEnMapa.metadata = { id: "geocerca_" + Codigo, tipo: TipoSitio };
            poligonoEnMapa.setMap(map2);
            poligonosgeocercas.push(poligonoEnMapa);

            google.maps.event.addListener(poligonoEnMapa, "rightclick", function (event) {
                overlayComplete(event);
                var lat = event.latLng.lat();
                var lng = event.latLng.lng();
                // populate yor box/field with lat, lng
                alert("Lat=" + lat + "; Lng=" + lng);
            });


            var markerGeocerca = new google.maps.Marker({
                position: coordenadasPoligono[1],
                //map2: map2,
                title: NomGeocerca,
                icon: flag,
            });
            markerGeocerca.metadata = { id: "geocerca_mk" + Codigo, tipo: TipoSitio };
            var MHtml = "<div><label>" + NomGeocerca + "</label></div>"
                + "<div>Código:" + CodRefSitioCliente + "</div>";
            // add an infowindow
            var MInfoWindow = new google.maps.InfoWindow({
                content: MHtml,
                maxWidth: 250
            });
            //open infowindow on click event on marker.
            google.maps.event.addListener(markerGeocerca, 'click', function () {

                MInfoWindow.open(map2, markerGeocerca);
            });
            markergeocercas.push(markerGeocerca);

            poligonoEnMapa.addListener('click', ObtenerCoordenadasDelPoligono);
        }



    } catch (Exception) {
        console.log(Exception);
    }


}

function overlayComplete(overlay) {
    google.maps.event.addListener(overlay, "click", function (event) {
        //console.log('wena shoro: ' + event);
    });
}

function drawPoly(bool) {
    for (var i = 0; i < poligonos.length; i++) {
        poligonos[i].setEditable(bool);
        poligonos[i].setDraggable(bool);

    }
}

function drawPolyGeocerca(bool) {
    for (var i = 0; i < poligonosgeocercas.length; i++) {
        poligonosgeocercas[i].setEditable(bool);
        poligonosgeocercas[i].setDraggable(bool);

    }
}


function EditarPoligono(Id, bool, IdMarker) {
    for (var i = 0; i < poligonos.length; i++) {
        if (poligonos[i].id == Id) {
            poligonos[i].setEditable(bool);
            poligonos[i].setDraggable(bool);
            MostrarSitioGeocerca("sitio_mk" + IdMarker);
            return true;
        }
    }
}

function EditarPoligonoGeocerca(Id, bool, IdMarker) {
    for (var i = 0; i < poligonosgeocercas.length; i++) {
        if (poligonosgeocercas[i].id == Id) {
            poligonosgeocercas[i].setEditable(bool);
            poligonosgeocercas[i].setDraggable(bool);
            MostrarGeocerca("geocerca_mk" + IdMarker);
            return true;
        }
    }
}

function ObtenerCoordenadasDelCirculo(Id) {
    for (var i = 0; i < poligonos.length; i++) {
        if (poligonos[i].id == Id) {
            // console.log("ObtenerCoordenadasDelCirculo", poligonos[i]);
            google.maps.event.trigger(poligonos[i], 'radius_changed');
            return true;
        }
    }
}



function CoordenadasDelPoligonoGeocerca(Id) {
    for (var i = 0; i < poligonosgeocercas.length; i++) {
        if (poligonosgeocercas[i].id == Id) {
            google.maps.event.trigger(poligonosgeocercas[i], "click", {});
            return true;
        }
    }
}


function LimpiarSitiosTemporales() {
    for (var i = 0; i < all_overlays.length; i++) {
        all_overlays[i].overlay.setMap(null);
    }
    all_overlays = [];
}


function CoordenadasDelPoligono(Id) {
    for (var i = 0; i < poligonos.length; i++) {
        if (poligonos[i].id == Id) {
            google.maps.event.trigger(poligonos[i], "click", {});
            return true;
        }
    }
}


function findPoly() {
    for (var i = 0; i < poligonos.length; i++) {

        return poligonos[i];
    }

}

function crearPoligono(tipo, tipositio) {
    var color;
    var linea;

    if (tipositio == 1) {
        color = '#000000'; //Rojo
        linea = '#000000';
        flag = '../img/map2/pin_azul.png';//Negro
    }

    if (tipositio == 2) {
        color = '#FF0000'; //Rojo
        linea = '#000000'; //Negro
        flag = '../img/map2/pin_rojo.png';
    }
    if (tipositio == 3) {
        color = '#090F59'; //Azul
        linea = '#FF0000'; //Rojo
        flag = '../img/map2/pin_azul.png';
    }
    if (tipositio == 4) {
        color = '#F0FA33'; //Amarillo
        linea = '#FF0000'; //Rojo
        flag = '../img/map2/pin_amarillo.png';
    }

    if (tipo == "C") {
        drawingManager.setDrawingMode(google.maps.drawing.OverlayType.CIRCLE);
        drawingManager.metadata = { id: "sitio_temp" };
        drawingManager.setMap(map2);
    }

    if (tipo == "P") {
        drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);
        drawingManager.metadata = { id: "sitio_temp" };
        drawingManager.setMap(map2);
    }

    if (tipo == "R") {
        drawingManager.setDrawingMode(google.maps.drawing.OverlayType.RECTANGLE);
        drawingManager.metadata = { id: "sitio_temp" };
        drawingManager.setMap(map2);
    }


    //listener que se gatilla cuando se termina de dibujar el sitio
    google.maps.event.addListener(drawingManager, 'overlaycomplete', function (event) {

        all_overlays.push(event);

        event.overlay.setOptions({ strokeColor: linea, fillColor: color });
        drawingManager.setDrawingMode(null);

        google.maps.event.addListener(event.overlay, 'radius_changed', function () {
            var radius = event.overlay.getRadius();
            radius = Math.round(radius);
            var latt = event.overlay.getCenter().lat();
            var longg = event.overlay.getCenter().lng();
            $("[id$=coordenadas]").html(latt + ',' + longg);
            $("[id$=txtRadio]").val(radius);
            $("[id$=txtRadioSitio]").val(radius);
        });

        google.maps.event.addListener(event.overlay, 'bounds_changed', function () {
            var latIni = event.overlay.getBounds().Va.i;
            var lngIni = event.overlay.getBounds().Qa.i;
            var latFin = event.overlay.getBounds().Va.j;
            var lngFin = event.overlay.getBounds().Qa.j;
            var coordenadas = latIni + "," + lngIni + "," + latFin + "," + lngFin;
            $("[id$=hPuntosDelPoligono]").html(2);
            //valores = [0, coordenadas, lat, lng];
            $("[id$=coordenadas]").html(coordenadas);
            $("[id$=txtRadio]").val(0);
        });

        google.maps.event.addListener(event.overlay, 'dragend', function () {
            //console.log("Evento al drag sitio");
            if (event.type == "circle") {
                var radius = event.overlay.getRadius();
                radius = Math.round(radius);
                var latt = event.overlay.getCenter().lat();
                var longg = event.overlay.getCenter().lng();
                $("[id$=coordenadas]").html(latt + ',' + longg);
                $("[id$=txtRadio]").val(radius);
                $("[id$=txtRadioSitio]").val(radius);
            } else if (event.type == "rectangle") {
                var latIni = event.overlay.getBounds().Va.i;
                var lngIni = event.overlay.getBounds().Qa.i;
                var latFin = event.overlay.getBounds().Va.j;
                var lngFin = event.overlay.getBounds().Qa.j;
                var coordenadas = latIni + "," + lngIni + "," + latFin + "," + lngFin;
                $("[id$=hPuntosDelPoligono]").html(2);
                //valores = [0, coordenadas, lat, lng];
                $("[id$=coordenadas]").html(coordenadas);
                $("[id$=txtRadio]").val(0);
            } else {
                var vertices = event.overlay.getPath("latLngs");
                var contentString = "";
                for (var i = 0; i < vertices.length; i++) {
                    var xy = vertices.getAt(i);
                    contentString += xy.lat() + ',' + xy.lng() + ',';
                }
                if (contentString != "")
                    contentString = contentString.substring(0, contentString.length - 1);
                $("[id$=hPuntosDelPoligono]").html(i);
                $("[id$=coordenadas]").html(contentString);
                $("[id$=txtRadio]").val(0);
                $("[id$=txtRadioSitio]").val(0);
            }
        });

        if (event.type == google.maps.drawing.OverlayType.POLYGON) {
            google.maps.event.addListener(event.overlay.getPath(), 'set_at', function () {
                //console.log("Evento mover punto");
                var vertices = event.overlay.getPath("latLngs");
                var contentString = "";
                for (var i = 0; i < vertices.length; i++) {
                    var xy = vertices.getAt(i);
                    contentString += xy.lat() + ',' + xy.lng() + ',';
                }
                if (contentString != "")
                    contentString = contentString.substring(0, contentString.length - 1);
                $("[id$=hPuntosDelPoligono]").html(i);
                $("[id$=coordenadas]").html(contentString);
                $("[id$=txtRadio]").val(0);
            });


            google.maps.event.addListener(event.overlay.getPath(), 'insert_at', function () {
                //console.log("Evento mover punto");
                var vertices = event.overlay.getPath("latLngs");
                var contentString = "";
                for (var i = 0; i < vertices.length; i++) {
                    var xy = vertices.getAt(i);
                    contentString += xy.lat() + ',' + xy.lng() + ',';
                }
                if (contentString != "")
                    contentString = contentString.substring(0, contentString.length - 1);
                $("[id$=hPuntosDelPoligono]").html(i);
                $("[id$=coordenadas]").html(contentString);
                $("[id$=txtRadio]").val(0);
                //console.log("OK", contentString);
            });

            google.maps.event.addListener(event.overlay.getPath(), 'remove_at', function () {
                //console.log("Evento mover punto");
                var vertices = event.overlay.getPath("latLngs");
                var contentString = "";
                for (var i = 0; i < vertices.length; i++) {
                    var xy = vertices.getAt(i);
                    contentString += xy.lat() + ',' + xy.lng() + ',';
                }

                $("[id$=hPuntosDelPoligono]").html(i);

                if (contentString != "")
                    contentString = contentString.substring(0, contentString.length - 1);
                $("[id$=coordenadas]").html(contentString);
                $("[id$=txtRadio]").val(0);
                //console.log("OK", $("[id$=hPuntosDelPoligono]").html());
            });
        }

        //console.log(event.type);
        pathPoligono(event);

        // drawingManager.addListener('click', ObtenerCoordenadasDelPoligono);

        /*
        google.maps.event.addListener(map2, 'click', function (e) {
            polygon.getPath().push(e.latLng);
        });
        */

        //Boton para limpiar póligono luego de dibujarlo
        //Cambiar ID según correpsonda.

        /*
        document.getElementById("btnLimpiarPoligono").addEventListener("click", function () {
            event.overlay.setMap(null);
            
        })

        //Boton para borrar poligono al apretar cancelar
        document.getElementById("btnCancelar").addEventListener("click", function () {
            event.overlay.setMap(null);

        })

        //Boton para 
        document.getElementById("btnGuardar").addEventListener("click", function () {
            pathpoligono = "";
            valores = [];
            drawPoly(false);
            event.overlay.setMap(null);

        })*/
    });

}

function pathPoligono(event) {

    valores = []; //Arreglo matricial = [Radio, Coordenadas, Latitud, Longitud]
    if (event.type == google.maps.drawing.OverlayType.CIRCLE) {
        var radius = event.overlay.getRadius();
        var bounds = event.overlay.getBounds();
        var lat = event.overlay.getCenter().lat();
        var lng = event.overlay.getCenter().lng();
        event.overlay.setEditable(true);
        event.overlay.setDraggable(true);
        valores = [parseInt(radius), lat + "," + lng, lat, lng];

        $("[id$=coordenadas]").html(lat + "," + lng);
        //$("[id$=coordenadas]").html("");
        $("[id$=txtRadio]").val(parseInt(radius));
        $("[id$=txtRadioSitio]").val(parseInt(radius));
    }

    if (event.type == google.maps.drawing.OverlayType.RECTANGLE) {

        event.overlay.setEditable(true);
        event.overlay.setDraggable(true);
        var latIni = event.overlay.getBounds().Va.i;
        var lngIni = event.overlay.getBounds().Qa.i;
        var latFin = event.overlay.getBounds().Va.j;
        var lngFin = event.overlay.getBounds().Qa.j;
        var coordenadas = latIni + "," + lngIni + "," + latFin + "," + lngFin;
        $("[id$=hPuntosDelPoligono]").html(2);
        //valores = [0, coordenadas, lat, lng];
        $("[id$=coordenadas]").html(coordenadas);
        $("[id$=txtRadio]").val(0);
        //console.log(valores);
    }

    if (event.type == google.maps.drawing.OverlayType.POLYGON) {

        event.overlay.setEditable(true);
        event.overlay.setDraggable(true);
        var lat;
        var lng;

        var coordinates = "";
        coordinates = (event.overlay.getPath().getArray());//coordenadas
        var vertices = (event.overlay.getPath());
        var numVertices = vertices.getLength();

        //console.log(event);

        var coordenadas = "";
        for (var i = 0; i < numVertices; i++) {
            if (coordenadas == "") {
                coordenadas = vertices.getAt(i).lat() + "," + vertices.getAt(i).lng() + ",";
                lat = vertices.getAt(i).lat();
                lng = vertices.getAt(i).lng();
            }
            else {
                if (i == (numVertices - 1)) {
                    coordenadas = coordenadas + vertices.getAt(i).lat() + "," + vertices.getAt(i).lng();
                    //coordenadas = coordenadas + vertices.getAt(0).lat() + " " + vertices.getAt(0).lng();
                }
                else {
                    coordenadas = coordenadas + vertices.getAt(i).lat() + "," + vertices.getAt(i).lng() + ",";
                }
            }

        }
        $("[id$=hPuntosDelPoligono]").html(i);
        //valores = [0, coordenadas, lat, lng];
        $("[id$=coordenadas]").html(coordenadas);
        $("[id$=txtRadio]").val(0);
        //console.log(valores);

    }
}


function ObtenerCoordenadasDelPoligono(event) {
    //console.log(event);
    // Since this polygon has only one path, we can call getPath() to return the
    // MVCArray of LatLngs.
    var vertices = this.getPath();
    /*
    var contentString = '<b>Bermuda Triangle polygon</b><br>' +
        'Clicked location: <br>' + event.latLng.lat() + ',' + event.latLng.lng() +
        '<br>';
    */
    var contentString = "";
    // Iterate over the vertices.
    for (var i = 0; i < vertices.getLength(); i++) {
        var xy = vertices.getAt(i);
        //contentString += '<br>' + 'Coordinate ' + i + ':<br>' + xy.lat() + ',' + xy.lng();
        contentString += xy.lat() + ',' + xy.lng() + ',';
    }
    if (contentString != "")
        contentString = contentString.substring(0, contentString.length - 1);

    $("[id$=hPuntosDelPoligono]").html(i);
    $("[id$=coordenadas]").html(contentString);
    // Replace the info window's content and position.
    return true;
}

function MostrarSitioGeocerca(Id) {
    for (var i = 0; i < markersitios.length; i++) {
        if (markersitios[i].metadata.id == Id) {
            google.maps.event.trigger(markersitios[i], 'click');
            map2.setZoom(12);
        }
    }
}

function MostrarGeocerca(Id) {
    for (var i = 0; i < markergeocercas.length; i++) {
        if (markergeocercas[i].metadata.id == Id) {
            google.maps.event.trigger(markergeocercas[i], 'click');
            map2.setZoom(12);
        }
    }
}

function RegistrarLatLonMap(coordenadas, zoom) {

    $.ajax({
        contentType: 'application/json; charset=utf-8',
        url: '../ws/ws_sitiogeocerca.asmx/gmaplatlon',
        data: '{"coordenadas":"' + coordenadas + '","zoom":"' + zoom + '"}',
        success: function (jsondata) {


        },
        error: function (msg) {
            //$.msgbox('</br><font size="4"  align="center"><span>Dibuje el sitio, haciendo click  sobre el mapa. </span></font>', { type: "alert" });
            //alert('Ocurrio un problema al intentar la carga : ' + msg.responseText);
        }
    });

}

function RetornaLatLon() {
    $.ajax({
        contentType: 'application/json; charset=utf-8',
        url: '../ws/ws_sitiogeocerca.asmx/RetornaLatLon',
        data: '{}',
        success: function (jsondata) {


            var str = jsondata.d;
            if (str != "-1*-1") {
                var res = str.split("*");
                var coor = res[0].replace(" ", "");
                var acoor = coor.split(",");
                coords = new google.maps.LatLng(acoor[0], acoor[1]);
                map2.setCenter(coords);
                map2.setZoom(parseInt(res[1]));
            }
        },
        error: function (msg) {
            //$.msgbox('</br><font size="4"  align="center"><span>Dibuje el sitio, haciendo click  sobre el mapa. </span></font>', { type: "alert" });
            //alert('Ocurrio un problema al intentar la carga : ' + msg.responseText);
        }
    });

}
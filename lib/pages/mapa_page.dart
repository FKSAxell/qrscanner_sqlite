import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrscanner_sqlite/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

   Completer<GoogleMapController> _controller = Completer();




  @override
  Widget build(BuildContext context) {

    

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    final CameraPosition _kGooglePlex = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 70,
    );

    //Marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId("geo-location"),
      position: scan.getLatLng()
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

        markers: markers ,
      ),
    );
  }
}
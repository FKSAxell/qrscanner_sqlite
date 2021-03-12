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
   MapType mapType = MapType.normal;




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
        actions: [
          IconButton(icon: Icon(Icons.location_disabled), 
          onPressed: () async {
            
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: scan.getLatLng(),
                  zoom: 17,
                  tilt: 70
                )
              )
            );

          })
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        mapType: mapType,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

        markers: markers ,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers) , 
        onPressed: ()  {
          
          if(mapType == MapType.normal){
            mapType=MapType.satellite;
          }else{
            mapType=MapType.normal;
          }
          setState(() {
            
          });
         

        },
      ),
    );
  }
}
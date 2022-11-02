import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
// init Set of markers
  var myMarkers = HashSet<Marker>();

// init GoogleMap Controller
  Completer<GoogleMapController> _controller = Completer();

// init Camera position
  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(37, -122), zoom: 14);

// init another Camera position
  static final CameraPosition _kLake = CameraPosition(
      target: LatLng(21.0203579, 105.7913902), bearing: 30, tilt: 0, zoom: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps")),

      // body show Maps
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

          // add markers to myMarker
          setState(() {
            // ignore: prefer_const_constructors
            myMarkers.add(Marker(

                //markers ID
                markerId: MarkerId("1"),

                //postion of the markers
                position: LatLng(21.0203579, 105.7913902)));
          });
        },

        // show markers in Set to map screen
        markers: myMarkers,
      ),

      // Button go to location
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: FloatingActionButton.extended(
          onPressed: _goToTheLake,
          label: Text("go to 219 Trung Kinh!"),
          icon: Icon(Icons.directions_boat),
        ),
      ),
    );
  }

// function to set controller to location
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

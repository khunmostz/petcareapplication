import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/screens/Content/detaillocation_page.dart';
import 'package:petcare_project/widget/search_bar.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Position? userLocation;
  Completer<GoogleMapController> _mapController = Completer();
  late LatLng _latLng = LatLng(13.803960, 100.739408);
  late CameraPosition _cameraPosition =
      CameraPosition(target: _latLng, zoom: 15);

  Marker _markerRed = Marker(
    markerId: MarkerId('Kasembundit'),
    infoWindow: InfoWindow(title: "Kasembundit Universe"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.803960, 100.739408),
  );

  Marker _markerBlue = Marker(
    markerId: MarkerId('ตลาดทองร่มเกล้า'),
    infoWindow: InfoWindow(title: "ตลาดทองร่มเกล้า"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.800507, 100.744112),
  );

  Polyline _polyline = Polyline(
    polylineId: PolylineId('polyline'),
    points: [
      LatLng(13.803960, 100.739408),
      LatLng(13.800507, 100.744112),
    ],
    width: 5,
  );

  Polygon _polygon = Polygon(
    polygonId: PolygonId('polygon'),
    points: [
      LatLng(13.803960, 100.739408),
      LatLng(13.800507, 100.744112),
      LatLng(13.799, 100.740),
      LatLng(13.834, 100.740),
    ],
    strokeWidth: 5,
    fillColor: Colors.transparent,
  );

  Future<Position?> _getLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
        // กำหนดค่าความแม่นยำ
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      userLocation = null;
    }
    return userLocation; // return ตำแหน่งปัจจุบันออกไป
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
          future: _getLocation(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else {
              return Container(
                width: size.width,
                height: size.height,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  markers: {
                    _markerRed,
                    _markerBlue,
                  },
                  polylines: {_polyline},
                  polygons: {_polygon},
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                  },
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _latLng,
                    zoom: 15,
                  ),
                ),
              );
            }
          },
        ),
        Positioned(
          top: 80,
          left: 30,
          right: 30,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade50,
                  spreadRadius: 0.5,
                  blurRadius: 10,
                )
              ],
            ),
            child: SearchField(),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 30,
          right: 30,
          child: Container(
            width: size.width,
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailLocationPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 8,
                            spreadRadius: 5,
                            offset: Offset(0.1, 0.3),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Position? userLocation;
  late GoogleMapController? _mapController;
  late LatLng _latLng = LatLng(userLocation!.latitude, userLocation!.longitude);
  late CameraPosition _cameraPosition =
      CameraPosition(target: _latLng, zoom: 15);

  void _onMapCreate(GoogleMapController? controller) {
    _mapController = controller;
  }

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
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreate,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _latLng,
                    zoom: 15,
                  ),
                ),
              );
            }
          },
        )
      ],
    ));
  }
}

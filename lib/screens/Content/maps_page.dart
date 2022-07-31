import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lotties;
import 'package:petcare_project/controllers/map_controller.dart';
import 'package:petcare_project/services/services.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage>
    with SingleTickerProviderStateMixin {
  final MapController _mapController = Get.put(MapController());
  late AnimationController _animationController;
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Platform.isIOS ? Duration(seconds: 6) : Duration(seconds: 5),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoogleMaps examples')),
      body: StreamBuilder(
          stream: _mapController.getUserPosition().asStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: lotties.Lottie.asset(
                  'assets/lottie/progress-loading.json',
                  repeat: true,
                  frameRate: lotties.FrameRate(240),
                  controller: _animationController,
                ),
              );
            } else {
              return GoogleMap(
                mapType: MapType.normal,
                // zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _mapController.userPosition.latitude,
                      _mapController.userPosition.longitude,
                    ),
                    zoom: 14.5),
                markers: placeKM.map((e) => e).toSet(),

                circles: Set.from(
                  [
                    Circle(
                      circleId: CircleId('currentCircle'),
                      center: LatLng(_mapController.userPosition.latitude,
                          _mapController.userPosition.longitude),
                      radius: 2500,
                      fillColor: Colors.orangeAccent.shade100.withOpacity(0.5),
                      strokeColor: Colors.orange,
                      strokeWidth: 1,
                    ),
                  ],
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            }
          }),
    );
  }
}

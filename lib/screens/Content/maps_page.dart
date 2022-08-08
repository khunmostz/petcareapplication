import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lotties;
import 'package:petcare_project/controllers/map_controller.dart';
import 'package:petcare_project/services/services.dart';
import 'package:petcare_project/utils/constant.dart';

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
    // var size = MediaQuery.of(context).size;
    var size = Get.size;
    print('-----------------' * 50);
    // print(placeDetail.toString());
    return Scaffold(
      // appBar: AppBar(title: const Text('GoogleMaps examples')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefualtPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              // Search
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    // fillColor: Colors.black,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Search',
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(height: 20),
              // Map
              Container(
                width: size.width,
                height: size.height * 0.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GetBuilder<MapController>(builder: (_) {
                    if (_mapController.userPosition.latitude != null) {
                      return GoogleMap(
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            _mapController.userPosition.latitude,
                            _mapController.userPosition.longitude,
                          ),
                          zoom: 12,
                        ),
                        markers: placeKM.map((e) => e).toSet(),
                        circles: Set.from(
                          [
                            Circle(
                              circleId: CircleId('currentCircle'),
                              center: LatLng(
                                  _mapController.userPosition.latitude,
                                  _mapController.userPosition.longitude),
                              radius: 5000,
                              fillColor:
                                  Colors.orangeAccent.shade100.withOpacity(0.5),
                              strokeColor: Colors.orange,
                              strokeWidth: 1,
                            ),
                          ],
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
                ),
              ),
              SizedBox(height: 20),
              // NearMe
              Text(
                'ใกล้ฉัน',
                style: GoogleFonts.mitr(fontSize: 16),
              ),
              SizedBox(height: 10),
              GetBuilder<MapController>(builder: (_) {
                return Container(
                  width: size.width,
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: placeName.length,
                    itemBuilder: (context, index) {
                      var locationName = placeName[index];
                      var locationImage = placeImage[index];
                      // print(locationImage);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: NetworkImage(locationImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

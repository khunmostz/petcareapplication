import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcare_project/controllers/map_controller.dart';
import 'package:petcare_project/models/location.dart';
import 'package:petcare_project/utils/distance.dart';

List<Marker> placeKM = [];

final MapController _mapController = Get.find<MapController>();

Future<dynamic> getRequest(
    {required String path, required Position userPosition}) async {
  try {
    final res = await Dio().get(path);

    var data = res.data['locations'].map((place) {
      return Location.fromJson(place);
    });
    BitmapDescriptor userMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/image/location-pin-user.png",
    );
    BitmapDescriptor hospitalMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/image/location-pin-hospital.png",
    );
    print(
        'current location user: ${_mapController.userPosition.latitude.toString()}');
    data.forEach((place) {
      double distancKm = calcDistance(
          userPosition.latitude,
          userPosition.longitude,
          double.parse(place.locationLat),
          double.parse(place.locationLong));
      if (distancKm <= 5) {
        print('location distance 5 KM: ${place.locationName.toString()}');

        Marker userLocation = Marker(
          markerId: MarkerId('User'),
          infoWindow: InfoWindow(
            title: 'User',
          ),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(
            _mapController.userPosition.latitude,
            _mapController.userPosition.longitude,
          ),
        );
        Marker hospitalLocation = Marker(
          markerId: MarkerId('Hospital'),
          infoWindow: InfoWindow(
            title: place.locationName,
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: LatLng(
            double.parse(place.locationLat),
            double.parse(place.locationLong),
          ),
        );
        placeKM.add(userLocation);
        placeKM.add(hospitalLocation);
      }
    });
  } on DioError catch (e) {
    print(e.toString());
    errorFilter(e);
  }
}

errorFilter(DioError e) {
  if (e.error is SocketException) {
    Get.snackbar('แจ้งเตือน', 'กรุณาเช่ื่อมต่ออินเตอร์เน็ตแล้วลองอีกครั้ง');
  }

  if (e.response != null) {
    if (e.response!.statusCode! >= 500) {
      Get.snackbar('แจ้งเตือน', 'ไม่สามารถเชื่อมต่อกับเซิฟเวอร์ได้');
    } else {
      Get.snackbar('แจ้งเตือน', 'เกิดข้อผิดพลาดกรุณาลองใหม่อีกครั้ง');
    }
  } else {
    Get.snackbar('แจ้งเตือน', 'มีข้อผิิดพลาดเกิดขึ้น');
  }
}

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcare_project/controllers/map_controller.dart';
import 'package:petcare_project/models/location.dart';
import 'package:petcare_project/models/promotion.dart';
import 'package:petcare_project/utils/distance.dart';

List allPlace = [];
List equalPlace = [];
List allPromotions = [];

List<Marker> placeKM = [];
List placeName = [];
List placeImage = [];
List placeDesc = [];
List placeLat = [];
List placeLong = [];

final MapController _mapController = Get.find<MapController>();

Future<dynamic> getRequestMapDistance(
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
      print('location: ' + place.locationName.toString());

      double distancKm = calcDistance(
          userPosition.latitude,
          userPosition.longitude,
          double.parse(place.locationLat),
          double.parse(place.locationLong));

      if (distancKm <= 5) {
        // print('location distance 5 KM: ${place.locationName.toString()}');

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

        var locationName = place.locationName.toString();
        var locationImage = place.locationImage.toString();
        var locationDesc = place.locationDesc.toString();
        var locationLat = place.locationLat.toString();
        var locationLong = place.locationLong.toString();
        placeName.add(locationName);
        placeImage.add(locationImage);
        placeDesc.add(locationDesc);
        placeLat.add(locationLat);
        placeLong.add(locationLong);
      }
    });
  } on DioError catch (e) {
    print(e.toString());
    errorFilter(e);
  }
}

Future<dynamic> getRequestAllMap({required String path}) async {
  final res = await Dio().get(path);

  var data = res.data['locations'].map((place) {
    return Location.fromJson(place);
  });

  data.forEach((place) {
    allPlace.add(place.locationName);
  });
}

Future<dynamic> getRequestEqualAllMap(
    {required String path, required Position userPosition}) async {
  final res = await Dio().get(path);

  var data = res.data['locations'].map((place) {
    return Location.fromJson(place);
  });

  // equalPlace.add(data);
  data.forEach((place) {
    // equalPlace.add(place);
    double distancKm = calcDistance(
        userPosition.latitude,
        userPosition.longitude,
        double.parse(place.locationLat),
        double.parse(place.locationLong));

    if (distancKm <= 5) {
      // print('place : ${place.locationName}');
      equalPlace.add(place);
    }
  });
}

Future<dynamic> getPromotion({required String path}) async {
  final res = await Dio().get(path);
  var data = res.data['promotions'].map((promotion) {
    // print('promotion: ${promotion}');
    return Promotions.fromJson(promotion);
  });
  print('from get');
  allPromotions.clear();
  data.forEach((promotion) {
    // print(promotion['promotion']);
    // print(promotion.promotionTitle);
    allPromotions.add(
      {
        'promotionId': promotion.promotionId,
        'promotionTitle': promotion.promotionTitle,
        'promotionImage': promotion.promotionImage
      },
    );
    print('sss' + allPromotions.length.toString());
  });
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

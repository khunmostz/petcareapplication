import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:petcare_project/services/api_url.dart';
import 'package:petcare_project/services/services.dart';

class MapController extends GetxController {
  var userPosition;

  void onInit() async {
    super.onInit();
    await getUserPosition();
  }

  Future getUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((currentLo) async {
      userPosition = currentLo;
      print('--------------------------------------');
      await getRequest(path: API_URL.hostName, userPosition: userPosition);
    });
    update();
  }
}

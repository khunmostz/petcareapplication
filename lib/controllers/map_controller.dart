import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:petcare_project/controllers/content_controller.dart';
import 'package:petcare_project/services/api_url.dart';
import 'package:petcare_project/services/services.dart';

class MapController extends GetxController {
  final ContentController _contentController = Get.find<ContentController>();

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
    await getCurrentUser();

    update();
  }

  Future<dynamic> getCurrentUser() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((currentLo) async {
      userPosition = currentLo;
      print('--------------------------------------');
      print('param: ${_contentController.param}');
      await getRequestMap(
          path: API_URL.hostName +
              '/get/location/type/${_contentController.param}',
          userPosition: userPosition);
    });
  }
}

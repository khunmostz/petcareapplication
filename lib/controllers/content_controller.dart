import 'package:get/get.dart';
import 'package:petcare_project/controllers/map_controller.dart';
import 'package:petcare_project/services/api_url.dart';

class ContentController extends GetxController {
  String? param;

  Future<void> getParam(String type) async {
    param = type;
    print(param);
    update();
  }
}

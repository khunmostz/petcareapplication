import 'package:get/get.dart';
import 'package:petcare_project/services/api_url.dart';
import 'package:petcare_project/services/services.dart';

class ContentController extends GetxController {
  String? param;

  Future<void> getParam(String type) async {
    param = type;
    print(param);
    update();
  }

  Future<dynamic> allPromotion() async {
    allPromotions.clear();
    print("promotions: " + allPromotions.length.toString());
    await getPromotion(path: '${API_URL.hostName}/promotion/get');
  }
}

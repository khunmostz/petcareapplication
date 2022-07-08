import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BottomNavController extends GetxController {
  var selectIndex = 0.obs;
  void changIndex(int index) {
    selectIndex.value = index;
    update();
  }
}

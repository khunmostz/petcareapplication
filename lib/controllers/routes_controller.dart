import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BottomNavController extends GetxController {
  RxInt selectIndex = 0.obs;
  void changIndex(int index) {
    selectIndex.value = index;
  }
}

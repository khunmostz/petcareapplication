import 'package:get/get.dart';

class PetController extends GetxController {
  RxBool selected = false.obs;
  RxInt? selectId;
  void toggleWidget(RxInt? index) {
    selected.value = !selected.value;
    selectId = index;
    print(selected.toString());
    print(selectId);
    update();
  }
}

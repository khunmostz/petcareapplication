import 'package:get/get.dart';

class PetController extends GetxController {
  RxBool selected = true.obs;
  RxInt? selectId;
  void toggleWidget(RxInt? index) {
    selected.value = !selected.value;
    selectId = index;
    print(selected.toString());
    print(selectId);
    update();
  }
}

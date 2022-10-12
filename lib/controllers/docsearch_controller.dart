import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DocSearchController extends GetxController {
  List dataShow = [];
  List dataFromFirebase = [];

  List petShow = [];

  Future<void> fetchDataFromFirebase() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'User')
        .get();
    data.docs.forEach((element) {
      dataShow.add(element.data());
      dataFromFirebase.add(element.data());
      update();
    });
  }

  void onSearch(keyword) {
    dataShow = dataFromFirebase.where((element) {
      return (element['username'] as String).contains(keyword);
    }).toList();
    update();
  }

  Future<void> fetchPetUserById(String uid) async {
    // print(uid);
    petShow.clear();
    var data = await FirebaseFirestore.instance
        .collection('pets')
        .where('uid', isEqualTo: uid)
        .get();
    data.docs.forEach((element) {
      print(element['petName']);
      petShow.add(element.data());
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataFromFirebase();
  }
}

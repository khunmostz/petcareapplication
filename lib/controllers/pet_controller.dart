<<<<<<< HEAD
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
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetController extends GetxController {
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController foodController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  Future<void> addPet(String birdthday, String Vaccine) async {
    try {
      await FirebaseFirestore.instance
          .collection('pets')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'petName': petNameController.text.trim(),
        'type': typeController.text.trim(),
        'food': foodController.text.trim(),
        'weight': weightController.text.trim(),
        'gender': genderController.text.trim(),
        'birdthday': birdthday,
        'vaccine': Vaccine
      });
    } catch (e) {}
  }

  Future<void> updateImageProfile(String image) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'image': image,
      });
    } catch (e) {
      print(e);
      Get.snackbar(
        'แจ้งเตือน',
        'เกิดข้อผิดพลาด',
      );
    }
>>>>>>> forgotpage
  }
}

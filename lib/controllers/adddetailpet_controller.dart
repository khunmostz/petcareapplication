import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDetailPetController extends GetxController {
  final TextEditingController dateTimeController =
      TextEditingController(text: DateTime.now().toString().substring(0, 10));
  final TextEditingController desController = TextEditingController();

  Future<void> addPetTreat({required String petName}) async {
    try {
      await FirebaseFirestore.instance.collection('pettreat').add({
        'petName': petName,
        'date': dateTimeController.text.trim(),
        'description': desController.text.trim(),
      });
      Get.back();
      Get.snackbar(
        'แจ้งเตือน',
        'เพิ่มข้อมูลสำเร็จ',
      );
    } catch (e) {
      print(e);
    }
  }
}

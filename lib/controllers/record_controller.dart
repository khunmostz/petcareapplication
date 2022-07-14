import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RecordController extends GetxController {
  final TextEditingController particularController = TextEditingController();
  final TextEditingController payController = TextEditingController();

  Future<void> addRecord(String date) async {
    try {
      if (checkEmpty()) {
        await FirebaseFirestore.instance.collection('records').add({
          'particular': particularController.text,
          'pay': payController.text,
          'date': date
        });
        Get.snackbar('แจ้งเตือน', 'เพิ่มข้อมูลสำเร็จ');
        clearForm();
        return Get.back();
      } else {
        Get.snackbar('แจ้งเตือน', 'กรุณารอกข้อมูลให้ครบ');
      }
    } catch (e) {
      print(e);
    }
  }

  clearForm() {
    particularController.clear();
    payController.clear();
  }

  bool checkEmpty() {
    if (particularController.text.isEmpty || payController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

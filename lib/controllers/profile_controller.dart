import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var user;

  late final TextEditingController usernameController =
      TextEditingController(text: user['username'].toString());
  late final TextEditingController emailController =
      TextEditingController(text: user['email'].toString());
  late final TextEditingController telController =
      TextEditingController(text: user['tel'].toString());
  late final TextEditingController addressController =
      TextEditingController(text: user['address'].toString());

  Future<dynamic> getUserDetail() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get()
          .then((snapshot) {
        print(snapshot.docs[0].data());
        snapshot.docs.forEach((data) {
          user = data.data();
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'tel': telController.text.trim(),
        'address': addressController.text.trim(),
      });
      Get.snackbar(
        'แจ้งเตือน',
        'อัปเดทข้อมูลสำเร็จ',
      );
      Get.back();
    } catch (e) {
      print(e);
      Get.snackbar(
        'แจ้งเตือน',
        'เกิดข้อผิดพลาด',
      );
    }
    // print(FirebaseAuth.instance.currentUser!.);
  }
}

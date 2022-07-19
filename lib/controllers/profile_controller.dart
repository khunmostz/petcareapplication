import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var user;

  late final Rx<TextEditingController> usernameController =
      TextEditingController(text: user['username'].toString()).obs;
  late final Rx<TextEditingController> emailController =
      TextEditingController(text: user['email'].toString()).obs;
  late final Rx<TextEditingController> telController =
      TextEditingController(text: user['tel'].toString()).obs;
  late final Rx<TextEditingController> addressController =
      TextEditingController(text: user['address'].toString()).obs;

  File? image;

  Future<void> selectImageProfile() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _pickedImage = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 150,
      maxWidth: 150,
    );
    final ImageFile = File(_pickedImage!.path);
    image = ImageFile;
  }

  Future<Stream<dynamic>?> getUserDetail() async {
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
      update(['getUserDetail']);
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
        'username': usernameController.value.text.trim(),
        'email': emailController.value.text.trim(),
        'tel': telController.value.text.trim(),
        'address': addressController.value.text.trim(),
      });
      Get.snackbar(
        'แจ้งเตือน',
        'อัปเดทข้อมูลสำเร็จ',
      );
      update(['updateUser']);
      Get.back();
    } catch (e) {
      print(e);
      Get.snackbar(
        'แจ้งเตือน',
        'เกิดข้อผิดพลาด',
      );
    }
    print(FirebaseAuth.instance.currentUser!.uid);
  }
}

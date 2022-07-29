import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController extends GetxController {
  var user;

  final Rx<TextEditingController> usernameController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> telController = TextEditingController().obs;
  final Rx<TextEditingController> addressController =
      TextEditingController().obs;

  File? image;

  // @override
  // void onInit() async {
  //   super.onInit();
  //   await getUserDetail();
  //   print('pull data');
  // }

  Future<void> uploadImageProfile() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? _pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 150,
        maxWidth: 150,
      );
      if (_pickedImage != null) {
        final Rx<File> _imagePath = File(_pickedImage.path).obs;
        image = _imagePath.value;
      }

      uploadProfile(image!.path.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadProfile(String imagePath) async {
    var firebaseRef = await FirebaseStorage.instance
        .ref()
        .child('profile-image/${imagePath.split('/').last}');
    var uploadTask = firebaseRef.putFile(image!);
    var taskSnapshot = await uploadTask.whenComplete(() async {
      print('upload profile success');
      Get.snackbar('แจ้งเตือน', 'เปลี่ยนรูปภาพสำเร็จ');
    }).then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      print(imageUrl.toString());
      user['image'] = imageUrl;
      updateImageProfile(imageUrl.toString());
    });
  }

  Future<Stream<dynamic>?> getUserDetail() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get()
          .then((snapshot) async {
        print(snapshot.docs[0].data());
        snapshot.docs.forEach((data) {
          user = data.data();
          // print(user['email']);
          usernameController.value.text = user['username'].toString();
          emailController.value.text = user['email'].toString();
          telController.value.text = user['tel'].toString();
          addressController.value.text = user['address'].toString();
        });
      });
      update(['getUserDetail']);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> updateImageProfile(String image) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'image': image,
      });
      update(['updateProfile']);
    } catch (e) {
      print(e);
      Get.snackbar(
        'แจ้งเตือน',
        'เกิดข้อผิดพลาด',
      );
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
      Get.back();
      update(['updateUser']);
    } catch (e) {
      print(e);
      Get.snackbar(
        'แจ้งเตือน',
        'เกิดข้อผิดพลาด',
      );
    }
    // print(FirebaseAuth.instance.currentUser!.uid);
  }
}
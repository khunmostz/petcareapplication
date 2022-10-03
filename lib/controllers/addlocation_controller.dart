import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare_project/services/api_url.dart';
import 'package:petcare_project/services/services.dart';

class AddLocationController extends GetxController {
  final TextEditingController establishmentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameDoctorController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telController = TextEditingController();

  var urlFirebase;

  var dataCheck = '';

  File? image;

  void onInit() {
    super.onInit();
    fetchDoc();
  }

  Future<void> uploadLocationImage({required ImageSource imageSource}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? _pickedImage = await _picker.pickImage(
        source: imageSource,
        imageQuality: 50,
        maxHeight: 150,
        maxWidth: 150,
      );
      if (_pickedImage != null) {
        final Rx<File> _imagePath = File(_pickedImage.path).obs;
        image = _imagePath.value;
      }

      print('image: ${image}');
      update();

      uploadImage(image!.path.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadImage(String imagePath) async {
    var firebaseRef = await FirebaseStorage.instance
        .ref()
        .child('location-image-check/${imagePath.split('/').last}');
    var uploadTask = firebaseRef.putFile(image!);
    var taskSnapshot = await uploadTask.whenComplete(() async {
      print('upload location image success');
      // Get.snackbar('แจ้งเตือน', 'เปลี่ยนรูปภาพสำเร็จ');
    }).then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      // print(';djlksjfsalkfjklsdf: ${imageUrl.toString()}');

      // user['image'] = imageUrl;
      updateImageProfile(imageUrl.toString());
    });
  }

  Future<void> updateImageProfile(String image) async {
    // print(image);
    try {
      await FirebaseFirestore.instance
          .collection('doctor')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
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

  Future addDoctor() async {
    Timer _timer;

    _timer = Timer(Duration(seconds: 5), () {
      Get.back();
    });

    try {
      await getRequestAllMap(path: '${API_URL.hostName}/get/location');
      var result = allPlace.firstWhere(
          (element) => element == establishmentController.text,
          orElse: () => '');

      if (image == null) {
        Get.defaultDialog(
          title: "แจ้งเตือน",
          middleText: "กรุณาใส่รูปภาพ หรือ กรอกข้อมูลให้ถูกต้อง",
          radius: 30,
        );
      }
      if (result != '') {
        print('found' + result);

        FirebaseFirestore.instance
            .collection('doctor')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
              ({
                'image': '',
                'establishment': establishmentController.text.trim(),
                'nameDoctor': nameDoctorController.text.trim(),
                'email': emailController.text.trim(),
                'tel': telController.text.trim(),
              }),
            )
            .then((value) => {
                  print('success'),
                  dataCheck = 'have',
                  Get.defaultDialog(
                    title: "แจ้งเตือน",
                    middleText: "เพิ่มข้อมูลสำเร็จ",
                    radius: 30,
                  ).then((value) => Get.back()),
                  update(),
                  // Get.back(),
                });
      } else {
        print('nothinhg found');
        Get.defaultDialog(
          title: "ไม่พบสถานที",
          middleText: "กรุณาที่ต่อเจ้าหน้าที่ \n"
              "petcare@gmail.com",
          radius: 30,
        ).then((value) => Get.back());
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future fetchDoc() async {
    print('uid : ' + FirebaseAuth.instance.currentUser!.uid);
    // dataCheck.clear();
    var data = await FirebaseFirestore.instance
        .collection('doctor')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print("exists :" + data.exists.toString());
    if (data.exists) {
      dataCheck = 'have';
      update();
    } else {
      dataCheck = 'no';
      update();
    }
    print('=' * 100);
    print(dataCheck);
  }
}

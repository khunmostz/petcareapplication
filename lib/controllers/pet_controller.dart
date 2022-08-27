import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PetController extends GetxController {
  var pets;
  var docLength;

  var test = 0.obs;

  List data = [];

  List petName = [].obs;
  List petType = [].obs;
  List petSpecies = [].obs;
  List petGender = [].obs;
  List petBday = [].obs;
  List petVday = [].obs;
  List petImage = [].obs;
  List petWeight = [].obs;

  final TextEditingController idController = TextEditingController();
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  late String bday;
  late String vday;

  RxString birdthday = ''.obs;
  RxString vaccine = ''.obs;
  String? pathImageStore;

  File? image;

  Future<void> uploadImageProfile({required ImageSource imageSource}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? _pickedImage = await _picker.pickImage(
        source: imageSource,
        imageQuality: 100,
        maxHeight: 150,
        maxWidth: 150,
      );
      if (_pickedImage != null) {
        final Rx<File> _imagePath = File(_pickedImage.path).obs;
        image = _imagePath.value;
      }
      update(['chooseImage']);
      uploadProfile(image!.path.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadProfile(String imagePath) async {
    var firebaseRef = await FirebaseStorage.instance
        .ref()
        .child('pet-image/${imagePath.split('/').last}');
    var uploadTask = firebaseRef.putFile(image!);
    var taskSnapshot = await uploadTask.whenComplete(() async {
      print('upload profile success');
      Get.snackbar('แจ้งเตือน', 'เปลี่ยนรูปภาพสำเร็จ');
    }).then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      // print(imageUrl.toString())

      pathImageStore = imageUrl;
      // print('url : ${pathImageStore.toString()}');
    });
  }

  selectBirdthday(BuildContext context, date) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((value) {
      date = value;
      bday = date.toString();
      birdthday = bday.obs;

      if (birdthday != '') {
        print(birdthday.toString().substring(0, 10));
        update(['updateDay']);
      }
    });
  }

  selectVaccine(BuildContext context, date) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((value) {
      date = value;
      vday = date.toString();
      vaccine = vday.obs;

      if (vaccine != '') {
        print(birdthday.toString().substring(0, 10));
        update(['updateVaccine']);
      }
    });
  }

  Future<dynamic> getPet() async {
    petName = [].obs; // กันมันแสดง index ตัวแรก

    try {
      await FirebaseFirestore.instance
          .collection('pets')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          // .orderBy('createdAt', descending: true)
          .get()
          .then((value) async {
        value.docs.forEach((pet) {
          pets = pet.data();

          petImage.add(pets['image']);
          petName.add(pets['petName']);
          petType.add(pets['type']);
          petSpecies.add(pets['species']);
          petWeight.add(pets['weight']);
          petGender.add(pets['gender']);
          petBday.add(pets['birdthday']);
          petVday.add(pets['vaccine']);

          // petName.refresh();
        });
        print('pet controller' + petName.length.toString());
        docLength = value.docs.length;
        print(petType.length.toString());
        update(['getPets']);

        // print(data.toString());
      });
    } catch (e) {}
  }

  Future<dynamic> addPet(String birdthday, String vaccine, String image) async {
    try {
      await FirebaseFirestore.instance.collection('pets').doc().set({
        // 'id': idController.text.trim(),
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'image': image,
        'petName': petNameController.text.trim().toLowerCase(),
        'type': typeController.text.trim().toLowerCase(),
        'species': speciesController.text.trim().toLowerCase(),
        'weight': weightController.text.trim() + 'KG',
        'gender': genderController.text.trim().toLowerCase(),
        'birdthday': birdthday.substring(0, 10),
        'vaccine': vaccine.substring(0, 10),
      }).then((value) {
        petName.add(petNameController.text.trim());
        petImage.add(image);
        petType.add(typeController.text.trim());
        petSpecies.add(speciesController.text.trim());
        petWeight.add(weightController.text.trim());
        petGender.add(genderController.text.trim());
        petBday.add(pets['birdthday']);
        petVday.add(pets['vaccine']);

        docLength++;

        this.image = null;

        update(['addPets']);
        Get.back();
        Get.snackbar(
          'แจ้งเตือน',
          'เพิ่มข้อมูลสำเร็จ',
        );
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePetProfile(String image) async {
    try {
      await FirebaseFirestore.instance
          .collection('pets')
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
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RecordController extends GetxController {
  var pets;
  var date;
  var docLength = 0.obs;
  var recordDocLength;
  RxInt selectedIndex = 0.obs;
  var recordDataId = [].obs;
  var searchDataId = [].obs;

  List petName = [].obs;
  List petType = [];
  List petSpecies = [];
  List petGender = [];
  List petBday = [];
  List petVday = [];
  List petImage = [];
  List petWeight = [];

  final TextEditingController petNameController = TextEditingController();
  final TextEditingController particularController = TextEditingController();
  final TextEditingController payController = TextEditingController();

  void onInit() async {
    super.onInit();
    await getPet();
    print('from controller ${docLength.value}');
  }

  // void onReady() {
  //   super.onReady();

  // }

  Future<dynamic> getPet() async {
    print('xxxxxxxxx');
    petName = []; // กันมันแสดง index ตัวแรก

    try {
      await FirebaseFirestore.instance
          .collection('pets')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        docLength = value.docs.length.obs;
        print('getPets: ${docLength.toString()}');
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
          print("petName: ${petName.toString()}");
        });
      });
      update(['getPets']);
    } catch (e) {}
  }

  Future<dynamic> getRecordByName(String? nameIndex) async {
    recordDataId = [].obs;
    petNameController.text = nameIndex!;
    try {
      await FirebaseFirestore.instance
          .collection('records')
          .where('petname', isEqualTo: nameIndex)
          .get()
          .then((value) {
        recordDocLength = value.docs.length;

        print(recordDocLength.toString());
        value.docs.forEach((id) {
          recordDataId.add(id);
        });

        searchDataId = recordDataId;
        // recordDataId.where((element) => element['date']).contains(date);
        // print(
        //     'test ${recordDataId.where((element) => element['date']).contains(date).toString()}');
      });

      update(['getPetId']);
    } catch (e) {}
  }

  Future<void> addRecord(String date) async {
    try {
      if (checkEmpty()) {
        await FirebaseFirestore.instance.collection('records').add({
          'petname': petNameController.text.trim().toLowerCase(),
          'particular': particularController.text,
          'pay': payController.text,
          'date': date
        }).then((value) => Get.back());
        Get.snackbar('แจ้งเตือน', 'เพิ่มข้อมูลสำเร็จ');
        clearForm();

        update(['updateRecord']);
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

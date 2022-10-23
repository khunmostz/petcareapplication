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

  List petUid = [].obs;
  List petName = [].obs;
  List petType = [].obs;
  List petSpecies = [].obs;
  List petGender = [].obs;
  List petBday = [].obs;
  List petVday = [].obs;
  List petNeVday = [].obs;
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
  late String neday;

  RxString birdthday = ''.obs;
  RxString vaccine = ''.obs;
  RxString nevaccine = ''.obs;
  String? pathImageStore;

  File? image;

  List result = [];
  List showCate = [];
  List typeP = [
    {'id': 1, 'value': 'กบ'},
    {'id': 2, 'value': 'กระต่าย'},
    {'id': 3, 'value': 'กระรอก'},
    {'id': 4, 'value': 'กิ้งก่า'},
    {'id': 5, 'value': 'งู'},
    {'id': 6, 'value': 'ชูกาไรเดอร์'},
    {'id': 7, 'value': 'เต่า'},
    {'id': 8, 'value': 'นก'},
    {'id': 9, 'value': 'ปลา'},
    {'id': 10, 'value': 'เม่น'},
    {'id': 11, 'value': 'แมว'},
    {'id': 12, 'value': 'ลิง'},
    {'id': 13, 'value': 'หนู'},
    {'id': 14, 'value': 'หมา'},
    {'id': 15, 'value': 'อื่นๆ'}
  ];
  List<dynamic> typeCategories = [
    {
      'id': 'อื่นๆ',
      'type': [
        'ไม่รู้ (Unknown)',
      ]
    },
    {
      'id': 'กบ',
      'type': ['ไม่รู้ (Unknown)', 'ฮอร์นฟร็อก Horned Frogs']
    },
    {
      'id': 'กระต่าย',
      'type': [
        "ไม่รู้ (Unknown)",
        "กระต่ายไทย",
        "นิวซีแลนด์ ไวท์ แรบบิท",
        "ไลอ้อนเฮดท์",
        "เท็ดดี้แบร์",
        "เจอร์รี่วู๊ดดี้ทอย",
        "มินิล็อป",
        "ฮอลแลนด์ล็อป",
        "เฟรนซ์ล็อป",
        "อิงลิซล็อป",
        "ดัชต์",
        "มินิเร็กซ์",
        "โปลิส",
        "เนเธอร์แลนด์ดรอฟ"
      ]
    },
    {
      'id': 'กระรอก',
      'type': [
        "ไม่รู้ (Unknown)",
        "แพรีด็อก (Prairie Dog)",
      ]
    },
    {
      'id': 'กิ้งก่า',
      'type': [
        "ไม่รู้ (Unknown)",
        "กิ้งก่าทะเลทราย (Bearded Dragon)",
        "เวลล์คามิเลียน (Veiled Chameleon)",
        "อีกัวนา (lguana)"
      ]
    },
    {
      'id': 'งู',
      'type': [
        "ไม่รู้ (Unknown)",
        "คอร์นสเนค (Cornsnake)",
      ]
    },
    {
      'id': 'ชูกาไรเดอร์',
      'type': [
        "ไม่รู้ (Unknown)",
      ]
    },
    {
      'id': 'เต่า',
      'type': [
        "ไม่รู้ (Unknown)",
        "ซูลคาตา (Sulcata)",
      ]
    },
    {
      'id': 'นก',
      'type': [
        "ไม่รู้ (Unknown)",
        "คานารี่",
        "นกฟินซ์",
        "เลิฟเบิร์ด",
        "หงส์หยก",
        "ซัน คอนัวร์",
        "นกแก้วโนรี",
        "โรเซล่า",
        "กระตั้วกาล่า",
        "นกแก้วสกาเล็ต มาคอร์",
      ]
    },
    {
      'id': 'ปลา',
      'type': [
        "ไม่รู้ (Unknown)",
        "ปลาทอง",
        "ปลาหมอสี",
        "ปลาหางนกยูง",
        "ปลาสอด",
        "ปลากัด",
        "ปลานีออน",
        "ปลาเทวดา",
        "ปลาม้าลาย",
        "ปลาบอลลูน",
        "ปลาหมอแรมโบลิเวีย",
      ]
    },
    {
      'id': 'เม่น',
      'type': [
        "ไม่รู้ (Unknown)",
        "เม่นแคระ (Hedgehog)",
      ]
    },
    {
      'id': 'แมว',
      'type': [
        "ไม่รู้ (Unknown)",
        "เดวอน เร็กซ์",
        "เบงกอล",
        "เบอร์มิลลา",
        "เบอร์มีส",
        "เยอรมัน เร็กซ์",
        "เอเชียน",
        "แมงซ์",
        "โคราช",
        "โซโกเก"
            "โอเรียลทัล",
        "ขาวมณี",
        "คอร์นิช เร็กซ์",
        "คูริเลียน บ็อบเทล",
        "ซีย์เชลลอยส์",
        "ดอน สฟิงซ์",
        "ท็องกินิส",
        "บริติช ชอร์ตแฮร์",
        "บอมเบย์",
        "ปีเตอร์บัลด์",
        "พิกซีบ็อบ",
        "มันช์กิน",
        "รัสเซียน",
        "วิเชียรมาศ",
        "สโนว์ชู",
        "สิงหปุระ",
        "อเมริกัน เคิร์ล",
        "อเมริกัน ไวร์แฮร์",
        "อเมริกัน ชอร์ตแฮร์",
        "อเมริกัน บ็อบเทล",
        "อ็อกซิแคต",
        "ออสเตรเลียน มิสต์",
        "อะบิสซิเนียน",
        "เจแปนนีส บ็อบเทล",
        "เซลเกิร์ก เร็กซ์",
        "เตอร์กิช แวน",
        "เตอร์กิช แวนเคดิซี",
        "เตอร์กิช แองโกรา",
        "เมนคูน",
        "ชาร์เทรอ",
        "นอร์วีเจียน ฟอเรสต์",
        "แร็กดอล",
        "โซมาลี",
        "ไซบีเรียน",
        "ซาเคร็ด เบอร์แมน",
        "ซิมริค",
        "นีวา มาสเคอเรด",
        "รากามัฟฟิน",
        "ลาเปิร์ม",
        "สก็อตติช โฟลด์",
        "สก็อตติช สเตรท",
      ]
    },
    {
      'id': 'ลิง',
      'type': [
        "ไม่รู้ (Unknown)",
        "ทามาริน (Tamarin)",
        "มาโมเสท (Marmosets)",
      ]
    },
    {
      'id': 'หนู',
      'type': [
        "ไม่รู้ (Unknown)",
        "เจอร์บิล (Gerbil)",
        "ชินชิล่า (Chinchilla)",
        "หนูตะเภา (Guinea Pig)",
        "แฮมสเตอร์ (Hamster)",
      ]
    },
    {
      'id': 'หมา',
      'type': [
        "ไม่รู้ (Unknown)",
        "ร็อตไวเลอร์ (Rottweiler)"
            "โกลเด้น รีทรีฟเวอร์ (Golden Retriever)",
        "คอลลี่ (Collie)",
        "แจ็ครัสเซลล์ เทอร์เรีย (Jack Russell)",
        "ชเนาเซอร์ (Schnauzer)",
        "ชิวาวา (Chihuahua)",
        "ชิสุ (Shih tzu)",
        "เชา เชา (Chow Chow)",
        "ซามอยด์ (Samoyed)",
        "เซนต์เบอร์นาร์ด (Saint Bernard)",
        "ไซบีเรียน ฮัสกี้ (Siberian Husky)",
        "ดัชชุน (Dachshund)",
        "บอสตัน เทอร์เรีย (Boston Terrier)",
        "บิชอง ฟริเซ่ (Bichon Frise)",
        "บีเกิ้ล (Beagle)",
        "บูลด็อก (British Bulldog)",
        "บูลเทอร์เรีย (Bull Terrier)",
        "ปอมเมอเรเนียน (Pomeranian)",
        "ปั๊ก (Pug)",
        "ปาปิยอง (Papillon)",
        "พุดเดิ้ล (Poodle)",
        "เฟรนช์ บูลด็อก (French Bulldog)",
        "มอลทีส (Maltese)",
        "ยอร์คเชียร์ เทอร์เรีย (Yorkshire Terrier)",
        "ลาบราดอร์ (Labrador)",
        "เวลส์ คอร์กี้ (Welsh Corgi)",
        "เวสต์ ไฮแลนด์ ไวท์ เทอร์เรีย (West Highland White Terrier)",
        "สก็อตติช เทอร์เรียร์ (Scottish Terrier)",
        "อลาสกัน มาลามิวท์ (Alaskan Malamute)",
        "ออสเตรเลียน เชพเพิร์ด (Australian Shepherd)",
      ]
    },
  ];

  List genderList = ['ผู้', 'เมีย'];
  List weightList = [
    '1 - 5',
    '5 - 10',
    '10 - 15',
    '15 - 20',
    '20 - 25',
    '25 - 30',
    '30 - 35',
    '35 - 40',
    '40 - 45',
    '45 - 50',
    '50 - 55',
    '55 - 60',
  ];

  void onSelected(selected) {
    Map data = {};
    data = typeCategories.firstWhere((element) => element['id'] == selected);
    showCate = data['type'];
    print(showCate);

    update();
  }

  Future<void> uploadImageProfile({required ImageSource imageSource}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? _pickedImage = await _picker.pickImage(
        source: imageSource,
        imageQuality: 100,
        maxHeight: 500,
        maxWidth: 500,
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
      if (value == null) {
        print('-' * 100);
        var check = value.toString();
        // print(check);
        check = 'เลือกวันเกิด';
        // print(check);
        birdthday = check.obs;
        update(['updateVaccine']);
        return;
      }
      date = value;
      bday = date.toString();
      birdthday = bday.obs;

      if (birdthday != '') {
        // print(birdthday.toString().substring(0, 10));
        update(['updateDay']);
      }
    });
  }

  selectVaccine(BuildContext context, date) async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((value) {
      // print(value);
      if (value == null) {
        print('-' * 100);
        var check = value.toString();
        // print(check);
        check = 'ตารางวัคซีน';
        // print(check);
        vaccine = check.obs;
        update(['updateVaccine']);
        return;
      }
      date = value;
      vday = date.toString();
      vaccine = vday.obs;

      update(['updateVaccine']);
    });

    if (picker == null) return;

    ;
  }

  selectNextVaccine(BuildContext context, date) async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((value) {
      // print(value);
      if (value == null) {
        print('-' * 100);
        var check = value.toString();
        // print(check);
        check = 'ตารางวัคซีน';
        // print(check);
        nevaccine = check.obs;
        update(['updateNextVaccine']);
        return;
      }
      date = value;
      neday = date.toString();
      nevaccine = neday.obs;

      update(['updateNextVaccine']);
    });

    if (picker == null) return;

    ;
  }

  Future<dynamic> getPet() async {
    petName = [].obs; // กันมันแสดง index ตัวแรก
    petImage = [].obs;
    petType = [].obs;
    petWeight = [].obs;
    try {
      await FirebaseFirestore.instance
          .collection('pets')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        value.docs.forEach((pet) {
          pets = pet.data();

          // print('ssssssss: ${pets['uid']}');
          petUid.add(pets['uid']);
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
      await FirebaseFirestore.instance
          .collection('pets')
          .doc(petNameController.text.trim().toLowerCase())
          .set({
        // 'id': idController.text.trim(),
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'image': image,
        'petName': petNameController.text.trim().toLowerCase(),
        'type': typeController.text.trim().toLowerCase(),
        'species': speciesController.text.trim().toLowerCase(),
        'weight': weightController.text.trim() + ' กิโลกรัม',
        'gender': genderController.text.trim().toLowerCase(),
        'birdthday': birdthday.substring(0, 10),
        'vaccine': vaccine.substring(0, 10),
        'next-vaccine': nevaccine.substring(0, 10),
      }).then((value) {
        petName.add(petNameController.text.trim());
        petImage.add(image);
        petType.add(typeController.text.trim());
        petSpecies.add(speciesController.text.trim());
        petWeight.add(weightController.text.trim());
        petGender.add(genderController.text.trim());
        petBday.add(pets['birdthday']);
        petVday.add(pets['vaccine']);
        petNeVday.add(pets['next-vaccine']);
        // docLength++;

        this.image = null;
        petNameController.text = '';
        typeController.text = '';
        speciesController.text = '';
        weightController.text = '';
        genderController.text = '';
        birdthday = 'เลือกวันเกิด';
        vaccine = 'ตารางวัคซีน';
        // nevaccine = 'กำหนดการฉีดวัคซีน';
        update(['addPets']);
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

  Future<void> deletePet(String petname, int index) async {
    petName.removeAt(index);
    petImage.removeAt(index);
    petType.removeAt(index);
    petSpecies.removeAt(index);
    petWeight.removeAt(index);
    petGender.removeAt(index);
    petBday.removeAt(index);
    petVday.removeAt(index);
    try {
      await FirebaseFirestore.instance
          .collection('pets')
          .doc(petname.toLowerCase())
          .delete()
          .then((value) {
        Get.snackbar('แจ้งเตือน', 'ลบ ${petname} สำเร็จ');

        print('petName Length: ${petName.length}');
        update();
      });
    } catch (e) {
      print(e);
    }
  }

  // -------------------------------------------

  List treat = [];

  Future<void> fetchTreat({required String petName}) async {
    treat.clear();
    var data = await FirebaseFirestore.instance
        .collection('pettreat')
        // .orderBy('date', descending: true)
        .where('petName', isEqualTo: petName)
        .get();

    List test = [...data.docs];
    test = test.map((e) {
      var date = e.data()['date'];
      int year = int.parse(date.toString().split('-')[0]);
      int month = int.parse(date.toString().split('-')[1]);
      int day = int.parse(date.toString().split('-')[2]);
      print(date.toString());
      return {
        "data": e,
        "date": DateTime(year, month, day).millisecondsSinceEpoch,
      };
    }).toList();

    test.sort(((a, b) {
      return (b['date'] as int).compareTo((a['date'] as int));
    }));

    test.forEach((element) {
      // print(element['description']);
      treat.add(element['data'].data());
      update();
    });

    // data.docs.forEach((element) {
    //   // print(element['description']);
    //   treat.add(element.data());
    //   update();
    // });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var user;

  // Future<dynamic> getUserDocId() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
  //       .get()
  //       .then((snapshot) {
  //     snapshot.docs.forEach((data) {
  //       // print(data['email']);
  //     });
  //   });
  // }

  Future<dynamic> getUserDetail() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((data) {
        user = data.data();
      });
    });
  }
}

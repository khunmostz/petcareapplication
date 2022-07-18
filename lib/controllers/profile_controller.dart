import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var user;

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
          print(user['username']);
          // print('xxxxxzxczzxcxxxxxxxxxxxx');
          // print(FirebaseAuth.instance.currentUser!.email.toString());
        });
      });
    } catch (e) {
      print(e);
    }
  }
}

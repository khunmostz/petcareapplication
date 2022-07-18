import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

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
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUser() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc().update({
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'tel': telController.text.trim(),
        'address': addressController.text.trim(),
      });
    } catch (e) {
      print(e);
    }
  }
}

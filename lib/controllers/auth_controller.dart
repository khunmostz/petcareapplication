import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  var isLogin = false;
  // bool isEmpty = false;

  late Rx<User?> _user;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.userChanges());
    ever(_user, _authScreen);
  }

  _authScreen(User? user) {
    if (user == null) {
      // print('login page');
      Get.offAllNamed('/signin');
    } else {
      // print('content page');
      Get.offAllNamed('/bottomnav');
    }
  }

  bool checkPassword() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return false;
    } else {
      return true;
    }
  }

  bool checkEmpty() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future signIn() async {
    try {
      if (checkEmpty()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        clearForm();
      } else if (!checkEmpty()) {
        return Get.snackbar(
          'แจ้งเตือน',
          'กรุณากรอกข้อมูลให้ครบ',
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      Get.snackbar('เกิดข้อผิดพลาด', 'กรุณาลองใหม่อีกครั้ง');
    }
  }

  Future signUp(String type) async {
    try {
      if (checkPassword() || checkEmpty()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        addUserDetails(
          usernameController.text.trim(),
          emailController.text.trim(),
          type,
        );
        clearForm();
      } else if (checkEmpty()) {
        Get.snackbar('แจ้งเตือน', 'กรุณากรอกรหัสผ่านให้ตรงกัน');
      } else {
        Get.snackbar('แจ้งเตือน', 'กรุณากรอกข้อมูลให้ครบ');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return Get.snackbar(
              'เกิดข้อผิดพลาด', 'อีเมลนี้เชื่อมโยงกับบัญชีอื่นแล้ว');
          break;
      }
    }
  }

  Future addUserDetails(String username, String email, String type) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'username ': username,
        'email': email,
        'type': type,
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      Get.snackbar('เกิดข้อผิดพลาด', 'กรุณาลองใหม่อีกครั้ง');
    }
  }

  clearForm() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    usernameController.clear();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future passwordReset(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Get.snackbar('เกิดข้อผิดพลาด', 'กรุณาลองใหม่อีกครั้ง');
    }
  }
}

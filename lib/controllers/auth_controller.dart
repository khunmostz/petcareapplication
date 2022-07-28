import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcare_project/controllers/profile_controller.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController forgotController = TextEditingController();

  var _profileController = Get.put(ProfileController());

  var isLogin = false;

  late Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.userChanges());
    ever(_user, _authScreen);
  }

  _authScreen(User? user) {
    if (user == null) {
      print('login page');
      Get.offAllNamed('/signin');
    } else {
      print('content page');
      _profileController.getUserDetail();
      Get.offAllNamed('/bottomnav');
      //   Future.delayed(
      //       Duration(milliseconds: 350), () => );
    }
  }

  Future signIn(GlobalKey<FormState> key) async {
    try {
      if (!key.currentState!.validate()) {
        return;
      } else {
        key.currentState!.save();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        clearForm();
        Get.offAllNamed('/bottomnav');
      }
      return;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "user-not-found":
          return Get.snackbar('เกิดข้อผิดพลาด', 'ไม่พบข้อมูลในระบบ');
        case "wrong-password":
          return Get.snackbar('เกิดข้อผิดพลาด', 'บัญชีหรือรหัสผ่านผิดพลาด');
        default:
      }
    }
  }

  Future signUp(String type, GlobalKey<FormState> key) async {
    try {
      if (!key.currentState!.validate()) {
        return;
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        addUserDetails(
          usernameController.text.trim(),
          emailController.text.trim(),
          type,
        );
        clearForm();
        Get.offAllNamed('/bottomnav');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return Get.snackbar(
              'เกิดข้อผิดพลาด', 'อีเมลนี้เชื่อมโยงกับบัญชีอื่นแล้ว');
      }
    }
  }

  Future addUserDetails(String username, String email, String type) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(
            FirebaseAuth.instance.currentUser!.uid,
          )
          .set({
        'image': '',
        'username': username,
        'email': email,
        'type': type,
        'tel': '',
        'address': '',
      });
    } on FirebaseAuthException catch (e) {
      print(e.email);
      // switch (e.email) {
      //   case "invalid-email":
      //     return print('xxx');
      //     break;
      //   default:
      // }
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future passwordReset(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      Get.snackbar('แจ้งเตือน', 'โปรดช็คอีเมล');
      print(email);
      forgotController.clear();
      Get.toNamed('/signin');
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

  // ----------------- validator ------------------//

  EmailValidator(String value) {
    if (!GetUtils.isEmail(value)) {
      return "กรุณากรอกรูปแบบอีเมล์ให้ถูกต้อง";
    }
    return null;
  }

  PasswordValidator(String value) {
    if (value.length < 8) {
      return "กรุณากรอกรหัสผ่าน 8 ตัวขึ้นไป";
    }
    return null;
  }

  checkPassword(String value) {
    if (value != passwordController.text.trim()) {
      return "กรุณากรอกรหัสผ่านให้ตรงกัน";
    }
    return null;
  }
}

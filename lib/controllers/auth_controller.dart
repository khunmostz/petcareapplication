import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
=======
import 'package:petcare_project/controllers/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> forgotpage

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

<<<<<<< HEAD
  var isLogin = false;
  // bool isEmpty = false;

  late Rx<User?> _user;

  @override
  void onInit() {
    super.onInit();
  }
=======
  final TextEditingController forgotController = TextEditingController();

  var _profileController = Get.put(ProfileController());

  var isLogin = false;

  late Rx<User?> user;
>>>>>>> forgotpage

  @override
  void onReady() {
    super.onReady();
<<<<<<< HEAD
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
=======
    user = Rx<User?>(FirebaseAuth.instance.currentUser);
    user.bindStream(FirebaseAuth.instance.userChanges());
    ever(user, _authScreen);
  }

  _authScreen(User? user) async {
    if (user == null) {
      SharedPreferences myPrefs = await SharedPreferences.getInstance();
      bool? checkPage = myPrefs.getBool("isFirstRun");
      if (checkPage == null || checkPage == true) {
        print('iffffffffffffffff');
        Get.toNamed("/before");
      } else {
        print('eeeeeeeeeeeeeeeeffffffffffffffff');
        Get.toNamed("/signin");
      }

      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    } else {
      print('content page');
      _profileController.getUserDetail();
      Get.offAllNamed('/bottomnav');
      // Future.delayed(
      //     Duration(milliseconds: 350), () => );
    }
  }

  Future signIn(GlobalKey<FormState> key) async {
    try {
      if (!key.currentState!.validate()) {
        return;
      } else {
        key.currentState!.save();
>>>>>>> forgotpage
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        clearForm();
<<<<<<< HEAD
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
=======
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
>>>>>>> forgotpage
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        addUserDetails(
          usernameController.text.trim(),
          emailController.text.trim(),
          type,
        );
        clearForm();
<<<<<<< HEAD
      } else if (checkEmpty()) {
        Get.snackbar('แจ้งเตือน', 'กรุณากรอกรหัสผ่านให้ตรงกัน');
      } else {
        Get.snackbar('แจ้งเตือน', 'กรุณากรอกข้อมูลให้ครบ');
=======
        Get.offAllNamed('/bottomnav');
>>>>>>> forgotpage
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return Get.snackbar(
              'เกิดข้อผิดพลาด', 'อีเมลนี้เชื่อมโยงกับบัญชีอื่นแล้ว');
<<<<<<< HEAD
          break;
=======
>>>>>>> forgotpage
      }
    }
  }

  Future addUserDetails(String username, String email, String type) async {
    try {
<<<<<<< HEAD
      await FirebaseFirestore.instance.collection('users').add({
        'username': username,
        'email': email,
        'type': type,
      });
    } on FirebaseAuthException catch (e) {
=======
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
>>>>>>> forgotpage
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

<<<<<<< HEAD
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
=======
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
>>>>>>> forgotpage
  }
}

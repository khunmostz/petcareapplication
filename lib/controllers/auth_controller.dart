import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  var isLogin = false;

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
      Get.offAllNamed('/content');
    }
  }

  Future signIn() async {
    if (emailController.text.isEmpty || emailController.text.isEmpty) {
      return Get.snackbar(
        'แจ้งเตือน',
        'กรุณากรอกข้อมูลให้ครบ',
      );

      // Get.defaultDialog(
      //   title: 'เกิดข้อผิดพลาด',
      //   content: Text('กรุณาลองใหม่อีกครั้ง'),
      //   actions: [
      //     FlatButton(
      //       child: Text('ยืนยัน'),
      //       onPressed: () => Get.back(),
      //     ),
      //   ],
      // );
    } else {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
    // print(emailController.text);
  }

  Future signUp() async {
    if (emailController.text.isEmpty || emailController.text.isEmpty) {
      return Get.snackbar(
        'แจ้งเตือน',
        'กรุณากรอกข้อมูลให้ครบ',
        backgroundColor: Colors.red,
      );
    } else {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
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

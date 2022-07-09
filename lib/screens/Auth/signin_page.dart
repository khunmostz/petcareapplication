import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:petcare_project/controllers/auth_controller.dart';
import 'package:petcare_project/screens/Auth/Widget/signin_container.dart';
import 'package:petcare_project/utils/constant.dart';

import '../../GlobalWidget/custom_button.dart';
import 'Widget/auth_textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    AnimationController? _controller;

    void initState() {
      super.initState();
      _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
    }

    return Scaffold(
      backgroundColor: kDefualtColorMain,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.4,
              child: Image.asset('assets/image/logo-petcare-white.png'),
            ),
            SignInContainer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../utils/constant.dart';
import 'Widget/signup_container.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: kDefualtColorMain,
      minimumSize: Size(size.width, 50),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: kDefualtColorMain,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.4,
              child: Image.asset(
                'assets/image/logo-petcare-white.png',
              ),
            ),
            SignUpContainer(),
          ],
        ),
      ),
    );
  }
}

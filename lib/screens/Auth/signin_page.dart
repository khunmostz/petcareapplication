import 'package:flutter/material.dart';
import 'package:petcare_project/screens/Auth/Widget/signin_container.dart';
import 'package:petcare_project/utils/constant.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

<<<<<<< HEAD
class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
=======
class _SignInPageState extends State<SignInPage> {
>>>>>>> forgotpage
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

<<<<<<< HEAD
    AnimationController? _controller;

    void initState() {
      super.initState();
      _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
    }

=======
>>>>>>> forgotpage
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

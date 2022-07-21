import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcare_project/controllers/auth_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/custom_button.dart';
import 'auth_textfield.dart';

class SignInContainer extends StatefulWidget {
  @override
  State<SignInContainer> createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer> {
  final AuthController _authController = Get.put(AuthController());

  @override
  void dispose() {
    super.dispose();
    // _authController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefualtPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // username textfield
            Text(
              'Username',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            AuthTextField(
              hintText: 'example@gmail.com',
              controller: _authController.emailController,
            ),
            SizedBox(height: 20),
            Text(
              'Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // password textfield
            AuthTextField(
              obscureText: true,
              hintText: '********',
              controller: _authController.passwordController,
            ),
            SizedBox(height: 10),
            SizedBox(height: 25),
            CustomButton(
              text: 'Sign In',
              onPressed: () async {
               await _authController
                    .signIn()
                    .then((value) => Get.offAllNamed('/bottomnav'));
              },
            ),
            SizedBox(height: 20),
            // forgot pass
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Don't have an account ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/signup'),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: kDefualtColorMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

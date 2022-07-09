import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../GlobalWidget/custom_button.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/constant.dart';
import 'auth_textfield.dart';

class SignInContainer extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

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
                controller: _authController.emailController),
            SizedBox(height: 20),
            Text('Password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 10),
            AuthTextField(
                obscureText: true,
                hintText: '********',
                controller: _authController.passwordController),
            SizedBox(height: 10),
            SizedBox(height: 25),
            CustomButton(routeName: '/bottomnav', text: 'Sign'),
            SizedBox(height: 20),
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

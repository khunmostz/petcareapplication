import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../GlobalWidget/custom_button.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/constant.dart';
import 'auth_textfield.dart';

class SignUpContainer extends StatefulWidget {
  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  final AuthController _authController = Get.put(AuthController());
  List _dropdownValue = ['User', 'Doctor'];
  Object? _iniialValue = 'User';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(),
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
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'John Doe',
              ),
            ),
            Text(
              'Email',
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
            Text(
              'Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: '*************',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Types',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            DropdownButton(
              value: _iniialValue,
              // isExpanded: true,
              items: _dropdownValue.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _iniialValue = value as String;
                });
              },
            ),
            SizedBox(height: 25),
            CustomButton(routeName: '/signup', text: 'SignUp'),
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
                  "Already have an account ?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/signin');
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: kDefualtColorMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

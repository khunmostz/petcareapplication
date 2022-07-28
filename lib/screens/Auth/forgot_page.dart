import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/auth_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/custom_button.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height,
            child: Container(
              color: Colors.white,
            ),
          ),

          // forgot password
          Positioned(
            width: size.width,
            height: size.height * 0.3,
            child: Container(
              decoration: BoxDecoration(
                color: kDefualtColorMain,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Forgot Password',
                    style: GoogleFonts.mitr(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Please enter your email',
                    style: GoogleFonts.mitr(
                      fontSize: 14,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // textfield
          Positioned(
              top: 250,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                child: TextFormField(
                  controller: _authController.forgotController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: 'example@test.com',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: ((value) {
                    _authController.EmailValidator(value!);
                  }),
                ),
              )),

          // accepth button
          Positioned(
            top: 400,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
              child: CustomButton(
                text: 'Accepth',
                onPressed: () => _authController.passwordReset(
                  _authController.forgotController.text.trim(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/auth_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/custom_button.dart';
import 'auth_textfield.dart';

class SignInContainer extends StatefulWidget {
  @override
  State<SignInContainer> createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer> {
  final AuthController _authController = Get.find<AuthController>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // username textfield
              Row(
                children: [
                  Text(
                    'Email',
                    style: GoogleFonts.mitr(
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    ' *',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              AuthTextField(
                hintText: 'example@gmail.com',
                controller: _authController.emailController,
                validator: (value) {
                  return _authController.EmailValidator(value!);
                },
                onSaved: (value) {
                  _authController.emailController.text = value!;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Password',
                    style: GoogleFonts.mitr(
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    ' * 8 ตัวขึ้นไป',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // password textfield
              AuthTextField(
                obscureText: true,
                hintText: '********',
                controller: _authController.passwordController,
                validator: (value) {
                  return _authController.PasswordValidator(value!);
                },
                onSaved: (value) {
                  _authController.passwordController.text = value!;
                },
              ),
              SizedBox(height: 10),
              SizedBox(height: 25),
              CustomButton(
                text: 'Sign In',
                onPressed: () async {
                  await _authController.signIn(_formKey);
                },
              ),
              SizedBox(height: 20),
              // forgot pass
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Get.toNamed('/forgot'),
                  child: Text(
                    'Forgot Password ?',
                    style: GoogleFonts.mitr(),
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
                    style: GoogleFonts.mitr(),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/signup'),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.mitr(
                        color: kDefualtColorMain,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

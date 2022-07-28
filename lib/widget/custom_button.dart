import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/auth_controller.dart';
import 'package:petcare_project/utils/constant.dart';

class CustomButton extends StatelessWidget {
  final String? routeName;
  final String? text;
  final Function()? onPressed;
  const CustomButton({Key? key, this.routeName, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
<<<<<<< HEAD
    final AuthController _authController = Get.put(AuthController());
=======
>>>>>>> forgotpage
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: kDefualtColorMain,
      minimumSize: Size(size.width, 50),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
    return ElevatedButton(
      style: buttonStyle,
      onPressed: () {
<<<<<<< HEAD
        // Get.toNamed(routeName);
=======
>>>>>>> forgotpage
        onPressed?.call();
        // print(onPressed!());
      },
      child: Text(
        text!,
        style: GoogleFonts.mitr(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcare_project/utils/constant.dart';

class CustomButton extends StatelessWidget {
  final String routeName;
  final String text;
  const CustomButton({Key? key, required this.routeName, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
        Get.toNamed(routeName);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

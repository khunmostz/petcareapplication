import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:petcare_project/widget/custom_button.dart';

import '../../utils/constant.dart';

class BeforePage extends StatefulWidget {
  const BeforePage({Key? key}) : super(key: key);

  @override
  State<BeforePage> createState() => _BeforePageState();
}

class _BeforePageState extends State<BeforePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _controller.dispose();
  }

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Spacer(),
          Lottie.asset(
            'assets/lottie/blackcat.json',
            repeat: true,
            frameRate: FrameRate(240),
          ),
          Spacer(),
          // title
          Container(
            width: double.infinity,
            height: size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.black,
                  ]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(kDefualtPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Box
                  TweenAnimationBuilder(
                    child: Text(
                      "Do you want ?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    duration: Duration(seconds: 2),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (BuildContext context, double _var, child) {
                      return Opacity(
                        opacity: _var,
                        child: Padding(
                          padding: EdgeInsets.only(top: _var * 20),
                          child: child,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 25),
                  // Sign In button
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      Get.toNamed('/signin');
                    },
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.mitr(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Sign Up button
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      Get.toNamed('/signup');
                    },
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.mitr(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Already a member ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member ?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/signin');
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: kDefualtColorMain,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

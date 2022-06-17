import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant.dart';

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
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Spacer(),
          Lottie.asset(
            'assets/lottie/blackcat.json',
            controller: _controller,
            frameRate: FrameRate(240),
            onLoaded: (composition) {
              _controller.repeat();
            },
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
                  Text(
                    "Do you want ?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // Sign In button
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Sign Up button
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
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
                      Text(
                        "Sign In",
                        style: TextStyle(
                          color: kDefualtColorMain,
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

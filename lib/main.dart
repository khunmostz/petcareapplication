import 'package:flutter/material.dart';
import 'package:petcare_project/page/before_page.dart';
import 'package:petcare_project/page/content_page.dart';
import 'package:petcare_project/page/mypet_page.dart';
import 'package:petcare_project/page/profile_page.dart';
import 'package:petcare_project/page/record_page.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/utils/route.dart';
import 'package:petcare_project/page/signin_page.dart';
import 'package:petcare_project/page/signup_page.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.orange,
          ),
        ),
        home: SplashScreenView(
          navigateRoute: BeforePage(),
          duration: 3000,
          imageSize: 400,
          imageSrc: "assets/image/logo-petcare.png",
          backgroundColor: Colors.white,
        ),
        routes: {
          '/signin': (context) => SignInPage(),
          '/signup': (context) => SignUpPage(),
          '/route': (context) => RoutePage(),
          '/content': (context) => ContentPage(),
          '/record': (context) => RecordPage(),
          '/mypet': (context) => MyPetPage(),
          '/profile': (context) => ProfilePage(),
        });
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/screens/Auth/before_page.dart';
import 'package:petcare_project/utils/routes.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashScreenView(
        navigateRoute: BeforePage(),
        duration: 3000,
        imageSize: 400,
        imageSrc: "assets/image/logo-petcare.png",
        backgroundColor: Colors.white,
      ),
      getPages: Routes.allRoutes,
    );
  }
}

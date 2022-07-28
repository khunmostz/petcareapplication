import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/screens/Auth/before_page.dart';
=======
import 'package:petcare_project/controllers/auth_controller.dart';
import 'package:petcare_project/screens/Auth/before_page.dart';
import 'package:petcare_project/utils/bottomnav.dart';
>>>>>>> forgotpage
import 'package:petcare_project/utils/routes.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

<<<<<<< HEAD
class MyApp extends StatelessWidget {
=======
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // var _authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

>>>>>>> forgotpage
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashScreenView(
<<<<<<< HEAD
        navigateRoute: BeforePage(),
=======
        navigateRoute: CheckPage(),
>>>>>>> forgotpage
        duration: 3000,
        imageSize: 400,
        imageSrc: "assets/image/logo-petcare.png",
        backgroundColor: Colors.white,
      ),
      getPages: Routes.allRoutes,
    );
<<<<<<< HEAD
=======
  }
}

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  void initState() {
    super.initState();
    var _authController = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
>>>>>>> forgotpage
  }
}

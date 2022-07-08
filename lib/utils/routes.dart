import 'package:get/get.dart';
import 'package:petcare_project/screens/before_page.dart';
import 'package:petcare_project/screens/content_page.dart';
import 'package:petcare_project/screens/mypet_page.dart';
import 'package:petcare_project/screens/profile_page.dart';
import 'package:petcare_project/screens/record_page.dart';
import 'package:petcare_project/screens/signin_page.dart';
import 'package:petcare_project/screens/signup_page.dart';
import 'package:petcare_project/utils/bottomnav.dart';

class Routes {
  static String initialPage = '/before';
  static List<GetPage> allRoutes = [
    GetPage(name: '/before', page: () => BeforePage()),
    GetPage(name: '/signin', page: () => SignInPage()),
    GetPage(name: '/signup', page: () => SignUpPage()),
    GetPage(name: '/bottomnav', page: () => BottomNav()),
    GetPage(name: '/content', page: () => ContentPage()),
    GetPage(name: '/record', page: () => RecordPage()),
    GetPage(name: '/mypet', page: () => MyPetPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
  ];
}

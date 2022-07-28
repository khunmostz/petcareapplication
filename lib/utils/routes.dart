import 'package:get/get.dart';
import 'package:petcare_project/screens/Auth/before_page.dart';
<<<<<<< HEAD
=======
import 'package:petcare_project/screens/Auth/forgot_page.dart';
>>>>>>> forgotpage
import 'package:petcare_project/screens/Auth/signin_page.dart';
import 'package:petcare_project/screens/Auth/signup_page.dart';
import 'package:petcare_project/screens/Content/content_page.dart';
import 'package:petcare_project/screens/Pet/mypet_page.dart';
<<<<<<< HEAD
import 'package:petcare_project/screens/Profile/profile_page.dart';
import 'package:petcare_project/screens/Record/record_page.dart';

=======
import 'package:petcare_project/screens/Pet/petdetail_page.dart';
import 'package:petcare_project/screens/Profile/profile_page.dart';
import 'package:petcare_project/screens/Record/record_page.dart';
>>>>>>> forgotpage
import 'package:petcare_project/utils/bottomnav.dart';

class Routes {
  static String initialPage = '/before';
  static List<GetPage> allRoutes = [
    GetPage(name: '/before', page: () => BeforePage()),
    GetPage(name: '/signin', page: () => SignInPage()),
    GetPage(name: '/signup', page: () => SignUpPage()),
<<<<<<< HEAD
    GetPage(name: '/bottomnav', page: () => BottomNav()),
    GetPage(name: '/content', page: () => ContentPage()),
    GetPage(name: '/record', page: () => RecordPage()),
=======
    GetPage(name: '/forgot', page: () => ForgotPage()),
    GetPage(name: '/bottomnav', page: () => BottomNav()),
    GetPage(name: '/content', page: () => ContentPage()),
    GetPage(name: '/record', page: () => RecordPage()),
    GetPage(name: '/petdetail', page: () => PetDetailPage()),
>>>>>>> forgotpage
    GetPage(name: '/mypet', page: () => MyPetPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
  ];
}

import 'package:get/get.dart';
import 'package:petcare_project/screens/Auth/before_page.dart';
import 'package:petcare_project/screens/Auth/forgot_page.dart';
import 'package:petcare_project/screens/Auth/signin_page.dart';
import 'package:petcare_project/screens/Auth/signup_page.dart';
import 'package:petcare_project/screens/Content/content_page.dart';
import 'package:petcare_project/screens/Content/location_page.dart';
import 'package:petcare_project/screens/Content/maps_page.dart';
import 'package:petcare_project/screens/Content/showsearch_page.dart';
import 'package:petcare_project/screens/Doctor/adddetailpet.dart';
import 'package:petcare_project/screens/Doctor/addlocation_page.dart';
import 'package:petcare_project/screens/Doctor/docsearch.dart';
import 'package:petcare_project/screens/Doctor/userdetail.dart';
import 'package:petcare_project/screens/Pet/mypet_page.dart';
import 'package:petcare_project/screens/Pet/petdetail_page.dart';
import 'package:petcare_project/screens/Pet/re_petdetail_page.dart';
import 'package:petcare_project/screens/Profile/profile_page.dart';
import 'package:petcare_project/screens/Record/record_page.dart';
import 'package:petcare_project/utils/bottomnav.dart';

class Routes {
  static String initialPage = '/before';
  static List<GetPage> allRoutes = [
    GetPage(name: '/before', page: () => BeforePage()),
    GetPage(name: '/signin', page: () => SignInPage()),
    GetPage(name: '/signup', page: () => SignUpPage()),
    GetPage(name: '/forgot', page: () => ForgotPage()),
    GetPage(name: '/bottomnav', page: () => BottomNav()),
    GetPage(name: '/content', page: () => ContentPage()),
    GetPage(name: '/mappage', page: () => MapsPage()),
    GetPage(name: '/record', page: () => RecordPage()),
    GetPage(name: '/locationpage', page: () => LocationPage()),
    GetPage(name: '/petdetail', page: () => PetDetailPage()),
    GetPage(name: '/mypet', page: () => MyPetPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
    GetPage(name: '/showsearch', page: () => ShowSearch()),
    GetPage(name: '/addlocation', page: () => AddLocationPage()),
    GetPage(name: '/docseach', page: () => DocSearch()),
    GetPage(name: '/userdetail', page: () => UserDetail()),
    GetPage(name: '/adddetailpet', page: () => AddDetailPet()),
    GetPage(name: '/repetdetail', page: () => RePetDetailPage()),
  ];
}

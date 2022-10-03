import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petcare_project/animations/dogsearch_animation.dart';
import 'package:petcare_project/controllers/addlocation_controller.dart';
import 'package:petcare_project/controllers/content_controller.dart';
import 'package:petcare_project/controllers/docsearch_controller.dart';
import 'package:petcare_project/controllers/profile_controller.dart';
import 'package:petcare_project/controllers/record_controller.dart';
import 'package:petcare_project/screens/Content/content_page.dart';
import 'package:petcare_project/screens/Doctor/docsearch.dart';
import 'package:petcare_project/screens/Pet/mypet_page.dart';
import 'package:petcare_project/screens/Profile/profile_page.dart';
import 'package:petcare_project/screens/Record/record_page.dart';
import 'constant.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var _selectedIndex = 0;
  final ProfileController _profileController = Get.find<ProfileController>();
  final RecordController _recordController = Get.put(RecordController());
  final AddLocationController _addLocationController =
      Get.put(AddLocationController());

  final DocSearchController _docSearchController =
      Get.put(DocSearchController());
  final DogSearchAniamtion _aniamtion = Get.put(DogSearchAniamtion());

  final screenUser = [
    ContentPage(),
    RecordPage(),
    MyPetPage(),
    ProfilePage(),
  ];
  final screenHospitalH = [
    ContentPage(),
    DocSearch(),
    ProfilePage(),
  ];
  final screenHospitalNH = [
    ContentPage(),
    ProfilePage(),
  ];

  final controllerPage = [
    ContentController(),
  ];

  final tabUser = [
    GButton(
      icon: Icons.home,
      text: "หน้าหลัก",
    ),
    GButton(
      icon: Icons.article,
      text: "ค่าใช้จ่าย",
    ),
    GButton(
      icon: Icons.pets,
      text: "สัตว์เลี้ยง",
    ),
    GButton(
      icon: Icons.person,
      text: "บัญชี",
    ),
  ];
  final tabHospitalH = [
    GButton(
      icon: Icons.home,
      text: "หน้าหลัก",
    ),
    GButton(
      icon: Icons.healing,
      text: "การรักษา",
    ),
    GButton(
      icon: Icons.person,
      text: "บัญชี",
    ),
  ];
  final tabHospitalNH = [
    GButton(
      icon: Icons.home,
      text: "หน้าหลัก",
    ),
    GButton(
      icon: Icons.person,
      text: "บัญชี",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: GetBuilder<ProfileController>(
        id: 'getUserDetail',
        builder: (_) {
          if (_profileController.userType.value == 'User') {
            return Container(
              width: size.width,
              color: kDefualtColorMain,
              child: Padding(
                padding: const EdgeInsets.all(kDefualtPadding / 2),
                child: GNav(
                  backgroundColor: kDefualtColorMain,
                  color: Colors.white,
                  activeColor: Colors.white,
                  tabBackgroundColor: Colors.black38,
                  gap: 7,
                  padding: EdgeInsets.all(16),
                  style: GnavStyle.google,
                  onTabChange: (index) {
                    // print(index);
                    setState(() {
                      _selectedIndex = index;
                      if (_selectedIndex == 1) {
                        print('record');
                        _recordController.getPet();
                      }
                    });
                  },
                  tabs: tabUser,
                ),
              ),
            );
          } else {
            return GetBuilder<AddLocationController>(builder: (_) {
              return Container(
                width: size.width,
                color: kDefualtColorMain,
                child: Padding(
                  padding: const EdgeInsets.all(kDefualtPadding / 2),
                  child: GNav(
                    backgroundColor: kDefualtColorMain,
                    color: Colors.white,
                    activeColor: Colors.white,
                    tabBackgroundColor: Colors.black38,
                    gap: 7,
                    padding: EdgeInsets.all(16),
                    style: GnavStyle.google,
                    onTabChange: (index) {
                      // print(index);
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    tabs: _addLocationController.dataCheck == 'have'
                        ? tabHospitalH
                        : tabHospitalNH,
                  ),
                ),
              );
            });
          }
        },
      ),
      body: Builder(
        builder: ((_) {
          if (_profileController.userType.value == 'User') {
            return GetBuilder<ProfileController>(
                id: 'getUserDetail',
                builder: (context) {
                  return IndexedStack(
                      index: _selectedIndex, children: screenUser);
                });
          } else {
            return GetBuilder<AddLocationController>(builder: (_) {
              return IndexedStack(
                  index: _selectedIndex,
                  children: _addLocationController.dataCheck == 'have'
                      ? screenHospitalH
                      : screenHospitalNH);
            });
          }
        }),
      ),
    );
  }
}

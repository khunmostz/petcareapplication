import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petcare_project/controllers/content_controller.dart';
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

  final screenUser = [
    ContentPage(),
    RecordPage(),
    MyPetPage(),
    ProfilePage(),
  ];
  final screenHospital = [
    ContentPage(),
    DocSearch(),
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
  final tabHospital = [
    GButton(
      icon: Icons.home,
      text: "หน้าหลัก",
    ),
    GButton(
      icon: Icons.healing,
      text: "คนรักษา",
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
                  tabs: tabHospital,
                ),
              ),
            );
          }
        },
      ),
      body: GetBuilder<ProfileController>(
        id: 'getUserDetail',
        builder: ((_) {
          if (_profileController.userType.value == 'User') {
            return IndexedStack(index: _selectedIndex, children: screenUser);
          } else {
            return IndexedStack(
                index: _selectedIndex, children: screenHospital);
          }
        }),
      ),
    );
  }
}

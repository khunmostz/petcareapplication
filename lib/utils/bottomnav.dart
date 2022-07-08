import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petcare_project/controllers/bottomnav_controller.dart';
import 'package:petcare_project/screens/content_page.dart';
import 'package:petcare_project/screens/mypet_page.dart';
import 'package:petcare_project/screens/profile_page.dart';
import 'package:petcare_project/screens/record_page.dart';
import 'package:petcare_project/utils/routes.dart';
import 'constant.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  // var _selectedIndex = 0;
  final _controller = Get.put(BottomNavController());
  final screen = [
    ContentPage(),
    RecordPage(),
    MyPetPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
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
              _controller.changIndex(index);
            },
            tabs: const [
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
                text: "บัญชีผู้ใช้",
              ),
            ],
          ),
        ),
      ),
      body: GetX<BottomNavController>(
        init: BottomNavController(),
        initState: (_) {},
        builder: (_) {
          return IndexedStack(
            index: _controller.selectIndex.value,
            children: screen,
          );
        },
      ),
    );
  }
}

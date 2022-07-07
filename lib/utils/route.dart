import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petcare_project/screens/content_page.dart';
import 'package:petcare_project/screens/mypet_page.dart';
import 'package:petcare_project/screens/profile_page.dart';
import 'package:petcare_project/screens/record_page.dart';
import 'constant.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  var _selectedIndex = 0;
  final List screen = [
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
              print(size.height);
              setState(() {
                _selectedIndex = index;
              });
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
      body: screen[_selectedIndex],
    );
  }
}

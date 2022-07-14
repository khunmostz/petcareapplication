import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/profile_controller.dart';
import 'package:petcare_project/data/petData.dart';
import 'package:petcare_project/screens/Profile/Widget/profile_container.dart';
import 'package:petcare_project/screens/Profile/Widget/profile_textfield.dart';
import '../../utils/constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //ปูพื้น
                Container(
                  width: size.width,
                  height: size.height >= 920
                      ? size.height * 0.32
                      : size.height * 0.35,
                  color: Colors.white,
                ),
                //backgroud linear
                Container(
                  width: size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade100,
                        kDefualtColorMain,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                //top container
                Positioned(
                  top: 80,
                  right: 0,
                  left: 0,
                  child: ProfileContainer(size: size),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: size.width,
              height:
                  size.height >= 920 ? size.height * 0.6 : size.height * 0.5,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                  child: FutureBuilder(
                      future: _profileController.getUserDetail(),
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            SizedBox(height: 30),
                            ProfileTextField(
                              hintText: 'Username',
                              readOnly: true,
                              initialValue: _profileController.user['username']
                                  .toString(),
                            ),
                            SizedBox(height: 20),
                            ProfileTextField(
                              hintText: 'Email',
                              readOnly: true,
                              initialValue:
                                  _profileController.user['email'].toString(),
                            ),
                            SizedBox(height: 20),
                            ProfileTextField(
                              hintText: 'Tel',
                              readOnly: true,
                            ),
                            SizedBox(height: 20),
                            ProfileTextField(
                              hintText: 'Address',
                              readOnly: true,
                            ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     _profileController.getUserDetail();
                            //     // _profileController.getUserDocId();
                            //   },
                            //   child: Text('get'),
                            // )
                          ],
                        );
                      }),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

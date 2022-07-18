import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/profile_controller.dart';
import 'package:petcare_project/data/petData.dart';
import 'package:petcare_project/screens/Profile/Widget/profile_textfield.dart';
import 'package:petcare_project/utils/constant.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final ProfileController _profileController = Get.put(ProfileController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
      width: size.width,
      height: 200,
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefualtPadding, vertical: kDefualtPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: null,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'พลอากาศเอกฟูฟู่',
                      style: GoogleFonts.mitr(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: AlertDialog(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefualtPadding),
                                  child: Text(
                                    'แก้ไขข้อมูลส่วนตัว',
                                    style: GoogleFonts.mitr(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kDefualtPadding),
                                    child: Container(
                                      // width: size.width * 0.5,
                                      height: size.height * 0.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          ProfileTextField(
                                            hintText: 'username',
                                            initialValue: _profileController
                                                .user['username']
                                                .toString(),
                                          ),
                                          SizedBox(height: 20),
                                          ProfileTextField(
                                            hintText: 'email',
                                            initialValue: _profileController
                                                .user['email']
                                                .toString(),
                                          ),
                                          SizedBox(height: 20),
                                          ProfileTextField(
                                            hintText: 'tel',
                                            initialValue: _profileController
                                                .user['tel']
                                                .toString(),
                                          ),
                                          SizedBox(height: 20),
                                          ProfileTextField(
                                            hintText: 'address',
                                            maxLines: 8,
                                            initialValue: _profileController
                                                .user['address']
                                                .toString(),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    onSurface: Colors.white,
                                                  ),
                                                  child: Text('ยกเลิก'),
                                                  onPressed: () {},
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  child: Text('ยืนยัน'),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'แก้ไข',
                        style: GoogleFonts.mitr(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

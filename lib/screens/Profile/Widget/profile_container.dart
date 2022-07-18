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
    // TextEditingController _testController = TextEditingController(text: 'test');
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
                                      width: size.width,
                                      height: size.height * 0.7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          ProfileEdit(
                                            hintText: 'Username',
                                            keyboardType: TextInputType.text,
                                            controller: _profileController
                                                .usernameController,
                                          ),
                                          SizedBox(height: 20),
                                          ProfileEdit(
                                            hintText: 'Email',
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller: _profileController
                                                .emailController,
                                          ),
                                          SizedBox(height: 20),
                                          ProfileEdit(
                                            hintText: 'Tel',
                                            keyboardType: TextInputType.phone,
                                            controller: _profileController
                                                .telController,
                                          ),
                                          SizedBox(height: 20),
                                          SingleChildScrollView(
                                            child: ProfileEdit(
                                              hintText: 'Address',
                                              keyboardType: TextInputType.text,
                                              maxLines: 8,
                                              controller: _profileController
                                                  .addressController,
                                            ),
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
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  child: Text('ยืนยัน'),
                                                  onPressed: () {
                                                    _profileController
                                                        .updateUser();
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
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

class ProfileEdit extends StatelessWidget {
  final int maxLines;
  final String hintText;
  final TextInputType keyboardType;

  final TextEditingController? controller;
  const ProfileEdit({
    Key? key,
    this.maxLines = 1,
    required this.hintText,
    this.controller,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}

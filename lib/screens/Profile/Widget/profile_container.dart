import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/profile_controller.dart';
import 'package:petcare_project/screens/Profile/Widget/Profile_edit.dart';
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
                GetBuilder<ProfileController>(
                  id: 'selectImage',
                  builder: (_) {
                    return CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: NetworkImage(
                                  '${_profileController.user['image']}') !=
                              null
                          ? NetworkImage('${_profileController.user['image']}')
                          : null,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () =>
                                _profileController.uploadImageProfile(),
                            child: Text(
                              'เลือกรูป',
                              style: GoogleFonts.mitr(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
                    //
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: GetBuilder<ProfileController>(
                                id: 'updateUser',
                                builder: (_) {
                                  return AlertDialog(
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
                                          height: size.height < 920
                                              ? size.height * 0.7
                                              : size.height * 0.6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              ProfileEdit(
                                                hintText: 'Username',
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _profileController
                                                    .usernameController.value,
                                              ),
                                              SizedBox(height: 20),
                                              ProfileEdit(
                                                hintText: 'Email',
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: _profileController
                                                    .emailController.value,
                                              ),
                                              SizedBox(height: 20),
                                              ProfileEdit(
                                                hintText: 'Tel',
                                                keyboardType:
                                                    TextInputType.phone,
                                                controller: _profileController
                                                    .telController.value,
                                              ),
                                              SizedBox(height: 20),
                                              SingleChildScrollView(
                                                child: ProfileEdit(
                                                  hintText: 'Address',
                                                  keyboardType:
                                                      TextInputType.text,
                                                  maxLines: 8,
                                                  controller: _profileController
                                                      .addressController.value,
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
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
                                                        Get.back();
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
                                  );
                                },
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

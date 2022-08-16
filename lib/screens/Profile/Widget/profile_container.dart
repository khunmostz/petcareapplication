import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
                StreamBuilder<dynamic>(
                    stream: _profileController.getUserDetail().asStream(),
                    builder: (context, snapshot) {
                      // print(_profileController.user['image'] == null
                      //     ? null
                      //     : 'has Data');
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return GetBuilder<ProfileController>(
                          id: 'updateProfile',
                          builder: (_) {
                            return Stack(children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey[200],
                                // backgroundImage: NetworkImage(
                                //             '${_profileController.user['image']}') !=
                                //         null
                                //     ? NetworkImage(
                                //         '${_profileController.user['image']}')
                                //     : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('เลือกตัวเลือก'),
                                          content: Container(
                                            width: size.width,
                                            height: 150,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap: () =>
                                                        _profileController
                                                            .uploadImageProfile(
                                                                imageSource:
                                                                    ImageSource
                                                                        .camera),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.camera,
                                                            color:
                                                                kDefualtColorMain,
                                                          ),
                                                          SizedBox(width: 20),
                                                          Text('กล้อง'),
                                                        ],
                                                      ),
                                                    )),
                                                GestureDetector(
                                                    onTap: () {
                                                      _profileController
                                                          .uploadImageProfile(
                                                        imageSource:
                                                            ImageSource.gallery,
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons.image,
                                                              color:
                                                                  kDefualtColorMain),
                                                          SizedBox(width: 20),
                                                          Text('เลือกรูปภาพ'),
                                                        ],
                                                      ),
                                                    )),
                                                GestureDetector(
                                                    onTap: () => Get.back(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.remove_circle,
                                                            color: Colors.red,
                                                          ),
                                                          SizedBox(width: 20),
                                                          Text('ยกเลิก'),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]);
                          },
                        );
                      }
                    }),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GetBuilder<ProfileController>(
                        id: 'getUserDetail',
                        builder: (_) {
                          return Text(
                            '${_profileController.profileName.value}',
                            style: GoogleFonts.mitr(
                              fontSize: 18,
                            ),
                          );
                        }),
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

                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        Get.back();
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

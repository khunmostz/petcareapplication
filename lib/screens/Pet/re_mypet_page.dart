import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare_project/controllers/pet_controller.dart';
import 'package:petcare_project/screens/Pet/mypet_page.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/FadeTextAnimation.dart';
import 'package:petcare_project/widget/custom_button.dart';

class ReMyPetPage extends StatefulWidget {
  const ReMyPetPage({Key? key}) : super(key: key);

  @override
  State<ReMyPetPage> createState() => _ReMyPetPageState();
}

class _ReMyPetPageState extends State<ReMyPetPage> {
  final PetController _petController = Get.put(PetController());
  var birdthday, vaccine, nevaccine;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: Colors.white,
      minimumSize: Size(size.width, 50),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );

    return Stack(
      children: [
        Positioned(
          top: -size.height * 0.15,
          right: -size.height * 0.20,
          child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 250),
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, _) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: value * (size.height * 0.3),
                  width: value * (size.height * 0.4),
                  decoration: BoxDecoration(
                    color: kDefualtColorMain,
                    shape: BoxShape.circle,
                  ),
                );
              }),
        ),
        Positioned(
          // duration: const Duration(milliseconds: 250),
          top: -size.height * 0.42,
          left: 15,
          right: 15,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: size.width,
              height: size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeTextAnimation(
                        child: Text(
                          'สัตว์เลี้ยงของฉัน',
                          style: GoogleFonts.mitr(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      FadeTextAnimation(
                        child: Text(
                          'รายการสัตว์เลี้ยง',
                          style: GoogleFonts.mitr(
                            color: Colors.grey[600],
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 350),
                      tween: Tween(begin: 0, end: 1),
                      builder: (context, value, _) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          width: lerpDouble(0, 50, value),
                          height: lerpDouble(0, 50, value),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return SingleChildScrollView(
                                      child: AlertDialog(
                                        title: Text(
                                          'เพิ่มข้อมูลสัตวเลี้ยง',
                                          style: GoogleFonts.mitr(fontSize: 20),
                                        ),
                                        content: Container(
                                          width: size.width,
                                          height: size.height >= 790
                                              ? size.height * 0.7
                                              : size.height * 0.8,
                                          child: Column(
                                            children: [
                                              Stack(children: [
                                                GetBuilder<PetController>(
                                                  id: 'chooseImage',
                                                  builder: (_) {
                                                    return CircleAvatar(
                                                      radius: 50,
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      backgroundImage:
                                                          _petController
                                                                      .image !=
                                                                  null
                                                              ? FileImage(
                                                                  _petController
                                                                      .image!)
                                                              : null,
                                                      child: _petController
                                                                  .image !=
                                                              null
                                                          ? null
                                                          : Icon(Icons.image),
                                                    );
                                                  },
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: this.context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'เลือกตัวเลือก'),
                                                            content: Container(
                                                              width: size.width,
                                                              height: 150,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  GestureDetector(
                                                                      onTap: () => _petController.uploadImageProfile(
                                                                          imageSource: ImageSource
                                                                              .camera),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.camera,
                                                                              color: kDefualtColorMain,
                                                                            ),
                                                                            SizedBox(width: 20),
                                                                            Text('กล้อง'),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                  GestureDetector(
                                                                      onTap: () => _petController.uploadImageProfile(
                                                                          imageSource: ImageSource
                                                                              .gallery),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(Icons.image,
                                                                                color: kDefualtColorMain),
                                                                            SizedBox(width: 20),
                                                                            Text('เลือกรูปภาพ'),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                  GestureDetector(
                                                                      onTap: () => Get
                                                                          .back(),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
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
                                                      backgroundColor:
                                                          Colors.grey,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                              SizedBox(height: 10),
                                              PetDialog(
                                                size: size,
                                                title: 'ชื่อสัตว์เลี้ยง',
                                                controller: _petController
                                                    .petNameController,
                                              ),
                                              SizedBox(height: 10),
                                              DropdownSearch<dynamic>(
                                                items: _petController.typeP
                                                    .map((e) => e['value'])
                                                    .toList(),
                                                onChanged: ((value) {
                                                  // print(_petController.typeController.text);
                                                  _petController
                                                      .onSelected(value);
                                                  _petController.typeController
                                                      .text = value;
                                                }),
                                                selectedItem:
                                                    "เลือกสัตว์เลี้ยง",
                                              ),
                                              SizedBox(height: 10),
                                              GetBuilder<PetController>(
                                                  builder: (_) {
                                                return DropdownSearch<dynamic>(
                                                  items:
                                                      _petController.showCate,
                                                  onChanged: ((value) {
                                                    _petController
                                                        .speciesController
                                                        .text = value;
                                                  }),
                                                  selectedItem:
                                                      "พันธุ์สัตวเลี้ยง",
                                                );
                                              }),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: DropdownSearch<
                                                          dynamic>(
                                                        items: _petController
                                                            .weightList,
                                                        onChanged: ((value) {
                                                          _petController
                                                              .weightController
                                                              .text = value;
                                                        }),
                                                        selectedItem: "น้ำหนัก",
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: DropdownSearch<
                                                          dynamic>(
                                                        items: _petController
                                                            .genderList,
                                                        onChanged: ((value) {
                                                          _petController
                                                              .genderController
                                                              .text = value;
                                                        }),
                                                        selectedItem: "เพศ",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _petController
                                                            .selectBirdthday(
                                                                this.context,
                                                                birdthday);
                                                      },
                                                      child: GetBuilder<
                                                          PetController>(
                                                        id: 'updateDay',
                                                        builder: (_) {
                                                          return Container(
                                                            width: size.width,
                                                            height: 60,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  _petController
                                                                              .birdthday
                                                                              .toString() ==
                                                                          ''
                                                                      ? 'เลือกวันเกิด'
                                                                      : _petController
                                                                          .birdthday
                                                                          .toString()
                                                                          .characters
                                                                          .take(
                                                                              10)
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          _petController
                                                              .selectVaccine(
                                                                  this.context,
                                                                  vaccine),
                                                      child: GetBuilder<
                                                          PetController>(
                                                        id: 'updateVaccine',
                                                        builder: (_) {
                                                          return Container(
                                                            width: size.width,
                                                            height: 60,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  _petController
                                                                              .vaccine
                                                                              .toString() ==
                                                                          ''
                                                                      ? 'ตารางวัคซีน'
                                                                      : _petController
                                                                          .vaccine
                                                                          .toString()
                                                                          .characters
                                                                          .take(
                                                                              10)
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () => _petController
                                                      .selectNextVaccine(
                                                          this.context,
                                                          nevaccine),
                                                  child:
                                                      GetBuilder<PetController>(
                                                    id: 'updateNextVaccine',
                                                    builder: (_) {
                                                      return Container(
                                                        width: size.width,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              _petController
                                                                          .vaccine
                                                                          .toString() ==
                                                                      ''
                                                                  ? 'กำหนดการฉีดวัคซีน'
                                                                  : _petController
                                                                      .vaccine
                                                                      .toString()
                                                                      .characters
                                                                      .take(10)
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ), // SizedBox(height: 30),
                                              SizedBox(height: 10),
                                              CustomButton(
                                                text: 'ยืนยัน',
                                                onPressed: () async {
                                                  if (_petController
                                                          .pathImageStore ==
                                                      null) {
                                                    return Get.snackbar(
                                                        'แจ้งเตือน',
                                                        'กรุณาเพิ่มรูปภาพสัตว์เลี้ยง');
                                                  } else {
                                                    _petController.addPet(
                                                      _petController
                                                          .birdthday.value,
                                                      _petController
                                                          .vaccine.value,
                                                      _petController
                                                          .pathImageStore!,
                                                    );
                                                    await _petController
                                                        .getPet();
                                                    Get.back();
                                                    Get.snackbar(
                                                      'แจ้งเตือน',
                                                      'เพิ่มข้อมูลสำเร็จ',
                                                    );
                                                  }
                                                },
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                style: buttonStyle,
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text(
                                                  'ยกเลิก',
                                                  style: GoogleFonts.mitr(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.add,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
        Positioned(
          // top: -size.height * 0.36,
          top: size.height > 860
              ? -size.height * 0.001 + 130
              : -size.height * 0.001 + 100,
          bottom: 0,
          right: 0,
          left: 0,
          // left: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 500),
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, _) {
                return Transform.scale(
                  scale: value,
                  child: StreamBuilder<dynamic>(
                      stream: _petController.getPet().asStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return GetBuilder<PetController>(
                              id: 'addPets',
                              builder: (_) {
                                return GetBuilder<PetController>(builder: (_) {
                                  return ListView.builder(
                                      itemCount: _petController.docLength,
                                      itemBuilder: (context, index) {
                                        // print('length ${_petController.petName[0]}');
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: kDefualtPadding),
                                          child: GestureDetector(
                                            onTap: (() async {
                                              await _petController.fetchTreat(
                                                  petName: _petController
                                                      .petName[index]);
                                              Get.toNamed(
                                                '/repetdetail',
                                                arguments: [
                                                  _petController
                                                          .petImage[index] ??
                                                      [],
                                                  _petController
                                                          .petName[index] ??
                                                      [],
                                                  _petController
                                                          .petType[index] ??
                                                      [],
                                                  _petController
                                                          .petSpecies[index] ??
                                                      [],
                                                ],
                                              );
                                            }),
                                            child: Row(
                                              children: [
                                                AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 450),
                                                  width: lerpDouble(0, 30, 0.3),
                                                  height: lerpDouble(0,
                                                      size.height * 0.65, 0.3),
                                                  decoration: BoxDecoration(
                                                    color: kDefualtColorMain,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(14),
                                                      bottomLeft:
                                                          Radius.circular(14),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black45,
                                                        spreadRadius: 1,
                                                        blurRadius: 7,
                                                        offset: Offset(2, 6),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 350),
                                                  width: size.width - 30,
                                                  height: size.height * 0.2,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(14),
                                                      bottomRight:
                                                          Radius.circular(14),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black45,
                                                        spreadRadius: 1,
                                                        blurRadius: 7,
                                                        offset: Offset(2, 6),
                                                      )
                                                    ],
                                                    color: Colors
                                                        .orangeAccent.shade100,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FadeTextAnimation(
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          1),
                                                              child: Text(
                                                                'ชื่อ: ${_petController.petName[index]}',
                                                                //'adsad',
                                                                style:
                                                                    GoogleFonts
                                                                        .mitr(
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ),
                                                            FadeTextAnimation(
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          1),
                                                              child: Text(
                                                                'สายพันธฺุ์: ${_petController.petSpecies[index]}',
                                                                style:
                                                                    GoogleFonts
                                                                        .mitr(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                            FadeTextAnimation(
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          1),
                                                              child: Text(
                                                                'น้ำหนัก: ${_petController.petWeight[index]}',
                                                                style:
                                                                    GoogleFonts
                                                                        .mitr(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            GestureDetector(
                                                              onTap: () =>
                                                                  print(size
                                                                      .height),
                                                              child: Container(
                                                                width: 100,
                                                                height: 40,
                                                                // color: Colors.black,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      kDefualtColorMain,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  'เพิ่มเติม',
                                                                  style:
                                                                      GoogleFonts
                                                                          .mitr(),
                                                                )),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Container(
                                                          width: 100,
                                                          height: 100,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            child: Hero(
                                                              tag: _petController
                                                                      .petName[
                                                                  index],
                                                              child:
                                                                  Image.network(
                                                                '${_petController.petImage[index]}',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                });
                              });
                        }
                      }),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

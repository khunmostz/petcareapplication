import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:petcare_project/controllers/pet_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/custom_button.dart';

class MyPetPage extends StatefulWidget {
  const MyPetPage({Key? key}) : super(key: key);

  @override
  State<MyPetPage> createState() => _MyPetPageState();
}

class _MyPetPageState extends State<MyPetPage>
    with SingleTickerProviderStateMixin {
  final PetController _petController = Get.put(PetController());
  late final AnimationController _controller;
  var birdthday, vaccine;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
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
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage:
                                        _petController.image != null
                                            ? FileImage(_petController.image!)
                                            : null,
                                    child: _petController.image != null
                                        ? null
                                        : Icon(Icons.image),
                                  );
                                }),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: this.context,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                  onTap: () => _petController
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
                                                  onTap: () => _petController
                                                      .uploadImageProfile(
                                                          imageSource:
                                                              ImageSource
                                                                  .gallery),
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
                          ]),
                          // SizedBox(height: 20),
                          // PetDialog(
                          //   size: size,
                          //   title: 'หมายเลข',
                          //   controller: _petController.idController,
                          // ),
                          SizedBox(height: 10),
                          PetDialog(
                            size: size,
                            title: 'ชื่อสัตว์เลี้ยง',
                            controller: _petController.petNameController,
                          ),
                          SizedBox(height: 10),
                          PetDialog(
                            size: size,
                            title: 'ประเภท',
                            controller: _petController.typeController,
                          ),
                          SizedBox(height: 10),
                          PetDialog(
                            size: size,
                            title: 'สายพัน',
                            controller: _petController.speciesController,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: PetDialog(
                                    size: size,
                                    title: 'น้ำหนัก (กิโลกรัม)',
                                    controller: _petController.weightController,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: PetDialog(
                                    size: size,
                                    title: 'เพศ',
                                    controller: _petController.genderController,
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
                                    _petController.selectBirdthday(
                                        this.context, birdthday);
                                  },
                                  child: GetBuilder<PetController>(
                                    id: 'updateDay',
                                    builder: (_) {
                                      return Container(
                                        width: size.width,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _petController.birdthday
                                                          .toString() ==
                                                      ''
                                                  ? 'เลือกวันเกิด'
                                                  : _petController.birdthday
                                                      .toString()
                                                      .substring(0, 10),
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _petController.selectVaccine(
                                      this.context, vaccine),
                                  child: GetBuilder<PetController>(
                                    id: 'updateVaccine',
                                    builder: (_) {
                                      return Container(
                                        width: size.width,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _petController.vaccine
                                                          .toString() ==
                                                      ''
                                                  ? 'ตารางวัคซีน'
                                                  : _petController.vaccine
                                                      .toString()
                                                      .substring(0, 10),
                                              style: TextStyle(
                                                  color: Colors.black54),
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
                          // SizedBox(height: 30),
                          Spacer(),
                          CustomButton(
                            text: 'ยืนยัน',
                            onPressed: () {
                              _petController.addPet(
                                  _petController.birdthday.value,
                                  _petController.vaccine.value,
                                  _petController.pathImageStore!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });

          // print('xxx');
          // _petController.testFunc();
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<dynamic>(
        stream: _petController.getPet().asStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                'assets/lottie/orange-loading.json',
                repeat: true,
                frameRate: FrameRate(240),
                controller: _controller,
              ),
            );
          } else {
            return GetBuilder<PetController>(
              id: 'addPets',
              builder: (_) {
                return ListView.builder(
                  itemCount: _petController.docLength,
                  itemBuilder: (context, index) {
                    print('page: ${_petController.petName}');
                    return GestureDetector(
                      onTap: (() => Get.toNamed(
                            '/petdetail',
                            arguments: [
                              _petController.petImage[index],
                              _petController.petName[index],
                              _petController.petType[index],
                              _petController.petSpecies[index],
                            ],
                          )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefualtPadding,
                            vertical: kDefualtPadding / 2),
                        child: Container(
                          width: size.width,
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                            color: kDefualtColorMain,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 15,
                                spreadRadius: 1,
                                offset: Offset(-4, -4),
                              ),
                              BoxShadow(
                                color: kDefualtColorMain,
                                blurRadius: 15,
                                spreadRadius: 1,
                                offset: Offset(4, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(kDefualtPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: '${_petController.petName[index]}',
                                  child: Container(
                                    width: size.width / 3,
                                    height: size.height * 0.3,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '${_petController.petImage[index]}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Name: ${_petController.petName[index]}',
                                      style: GoogleFonts.mitr(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Type: ${_petController.petType[index]}',
                                      style: GoogleFonts.mitr(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Species: ${_petController.petSpecies[index]}',
                                      style: GoogleFonts.mitr(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Weight: ${_petController.petWeight[index]}',
                                      style: GoogleFonts.mitr(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // GetBuilder<PetController>(
                                    //     id: 'test',
                                    //     builder: (_) {
                                    //       return Text(
                                    //           '${_petController.test.toString()}');
                                    //     }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PetDialog extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const PetDialog({
    Key? key,
    required this.size,
    required this.title,
    required this.controller,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: title,
          ),
        ),
      ),
    );
  }
}

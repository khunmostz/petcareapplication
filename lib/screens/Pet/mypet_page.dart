import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

class _MyPetPageState extends State<MyPetPage> with TickerProviderStateMixin {
  final PetController _petController = Get.put(PetController());
  late final AnimationController _controller;
  var birdthday, vaccine;

  List<String> Categories = [];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.repeat();
  }

  onSelected() {
    // Categories.add(data.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

    // print(Categories.toString());
    // var value = Categories.where((element) => (element).contains('กบ'));

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
                                  backgroundImage: _petController.image != null
                                      ? FileImage(_petController.image!)
                                      : null,
                                  child: _petController.image != null
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
                          SizedBox(height: 10),
                          PetDialog(
                            size: size,
                            title: 'ชื่อสัตว์เลี้ยง',
                            controller: _petController.petNameController,
                          ),
                          SizedBox(height: 10),
                          DropdownSearch<dynamic>(
                            items: _petController.typeP
                                .map((e) => e['value'])
                                .toList(),
                            onChanged: ((value) {
                              // print(_petController.typeController.text);
                              _petController.onSelected(value);
                              _petController.typeController.text = value;
                            }),
                            selectedItem: "เลือกสัตว์เลี้ยง",
                          ),
                          SizedBox(height: 10),
                          GetBuilder<PetController>(builder: (_) {
                            return DropdownSearch<dynamic>(
                              items: _petController.showCate,
                              onChanged: ((value) {
                                _petController.speciesController.text = value;
                              }),
                              selectedItem: "พันธุ์สัตวเลี้ยง",
                            );
                          }),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: DropdownSearch<dynamic>(
                                    items: _petController.weightList,
                                    onChanged: ((value) {
                                      _petController.weightController.text =
                                          value;
                                    }),
                                    selectedItem: "น้ำหนัก",
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: DropdownSearch<dynamic>(
                                    items: _petController.genderList,
                                    onChanged: ((value) {
                                      _petController.genderController.text =
                                          value;
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
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _petController.birdthday
                                                          .toString() ==
                                                      ''
                                                  ? 'เลือกวันเกิด'
                                                  : _petController.birdthday
                                                      .toString()
                                                      .characters
                                                      .take(10)
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                  onTap: () => _petController.selectVaccine(
                                      this.context, vaccine),
                                  child: GetBuilder<PetController>(
                                    id: 'updateVaccine',
                                    builder: (_) {
                                      return Container(
                                        width: size.width,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _petController.vaccine
                                                          .toString() ==
                                                      ''
                                                  ? 'ตารางวัคซีน'
                                                  : _petController.vaccine
                                                      .toString()
                                                      .characters
                                                      .take(10)
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
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
                            onPressed: () async {
                              if (_petController.pathImageStore == null) {
                                return Get.snackbar(
                                    'แจ้งเตือน', 'กรุณาเพิ่มรูปภาพสัตว์เลี้ยง');
                              } else {
                                _petController.addPet(
                                  _petController.birdthday.value,
                                  _petController.vaccine.value,
                                  _petController.pathImageStore!,
                                );
                                await _petController.getPet();
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
                return GetBuilder<PetController>(builder: (_) {
                  return ListView.builder(
                    itemCount: _petController.docLength,
                    itemBuilder: (context, index) {
                      // print('page: ${_petController.petName}');
                      print('length ${_petController.docLength.toString()}');

                      if (_petController.docLength <= 0) {
                        return Container(
                          child: Text('ไม่มีข้อมูลสัตว์เลี้ยง'),
                        );
                      } else {
                        return Slidable(
                          key: Key(_petController.petName[index]),
                          endActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),

                            // A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(onDismissed: () {
                              _petController.deletePet(
                                  _petController.petName[index], index);
                              setState(() {});
                            }),

                            // All actions are defined in the children parameter.
                            children: [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: (context) {
                                  _petController.deletePet(
                                      _petController.petName[index], index);
                                  setState(() {});
                                },
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: TweenAnimationBuilder<double>(
                              duration: const Duration(seconds: 2),
                              tween: Tween(begin: 0, end: 1),
                              curve: Curves.bounceOut,
                              builder: (context, value, _) {
                                var percent = value * index;
                                print(
                                    'image from mypet : ${_petController.petImage.length.toString()}');
                                return GestureDetector(
                                  onTap: (() async {
                                    await _petController.fetchTreat(
                                        petName: _petController.petName[index]);
                                    Get.toNamed(
                                      '/petdetail',
                                      arguments: [
                                        _petController.petImage[index] ?? [],
                                        _petController.petName[index] ?? [],
                                        _petController.petType[index] ?? [],
                                        _petController.petSpecies[index] ?? [],
                                      ],
                                    );
                                  }),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kDefualtPadding,
                                        vertical: kDefualtPadding / 2),
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..rotateY(value - 1)
                                        ..scale(value)
                                        ..translate(value - 1),
                                      child: Opacity(
                                        opacity: value,
                                        child: Container(
                                          width: size.width,
                                          height: size.height * 0.2,
                                          decoration: BoxDecoration(
                                            // border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                            padding: const EdgeInsets.all(
                                                kDefualtPadding),
                                            child: GetBuilder<PetController>(
                                                builder: (_) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Hero(
                                                    tag:
                                                        '${_petController.petName[index] ?? []} ',
                                                    child: Container(
                                                      width: size.width / 3,
                                                      height: size.height * 0.3,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            '${_petController.petImage[index] ?? []}',
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Name: ${_petController.petName[index] ?? []}',
                                                        style: GoogleFonts.mitr(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                      Text(
                                                        'Type: ${_petController.petType[index] ?? []}',
                                                        style: GoogleFonts.mitr(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                      Text(
                                                        'Weight: ${_petController.petWeight[index]}',
                                                        style: GoogleFonts.mitr(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    },
                  );
                });
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
  final TextInputType? type;
  const PetDialog(
      {Key? key,
      required this.size,
      required this.title,
      required this.controller,
      this.type})
      : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      // height: size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: TextFormField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: title,
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

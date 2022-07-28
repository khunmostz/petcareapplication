import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/pet_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:readmore/readmore.dart';

import '../../data/petData.dart';
=======
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/data/petData.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/custom_button.dart';
>>>>>>> forgotpage

class MyPetPage extends StatefulWidget {
  const MyPetPage({Key? key}) : super(key: key);

  @override
  State<MyPetPage> createState() => _MyPetPageState();
}

class _MyPetPageState extends State<MyPetPage> {
<<<<<<< HEAD
  bool _selected = false;
  int? _selectId;
  final _controller = Get.put(PetController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

=======
>>>>>>> forgotpage
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: ListView.builder(
                      itemCount: petData.length,
                      itemBuilder: (context, index) {
                        return popContainer(size, index, _selected);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget popContainer(Size size, int index, bool isSelected) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: kDefualtColorMain,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${petData[index].image}",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _controller.toggleWidget(index.obs);
                  },
                  child: GetBuilder<PetController>(
                    builder: (_) => _controller.selectId?.value != index ||
                            _controller.selected.value
                        ? Icon(Icons.arrow_drop_down)
                        : Icon(Icons.arrow_drop_up),
                  ),
                ),
              ],
            ),
          ),
        ),
        GetBuilder<PetController>(
          builder: (_) =>
              _controller.selectId?.value != index || _controller.selected.value
                  ? Container()
                  : TweenAnimationBuilder(
                      child: Container(
                        width: size.width,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Color.fromARGB(255, 255, 150, 79),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0, 5),
                            )
                          ],
                        ),
                      ),
                      duration: Duration(seconds: 1),
                      tween: Tween<double>(begin: 0, end: 1),
                      curve: Curves.ease,
                      builder: (BuildContext context, double _var, child) {
                        return Opacity(
                          opacity: _var,
                          child: Padding(
                            padding: EdgeInsets.only(top: _var * 20),
                            child: child,
                          ),
                        );
                      },
                    ),
        )
      ],
=======
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(
                'เพิ่มข้อมูลสัตวเลี้ยง',
                style: GoogleFonts.mitr(fontSize: 20),
              ),
              content: Container(
                width: size.width,
                height: size.height * 0.7,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: null,
                      child: Icon(Icons.photo),
                    ),
                    SizedBox(height: 10),
                    Text('เลือกรูปภาพ'),
                    SizedBox(height: 20),
                    PetDialog(size: size, petName: 'ชื่อสัตว์เลี้ยง'),
                    SizedBox(height: 10),
                    PetDialog(size: size, petName: 'ประเภท'),
                    SizedBox(height: 10),
                    PetDialog(size: size, petName: 'อาหารสัตว์'),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'น้ำหนัก',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'เพศ',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'วันเกิด',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'ตารางวัคซีน',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      text: 'ยืนยัน',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: petData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kDefualtPadding, vertical: kDefualtPadding / 2),
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
                    Container(
                      width: size.width / 3,
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Text('data'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PetDialog extends StatelessWidget {
  final String petName;
  const PetDialog({
    Key? key,
    required this.size,
    required this.petName,
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
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: petName,
          ),
        ),
      ),
>>>>>>> forgotpage
    );
  }
}

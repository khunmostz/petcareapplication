import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/record_controller.dart';
import 'package:petcare_project/data/petData.dart';
import 'package:petcare_project/screens/Record/Widget/blur_backgroud.dart';
import 'package:petcare_project/screens/Record/Widget/indicator.dart';
import 'package:petcare_project/screens/Record/Widget/petslide.dart';
import 'package:petcare_project/screens/Record/Widget/record_dialog.dart';
import 'package:petcare_project/screens/Record/Widget/record_table.dart';
import 'package:petcare_project/widget/custom_button.dart';
import '../../utils/constant.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage>
    with SingleTickerProviderStateMixin {
  var _selectedIndex = 0;
  bool _tapSearch = true;

  var date;

  late final AnimationController _controller;
  final RecordController _recordController = Get.put(RecordController());

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((value) {
      date = value;
      print(date);
    });
  }

  void _seachField() {
    if (_tapSearch == false) {
      _controller.forward();
      _tapSearch = true;
    } else {
      _controller.reverse();
      _tapSearch = false;
    }
    print(_tapSearch.toString());
  }

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: kDefualtColorMain,
    minimumSize: Size(100, 30),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
                Container(
                  width: size.width,
                  height: 300,
                  color: Colors.white,
                ),
                //backgroud
                BlurBackGroud(size: size, selectedIndex: _selectedIndex),
                // Pet Slide
                Positioned(
                  top: size.height < 685 ? 80 : 50,
                  width: size.width,
                  height: size.height / 4,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    itemCount: petData.length,
                    itemBuilder: (context, index) {
                      var _scale = _selectedIndex == index ? 1.0 : 0.8;
                      return TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 350),
                        tween: Tween(begin: _scale, end: _scale),
                        curve: Curves.ease,
                        child: PetSlide(
                          pet: petData[index],
                        ),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                ),
                // Indicator
                Positioned(
                  top: 280,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        petData.length,
                        (index) => Indicator(
                            isActive: _selectedIndex == index ? true : false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ประวัติ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ประวัติ",
                    style: GoogleFonts.mitr(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'กรุณากรอกข้อมูล',
                                  style: GoogleFonts.mitr(
                                    fontSize: 20,
                                  ),
                                ),
                                content: Container(
                                  width: size.width,
                                  height: size.height * 0.5,
                                  child: Column(
                                    children: [
                                      RecordDialog(
                                        title: 'รายการ',
                                        hinText: 'รายการ',
                                        keyboardType: TextInputType.text,
                                        controller: _recordController
                                            .particularController,
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RecordDialog(
                                              title: 'ค่าใช้จ่าย',
                                              hinText: 'ค่าใช้จ่าย',
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: _recordController
                                                  .payController,
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                _showDatePicker();
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 37),
                                                height: 65,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Icon(
                                                  Icons.date_range,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      CustomButton(
                                        onPressed: () {
                                          _recordController
                                              .addRecord(date.toString());
                                        },
                                        text: 'เพิ่มข้อมูล',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: kDefualtColorMain,
                            borderRadius: BorderRadius.circular(36),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: -10,
                                blurRadius: 10,
                                offset: Offset(0.0, 10),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 350),
                              width: 48,
                              child: Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          _tapSearch ? null : _showDatePicker();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          width: _tapSearch ? 48 : 200,
                          height: 48,
                          decoration: BoxDecoration(
                            color: kDefualtColorMain,
                            borderRadius: BorderRadius.circular(36),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: -10,
                                blurRadius: 10,
                                offset: Offset(0.0, 10),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              width: _tapSearch ? 48 : 200,
                              child: Row(
                                mainAxisAlignment: _tapSearch
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: _tapSearch ? 0 : 10,
                                  ),
                                  _tapSearch
                                      ? Container()
                                      : Text(
                                          "เลือกวันที่กด",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      _seachField();
                                    }),
                                    child: Padding(
                                      padding: _tapSearch
                                          ? EdgeInsets.only(right: 0)
                                          : EdgeInsets.only(right: 20),
                                      child: Align(
                                        alignment: _tapSearch
                                            ? Alignment.center
                                            : Alignment.centerRight,
                                        child: Icon(
                                          _tapSearch
                                              ? Icons.search
                                              : Icons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // แสดงรายรับรายจ่าย
            RecordTable(size: size),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

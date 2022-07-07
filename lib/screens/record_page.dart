import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/data/petData.dart';
import 'package:petcare_project/data/recordData.dart';
import '../utils/constant.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage>
    with SingleTickerProviderStateMixin {
  var _selectedIndex = 0;
  bool _tapSearch = true;

  late final AnimationController _controller;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((value) => print(value));
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
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
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                Container(
                  width: size.width,
                  height: 200,
                  child: PageView.builder(
                    controller: PageController(),
                    itemCount: petData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                '${petData[_selectedIndex].image}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(),
                        ),
                      );
                    },
                  ),
                ),
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
                      var slide = petData.length;
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
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            // แสดงรายรับรายจ่าย
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
              child: Container(
                width: size.width,
                height: size.height * 0.45,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black26,
                  //     blurRadius: 5,
                  //     spreadRadius: 3,
                  //     offset: Offset(-1, 3),
                  //   ),
                  // ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          'รายการ',
                          style: GoogleFonts.mitr(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'ค่าใช้จ่าย',
                          style: GoogleFonts.mitr(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'วันเวลา',
                          style: GoogleFonts.mitr(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                    rows: recordData
                        .map(
                          (record) => DataRow(cells: [
                            DataCell(Text(
                              '${record.title}',
                              style: GoogleFonts.mitr(
                                fontSize: 14,
                              ),
                            )),
                            DataCell(Text(
                              '${record.pay}',
                              style: GoogleFonts.mitr(
                                fontSize: 14,
                              ),
                            )),
                            DataCell(
                              Text(
                                '${record.date}'.toString().substring(0, 10),
                                style: GoogleFonts.mitr(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ]),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 0.4),
      width: isActive ? 22.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive ? kDefualtColorMain : Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}

class PetSlide extends StatelessWidget {
  final Pet pet;
  const PetSlide({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kDefualtPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(-1, 5),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(
            '${pet.image}',
            scale: 0.5,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

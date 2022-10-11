import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/record_controller.dart';
import 'package:petcare_project/screens/Record/Widget/indicator.dart';
import 'package:petcare_project/screens/Record/Widget/petslide.dart';
import 'package:petcare_project/screens/Record/Widget/record_dialog.dart';
import 'package:petcare_project/widget/custom_button.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../utils/constant.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  var _selectedIndex = 0;
  bool _tapSearch = true;
  var date;
  var search = '';

  // late final AnimationController _controller;
  // final RecordController _recordController = Get.find<RecordController>();

  final RecordController _recordController = Get.put(RecordController());
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((value) {
      date = value;
      setState(() {
        _recordController.search = date.toString();
      });
    });
  }

  void _seachField() {
    if (_tapSearch == false) {
      // _controller.forward();
      _tapSearch = true;
    } else {
      // _controller.reverse();
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
                  decoration: BoxDecoration(
                    color: kDefualtColorMain,
                  ),
                ),

                if (_recordController.docLength.value == 0)
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: kDefualtPadding + 60),
                      child: Text(
                        'กรุณาเพิ่มข้อมูลสัตว์เลี้ยง',
                        style: GoogleFonts.mitr(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                // Pet Slide
                GetBuilder<RecordController>(
                    id: 'getPets',
                    builder: (_) {
                      return Positioned(
                        top: size.height < 685 ? 80 : 50,
                        width: size.width,
                        height: size.height / 4,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.7),
                          onPageChanged: (index) {
                            setState(() {
                              _selectedIndex = index;
                              _recordController.selectedIndex.value = index;
                              // print(_recordController.selectedIndex.toString());
                              // print('after:' + _selectedIndex.toString());
                              _recordController.search = '';

                              // snapshotData = 0;
                            });
                          },
                          itemCount: _recordController.docLength.value,
                          itemBuilder: (context, index) {
                            print('+' * 100);
                            print(_recordController.docLength.value.toString());
                            print('index' + index.toString());
                            var _scale = _selectedIndex == index ? 1.0 : 0.8;
                            return TweenAnimationBuilder(
                              duration: const Duration(milliseconds: 350),
                              tween: Tween(begin: _scale, end: _scale),
                              curve: Curves.ease,
                              child: GetBuilder<RecordController>(
                                  id: 'getPets',
                                  builder: (_) {
                                    return PetSlide(
                                      pet: _recordController.petImage[index],
                                    );
                                  }),
                              builder: (context, double value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: child,
                                );
                              },
                            );
                          },
                        ),
                      );
                    }),
                // Indicator
                Positioned(
                  top: 280,
                  right: 0,
                  left: 0,
                  child: GetBuilder<RecordController>(
                    id: 'getPets',
                    builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            _recordController.docLength.value,
                            (index) => Indicator(
                                isActive:
                                    _selectedIndex == index ? true : false),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),

            // FlatButton(
            //     onPressed: () {
            //
            //     },
            //     child: Text('ssss')),
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
                          _recordController.petNameController.text =
                              _recordController.petName[_selectedIndex];
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
                                content: SingleChildScrollView(
                                  child: Container(
                                    width: size.width,
                                    height: size.height * 0.5,
                                    child: Column(
                                      children: [
                                        GetBuilder<RecordController>(
                                          id: 'getPets',
                                          builder: (_) {
                                            return RecordDialog(
                                              title: 'ชื่อสัตว์เลี้ยง',
                                              hinText: 'ชื่อสัตว์เลี้ยง',
                                              readOnly: true,
                                              keyboardType: TextInputType.text,
                                              controller: _recordController
                                                  .petNameController,
                                            );
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        RecordDialog(
                                          title: 'รายการ',
                                          hinText: 'รายการ',
                                          readOnly: false,
                                          keyboardType: TextInputType.text,
                                          controller: _recordController
                                              .particularController,
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RecordDialog(
                                                title: 'ค่าใช้จ่าย',
                                                hinText: 'ค่าใช้จ่าย',
                                                readOnly: false,
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
                                                  setState(() {
                                                    _recordController.search =
                                                        '';
                                                  });
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
                                                        BorderRadius.circular(
                                                            12),
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
                                                .addRecord(date.toString())
                                                .then((value) => print(
                                                    _recordController.search
                                                        .toString()));
                                          },
                                          text: 'เพิ่มข้อมูล',
                                        ),
                                      ],
                                    ),
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
                          // _tapSearch ? null : Get.toNamed('/showsearch');
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
            GetBuilder<RecordController>(
              id: 'getPets',
              builder: (_) {
                return recordTable(
                    indexSelect: _recordController.petName.length > 0
                        ? _recordController.petName[_selectedIndex]
                        : '');
              },
            ),
            SizedBox(height: 20),

            GetBuilder<RecordController>(
                id: 'updateRecord',
                builder: (_) {
                  if (_recordController.search != '') {
                    return Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _recordController.search = '';
                              _tapSearch = true;
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: kDefualtColorMain,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget recordTable({required String indexSelect}) {
    // print('qwerty:${indexSelect}');
    return GetBuilder<RecordController>(
        id: 'updateRecord',
        builder: (_) {
          return Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: (_recordController.search != '' &&
                          _recordController.search != null)
                      ? FirebaseFirestore.instance
                          .collection('records')
                          .where('date', isEqualTo: _recordController.search)
                          .where('petname', isEqualTo: indexSelect)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('records')
                          .where('petname',
                              isEqualTo: indexSelect.toLowerCase())
                          .snapshots(),
                  builder: (context, snapshot) {
                    // print(
                    //     'laksjdlkasdlald ${indexSelect.toLowerCase().toString()}');
                    int snapshotData = 0;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      snapshot.data!.docs.forEach((element) {
                        var value = int.parse(element['pay']);
                        snapshotData = snapshotData + value;
                      });

                      return Column(
                        children: [
                          DataTable(
                            columnSpacing: 50,
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
                            rows: snapshot.data!.docs
                                .map(
                                  (record) => DataRow(cells: [
                                    DataCell(
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 60),
                                        child: Text(
                                          '${record['particular']}',
                                          style: GoogleFonts.mitr(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(
                                      '${record['pay']}',
                                      style: GoogleFonts.mitr(
                                        fontSize: 14,
                                      ),
                                    )),
                                    DataCell(
                                      Text(
                                        '${record['date']}'
                                            .toString()
                                            .substring(0, 10),
                                        style: GoogleFonts.mitr(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ]),
                                )
                                .toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefualtPadding),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'รวม ${snapshotData.toString()}',
                                style: GoogleFonts.mitr(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          );
        });
  }

  Future showAlert() {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: 'Sorry, something went wrong',
    );
  }
}

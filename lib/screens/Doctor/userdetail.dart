import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/docsearch_controller.dart';
import 'package:petcare_project/utils/constant.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final DocSearchController _docSearchController = Get.find();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var username = Get.arguments[0];
    // print(_docSearchController.petShow[0]['gender']);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 248, 135, 100),
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [],
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: Column(
          children: [
            // User
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.green,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Hello \n${username}',
                    style: GoogleFonts.mitr(
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Pet Length
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 248, 135, 100),
                        offset: Offset(5, 5),
                        spreadRadius: 1,
                        blurRadius: 10),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefualtPadding, vertical: kDefualtPadding),
                  child: GetBuilder<DocSearchController>(builder: (_) {
                    return RichText(
                      text: TextSpan(
                        style: GoogleFonts.mitr(),
                        children: [
                          TextSpan(
                            text: 'จำนวนสัตว์เลี้ยง\n',
                            style: GoogleFonts.mitr(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${_docSearchController.petShow.length.toString()}',
                            style: GoogleFonts.mitr(
                              fontSize: 36,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // Show Pet

            GetBuilder<DocSearchController>(builder: (_) {
              return Container(
                width: double.infinity,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                    // border: Border.all(),
                    ),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _docSearchController.petShow.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/adddetailpet');
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefualtPadding / 2,
                                  vertical: kDefualtPadding / 4),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            Text(
                              "${_docSearchController.petShow[index]['petName']}",
                              style: GoogleFonts.mitr(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}

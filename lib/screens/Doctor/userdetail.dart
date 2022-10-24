import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/docsearch_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/shake_transition.dart';

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
    var image = Get.arguments[1];

    // print(_docSearchController.petShow[0]['gender']);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kDefualtColorMain,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // User
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                child: ShakeTransition(
                  child: Row(
                    children: [
                      if (image == "")
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              AssetImage('assets/image/person-placeholder.jpg'),
                        )
                      else
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage('${image}'),
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
              ),
              SizedBox(
                height: 20,
              ),
              // Pet Length
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                child: ShakeTransition(
                  left: false,
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: kDefualtColorMain.withOpacity(0.8),
                            offset: Offset(5, 5),
                            spreadRadius: 1,
                            blurRadius: 10),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefualtPadding,
                          vertical: kDefualtPadding),
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
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _docSearchController.petShow.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.offNamed('/adddetailpet', arguments: [
                              _docSearchController.petShow[index]['petName'],
                              _docSearchController.petShow[index]['image'],
                              _docSearchController.petShow[index]['type'],
                              _docSearchController.petShow[index]['species'],
                              _docSearchController.petShow[index]['gender'],
                              _docSearchController.petShow[index]['weight'],
                            ]);
                          },
                          child: TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 400),
                              tween: Tween(begin: 0.0, end: 1.0),
                              builder: (context, value, _) {
                                var percent = value + index * 2;
                                return Transform.translate(
                                  offset: Offset(-value * 1.3, value * 20),
                                  child: Opacity(
                                    opacity: value,
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.blue,
                                          backgroundImage: NetworkImage(
                                              '${_docSearchController.petShow[index]['image']}'),
                                        ),
                                        Text(
                                          "${_docSearchController.petShow[index]['petName']}",
                                          style: GoogleFonts.mitr(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

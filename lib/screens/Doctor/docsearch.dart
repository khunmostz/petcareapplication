import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/docsearch_controller.dart';
import 'package:petcare_project/utils/constant.dart';

class DocSearch extends StatefulWidget {
  const DocSearch({Key? key}) : super(key: key);

  @override
  State<DocSearch> createState() => _DocSearchState();
}

class _DocSearchState extends State<DocSearch> {
  final DocSearchController _docSearchController =
      Get.put(DocSearchController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Container(
        width: double.infinity,
        child: GetBuilder<DocSearchController>(
            init: DocSearchController(),
            builder: (_) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                    child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1.0, end: 0.0),
                        duration: const Duration(seconds: 1),
                        curve: Curves.bounceInOut,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(3, 3),
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            onChanged: ((value) {
                              _docSearchController.onSearch(value);
                            }),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: 'Search',
                              hintStyle: GoogleFonts.mitr(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0.0, -200 * value),
                            child: child as Widget,
                          );
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _docSearchController.dataShow.length,
                      itemBuilder: ((context, index) {
                        // '${_docSearchController.dataShow[index]['username']}'
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefualtPadding,
                              vertical: kDefualtPadding / 2),
                          child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.1, end: 1.0),
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeIn,
                              child: GestureDetector(
                                onTap: (() {
                                  Get.toNamed('/userdetail', arguments: [
                                    _docSearchController.dataShow[index]
                                        ['username'],
                                  ]);
                                  _docSearchController.fetchPetUserById(
                                      _docSearchController.dataShow[index]
                                          ['uid']);
                                }),
                                child: Container(
                                  width: size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(255, 248, 135, 100),
                                        Colors.white,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(5, 5),
                                          spreadRadius: 1,
                                          blurRadius: 10),
                                      BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-5, -5),
                                          spreadRadius: 1,
                                          blurRadius: 10)
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${_docSearchController.dataShow[index]['username']}',
                                        style: GoogleFonts.mitr(
                                          fontSize: 18,
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey,
                                        // backgroundImage: _docSearchController
                                        //             .dataShow[index]['image'] !=
                                        //         null
                                        //     ? NetworkImage(
                                        //         '${_docSearchController.dataShow[index]['image']}')
                                        //     : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              builder: (context, value, child) {
                                print(value);
                                var percent = value + 1;
                                return Opacity(
                                  opacity: value,
                                  child: Center(
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..rotateY(percent * pi),
                                      child: child as Widget,
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

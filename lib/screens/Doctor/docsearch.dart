import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/animations/dogsearch_animation.dart';
import 'package:petcare_project/controllers/docsearch_controller.dart';
import 'package:petcare_project/utils/constant.dart';

class DocSearch extends StatefulWidget {
  const DocSearch({Key? key}) : super(key: key);

  @override
  State<DocSearch> createState() => _DocSearchState();
}

class _DocSearchState extends State<DocSearch>
    with SingleTickerProviderStateMixin {
  final DocSearchController _docSearchController =
      Get.find<DocSearchController>();

  final DogSearchAniamtion _aniamtion = Get.find<DogSearchAniamtion>();

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
                    child: AnimatedBuilder(
                        animation: _aniamtion.animationController,
                        builder: (context, _) {
                          return Transform.translate(
                            offset: Offset(0.0, _aniamtion.animation.value),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                          child: AnimatedBuilder(
                              animation: _aniamtion.animationController,
                              builder: (context, _) {
                                return Opacity(
                                  opacity: _aniamtion.animation.value,
                                  child: Center(
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..rotateY(
                                            (_aniamtion.animation.value + 1) *
                                                pi),
                                      child: GestureDetector(
                                        onTap: (() {
                                          Get.toNamed('/userdetail',
                                              arguments: [
                                                _docSearchController
                                                        .dataShow[index]
                                                    ['username'],
                                                _docSearchController
                                                    .dataShow[index]['image']
                                              ]);
                                          _docSearchController.fetchPetUserById(
                                              _docSearchController
                                                  .dataShow[index]['uid']);
                                        }),
                                        child: Container(
                                          width: size.width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                kDefualtColorMain
                                                    .withOpacity(0.8),
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
                                              if (_docSearchController
                                                          .dataShow[index]
                                                      ['image'] ==
                                                  "")
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage: AssetImage(
                                                      'assets/image/person-placeholder.jpg'),
                                                )
                                              else
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage: NetworkImage(
                                                      '${_docSearchController.dataShow[index]['image']}'),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
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

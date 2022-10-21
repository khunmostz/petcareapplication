import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/animations/content_animation.dart';
import 'package:petcare_project/controllers/addlocation_controller.dart';
import 'package:petcare_project/controllers/auth_controller.dart';
import 'package:petcare_project/controllers/content_controller.dart';
import 'package:petcare_project/controllers/profile_controller.dart';
import 'package:petcare_project/services/services.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/data/menuData.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage>
    with SingleTickerProviderStateMixin {
  final ProfileController _profileController = Get.find<ProfileController>();
  final ContentController _contentController = Get.put(ContentController());

  final ContentAnimation _contentAniamtion = Get.put(ContentAnimation());
  final AddLocationController _addLocationController =
      Get.find<AddLocationController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    print(_contentAniamtion.animationController);
    print(Get.isRegistered<ContentAnimation>());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipPath(
              clipper: BackgroundHeader(),
              child: Container(
                width: size.width,
                // height:
                //     size.height < 920 ? size.height * 0.45 : size.height * 0.35,
                height:
                    size.height < 920 ? size.height * 0.35 : size.height * 0.3,
                color: kDefualtColorMain,
                child: CustomPaint(
                  painter: BackgroundPainter(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(kDefualtPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // header
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 25,
                                ),
                                Spacer(),
                                GetBuilder<ProfileController>(
                                    id: 'getUserDetail',
                                    builder: (_) {
                                      if (_profileController.userType.value ==
                                          'Doctor')
                                        return GetBuilder<
                                                AddLocationController>(
                                            builder: (_) {
                                          if (_addLocationController
                                                  .dataCheck ==
                                              'have') {
                                            return Container();
                                          } else {
                                            return IconButton(
                                              onPressed: () {
                                                Get.toNamed('/addlocation');
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                size: 25,
                                              ),
                                            );
                                          }
                                        });
                                      else {
                                        return Container();
                                      }
                                    }),
                              ],
                            ),
                            SizedBox(height: 10),
                            GetBuilder<ProfileController>(
                                id: 'getUserDetail',
                                builder: (controller) {
                                  return Text(
                                    controller.usernameController.value.text,
                                    style: GoogleFonts.mitr(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  );
                                }),
                            SizedBox(height: 10),
                            Text(
                              'Welcome back',
                              style: GoogleFonts.mitr(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                // border: Border.all(),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade50,
                                    spreadRadius: 0.5,
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              // child: SearchField(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // GetBuilder<ProfileController>(builder: (_) {
            //   if (_profileController.userType.value == 'Doctor') {
            //     print(_profileController.userType.value);
            //     return GestureDetector(
            //       onTap: () {
            //         Get.toNamed('/addlocation');
            //       },
            //       child: Hero(
            //         tag: 'addlocation',
            //         child: Container(
            //           width: 150,
            //           height: 50,
            //           decoration: BoxDecoration(
            //             color: kDefualtColorMain,
            //             borderRadius: BorderRadius.all(Radius.circular(20)),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'เพิ่มโลเคชั่น',
            //                 style: GoogleFonts.mitr(
            //                     fontSize: 18, fontWeight: FontWeight.w300),
            //               ),
            //               Icon(Icons.location_city)
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   } else {
            //     return Container();
            //   }
            // }),

            Container(
              width: size.width,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                  // border: Border.all(),
                  ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                child: AnimatedBuilder(
                    animation: _contentAniamtion.animationController,
                    builder: (context, _) {
                      return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 130,
                          childAspectRatio: 1.5,
                          mainAxisExtent: 120,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: menuTitleData.length,
                        itemBuilder: (BuildContext context, index) {
                          return SlideTransition(
                            position: _contentAniamtion.offsetAnimation,
                            child: Opacity(
                              opacity: _contentAniamtion.animation.value,
                              child: Container(
                                child: menuList(index),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ),
            // Recommend
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Promotion",
                        style: GoogleFonts.mitr(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _contentController.allPromotion().asStream(),
                      builder: ((context, snapshot) {
                        print('test1');
                        return AnimatedBuilder(
                          animation: _contentAniamtion.animationController,
                          child: Container(
                            width: size.width,
                            height: size.height * 0.4,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: allPromotions.length,
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 175, 175, 175),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset: Offset(-1, 5),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                            "${allPromotions[index]['promotionImage']}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "${allPromotions[index]['promotionTitle']}",
                                        style: GoogleFonts.mitr(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          builder: ((context, child) {
                            return SlideTransition(
                              position: _contentAniamtion.offsetAnimation,
                              child: Opacity(
                                opacity: _contentAniamtion.animation.value,
                                child: child,
                              ),
                            );
                          }),
                        );
                      }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget menuList(
    int index,
  ) {
    return GestureDetector(
      onTap: (() {
        Get.toNamed('/mappage');
        // print('type: ${menuTitleData[index].type?.split(' ').join('_')}');
        _contentController
            .getParam(menuTitleData[index].type!.split(' ').join('_'));
      }),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefualtPadding / 4),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
              // spreadRadius: 1.5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              '${menuTitleData[index].image}',
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${menuTitleData[index].titleMenu}',
              style: GoogleFonts.mitr(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundHeader extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    // (0,0) point 1
    path.lineTo(0, h); // 2 point
    path.quadraticBezierTo(w * 0.5, h - 50, w, h);
    path.lineTo(w, h - 100);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(0, size.height * 0.4);
    path.close();

    final path2 = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width * 0.9, 0);
    path.lineTo(size.width * 0.4, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

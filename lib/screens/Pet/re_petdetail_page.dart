import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/pet_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/FadeTextAnimation.dart';

class RePetDetailPage extends StatefulWidget {
  const RePetDetailPage({Key? key}) : super(key: key);

  @override
  State<RePetDetailPage> createState() => _RePetDetailPageState();
}

class _RePetDetailPageState extends State<RePetDetailPage> {
  @override
  Widget build(BuildContext context) {
    final PetController _petController = Get.find<PetController>();

    var gsize = Get.size;
    var petImage = Get.arguments[0];
    var petName = Get.arguments[1];
    var petType = Get.arguments[2];
    var petSpecies = Get.arguments[3];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 90,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: FadeTextAnimation(
                        duration: const Duration(milliseconds: 450),
                        child: Text(
                          petName,
                          style: GoogleFonts.mitr(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeTextAnimation(
                          duration: const Duration(milliseconds: 450),
                          child: Text(
                            '${petSpecies} / ${petType}',
                            style: GoogleFonts.mitr(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            backgroundColor: Colors.orangeAccent,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: petName,
                child: Image.network(
                  petImage,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              ...List.generate(_petController.treat.length,
                  (index) => CardDetail(gsize, _petController, index))
            ]),
          ),
        ],
      ),
    );
  }

  Widget CardDetail(Size gsize, PetController _petController, int index) {
    String str = _petController.treat[index]['date'];
    var split = str.split("-");

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: gsize.width * 0.7,
          height: gsize.height * 0.3,
          decoration: BoxDecoration(
            color: Colors.orangeAccent.shade100,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                spreadRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: FadeTextAnimation(
              child: Text(
                '${_petController.treat[index]['description']}',
                style: GoogleFonts.mitr(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Container(
          margin: EdgeInsets.only(top: 20),
          width: gsize.width * 0.2,
          height: gsize.height * 0.3,
          decoration: BoxDecoration(
            color: kDefualtColorMain,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                spreadRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTextAnimation(
                      child: Text(
                        '${split[0]}',
                        style: GoogleFonts.mitr(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTextAnimation(
                    child: Text(
                      '${split[2]} / ${split[1]}',
                      style: GoogleFonts.mitr(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

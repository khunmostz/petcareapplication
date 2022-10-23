import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/pet_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:readmore/readmore.dart';

class PetDetailPage extends StatefulWidget {
  const PetDetailPage({Key? key}) : super(key: key);

  @override
  State<PetDetailPage> createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  final PetController _petController = Get.find<PetController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(_petController.treat.length.toString());

    var petImage = Get.arguments[0];
    var petName = Get.arguments[1];
    var petType = Get.arguments[2];
    var petSpecies = Get.arguments[3];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
            ),
            Container(
              width: size.width,
              height: size.height * 0.4,
              child: Hero(
                tag: petName,
                child: Image.network(
                  petImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            '${petName}'.toUpperCase(),
                            style: GoogleFonts.mitr(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${petType} / '.toUpperCase(),
                                style: GoogleFonts.mitr(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                '${petSpecies}'.toUpperCase(),
                                style: GoogleFonts.mitr(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ...List.generate(
                            _petController.treat.length,
                            (index) => BlogContent(
                              index: index,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogContent extends StatelessWidget {
  const BlogContent({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final PetController _petController = Get.find<PetController>();
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            width: size.width,
            height: 100,
            // decoration: BoxDecoration(
            //   border: Border.all(),
            // ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Container(
                    width: size.width * 0.8,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade500.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: Offset(-4, -4),
                        ),
                        BoxShadow(
                          color: kDefualtColorMain,
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _petController.treat[index]['date'] == null
                            ? 'ไม่มีข้อมูลการักษา'
                            : '${_petController.treat[index]['date']}',
                        style: GoogleFonts.mitr(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 10,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: size.width,
            height: size.height * 0.2,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: size.width,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFF025564),
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
                      child: SingleChildScrollView(
                        child: ReadMoreText(
                          '${_petController.treat[index]['description']}',
                          trimLines: 5,
                          style: GoogleFonts.mitr(
                              color: Colors.white, fontSize: 16),
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '...Show more',
                          trimExpandedText: ' show less',
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.bookmark,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

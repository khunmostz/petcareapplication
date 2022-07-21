import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/data/petData.dart';
import 'package:petcare_project/utils/constant.dart';

class MyPetPage extends StatefulWidget {
  const MyPetPage({Key? key}) : super(key: key);

  @override
  State<MyPetPage> createState() => _MyPetPageState();
}

class _MyPetPageState extends State<MyPetPage> {
  double boxSize = 150.0;

  final ScrollController _scrollController = ScrollController();

  void onListen() {
    setState(() {});
    // print(_scrollController.offset);
  }

  @override
  void initState() {
    petData.addAll(List.from(petData));
    _scrollController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'My Pets',
                  style: GoogleFonts.mitr(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: petData.length,
                  (context, index) {
                    final pet = petData[index];
                    final itemPositionOffset = index * boxSize / 2;
                    final difference =
                        _scrollController.offset - itemPositionOffset;
                    final percent = 1 - (difference / boxSize / 2);
                    // if (index == 0) print(percent);

                    double opacity = percent;
                    double scale = percent;
                    if (opacity < 0) opacity = 0;
                    if (opacity > 1.0) opacity = 1.0;
                    if (scale > 1.0) scale = 1.0;

                    // Widget
                    return Align(
                      heightFactor: 0.5,
                      child: Opacity(
                        opacity: opacity,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..scale(scale, 1.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            color: kDefualtColorMain,
                            child: SizedBox(
                              height: boxSize,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        pet.name,
                                        style: GoogleFonts.mitr(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: size.width * 0.4,
                                      height: size.height * 0.3 / 2,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          pet.image,
                                          fit: BoxFit.cover,
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
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class myCustomHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Text('My Pets');
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

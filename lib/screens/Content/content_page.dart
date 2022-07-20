import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petcare_project/controllers/auth_controller.dart';
import 'package:petcare_project/screens/Profile/profile_page.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/data/menuData.dart';
import 'package:petcare_project/data/recommendData.dart';
import 'package:petcare_project/screens/Content/maps_page.dart';
import 'package:petcare_project/screens/Record/record_page.dart';
import 'package:petcare_project/widget/search_bar.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              height:
                  size.height < 920 ? size.height * 0.45 : size.height * 0.35,
              decoration: BoxDecoration(
                  color: kDefualtColorMain,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  )),
              child: Padding(
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
                        IconButton(
                          onPressed: () {
                            _authController.signOut();
                          },
                          icon: Icon(
                            Icons.logout,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hi User',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade50,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        // border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade50,
                            spreadRadius: 0.5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: SearchField(),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: size.width,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                  // border: Border.all(),
                  ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 130,
                    childAspectRatio: 1.6,
                    mainAxisExtent: 120,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: menuTitleData.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapsPage(),
                          ),
                        );
                      }),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: kDefualtPadding / 4),
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Recommend
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recommend",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      width: size.width,
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommendData.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 175, 175, 175),
                                        spreadRadius: 0,
                                        blurRadius: 5,
                                        offset: Offset(-1, 5),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      "${recommendData[index].imageRecommend}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("${recommendData[index].titleMenu}")
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // dummy container
                    Container(
                      width: double.infinity,
                      height: 500,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            )

            // Container(
            //   width: double.infinity,
            //   height: size.height,
            //   color: Colors.black,
            // ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petcare_project/constant.dart';
import 'package:petcare_project/data/menuData.dart';
import 'package:petcare_project/data/recommendData.dart';

import '../widget/search_bar.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

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
              height: size.height * 0.3,
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
                        Icon(
                          Icons.person,
                          size: 25,
                        ),
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
                          ]),
                      child: SearchField(),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // grid menu list
            // test
            // Text('${menuTitleData[0].titleMenu}'),
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
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    );
                  },
                ),
              ),
            ),
            // recommend
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

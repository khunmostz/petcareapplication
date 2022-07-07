import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:readmore/readmore.dart';

import '../data/petData.dart';

class MyPetPage extends StatefulWidget {
  const MyPetPage({Key? key}) : super(key: key);

  @override
  State<MyPetPage> createState() => _MyPetPageState();
}

class _MyPetPageState extends State<MyPetPage> {
  bool _selected = false;
  var _selectId;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: ListView.builder(
                      itemCount: petData.length,
                      itemBuilder: (context, index) {
                        return popContainer(size, index, _selected);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget popContainer(Size size, int index, bool isSelected) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: kDefualtColorMain,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${petData[index].image}",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("object");
                    setState(() {
                      _selected == !_selected;
                    });
                  },
                  child: _selected == true
                      ? Icon(Icons.arrow_drop_down)
                      : Icon(Icons.arrow_drop_up),
                ),
              ],
            ),
          ),
        ),
        _selected == true
            ? Container()
            : TweenAnimationBuilder(
                child: Container(
                  width: size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Color.fromARGB(255, 255, 150, 79),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                ),
                duration: Duration(seconds: 1),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (BuildContext context, double _var, child) {
                  return Opacity(
                    opacity: _var,
                    child: Padding(
                      padding: EdgeInsets.only(top: _var * 20),
                      child: child,
                    ),
                  );
                },
              ),
      ],
    );
  }
}

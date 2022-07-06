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
  bool _selected = true;
  List<Pet> _checkData = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefualtPadding),
                child: Column(
                  children: [
                    ...List.generate(6, (index) => popContainer(size)),
                    ...petData.where((value) {
                      return value.id == 1;
                    }).map((data) => Text('${data.name}')),
                  ],
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

  Widget popContainer(
    Size size,
  ) {
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
                    "${petData[0].image}",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selected = !_selected;
                      print(_selected);
                    });
                  },
                  child: Text(
                    '${petData[0].name}',
                    style: GoogleFonts.mitr(
                      fontSize: 16,
                    ),
                  ),
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

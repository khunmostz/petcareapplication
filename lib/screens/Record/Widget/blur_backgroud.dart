import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:petcare_project/data/petData.dart';

class BlurBackGroud extends StatelessWidget {
  const BlurBackGroud({
    Key? key,
    required this.size,
    required int selectedIndex,
    required this.pet,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  final Size size;
  final int _selectedIndex;
  final List pet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 200,
      child: PageView.builder(
        controller: PageController(),
        itemCount: petData.length,
        itemBuilder: (context, index) {
          return Container(
            width: size.width,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('${pet.toString()}'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(),
            ),
          );
        },
      ),
    );
  }
}

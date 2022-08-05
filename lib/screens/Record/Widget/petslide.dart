import 'package:flutter/material.dart';
import 'package:petcare_project/controllers/record_controller.dart';
import 'package:petcare_project/utils/constant.dart';

class PetSlide extends StatelessWidget {
  final String pet;
  const PetSlide({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kDefualtPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(-1, 5),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(
            '${pet}',
            scale: 0.5,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

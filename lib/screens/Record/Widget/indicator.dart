import 'package:flutter/material.dart';
import 'package:petcare_project/utils/constant.dart';

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 0.4),
      width: isActive ? 22.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive ? kDefualtColorMain : Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}

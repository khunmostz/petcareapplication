import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';

class ContentAnimation extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    offsetAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticIn,
    ));
    animationController.forward();
    animationController.addListener(() {
      // print(animationController.value);
    });
    print('onInitRun');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
}

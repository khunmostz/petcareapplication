import 'dart:ui';

import 'package:flutter/material.dart';

class FadeTextAnimation extends StatelessWidget {
  const FadeTextAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        duration: duration,
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, _) {
          return AnimatedOpacity(
            duration: const Duration(),
            curve: Curves.easeIn,
            opacity: value,
            child: child,
          );
        });
  }
}

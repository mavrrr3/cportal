import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  final double bottomPosition;
  const Loader({
    Key? key,
    this.bottomPosition = -54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottomPosition,
      left: 0,
      right: 0,
      child: Lottie.asset(
        'assets/lottie/loader.zip',
        width: 140,
        height: 140,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -54,
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

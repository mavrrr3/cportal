// ignore_for_file: prefer_int_literals

import 'package:flutter/material.dart';

class PinCodeInputAnimation {
  final AnimationController controller;
  final Animation<double> boxScaleIn;

  PinCodeInputAnimation(this.controller)
      : boxScaleIn = Tween(begin: 1.0, end: 1.2).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeIn,
          ),
        );
}

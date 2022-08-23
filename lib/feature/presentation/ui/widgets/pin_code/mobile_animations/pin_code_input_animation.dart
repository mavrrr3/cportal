// ignore_for_file: prefer_int_literals

import 'package:flutter/material.dart';

class PinCodeInputAnimation {
  final AnimationController controller;
  final Animation<double> boxScale;

  PinCodeInputAnimation(this.controller)
      : boxScale = Tween(begin: 1.0, end: 1.2).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeIn,
          ),
        );
}

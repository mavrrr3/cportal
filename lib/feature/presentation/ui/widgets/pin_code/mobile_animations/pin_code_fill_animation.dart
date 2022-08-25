import 'package:flutter/material.dart';

class PinCodeFillAnimation {
  final AnimationController controller;
  final Animation<Color?> boxColor;

  PinCodeFillAnimation(this.controller)
      : boxColor = ColorTween(begin: Colors.grey, end: Colors.blue).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeInOut,
          ),
        );
}

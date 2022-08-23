// ignore_for_file: prefer_int_literals

import 'package:flutter/material.dart';

class PinCodeSuccessAnimation {
  final AnimationController controller;
  final Animation<double> boxScale;
  final Animation<double> boxPosition;
  final Animation<double> boxOpacity;
  final Animation<double> boxLoading;
  PinCodeSuccessAnimation(this.controller)
      : boxScale = Tween(begin: 1.0, end: 1.2).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              0.2,
              curve: Curves.easeInOut,
            ),
          ),
        ),
        boxPosition = Tween(begin: 0.2, end: 0.6).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.2,
              0.6,
              curve: Curves.easeInOut,
            ),
          ),
        ),
        boxOpacity = Tween(begin: 0.6, end: 0.8).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.6,
              0.8,
              curve: Curves.easeInOut,
            ),
          ),
        ),
        boxLoading = Tween(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.8,
              1.0,
              curve: Curves.easeInOut,
            ),
          ),
        );
}

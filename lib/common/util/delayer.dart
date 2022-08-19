import 'dart:async';
import 'package:flutter/material.dart';

class Delayer {
  final int milliseconds;
  VoidCallback? action;
  Timer? timer;

  Delayer({
    required this.milliseconds,
    this.action,
    this.timer,
  });

  void run(VoidCallback action) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  static Stream<String> tick({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => (ticks - x - 1).toString(),
    ).take(ticks);
  }
}

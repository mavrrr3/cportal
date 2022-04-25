import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  Widget build(BuildContext context) {
    return Swipe(
      onSwipeRight: () => GoRouter.of(context).pop(),
      child: Column(
        children: [],
      ),
    );
  }
}

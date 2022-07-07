import 'package:flutter/material.dart';

class Cursor extends StatelessWidget {
  const Cursor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1,
        height: 24,
        decoration: BoxDecoration(
          color: const Color(0xFF2A85FF),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

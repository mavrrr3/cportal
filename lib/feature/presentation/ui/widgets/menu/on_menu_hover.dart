import 'package:flutter/material.dart';

class OnMenuHover extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  const OnMenuHover({Key? key, required this.builder}) : super(key: key);

  @override
  State<OnMenuHover> createState() => _OnMenuHoverState();
}

class _OnMenuHoverState extends State<OnMenuHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: widget.builder(isHovered),
    );
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String path;
  final double width;
  final Color? color;
  const SvgIcon(this.color, {Key? key, required this.path, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      color: color,
    );
  }
}

import 'package:flutter/material.dart';

class RoundedTabIndicator extends Decoration {
  final BoxPainter _painter;

  RoundedTabIndicator({
    required Color color,
    required bool isMobile,
    double radius = 4.0,
    double height = 2.5,
    double bottomMargin = 0.0,
  }) : _painter = _RoundedPainter(
          color,
          height,
          radius,
          bottomMargin,
          isMobile,
        );

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _RoundedPainter extends BoxPainter {
  final double radius;
  final double height;
  final double bottomMargin;
  final bool isMobile;
  final Paint _paint;

  _RoundedPainter(
    Color color,
    this.height,
    this.radius,
    this.bottomMargin,
    this.isMobile,
  ) : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuratiom) {
    final double padding = configuratiom.size!.width / 2 + offset.dx;
    final centerX = isMobile ? padding : padding - 4;
    final bottom = configuratiom.size!.height - bottomMargin;
    final width = configuratiom.size!.width / 2;
    canvas.drawRRect(
      RRect.fromLTRBR(
        centerX - width,
        bottom - height,
        centerX + width,
        bottom,
        Radius.circular(radius),
      ),
      _paint,
    );
  }
}

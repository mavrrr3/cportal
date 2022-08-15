import 'package:flutter/material.dart';

class RoundedTabIndicator extends Decoration {
  final BoxPainter _painter;

  RoundedTabIndicator({
    required Color color,
    double radius = 4.0,
    double height = 2.5,
    double bottomMargin = 0.0,
  }) : _painter = _RoundedPainter(
          color,
          height,
          radius,
          bottomMargin,
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
  final Paint _paint;

  _RoundedPainter(
    Color color,
    this.height,
    this.radius,
    this.bottomMargin,
  ) : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuratiom) {
    final centerX = configuratiom.size!.width / 2 + offset.dx;
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

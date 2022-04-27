import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.animationController,
    required this.position,
    required this.currentIndex,
  }) : super(key: key);

  final AnimationController animationController;
  final int position;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              _buildContainer(
                double.infinity,
                position < currentIndex
                    ? theme.primaryColor
                    : theme.cardColor.withOpacity(0.34),
              ),
              position == currentIndex
                  ? AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) => _buildContainer(
                        constraints.maxWidth * animationController.value,
                        theme.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildContainer(double width, Color color) {
    return Container(
      height: 2.0.h,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

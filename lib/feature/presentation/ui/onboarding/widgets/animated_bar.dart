import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  final AnimationController animationController;
  final int position;
  final int currentIndex;
  final double height;

  const AnimatedBar({
    Key? key,
    required this.animationController,
    required this.position,
    required this.currentIndex,
    this.height = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              _BuildContainer(
                width: double.infinity,
                height: height,
                color: position < currentIndex
                    ? theme.primaryColor
                    : theme.cardColor.withOpacity(0.34),
              ),
              if (position == currentIndex)
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) => _BuildContainer(
                    height: height,
                    width: constraints.maxWidth * animationController.value,
                    color: theme.primaryColor,
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          );
        }),
      ),
    );
  }
}

class _BuildContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const _BuildContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

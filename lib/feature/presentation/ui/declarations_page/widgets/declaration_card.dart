import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeclarationCard extends StatelessWidget {
  final double width;
  final String svgPath;
  final String text;
  const DeclarationCard({
    Key? key,
    required this.width,
    required this.svgPath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: width,
      height: 92,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            child: SvgPicture.asset(
              svgPath,
              width: 20,
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 26,
              bottom: 10,
            ),
            child: Text(
              text,
              style: theme.textTheme.headline6!.copyWith(
                color: theme.cardColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

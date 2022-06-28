import 'package:cportal_flutter/common/custom_theme.dart';
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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: width,
      height: 92,
      decoration: BoxDecoration(
        color: theme.cardColor,
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
              color: theme.textLight,
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.px14.copyWith(
                color: theme.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

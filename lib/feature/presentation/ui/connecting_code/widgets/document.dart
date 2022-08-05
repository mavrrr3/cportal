import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Document extends StatelessWidget {
  final String text;
  final Color? color;

  const Document({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return SizedBox(
      width: 141,
      child: Column(
        children: [
          SvgPicture.asset(
            ImageAssets.document,
            color: color,
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: theme.textTheme.px16.copyWith(
              height: 1.5,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ],
      ),
    );
  }
}

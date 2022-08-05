import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeclarationCard extends StatelessWidget {
  final double width;
  final String svgPath;
  final String text;
  const DeclarationCard({
    Key? key,
    this.width = 156,
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              svgPath,
              color: theme.textLight,
              width: 20,
            ),
            const SizedBox(height: 20),
            Expanded(
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
      ),
    );
  }
}

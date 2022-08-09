import 'dart:math';

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionItemArrow extends StatelessWidget {
  const SectionItemArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Transform.rotate(
      angle: -pi / 2,
      child: SvgPicture.asset(
        ImageAssets.arrowDown,
        color: theme.primary,
        width: 24,
        height: 24,
      ),
    );
  }
}

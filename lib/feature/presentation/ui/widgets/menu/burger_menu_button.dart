import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BurgerMenuButton extends StatelessWidget {
  final Function() onTap;
  const BurgerMenuButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
        child: SvgPicture.asset(
          ImageAssets.burgerMenu,
          width: 24,
          color: theme.text,
        ),
      ),
    );
  }
}

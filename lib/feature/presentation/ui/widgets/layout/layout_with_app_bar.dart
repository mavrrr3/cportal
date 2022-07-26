import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LayoutWithAppBar extends StatelessWidget {
  final String title;
  final Widget child;

  const LayoutWithAppBar({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: SafeArea(
          child: Center(
            child: Row(
              children: [
                MaterialButton(
                  shape: const CircleBorder(),
                  onPressed: context.pop,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: 44,
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 24,
                    child: SvgPicture.asset(
                      ImageAssets.backArrow,
                      color: theme.text,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.header,
                ),
              ],
            ),
          ),
        ),
      ),
      body: child,
    );
  }
}

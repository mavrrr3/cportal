import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthMobileLayout extends StatelessWidget {
  final Widget? appBarPrefix;
  final Widget? appBarSuffix;
  final Widget child;

  const AuthMobileLayout({
    Key? key,
    this.appBarPrefix,
    this.appBarSuffix,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appBarPrefix ??
                          SvgPicture.asset(
                            ImageAssets.logo,
                            color: theme.text?.withOpacity(0.4),
                            width: 24,
                            height: 32,
                          ),
                      appBarSuffix ?? const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Flexible(child: child),
            if (MediaQuery.of(context).padding.bottom == 0)
              const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/splash_widget.dart';
import 'package:flutter/material.dart';

class AuthDesktopLayout extends StatelessWidget {
  final Widget child;

  const AuthDesktopLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          const SplashWidget.desktop(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

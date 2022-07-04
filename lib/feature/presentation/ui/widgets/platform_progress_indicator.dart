import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformProgressIndicator extends StatelessWidget {
  const PlatformProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return isIos
        ? const CupertinoActivityIndicator(
            radius: 15,
          )
        : const CircularProgressIndicator(
            strokeWidth: 3,
          );
  }
}

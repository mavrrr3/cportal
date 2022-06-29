import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformProgressIndicator extends StatelessWidget {
  const PlatformProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform != TargetPlatform.iOS
        ? const CircularProgressIndicator(
            strokeWidth: 3,
          )
        : const CupertinoActivityIndicator(
            radius: 15,
          );
  }
}

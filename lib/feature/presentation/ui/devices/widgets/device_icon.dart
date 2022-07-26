import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/device/device_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceIcon extends StatelessWidget {
  final DevicePlatform platform;

  const DeviceIcon({
    Key? key,
    required this.platform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    switch (platform) {
      case DevicePlatform.android:
        return SvgPicture.asset(ImageAssets.android);
      case DevicePlatform.ios:
        return SvgPicture.asset(
          ImageAssets.apple,
          color: theme.brightness == Brightness.light ? theme.black : theme.text,
        );
      default:
        return SvgPicture.asset(
          ImageAssets.desktop,
          color: theme.primary,
        );
    }
  }
}

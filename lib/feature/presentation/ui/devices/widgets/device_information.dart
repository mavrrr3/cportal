import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeviceInformation extends StatelessWidget {
  final String deviceName;
  final String osVersion;
  final String location;
  final bool online;

  const DeviceInformation({
    Key? key,
    required this.deviceName,
    required this.osVersion,
    required this.location,
    required this.online,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Center(
            child: SvgPicture.asset(ImageAssets.android),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              deviceName,
              style: theme.textTheme.px14.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              osVersion,
              style: theme.textTheme.px14.copyWith(
                height: 1.43,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  location,
                  style: theme.textTheme.px14.copyWith(
                    color: theme.text?.withOpacity(0.68),
                    height: 1.33,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'deviceName',
                  style: theme.textTheme.px14.copyWith(
                    color: theme.text?.withOpacity(0.68),
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class DeviceInformation extends StatelessWidget {
  final String deviceName;
  final String osVersion;
  final String location;
  final String connectingStatus;
  final Widget icon;

  const DeviceInformation({
    Key? key,
    required this.deviceName,
    required this.osVersion,
    required this.location,
    required this.connectingStatus,
    required this.icon,
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
          child: Center(child: icon),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deviceName,
                style: theme.textTheme.px14Bold.copyWith(),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                osVersion,
                style: theme.textTheme.px14.copyWith(
                  height: 1.43,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      location,
                      style: theme.textTheme.px14.copyWith(
                        color: theme.text?.withOpacity(0.68),
                        height: 1.33,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      connectingStatus,
                      style: theme.textTheme.px14.copyWith(
                        color: theme.text?.withOpacity(0.68),
                        height: 1.33,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

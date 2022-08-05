import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/device/connecting_device_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/device_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainDevice extends StatelessWidget {
  final ConnectingDeviceEntity device;

  const MainDevice({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizedStrings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            localizedStrings.mainDevice,
            style: theme.textTheme.px22.copyWith(
              height: 1.27,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: DeviceInformation(
            deviceName: device.device,
            osVersion: device.deviceDescription,
            location: device.location,
            connectingStatus: localizedStrings.online,
            icon: DeviceIcon(platform: device.platform),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

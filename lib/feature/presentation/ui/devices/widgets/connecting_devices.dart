import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/date_time_util.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connectinng_devices_bloc/connecting_devices_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/device_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/device_information.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/end_other_sessions_popup.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectingDevices extends StatelessWidget {
  const ConnectingDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<ConnectingDevicesBloc, ConnectingDevicesState>(
      builder: (context, state) {
        if (state is ConnectingDevicesLoaded && state.connectingDevices.isNotEmpty) {
          final mainDevice = state.connectingDevices.first;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  strings.mainDevice,
                  style: theme.textTheme.px22,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: DeviceInformation(
                  deviceName: mainDevice.device,
                  osVersion: mainDevice.deviceDescription,
                  location: mainDevice.location,
                  connectingStatus: strings.online,
                  icon: DeviceIcon(platform: mainDevice.platform),
                ),
              ),
              const SizedBox(height: 18),
              if (state.connectingDevices.length > 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: () => showDialog<void>(
                        context: context,
                        builder: (context) => const EndOtherSessionsPopup(),
                      ),
                      child: Center(
                        child: Text(
                          strings.endOtherSessions,
                          style: theme.textTheme.px16.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.red,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        thickness: 1,
                        height: 32,
                        color: theme.divider,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        strings.otherDevices,
                        style: theme.textTheme.px22,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.connectingDevices.length - 1,
                      itemBuilder: (context, index) {
                        final deviceInfo = state.connectingDevices[index + 1];

                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: DeviceInformation(
                            deviceName: deviceInfo.device,
                            osVersion: deviceInfo.deviceDescription,
                            location: deviceInfo.location,
                            connectingStatus: DateTimeUtil.getFormattedDate(deviceInfo.lastConnection),
                            icon: DeviceIcon(platform: deviceInfo.platform),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                    ),
                  ],
                ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

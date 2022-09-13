import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/date_time_util.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connectinng_devices_bloc/connecting_devices_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/device_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/device_information.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/end_other_sessions_popup.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/main_device.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/bottom_padding.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/layout_with_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ConnectingDevicesScreen extends StatefulWidget {
  const ConnectingDevicesScreen({Key? key}) : super(key: key);

  @override
  State<ConnectingDevicesScreen> createState() => _ConnectingDevicesScreenState();
}

class _ConnectingDevicesScreenState extends State<ConnectingDevicesScreen> {
  @override
  void initState() {
    context.read<ConnectingDevicesBloc>().add(LoadConnectingDevices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizedStrings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return QuestionMobileLayoutWithAppBar(
      title: localizedStrings.devices,
      child: BlocBuilder<ConnectingDevicesBloc, ConnectingDevicesState>(
        builder: (context, state) {
          if (state is ConnectingDevicesLoaded && state.connectingDevices.isNotEmpty) {
            final mainDevice = state.connectingDevices.first;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: SvgPicture.asset(
                          theme.brightness == Brightness.light ? ImageAssets.monitorLight : ImageAssets.monitorDark,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32, bottom: 16),
                          child: Text(
                            localizedStrings.enterWithQrText,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.px16.copyWith(height: 1.25),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: theme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => context.pushNamed(
                            NavigationRouteNames.qrScanner,
                            // ignore: avoid_types_on_closure_parameters
                            extra: (String scannedData) {
                              context.read<ConnectingDevicesBloc>().add(SendScannedData(scannedData));
                              context.pop();
                            },
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                localizedStrings.connectDevice,
                                style: theme.textTheme.px16Bold.copyWith(color: theme.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      MainDevice(device: mainDevice),
                      MaterialButton(
                        onPressed: () => showDialog<void>(
                          context: context,
                          builder: (context) => const EndOtherSessionsPopup(),
                        ),
                        child: Center(
                          child: Text(
                            localizedStrings.endOtherSessions,
                            style: theme.textTheme.px16Bold.copyWith(color: theme.red),
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
                          localizedStrings.otherDevices,
                          style: theme.textTheme.px22.copyWith(
                            height: 1.27,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.connectingDevices.length - 1,
                    (context, index) {
                      final deviceInfo = state.connectingDevices[index + 1];
                      // Last element.
                      final isLast = index == state.connectingDevices.length - 2;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: DeviceInformation(
                              deviceName: deviceInfo.device,
                              osVersion: deviceInfo.deviceDescription,
                              location: deviceInfo.location,
                              connectingStatus: DateTimeUtil.getFormattedDate(deviceInfo.lastConnection),
                              icon: DeviceIcon(platform: deviceInfo.platform),
                            ),
                          ),
                          if (!isLast) const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                  child: BottomPadding(),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

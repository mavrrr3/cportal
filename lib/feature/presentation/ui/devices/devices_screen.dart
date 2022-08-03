import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connectinng_devices_bloc/connecting_devices_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/connecting_devices.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/layout_with_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  void initState() {
    context.read<ConnectingDevicesBloc>().add(LoadConnectingDevices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return LayoutWithAppBar(
      title: strings.devices,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SvgPicture.asset(
                theme.brightness == Brightness.light ? ImageAssets.monitorLight : ImageAssets.monitorDark,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
                strings.enterWithQrText,
                textAlign: TextAlign.center,
                style: theme.textTheme.px16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  primary: theme.primary,
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
                      strings.connectDevice,
                      style: theme.textTheme.px16.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const ConnectingDevices(),
          ],
        ),
      ),
    );
  }
}

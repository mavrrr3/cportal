import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/device_information.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/widgets/exit_other_device_popup.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/layout_with_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key? key}) : super(key: key);

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
              child: SvgPicture.asset(ImageAssets.addDeviceLogo),
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
                onPressed: () => context.pushNamed(NavigationRouteNames.qrScanner),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  strings.mainDevice,
                  style: theme.textTheme.px22,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: DeviceInformation(
                deviceName: 'Samsung Galaxy S8',
                osVersion: 'KoApp Android 8.8.5',
                location: 'Moscow, Russia',
                online: true,
              ),
            ),
            const SizedBox(height: 18),
            MaterialButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (context) => const ExitOtherDevicePopup(),
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
            Divider(
              thickness: 1,
              height: 32,
              color: theme.black?.withOpacity(0.08),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  strings.otherDevices,
                  style: theme.textTheme.px22,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.only(left: 16),
                child: DeviceInformation(
                  deviceName: 'Samsung Galaxy S8',
                  osVersion: 'KoApp Android 8.8.5',
                  location: 'Moscow, Russia',
                  online: true,
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            ),
          ],
        ),
      ),
    );
  }
}

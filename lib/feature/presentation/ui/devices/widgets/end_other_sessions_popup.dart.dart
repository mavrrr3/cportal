import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connectinng_devices_bloc/connecting_devices_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EndOtherSessionsPopup extends StatelessWidget {
  const EndOtherSessionsPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Dialog(
      backgroundColor: theme.cardColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 252,
        width: double.infinity,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Text(
                  strings.singOutFromOtherDevices,
                  style: theme.textTheme.px22.copyWith(height: 1.27),
                ),
              ),
            ),
            SvgPicture.asset(
              ImageAssets.exit,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                strings.areYouSureEndSessions,
                style: theme.textTheme.px14.copyWith(height: 1.43),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 4, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      primary: theme.primary,
                    ),
                    child: Text(
                      strings.cancelLowerCase,
                      style: theme.textTheme.px16.copyWith(
                        color: theme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      context.read<ConnectingDevicesBloc>().add(EndOtherSessions());
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      primary: theme.primary,
                    ),
                    child: Text(
                      strings.exit,
                      style: theme.textTheme.px16.copyWith(
                        color: theme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/disable_notification_select.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/profile_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisableNotificationBottomSheet extends StatelessWidget {
  final SwitchController notificationController;

  const DisableNotificationBottomSheet({
    Key? key,
    required this.notificationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizedStrings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 6, left: 16),
            child: Text(
              localizedStrings.turnOffNotify,
              style: theme.textTheme.px16,
            ),
          ),
          DisableNotificationSelect(
            title: localizedStrings.forHour,
            snackText: localizedStrings.oneHourCancelNotify,
            notificationController: notificationController,
          ),
          DisableNotificationSelect(
            title: localizedStrings.forFourHour,
            snackText:
                '${localizedStrings.notificationsTurnedOff} ${localizedStrings.on} ${localizedStrings.forFourHour}',
            notificationController: notificationController,
          ),
          DisableNotificationSelect(
            title: localizedStrings.forTwentyFourHour,
            snackText:
                '${localizedStrings.notificationsTurnedOff} ${localizedStrings.on} ${localizedStrings.forTwentyFourHour}',
            notificationController: notificationController,
          ),
          DisableNotificationSelect(
            title: localizedStrings.forever,
            snackText: '${localizedStrings.notificationsTurnedOff} ${localizedStrings.forever.toLowerCase()}',
            notificationController: notificationController,
          ),
        ],
      ),
    );
  }
}

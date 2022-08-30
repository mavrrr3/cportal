import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/profile_page.dart';

import 'package:flutter/material.dart';

class ProfileSwitch extends StatelessWidget {
  final SwitchController controller;
  final ProfileSwitchType? switchType;
  const ProfileSwitch({
    Key? key,
    this.switchType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return SizedBox(
      height: 20,
      width: 34,
      child: ValueListenableBuilder<bool>(
        valueListenable: controller,
        builder: (context, value, _) => Switch(
          activeTrackColor: theme.primary?.withOpacity(0.38),
          activeColor: theme.primary,
          inactiveTrackColor: theme.text?.withOpacity(0.08),
          inactiveThumbColor: theme.cardColor,
          value: value,
          onChanged: (value) {
            if (!value && switchType == ProfileSwitchType.notification) {
              _showDisableNotificationPopup(context);
              if (value) controller.value = value;
            }
            if (switchType == ProfileSwitchType.fingerPrint) {
              _turnOnOffFingerPrint(context);
              controller.value = context
                  .findAncestorStateOfType<ProfilePageState>()!
                  .isEnabledFingerPrint;
            }
          },
        ),
      ),
    );
  }

  void _showDisableNotificationPopup(BuildContext context) {
    context
        .findAncestorStateOfType<ProfilePageState>()
        ?.showDisableNotificationPopup();
  }

  void _turnOnOffFingerPrint(BuildContext context) {
    context.findAncestorStateOfType<ProfilePageState>()?.turnOnOffFingerPrint();
  }
}

/// A controller for a switch.
///
/// [value] is true, then switch is on, otherwise is false.
class SwitchController extends ValueNotifier<bool> {
  /// Initial value for controller.
  final bool isEnabled;

  /// Creates a controller for a switch.
  SwitchController({
    this.isEnabled = false,
  }) : super(isEnabled);
}

enum ProfileSwitchType { notification, fingerPrint }

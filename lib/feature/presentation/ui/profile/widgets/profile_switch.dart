import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class ProfileSwitch extends StatelessWidget {
  final SwitchController controller;

  const ProfileSwitch({
    Key? key,
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
          onChanged: (value) => controller.value = value,
        ),
      ),
    );
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

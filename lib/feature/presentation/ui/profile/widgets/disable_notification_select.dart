import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/profile_switch.dart';
import 'package:flutter/material.dart';

class DisableNotificationSelect extends StatelessWidget {
  final String title;
  final String snackText;
  final SwitchController notificationController;

  const DisableNotificationSelect({
    Key? key,
    required this.title,
    required this.snackText,
    required this.notificationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return InkWell(
      radius: 0,
      onTap: () {
        // Switch off.
        notificationController.value = false;
        // Close DisableNotificationBottomSheet.
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            backgroundColor: theme.text,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            content: Text(
              snackText,
              style: theme.textTheme.px14.copyWith(
                color: theme.brightness == Brightness.light ? theme.cardColor : theme.background,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: double.infinity,
          ),
          child: Text(
            title,
            style: theme.textTheme.px16Bold,
          ),
        ),
      ),
    );
  }
}

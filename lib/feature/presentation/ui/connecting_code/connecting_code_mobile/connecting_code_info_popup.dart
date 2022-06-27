import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/phone_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/what_get_with_you.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/work_mode_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectingCodeInfoPopup extends StatefulWidget {
  const ConnectingCodeInfoPopup({Key? key}) : super(key: key);

  @override
  State<ConnectingCodeInfoPopup> createState() => _ConnectingCodeInfoPopupState();
}

class _ConnectingCodeInfoPopupState extends State<ConnectingCodeInfoPopup> {
  bool isShowed = false;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      backgroundColor: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.howToGetCodeTitle,
                style: theme.textTheme.px22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.howToGetCodeText,
              style: theme.textTheme.px14,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.address,
                style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.addressForCode,
                style: theme.textTheme.px14.copyWith(
                  color: theme.textLight,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.workMode,
                  style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isShowed = !isShowed;
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 26,
                    color: theme.primary,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isShowed,
              child: const WorkModeTable(),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.getWithYou,
                style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WhatGetWithYou(
                  iconPath: ImageAssets.document,
                  text: AppLocalizations.of(context)!.passport,
                ),
                WhatGetWithYou(
                  iconPath: ImageAssets.document,
                  text: AppLocalizations.of(context)!.pass,
                  color: theme.primary,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.callBeforeCame,
                style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
              ),
            ),
            const SizedBox(height: 8),
            const PhoneButton(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${AppLocalizations.of(context)!.callAfter} 6 ${AppLocalizations.of(context)!.hours}',
                style: theme.textTheme.px14.copyWith(color: theme.red?.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              primary: theme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.close,
              style: theme.textTheme.px16.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.cardColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

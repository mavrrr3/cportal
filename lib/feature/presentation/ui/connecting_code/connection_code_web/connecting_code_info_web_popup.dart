import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/phone_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/what_get_with_you.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/work_mode_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ConnectingCodeInfoWebPopup extends StatelessWidget {
  const ConnectingCodeInfoWebPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    final double width = MediaQuery.of(context).size.width;
    final double contWidth = width * 0.515;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          SizedBox(width: width * 0.42),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 43, right: 43, top: 193),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.howToGetCodeTitleWeb,
                            style: theme.textTheme.px22,
                            softWrap: true,
                          ),
                          GestureDetector(
                            onTap: context.pop,
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.howToGetCodeText,
                        style: theme.textTheme.px14,
                        softWrap: true,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.address,
                        style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.addressForCode,
                        style: theme.textTheme.px14,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.workMode,
                        style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: contWidth * 0.52,
                        child: const WorkModeTable(),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        AppLocalizations.of(context)!.getWithYou,
                        style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: contWidth * 0.52,
                          child: Row(
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
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        AppLocalizations.of(context)!.callBeforeCame,
                        style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: contWidth * 0.45,
                        child: const PhoneButton(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${AppLocalizations.of(context)!.callAfter} 6 ${AppLocalizations.of(context)!.hours}',
                        style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

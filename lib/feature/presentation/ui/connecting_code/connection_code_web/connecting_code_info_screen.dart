import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/phone_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/what_get_with_you.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/work_mode_table.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ConnectingCodeInfoScreen extends StatelessWidget {
  const ConnectingCodeInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final double contWidth = width * 0.515;
    final double contHeigth = height * 0.643;

    return Scaffold(
      body: Row(
        children: [
          const SplashWidget.desktop(),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: contWidth,
                  maxHeight: contHeigth,
                  minHeight: contHeigth,
                  minWidth: contWidth,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(35),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: contWidth * 0.52,
                                  child: Text(
                                    AppLocalizations.of(context)!.howToGetCodeTitleWeb,
                                    style: theme.textTheme.px22,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: context.pop,
                                child: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: contWidth * 0.86,
                              child: Text(
                                AppLocalizations.of(context)!.howToGetCodeText,
                                style: theme.textTheme.px14,
                                softWrap: true,
                              ),
                            ),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: contWidth * 0.52,
                              child: const WorkModeTable(),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.getWithYou,
                              style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
                            ),
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
                                    iconPath: 'assets/icons/what_get_icon.svg',
                                    text: AppLocalizations.of(context)!.passport,
                                  ),
                                  WhatGetWithYou(
                                    iconPath: 'assets/icons/what_get_icon.svg',
                                    text: AppLocalizations.of(context)!.pass,
                                    color: theme.primary,
                                  ),
                                ],
                              ),
                            ),
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
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: PhoneButton(),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${AppLocalizations.of(context)!.callAfter} 6 ${AppLocalizations.of(context)!.hours}',
                              style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
                            ),
                          ),
                        ],
                      ),
                    ),
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

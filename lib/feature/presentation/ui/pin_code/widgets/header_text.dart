import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HeaderText {
  static HeaderTextWidget factory(
    TextEditingController pinController,
    PinCodeInputEnum input,
    BuildContext context,
  ) {
    switch (input) {
      case PinCodeInputEnum.create:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.createPinCode,
          secondText: AppLocalizations.of(context)!.itWillBeNeedToEnter,
        );
      case PinCodeInputEnum.repeat:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.repeatPinCode,
          secondText: ' ',
        );
      case PinCodeInputEnum.error:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
          error: AppLocalizations.of(context)!.errorPinCode,
        );
      case PinCodeInputEnum.wrong:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.repeatPinCode,
          secondText: '',
          error: pinController.text.length == 4
              ? AppLocalizations.of(context)!.pinNotCorrect
              : '',
        );
      default:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
        );
    }
  }
}

class HeaderTextWidget extends StatelessWidget {
  final String title;
  final String secondText;
  final String? error;

  const HeaderTextWidget({
    Key? key,
    required this.title,
    required this.secondText,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
                                 final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;


    return Column(
      children: [
        ResponsiveVisibility(
          hiddenWhen: const [
            Condition<dynamic>.largerThan(name: TABLET),
          ],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SvgIcon(null, path: 'logo_grey.svg', width: 24),
            ],
          ),
        ),
        const SizedBox(height: 31),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: theme.textTheme.header,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              secondText,
              style: theme.textTheme.px12.copyWith(
                color: secondText ==
                        AppLocalizations.of(context)!.itWillBeNeedToEnter
                    ? theme.textLight
                    : theme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 66),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error ?? '',
              style: theme.textTheme.px12.copyWith(
                color: theme.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

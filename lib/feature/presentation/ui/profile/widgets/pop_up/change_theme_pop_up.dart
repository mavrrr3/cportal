import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/pop_up/change_theme_button_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeThemePopUp extends StatefulWidget {
  const ChangeThemePopUp({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeThemePopUp> createState() => _ChangeThemePopUpState();
}

class _ChangeThemePopUpState extends State<ChangeThemePopUp> {
  late int _index;

  @override
  void initState() {
    _index = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;
    final adaptiveTheme = AdaptiveTheme.of(context);

    adaptiveTheme.mode.isLight
        ? _index = 0
        : adaptiveTheme.mode.isDark
            ? _index = 1
            : _index = 2;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            localizedStrings.appTheme,
            style: theme.textTheme.px12.copyWith(
              color: theme.textLight,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 350,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.text!.withOpacity(0.08),
            ),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  ChangeThemeButtonPopup(
                    text: localizedStrings.lightTheme,
                    onTap: () {
                      adaptiveTheme.setLight();
                      setState(() {
                        _index = 0;
                      });
                    },
                  ),
                  ChangeThemeButtonPopup(
                    text: localizedStrings.darkTheme,
                    onTap: () {
                      adaptiveTheme.setDark();
                      setState(() {
                        _index = 1;
                      });
                    },
                  ),
                  ChangeThemeButtonPopup(
                    text: localizedStrings.standartTheme,
                    onTap: () {
                      adaptiveTheme.setSystem();
                      setState(() {
                        _index = 2;
                      });
                    },
                  ),
                ],
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeIn,
                alignment: _index == 0
                    ? Alignment.centerLeft
                    : _index == 1
                        ? Alignment.center
                        : Alignment.topRight,
                child: Container(
                  width: 352 / 3,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: theme.primary,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.31),
                      ),
                    ],
                  ),
                  child: Text(
                    _setTextButtonChangeTheme(_index, localizedStrings),
                    style: theme.textTheme.px12.copyWith(
                      color: theme.brightness == Brightness.light
                          ? theme.cardColor
                          : theme.textLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _setTextButtonChangeTheme(
    int index,
    AppLocalizations localizedStrings,
  ) {
    switch (index) {
      case 0:
        return localizedStrings.lightTheme;
      case 1:
        return localizedStrings.darkTheme;
      case 2:
        return localizedStrings.standartTheme;
      default:
        return localizedStrings.lightTheme;
    }
  }
}

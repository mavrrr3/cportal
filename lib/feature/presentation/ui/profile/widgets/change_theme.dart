import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  State<ChangeTheme> createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  late int _index;
  late bool _canVibrate;

  @override
  void initState() {
    _index = 0;
    _canVibrate = true;
    _initVibrate();
    super.initState();
  }

  Future<void> _initVibrate() async {
    final bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    final double width = MediaQuery.of(context).size.width;

    final localizedStrings = AppLocalizations.of(context)!;

    final adaptiveTheme = AdaptiveTheme.of(context);

    if (adaptiveTheme.mode == AdaptiveThemeMode.light) {
      _index = 0;
    } else if (adaptiveTheme.mode == AdaptiveThemeMode.dark) {
      _index = 1;
    } else if (adaptiveTheme.mode == AdaptiveThemeMode.system) {
      _index = 2;
    }

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
          width: double.infinity,
          height: 36,
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
                  ChangeThemeButton(
                    text: localizedStrings.lightTheme,
                    onTap: () {
                      _vibrate(_canVibrate);
                      adaptiveTheme.setLight();
                      setState(() {
                        _index = 0;
                      });
                    },
                  ),
                  ChangeThemeButton(
                    text: localizedStrings.darkTheme,
                    onTap: () {
                      _vibrate(_canVibrate);
                      adaptiveTheme.setDark();
                      setState(() {
                        _index = 1;
                      });
                    },
                  ),
                  ChangeThemeButton(
                    text: localizedStrings.standartTheme,
                    onTap: () {
                      _vibrate(_canVibrate);
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
                  width: (width - 44) / 3,
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
                    _getTextForContainer(_index, localizedStrings),
                    style: theme.textTheme.px12.copyWith(
                      color: theme.brightness == Brightness.light ? theme.cardColor : theme.text,
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

  String _getTextForContainer(int index, AppLocalizations localizedStrings) {
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

  /// Вибрация по нажатию.
  void _vibrate(bool canVibrate) {
    try {
      if (canVibrate) {
        Vibrate.feedback(FeedbackType.light);
      }
    } on Exception catch (e) {
      log('Device can`t vibrate error: $e');
    }
  }
}

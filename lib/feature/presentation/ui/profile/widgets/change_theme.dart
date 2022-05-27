import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({
    Key? key,
  }) : super(key: key);

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
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width;

    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light) {
      _index = 0;
    } else if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
      _index = 1;
    } else {
      _index = 2;
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.of(context)!.appTheme,
            style: theme.textTheme.bodyText1!.copyWith(
              color: theme.hoverColor.withOpacity(0.68),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: 36.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.hoverColor.withOpacity(0.08),
            ),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  _BuildButton(
                    text: AppLocalizations.of(context)!.lightTheme,
                    onTap: () {
                      _vibrate(_canVibrate);
                      AdaptiveTheme.of(context).setLight();
                      setState(() {
                        _index = 0;
                      });
                    },
                  ),
                  _BuildButton(
                    text: AppLocalizations.of(context)!.darkTheme,
                    onTap: () {
                      _vibrate(_canVibrate);
                      AdaptiveTheme.of(context).setDark();
                      setState(() {
                        _index = 1;
                      });
                    },
                  ),
                  _BuildButton(
                    text: AppLocalizations.of(context)!.standartTheme,
                    onTap: () {
                      _vibrate(_canVibrate);
                      AdaptiveTheme.of(context).setSystem();
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
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: theme.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.31),
                      ),
                    ],
                  ),
                  child: Text(
                    _getTextForContainer(_index),
                    style: theme.textTheme.bodyText1!.copyWith(
                      color: theme.brightness == Brightness.light
                          ? theme.splashColor
                          : theme.hoverColor,
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

  String _getTextForContainer(int index) {
    switch (index) {
      case 0:
        return AppLocalizations.of(context)!.lightTheme;
      case 1:
        return AppLocalizations.of(context)!.darkTheme;
      case 2:
        return AppLocalizations.of(context)!.standartTheme;
      default:
        return AppLocalizations.of(context)!.lightTheme;
    }
  }

  /// Вибрация по нажатию
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

class _BuildButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  /// Кнопка для смены темы
  const _BuildButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
        child: SizedBox(
          width: (width - 34.w) / 3,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: theme.textTheme.bodyText1!.copyWith(
                color: theme.hoverColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

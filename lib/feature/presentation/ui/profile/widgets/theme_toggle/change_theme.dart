import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/theme_toggle/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  State<ChangeTheme> createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  AdaptiveThemeManager<ThemeData>? _adaptiveTheme;
  AppLocalizations? _localizedStrings;

  bool _canVibrate = false;
  bool _isInitialized = false;

  late final ThemeController _themeController;

  @override
  void initState() {
    _initVibrate();
    super.initState();
  }

  Future<void> _initVibrate() async {
    _canVibrate = await Vibrate.canVibrate;
  }

  @override
  void didChangeDependencies() {
    _adaptiveTheme = AdaptiveTheme.of(context);
    _localizedStrings = AppLocalizations.of(context);

    // Set initial value for theme controller.
    if (!_isInitialized) {
      if (_adaptiveTheme!.mode.isLight) {
        _themeController = ThemeController(AdaptiveThemeMode.light);
      } else if (_adaptiveTheme!.mode.isDark) {
        _themeController = ThemeController(AdaptiveThemeMode.dark);
      } else if (_adaptiveTheme!.mode.isSystem) {
        _themeController = ThemeController(AdaptiveThemeMode.system);
      }

      _isInitialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _localizedStrings!.appTheme,
          style: theme.textTheme.px12.copyWith(
            color: theme.textLight,
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
                    text: _localizedStrings!.lightTheme,
                    onTap: _setLightTheme,
                  ),
                  ChangeThemeButton(
                    text: _localizedStrings!.darkTheme,
                    onTap: _setDarkTheme,
                  ),
                  ChangeThemeButton(
                    text: _localizedStrings!.standartTheme,
                    onTap: _setSystemTheme,
                  ),
                ],
              ),
              ValueListenableBuilder<AdaptiveThemeMode>(
                valueListenable: _themeController,
                builder: (context, theme, child) {
                  return AnimatedAlign(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeIn,
                    alignment: theme.isLight
                        ? Alignment.centerLeft
                        : theme.isDark
                            ? Alignment.center
                            : Alignment.topRight,
                    child: child,
                  );
                },
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
                  child: ValueListenableBuilder<AdaptiveThemeMode>(
                    valueListenable: _themeController,
                    builder: (context, themeMode, child) {
                      return Text(
                        _getThemeButtonTitle(themeMode),
                        style: theme.textTheme.px12.copyWith(
                          color: theme.brightness == Brightness.light ? theme.cardColor : theme.text,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _setLightTheme() => _switchThemeMode(AdaptiveThemeMode.light);

  void _setDarkTheme() => _switchThemeMode(AdaptiveThemeMode.dark);

  void _setSystemTheme() => _switchThemeMode(AdaptiveThemeMode.system);

  void _switchThemeMode(AdaptiveThemeMode themeMode) {
    _vibrate();
    _themeController.value = themeMode;
    _adaptiveTheme?.setThemeMode(themeMode);
  }

  String _getThemeButtonTitle(AdaptiveThemeMode themeMode) {
    switch (themeMode) {
      case AdaptiveThemeMode.light:
        return _localizedStrings!.lightTheme;
      case AdaptiveThemeMode.dark:
        return _localizedStrings!.darkTheme;
      case AdaptiveThemeMode.system:
        return _localizedStrings!.standartTheme;
    }
  }

  /// Vibration on touch.
  void _vibrate() {
    try {
      if (_canVibrate) {
        Vibrate.feedback(FeedbackType.light);
      }
    } on Exception catch (e) {
      log('Device can`t vibrate error: $e');
    }
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }
}

/// A controller for a theme toggle.
class ThemeController extends ValueNotifier<AdaptiveThemeMode> {
  /// Creates a controller for a toggle.
  ThemeController(super.value);
}

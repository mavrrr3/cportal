// ignore_for_file: unused_element
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/avatar_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

bool _isNotificationTurnedOn = true;
var _isFingerPrintAuth = false;

class ProfilePopUp extends StatefulWidget {
  const ProfilePopUp({Key? key}) : super(key: key);

  @override
  State<ProfilePopUp> createState() => _ProfilePopUpState();
}

class _ProfilePopUpState extends State<ProfilePopUp> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    final Color? iconColor = theme.textLight;
    late ProfileEntity profile;

    void showChooserNotification(BuildContext context) {
      final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

      showModalBottomSheet<void>(
        backgroundColor: theme.cardColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.turnOffNotify,
                    style: theme.textTheme.px16,
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () => setState(() => showToasterAboutNotify(
                          theme,
                          'Оповещения выключены на 1 час',
                        )),
                    child: Text(
                      AppLocalizations.of(context)!.forHour,
                      style: theme.textTheme.px16.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppLocalizations.of(context)!.forFourHour,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppLocalizations.of(context)!.forTwentyFourHour,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppLocalizations.of(context)!.forever,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    const bool isNotificationTurnedOn = true;
    const bool isFingerPrintAuth = false;
    void turnOnOffNotify(bool newValue) {
      setState(() {
        _isNotificationTurnedOn = newValue;
        showChooserNotification(context);
      });
    }

    void turnOnOffFingerPrintAuth(bool newValue) {
      setState(() => _isFingerPrintAuth = newValue);
    }

    BlocProvider.of<GetSingleProfileBloc>(
      context,
      listen: false,
    ).add(const GetSingleProfileEventImpl(
      'A1B2C3D4E5',
      isMyProfile: true,
    ));

    return BlocBuilder<GetSingleProfileBloc, GetSingleProfileState>(
      builder: (context, state) {
        if (state is GetSingleProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetSingleProfileLoadedState) {
          profile = state.profile;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.profile,
                    style: theme.textTheme.header,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: theme.textLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                AvatarBox(
                  size: 102,
                  imgPath: profile.photoLink,
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              profile.fullName,
                              style: theme.textTheme.px17.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              profile.id,
                              style: theme.textTheme.px14.copyWith(),
                              softWrap: true,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
              ]),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleAndDescriptionRow(
                        title: AppLocalizations.of(context)!.department,
                        description: profile.position,
                      ),
                      const SizedBox(height: 8),
                      TitleAndDescriptionRow(
                        title: AppLocalizations.of(context)!.position,
                        description: profile.department,
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (profile.birthday != null)
                        TitleAndDescriptionRow(
                          title: AppLocalizations.of(context)!.birthDay,
                          description: profile.birthDayToString!,
                        ),
                      const SizedBox(height: 8),
                      TitleAndDescriptionRow(
                        title: AppLocalizations.of(context)!.email,
                        description: profile.email,
                      ),
                    ],
                  ),
                  const Flexible(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: TitleAndDescriptionRow(
                  title: 'Рабочий телефон',
                  description: profile.officePhone,
                ),
              ),
              const SizedBox(height: 32),
              Material(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 350,
                      child: Column(
                        children: [
                          Container(
                            width: 350,
                            decoration: BoxDecoration(
                              color: theme.text!.withOpacity(0.04),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .yourPhoneNumber,
                                    style: theme.textTheme.px12.copyWith(
                                      color: theme.textLight,
                                    ),
                                  ),
                                  Text(
                                    '+7 923 456 78 91',
                                    style: theme.textTheme.px16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.text!.withOpacity(0.08),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: RowProfile(
                                firstWidget: SvgIcon(
                                  iconColor,
                                  path: 'profile/add_person.svg',
                                  width: 22,
                                ),
                                text: AppLocalizations.of(context)!.newEmpoyee,
                                secondWidget: getBlueArrow(theme),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          RowProfile(
                            firstWidget: SvgIcon(
                              iconColor,
                              path: 'profile/bell.svg',
                              width: 21,
                            ),
                            text: AppLocalizations.of(context)!.notofications,
                            secondWidget: customSwitch(
                              theme,
                              isNotificationTurnedOn,
                              turnOnOffNotify,
                            ),
                          ),
                          const SizedBox(height: 24),
                          RowProfile(
                            firstWidget: SvgIcon(
                              iconColor,
                              path: 'finger_print.svg',
                              width: 20,
                            ),
                            text: AppLocalizations.of(context)!.fingerPrint,
                            secondWidget: customSwitch(
                              theme,
                              isFingerPrintAuth,
                              turnOnOffFingerPrintAuth,
                            ),
                          ),
                          const SizedBox(height: 24),
                          RowProfile(
                            firstWidget: SvgIcon(
                              iconColor,
                              path: 'profile/lock.svg',
                              width: 20,
                            ),
                            text: AppLocalizations.of(context)!.changePin,
                            secondWidget: getBlueArrow(theme),
                            call: () =>
                                context.goNamed(NavigationRouteNames.editPin),
                          ),
                          const SizedBox(height: 28),
                          const ChangeTheme(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const Center(
          child: Text('Пусто'),
        );
      },
    );
  }
}

class TitleAndDescriptionRow extends StatelessWidget {
  final String title;
  final String description;
  const TitleAndDescriptionRow({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.px14,
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.px16.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class RowProfile extends StatelessWidget {
  final Widget firstWidget;
  final String text;
  final Widget secondWidget;
  final Function? call;
  const RowProfile({
    Key? key,
    required this.firstWidget,
    required this.text,
    required this.secondWidget,
    this.call,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Row(
      children: [
        firstWidget,
        const SizedBox(
          width: 17,
        ),
        Text(
          text,
          style: theme.textTheme.px16.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        GestureDetector(
          onTap: () => call != null ? call!() : debugPrint('call = null'),
          child: secondWidget,
        ),
      ],
    );
  }
}

Widget getBlueArrow(CustomTheme theme) {
  return Icon(
    Icons.arrow_forward_ios_sharp,
    color: theme.primary,
    size: 18,
  );
}

Widget customSwitch(CustomTheme theme, bool val, Function onChangeMethod) =>
    Switch(
      activeTrackColor: theme.primary?.withOpacity(0.38),
      activeColor: theme.primary,
      hoverColor: Colors.transparent,
      // Сделал цвет такой вместо заведения нового из фигмы #D8E0E9.
      inactiveTrackColor: theme.text?.withOpacity(0.08),
      inactiveThumbColor: theme.cardColor,
      value: val,
      onChanged: (newValue) => onChangeMethod(newValue),
    );

void showToasterAboutNotify(CustomTheme theme, String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: theme.text,
    textColor: theme.cardColor,
    fontSize: 16,
  );
}

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeTheme> createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  late int _index;

  @override
  void initState() {
    _index = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? _index = 0
        : AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
            ? _index = 1
            : _index = 2;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.of(context)!.appTheme,
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
                  _BuildButtonChangeTheme(
                    text: AppLocalizations.of(context)!.lightTheme,
                    onTap: () {
                      AdaptiveTheme.of(context).setLight();
                      setState(() {
                        _index = 0;
                      });
                    },
                  ),
                  _BuildButtonChangeTheme(
                    text: AppLocalizations.of(context)!.darkTheme,
                    onTap: () {
                      AdaptiveTheme.of(context).setDark();
                      setState(() {
                        _index = 1;
                      });
                    },
                  ),
                  _BuildButtonChangeTheme(
                    text: AppLocalizations.of(context)!.standartTheme,
                    onTap: () {
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
                    _setTextButtonChangeTheme(_index),
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

  String _setTextButtonChangeTheme(int index) {
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
}

class _BuildButtonChangeTheme extends StatelessWidget {
  final String text;
  final Function() onTap;

  /// Кнопка для смены темы.
  const _BuildButtonChangeTheme({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: SizedBox(
          width: 348 / 3,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: theme.textTheme.px12.copyWith(
                color: theme.textLight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: unused_element
import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/pop_up/change_theme_pop_up.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/row_profile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/avatar_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ProfilePopUp extends StatefulWidget {
  const ProfilePopUp({Key? key}) : super(key: key);

  @override
  State<ProfilePopUp> createState() => _ProfilePopUpState();
}

class _ProfilePopUpState extends State<ProfilePopUp> {
  late CustomTheme theme;
  late AppLocalizations localizedStrings;
  bool isNotificationTurnedOn = true;
  bool isFingerPrintAuth = false;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context).extension<CustomTheme>()!;
    localizedStrings = AppLocalizations.of(context)!;

    final Color? iconColor = theme.textLight;
    late UserEntity user;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is GetSingleProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is Authenticated) {
          user = state.user;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizedStrings.profile,
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
                  imgPath: user.photoUrl,
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
                              user.name,
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
                              user.id,
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
                        title: localizedStrings.department,
                        description: user.position,
                      ),
                      const SizedBox(height: 8),
                      TitleAndDescriptionRow(
                        title: localizedStrings.position,
                        description: user.department,
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleAndDescriptionRow(
                        title: localizedStrings.birthDay,
                        description: user.birthDayToString,
                      ),
                      const SizedBox(height: 8),
                      TitleAndDescriptionRow(
                        title: localizedStrings.email,
                        description: user.email,
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
                  title: localizedStrings.office_phone,
                  description: user.officePhone,
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
                          OnHover(
                            builder: (isHovered) {
                              return Opacity(
                                opacity: isHovered ? 0.68 : 1,
                                child: Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          localizedStrings.yourPhoneNumber,
                                          style: theme.textTheme.px12.copyWith(
                                            color: theme.textLight,
                                          ),
                                        ),
                                        Text(
                                          user.personalPhone,
                                          style: theme.textTheme.px16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.text!.withOpacity(0.08),
                                ),
                              ),
                            ),
                            child: OnHover(
                              builder: (isHovered) {
                                return Opacity(
                                  opacity: isHovered ? 0.64 : 1,
                                  child: GestureDetector(
                                    onTap: () => context.goNamed(
                                      NavigationRouteNames.onBoardingStart,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20,
                                      ),
                                      child: RowProfile(
                                        firstWidget: SvgIcon(
                                          iconColor,
                                          path: ImageAssets.addPerson,
                                          width: 22,
                                        ),
                                        text: localizedStrings.newEmployee,
                                        secondWidget: getBlueArrow(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          OnHover(
                            builder: (isHovered) {
                              return Opacity(
                                opacity: isHovered ? 0.64 : 1,
                                child: GestureDetector(
                                  onTap: () =>
                                      turnOffNotify(isNotificationTurnedOn),
                                  child: RowProfile(
                                    firstWidget: SvgIcon(
                                      iconColor,
                                      path: ImageAssets.bell,
                                      width: 21,
                                    ),
                                    text: localizedStrings.notifications,
                                    secondWidget: customSwitch(
                                      isNotificationTurnedOn,
                                      turnOffNotify,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          OnHover(
                            builder: (isHovered) {
                              return Opacity(
                                opacity: isHovered ? 0.64 : 1,
                                child: GestureDetector(
                                  onTap: () => turnOnOffFingerPrintAuth(
                                    isFingerPrintAuth,
                                  ),
                                  child: RowProfile(
                                    firstWidget: SvgIcon(
                                      iconColor,
                                      path: ImageAssets.fingerPrint,
                                      width: 20,
                                    ),
                                    text: localizedStrings.fingerPrint,
                                    secondWidget: customSwitch(
                                      isFingerPrintAuth,
                                      turnOnOffFingerPrintAuth,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          OnHover(
                            builder: (isHovered) {
                              return Opacity(
                                opacity: isHovered ? 0.64 : 1,
                                child: GestureDetector(
                                  onTap: () => context
                                      .goNamed(NavigationRouteNames.changePin),
                                  child: RowProfile(
                                    firstWidget: SvgIcon(
                                      iconColor,
                                      path: ImageAssets.lock,
                                      width: 20,
                                    ),
                                    text: localizedStrings.changePin,
                                    secondWidget: getBlueArrow(),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 28),
                          const ChangeThemePopUp(),
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

  void showChooserNotification(BuildContext context) {
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
                  localizedStrings.turnOffNotify,
                  style: theme.textTheme.px16,
                ),
                const SizedBox(height: 18),
                RowTurnOffNotify(
                  notifyText: 'Оповещения выключены на 1 час',
                  rowText: localizedStrings.oneHourCancelNotify,
                ),
                const SizedBox(height: 24),
                RowTurnOffNotify(
                  notifyText:
                      'Оповещения выключены на ${localizedStrings.forFourHour}',
                  rowText: localizedStrings.forFourHour,
                ),
                const SizedBox(height: 24),
                RowTurnOffNotify(
                  notifyText:
                      'Оповещения выключены на ${localizedStrings.forTwentyFourHour}',
                  rowText: localizedStrings.forTwentyFourHour,
                ),
                const SizedBox(height: 24),
                RowTurnOffNotify(
                  notifyText:
                      'Оповещения выключены на ${localizedStrings.forever.toLowerCase()}',
                  rowText: localizedStrings.forever,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void turnOffNotify(bool newValue) {
    setState(() {
      if (!newValue) {
        showChooserNotification(context);
      }
      isNotificationTurnedOn = !isNotificationTurnedOn;
    });
  }

  void turnOnOffFingerPrintAuth(bool value) {
    setState(() {
      if (!value) {
        value;
      }
      isFingerPrintAuth = !isFingerPrintAuth;
    });
  }

  Widget getBlueArrow() {
    return Icon(
      Icons.arrow_forward_ios_sharp,
      color: theme.primary,
      size: 18,
    );
  }

  Widget customSwitch(bool val, Function onChangeMethod) => Switch(
        activeTrackColor: theme.primary?.withOpacity(0.38),
        activeColor: theme.primary,
        hoverColor: Colors.transparent,
        // Сделал цвет такой вместо заведения нового из фигмы #D8E0E9.
        inactiveTrackColor: theme.text?.withOpacity(0.08),
        inactiveThumbColor: theme.cardColor,
        value: val,
        onChanged: (newValue) => onChangeMethod(newValue),
      );
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

class RowTurnOffNotify extends StatefulWidget {
  final String notifyText;
  final String rowText;
  const RowTurnOffNotify({
    Key? key,
    required this.notifyText,
    required this.rowText,
  }) : super(key: key);

  @override
  State<RowTurnOffNotify> createState() => _RowTurnOffNotifyState();
}

class _RowTurnOffNotifyState extends State<RowTurnOffNotify> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      onTap: () => setState(() => showToasterAboutNotify(
            theme,
            widget.notifyText,
          )),
      child: Text(
        widget.rowText,
        style: theme.textTheme.px16.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void showToasterAboutNotify(CustomTheme theme, String text) {
    Navigator.of(context).pop();

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
}

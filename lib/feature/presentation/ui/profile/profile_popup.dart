// ignore_for_file: unused_element
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/pop_up/change_theme_pop_up.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/row_profile.dart';
import 'package:flutter/material.dart';
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
  late CustomTheme theme;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    final Color? iconColor = theme.textLight;
    late UserEntity user;

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
                  GestureDetector(
                    onTap: () => setState(() => showToasterAboutNotify(
                          theme,
                          'Оповещения выключены на 1 час',
                        )),
                    child: Text(
                      localizedStrings.forHour,
                      style: theme.textTheme.px16.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    localizedStrings.forFourHour,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    localizedStrings.forTwentyFourHour,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    localizedStrings.forever,
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
                                text: localizedStrings.newEmpoyee,
                                secondWidget: getBlueArrow(),
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
                            text: localizedStrings.notofications,
                            secondWidget: customSwitch(
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
                            text: localizedStrings.fingerPrint,
                            secondWidget: customSwitch(
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
                            text: localizedStrings.changePin,
                            secondWidget: getBlueArrow(),
                            call: () =>
                                context.goNamed(NavigationRouteNames.editPin),
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

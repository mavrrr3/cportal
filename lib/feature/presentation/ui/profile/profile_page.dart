import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/avatar_and_userinfo.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/change_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/row_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileEntity profile;

  bool isNotificationTurnedOn = true;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    final Color? iconColor = theme.textLight;

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

          return Scaffold(
            backgroundColor: theme.background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  context.goNamed(NavigationRouteNames.mainPage);
                },
                child: Icon(
                  Icons.close,
                  color: theme.text,
                ),
              ),
              centerTitle: false,
              title: Text(
                AppLocalizations.of(context)!.profile,
                style: theme.textTheme.header,
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    AvatarAndUserInfo(profile: profile),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: theme.text!.withOpacity(0.08),
                          ),
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
                    const SizedBox(height: 28),
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
                    const SizedBox(height: 26),
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
                    const SizedBox(height: 26),
                    RowProfile(
                      firstWidget: SvgIcon(
                        iconColor,
                        path: 'profile/lock.svg',
                        width: 20,
                      ),
                      text: AppLocalizations.of(context)!.changePin,
                      secondWidget: getBlueArrow(theme),
                      call: () => context.goNamed(NavigationRouteNames.editPin),
                    ),
                    const SizedBox(height: 28),
                    const ChangeTheme(),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(
          child: Text('Пусто'),
        );
      },
    );
  }

  void turnOnOffNotify(bool newValue) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    setState(() {
      isNotificationTurnedOn = newValue;
      if (newValue) {
        showChooserNotification(context, theme);
      }
    });
  }

  bool isFingerPrintAuth = false;

  void turnOnOffFingerPrintAuth(bool newValue) {
    setState(() => isFingerPrintAuth = newValue);
  }

  void showChooserNotification(BuildContext context, CustomTheme theme) {
    showModalBottomSheet<void>(
      backgroundColor: theme.cardColor,
      barrierColor: theme.barrierColor,
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
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() => showToasterAboutNotify(
                          context,
                          theme,
                          text: 'Оповещения выключены на 1 час',
                        ));
                  },
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
}

Widget getBlueArrow(CustomTheme theme) {
  return SvgPicture.asset(
    'assets/icons/question_arrow.svg',
    color: theme.primary,
    width: 8.5,
  );
}

Widget customSwitch(CustomTheme theme, bool val, Function onChangeMethod) =>
    SizedBox(
      height: 20,
      width: 34,
      child: Switch(
        activeTrackColor: theme.primary?.withOpacity(0.38),
        activeColor: theme.primary,
        // Сделал цвет такой вместо заведения нового из фигмы #D8E0E9.
        inactiveTrackColor: theme.text?.withOpacity(0.08),
        inactiveThumbColor: theme.cardColor,
        value: val,
        onChanged: (newValue) => onChangeMethod(newValue),
      ),
    );

void showToasterAboutNotify(
  BuildContext context,
  CustomTheme theme, {
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: theme.cardColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      content: Text(
        text,
        style: theme.textTheme.px14.copyWith(
          color: theme.brightness == Brightness.light
              ? theme.cardColor
              : theme.background,
        ),
      ),
    ),
  );
}

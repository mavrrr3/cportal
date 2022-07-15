import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
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
  late UserEntity user;
  late AppLocalizations localizedStrings;
  late CustomTheme theme;
  bool isNotificationTurnedOn = true;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context).extension<CustomTheme>()!;
    localizedStrings = AppLocalizations.of(context)!;
    final Color? iconColor = theme.textLight;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          user = state.user;

          return Scaffold(
            backgroundColor: theme.background,
            appBar: AppBar(
              backgroundColor: theme.background,
              elevation: 0,
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
                localizedStrings.profile,
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
                    AvatarAndUserInfo(user: user),
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
                            path: ImageAssets.addPerson,
                            width: 22,
                          ),
                          text: localizedStrings.newEmpoyee,
                          secondWidget: getBlueArrow(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    RowProfile(
                      firstWidget: SvgIcon(
                        iconColor,
                        path: ImageAssets.bell,
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
                        path: ImageAssets.fingerPrint,
                        width: 20,
                      ),
                      text: localizedStrings.fingerPrint,
                      secondWidget: customSwitch(
                        isFingerPrintAuth,
                        turnOnOffFingerPrintAuth,
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => context.goNamed(NavigationRouteNames.editPin),
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
                    const SizedBox(height: 24),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => context.pushNamed(NavigationRouteNames.devices),
                      child: RowProfile(
                        firstWidget: SvgIcon(
                          iconColor,
                          path: ImageAssets.addDevice,
                          width: 20,
                        ),
                        text: localizedStrings.devices,
                        secondWidget: getBlueArrow(),
                      ),
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
    setState(() {
      isNotificationTurnedOn = newValue;
      if (newValue) {
        showChooserNotification(context);
      }
    });
  }

  bool isFingerPrintAuth = false;

  void turnOnOffFingerPrintAuth(bool newValue) {
    setState(() => isFingerPrintAuth = newValue);
  }

  void showChooserNotification(BuildContext context) {
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
                  localizedStrings.turnOffNotify,
                  style: theme.textTheme.px16,
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() => showToasterAboutNotify(
                          context,
                          text: localizedStrings.oneHourCancelNotify,
                        ));
                  },
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

  Widget getBlueArrow() {
    return SvgPicture.asset(
      ImageAssets.questionArrow,
      color: theme.primary,
      width: 8.5,
    );
  }

  Widget customSwitch(bool val, Function onChangeMethod) => SizedBox(
        height: 20,
        width: 34,
        child: Switch(
          activeTrackColor: theme.primary?.withOpacity(0.38),
          activeColor: theme.primary,
          inactiveTrackColor: theme.text?.withOpacity(0.08),
          inactiveThumbColor: theme.cardColor,
          value: val,
          onChanged: (newValue) => onChangeMethod(newValue),
        ),
      );

  void showToasterAboutNotify(
    BuildContext context, {
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
            color: theme.brightness == Brightness.light ? theme.cardColor : theme.background,
          ),
        ),
      ),
    );
  }
}

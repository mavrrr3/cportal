// ignore_for_file: avoid_types_on_closure_parameters

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/platform_util.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/finger_print_support_bloc/finger_print_support_bloc.dart';

import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/turn_off_finger_print_bloc/turn_off_finger_print_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/avatar_and_userinfo.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/notification_bottom_sheet/disable_notification_bottom_sheet.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/profile_divider.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/profile_section_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/profile_switch.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/section_item_arrow.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/theme_toggle/change_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/bottom_padding.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/layout_with_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final notificationController = SwitchController();
  final fingerPrintAuthController = SwitchController();
  bool isFingerPrintSupport = false;
  bool isEnabledFingerPrint = false;
  CustomTheme? theme;

  @override
  void initState() {
    context.read<FingerPrintSupportBloc>().add(const CheckFingerPrintSupport());
    context.read<TurnOffFingerPrintBloc>().add(const IsFingerPrintEnabledEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context).extension<CustomTheme>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final localizedStrings = AppLocalizations.of(context)!;
    isFingerPrintSupport = context.select((FingerPrintSupportBloc bloc) => bloc.state);

    isEnabledFingerPrint = context.select((TurnOffFingerPrintBloc bloc) => bloc.state.isEnabled);

    return QuestionMobileLayoutWithAppBar(
      icon: ImageAssets.close,
      title: localizedStrings.profile,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 16,
                    ),
                    child: AvatarAndUserInfo(user: state.user),
                  ),
                  const ProfileDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ProfileSectionItem(
                      title: localizedStrings.newEmployee,
                      prefixIcon: ImageAssets.addPerson,
                      suffix: const SectionItemArrow(),
                      onTap: () => context.goNamed(NavigationRouteNames.onBoardingStart),
                    ),
                  ),
                  const ProfileDivider(),
                  const SizedBox(height: 16),
                  ProfileSectionItem(
                    title: localizedStrings.notifications,
                    prefixIcon: ImageAssets.bell,
                    suffix: ProfileSwitch(
                      controller: notificationController,
                      switchType: ProfileSwitchType.notification,
                    ),
                    onTap: () {
                      if (notificationController.value) {
                        showDisableNotificationPopup();
                      }
                      notificationController.value = true;
                    },
                  ),
                  if (isFingerPrintSupport) ...[
                    BlocBuilder<TurnOffFingerPrintBloc, TurnOffFingerState>(
                      builder: (context, state) {
                        fingerPrintAuthController.value = state.isEnabled;

                        return ProfileSectionItem(
                          title: localizedStrings.fingerPrint,
                          prefixIcon: ImageAssets.smallFingerPrint,
                          suffix: ProfileSwitch(
                            controller: fingerPrintAuthController,
                            switchType: ProfileSwitchType.fingerPrint,
                          ),
                          onTap: () {
                            turnOnOffFingerPrint();
                            setState(() {
                              fingerPrintAuthController.value = !state.isEnabled;
                            });
                          },
                        );
                      },
                    ),
                  ],
                  ProfileSectionItem(
                    title: localizedStrings.changePin,
                    prefixIcon: ImageAssets.lock,
                    suffix: const SectionItemArrow(),
                    onTap: () => context.goNamed(NavigationRouteNames.changePin),
                  ),
                  if (kIsMobile)
                    ProfileSectionItem(
                      title: localizedStrings.devices,
                      prefixIcon: ImageAssets.addDevice,
                      suffix: const SectionItemArrow(),
                      onTap: () => context.pushNamed(NavigationRouteNames.devices),
                    ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: ChangeTheme(),
                  ),
                  const BottomPadding(),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void showDisableNotificationPopup() {
    showModalBottomSheet<void>(
      backgroundColor: theme?.cardColor,
      barrierColor: theme?.barrierColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return DisableNotificationBottomSheet(
          notificationController: notificationController,
        );
      },
    );
  }

  void turnOnOffFingerPrint() {
    context.read<TurnOffFingerPrintBloc>().add(const TurnOffFingerPrintEvent());
  }

  @override
  void dispose() {
    notificationController.dispose();
    fingerPrintAuthController.dispose();
    super.dispose();
  }
}

import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:flutter/material.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/avatar_and_userinfo.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/change_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/row_profile.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/profile_page.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final ThemeData theme = Theme.of(context);
    Color iconColor = theme.hoverColor.withOpacity(0.64);
    late ProfileEntity profile;

    void showChooserNotification(BuildContext context, ThemeData theme) {
      showModalBottomSheet<void>(
        backgroundColor: theme.splashColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.turnOffNotify,
                    style: theme.textTheme.headline5,
                  ),
                  SizedBox(height: 18.h),
                  GestureDetector(
                    onTap: (() => setState(() => showToasterAboutNotify(
                          theme,
                          'Оповещения выключены на 1 час',
                        ))),
                    child: Text(
                      AppLocalizations.of(context)!.forHour,
                      style: theme.textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    AppLocalizations.of(context)!.forFourHour,
                    style: theme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    AppLocalizations.of(context)!.forTwentyFourHour,
                    style: theme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    AppLocalizations.of(context)!.forever,
                    style: theme.textTheme.headline5!.copyWith(
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

    void turnOnOffNotify(bool newValue) {
      setState(() {
        _isNotificationTurnedOn = newValue;
        showChooserNotification(context, Theme.of(context));
      });
    }

    void turnOnOffFingerPrintAuth(bool newValue) {
      setState(() => _isFingerPrintAuth = newValue);
    }

    BlocProvider.of<GetSingleProfileBloc>(
      context,
      listen: false,
    ).add(const GetSingleProfileEventImpl('A1B2C3D4E5'));

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
                    style: theme.textTheme.headline2,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // ! При возврате со страницы Смотреть данные
                      // ! и нажатии закрыть Профиль прилетает эксепшен
                      // ! GoRouter.of(context).pop();
                      context.goNamed(NavigationRouteNames.mainPage);
                    },
                    child: Icon(
                      Icons.close,
                      color: theme.hoverColor,
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
                    Text(
                      '${profile.firstName} ${profile.middleName} ${profile.lastName}',
                      style: theme.textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
              ]),
              SizedBox(height: 16.h),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: theme.hoverColor.withOpacity(0.08),
                    ),
                    bottom: BorderSide(
                      color: theme.hoverColor.withOpacity(0.08),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0.h),
                  child: RowProfile(
                    firstWidget: SvgIcon(
                      iconColor,
                      path: 'profile/add_person.svg',
                      width: 22.w,
                    ),
                    text: AppLocalizations.of(context)!.newEmpoyee,
                    secondWidget: getBlueArrow(theme),
                  ),
                ),
              ),
              // SizedBox(height: 24.h),
              // RowProfile(
              //   firstWidget: SvgIcon(
              //     iconColor,
              //     path: 'profile/bell.svg',
              //     width: 21.w,
              //   ),
              //   text: AppLocalizations.of(context)!.notofications,
              //   secondWidget: customSwitch(
              //     theme,
              //     _isNotificationTurnedOn,
              //     turnOnOffNotify,
              //   ),
              // ),
              // SizedBox(height: 24.h),
              // RowProfile(
              //   firstWidget: SvgIcon(
              //     iconColor,
              //     path: 'finger_print.svg',
              //     width: 20.w,
              //   ),
              //   text: AppLocalizations.of(context)!.fingerPrint,
              //   secondWidget: customSwitch(
              //     theme,
              //     _isFingerPrintAuth,
              //     turnOnOffFingerPrintAuth,
              //   ),
              // ),
              // SizedBox(height: 24.h),
              // RowProfile(
              //   firstWidget: SvgIcon(
              //     iconColor,
              //     path: 'profile/lock.svg',
              //     width: 20.w,
              //   ),
              //   text: AppLocalizations.of(context)!.changePin,
              //   secondWidget: getBlueArrow(theme),
              //   call: () => context.goNamed(NavigationRouteNames.editPin),
              // ),
              // SizedBox(height: 28.h),
              // const ChangeTheme(),
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

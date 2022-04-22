import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/avatar_and_userinfo.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/change_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/row_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileEntity profile;

  Color iconColor = AppColors.kLightTextColor.withOpacity(0.64);

  Icon blueArrow = const Icon(
    Icons.arrow_forward_ios_sharp,
    color: AppColors.blue,
    size: 18,
  );

  bool isNotificationTurnedOn = true;

  void turnOnOffNotify(bool newValue) {
    setState(() {
      isNotificationTurnedOn = newValue;
      showChooserNotification(context);
    });
  }

  bool isFingerPrintAuth = false;

  void turnOnOffFingerPrintAuth(bool newValue) {
    setState(() => isFingerPrintAuth = newValue);
  }

  void showToasterAboutNotify(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.kLightTextColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showChooserNotification(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
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
                  style: kMainTextRoboto,
                ),
                SizedBox(height: 18.h),
                GestureDetector(
                  onTap: (() => setState(() => showToasterAboutNotify(
                        'Оповещения выключены на 1 час',
                      ))),
                  child: Text(
                    AppLocalizations.of(context)!.forHour,
                    style: kMainTextRoboto.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  AppLocalizations.of(context)!.forFourHour,
                  style: kMainTextRoboto.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  AppLocalizations.of(context)!.forTwentyFourHour,
                  style: kMainTextRoboto.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  AppLocalizations.of(context)!.forever,
                  style: kMainTextRoboto.copyWith(
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

  Widget customSwitch(bool val, Function onChangeMethod) => Switch(
        activeTrackColor: AppColors.blue.withOpacity(0.38),
        activeColor: AppColors.blue,
        // Сделал цвет такой вместо заведения нового из фигмы #D8E0E9
        inactiveTrackColor: AppColors.kLightTextColor.withOpacity(0.08),
        inactiveThumbColor: Colors.white,
        value: val,
        onChanged: (newValue) => onChangeMethod(newValue),
      );

  @override
  Widget build(BuildContext context) {
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

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: const Icon(
                Icons.close,
                color: AppColors.kLightTextColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.profile,
                style: kMainTextRusso.copyWith(fontSize: 28.sp),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.0.w,
                  right: 16.0.w,
                  bottom: 20.0.h,
                ),
                child: Column(
                  children: [
                    AvatarAndUserInfo(profile: profile),
                    SizedBox(height: 16.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.kLightTextColor.withOpacity(0.08),
                          ),
                          bottom: BorderSide(
                            color: AppColors.kLightTextColor.withOpacity(0.08),
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
                          secondWidget: blueArrow,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    RowProfile(
                      firstWidget: SvgIcon(
                        iconColor,
                        path: 'profile/bell.svg',
                        width: 21.w,
                      ),
                      text: AppLocalizations.of(context)!.notofications,
                      secondWidget:
                          customSwitch(isNotificationTurnedOn, turnOnOffNotify),
                    ),
                    SizedBox(height: 24.h),
                    RowProfile(
                      firstWidget: SvgIcon(
                        iconColor,
                        path: 'finger_print.svg',
                        width: 20.w,
                      ),
                      text: AppLocalizations.of(context)!.fingerPrint,
                      secondWidget: customSwitch(
                        isFingerPrintAuth,
                        turnOnOffFingerPrintAuth,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    RowProfile(
                      firstWidget: SvgIcon(
                        iconColor,
                        path: 'profile/lock.svg',
                        width: 20.w,
                      ),
                      text: AppLocalizations.of(context)!.changePin,
                      secondWidget: blueArrow,
                    ),
                    SizedBox(height: 28.h),
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
}

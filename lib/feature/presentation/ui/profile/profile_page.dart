import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/avatar_and_userinfo.dart';
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
                Text('Отключить уведомления', style: kMainTextRoboto),
                SizedBox(height: 18.h),
                GestureDetector(
                  onTap: (() => setState(() => showToasterAboutNotify(
                        'Оповещения выключены на 1 час',
                      ))),
                  child: Text(
                    'На час',
                    style: kMainTextRoboto.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  '4 часа',
                  style: kMainTextRoboto.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  '24 часа',
                  style: kMainTextRoboto.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Навсегда',
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
                          text: 'Новому сотруднику',
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
                      text: 'Уведомления',
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
                      text: 'Сканер отпечатков',
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
                      text: 'Сменить ПИН',
                      secondWidget: blueArrow,
                    ),
                    SizedBox(height: 28.h),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Тема приложения',
                            style: kMainTextRoboto.copyWith(
                              fontSize: 12,
                              color:
                                  AppColors.kLightTextColor.withOpacity(0.68),
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
                              color:
                                  AppColors.kLightTextColor.withOpacity(0.08),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100.w, 36.h),
                                  primary: AppColors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Светлая',
                                  style: kMainTextRoboto.copyWith(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size(100.w, 36.h),
                                  primary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Темная',
                                  style: kMainTextRoboto.copyWith(
                                    fontSize: 12,
                                    color: AppColors.kLightTextColor,
                                  ),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  minimumSize: Size(100.w, 36.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Стандартная',
                                  style: kMainTextRoboto.copyWith(
                                    fontSize: 12,
                                    color: AppColors.kLightTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

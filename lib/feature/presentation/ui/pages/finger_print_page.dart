import 'dart:developer';
import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_auth_bloc/biometric_auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FingerPrintPage extends StatelessWidget {
  const FingerPrintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BiometricBloc, BiometricState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(color: Color(0xFFE5E5E5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0.w,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 48.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgIcon(null, path: 'logo_grey.svg', width: 24.0.w),
                        ],
                      ),
                      SizedBox(height: 31.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.useFingerPrint,
                                style: kMainTextRusso.copyWith(
                                  fontSize: 28.sp,
                                  height: 1.286,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .doFingerPrintNotInputPin,
                            style: kMainTextRoboto.copyWith(
                              fontSize: 14.sp,
                              height: 1.714,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 48.h),
                      SvgIcon(
                        AppColors.kLightTextColor.withOpacity(0.1),
                        path: 'finger_print.svg',
                        width: 149.21.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.0.w,
                          right: 16.0.w,
                          top: 62.87.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Button.factory(
                              ButtonEnum.blue,
                              AppLocalizations.of(context)!.yes,
                              () {
                                BlocProvider.of<BiometricBloc>(
                                  context,
                                  listen: false,
                                ).add(const GetBiometricEvent());
                                log('isAuthenticated ${state.authStatus}');
                                log('Biometric list ${state.listBiometric}');
                              },
                            ),
                            Button.factory(
                              ButtonEnum.outlined,
                              AppLocalizations.of(context)!.noThanks,
                              () async {
                                // TODO Реализовать функционал кнопки Нет, спасибо
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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

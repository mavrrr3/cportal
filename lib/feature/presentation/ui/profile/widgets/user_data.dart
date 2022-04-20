import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserData extends StatelessWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetSingleProfileBloc>(
      context,
      listen: false,
    ).add(const GetSingleProfileEventImpl('A1B2C3D4E5'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.goNamed(NavigationRouteNames.profile),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.kLightTextColor,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.yourData,
          style: kMainTextRusso.copyWith(fontSize: 28),
        ),
      ),
      body: BlocBuilder<GetSingleProfileBloc, GetSingleProfileState>(
        builder: (context, state) {
          if (state is GetSingleProfileLoadedState) {
            final ProfileEntity profile = state.profile;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 33.h),
                  const PhoneBox(),
                  SizedBox(height: 24.h),
                  UserDataRow(
                    normalText: AppLocalizations.of(context)!.position,
                    boldText: profile.position.description,
                  ),
                  SizedBox(height: 8.h),
                  UserDataRow(
                    normalText: AppLocalizations.of(context)!.department,
                    boldText: profile.position.department,
                  ),
                  SizedBox(height: 8.h),
                  UserDataRow(
                    normalText: AppLocalizations.of(context)!.birthDay,
                    boldText: profile.birthday,
                  ),
                  SizedBox(height: 8.h),
                  UserDataRow(
                    normalText: AppLocalizations.of(context)!.email,
                    boldText: profile.email,
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class UserDataRow extends StatelessWidget {
  final String normalText;
  final String boldText;

  const UserDataRow({
    Key? key,
    required this.normalText,
    required this.boldText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          normalText,
          style: kMainTextRoboto.copyWith(
            fontSize: 14.sp,
            color: AppColors.kLightTextColor.withOpacity(0.68),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          boldText,
          style: kMainTextRoboto.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class PhoneBox extends StatelessWidget {
  const PhoneBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.kLightTextColor.withOpacity(0.04),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.sp),
          topRight: Radius.circular(4.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.yourPhoneNumber,
              style: kMainTextRoboto.copyWith(
                fontSize: 12.sp,
                color: AppColors.kLightTextColor.withOpacity(0.68),
              ),
            ),
            Text(
              '+7 923 456 78 91',
              style: kMainTextRoboto.copyWith(
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

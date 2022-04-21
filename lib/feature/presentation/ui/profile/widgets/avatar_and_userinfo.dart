import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class AvatarAndUserInfo extends StatelessWidget {
  final ProfileEntity profile;

  const AvatarAndUserInfo({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 30.h),
          AvatarBox(
            size: 102,
            imgPath: profile.photoLink,
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: 250.w,
            child: Text(
              '${profile.firstName} ${profile.middleName} ${profile.lastName}',
              style: kMainTextRoboto.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            profile.phone[0].number,
            style: kMainTextRoboto.copyWith(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 6.h),
          TextButton(
            onPressed: (() => context.goNamed(NavigationRouteNames.userData)),
            child: Text(
              AppLocalizations.of(context)!.watchData,
              style: kMainTextRoboto.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

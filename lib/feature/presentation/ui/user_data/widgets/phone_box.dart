import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneBox extends StatelessWidget {
  const PhoneBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: theme.hoverColor.withOpacity(0.04),
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
              style: theme.textTheme.bodyText1!
                  .copyWith(color: theme.hoverColor.withOpacity(0.68)),
            ),
            Text(
              '+7 923 456 78 91',
              style: theme.textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}

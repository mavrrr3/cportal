import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    Key? key,
    required this.content,
  }) : super(key: key);

  final OnboardingEntity content;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 68.h),
        Text(
          content.title,
          style: theme.textTheme.headline2,
        ),
        SizedBox(height: 8.h),
        Text(
          content.description,
          style: theme.textTheme.headline5,
        ),
        SizedBox(height: 64.h),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            content.image,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

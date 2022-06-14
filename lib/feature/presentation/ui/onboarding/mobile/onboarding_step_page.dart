import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingStepPage extends StatelessWidget {
  final OnboardingEntity content;

  const OnBoardingStepPage({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 68),
        Text(
          content.title,
          style: theme.textTheme.headline2,
        ),
        const SizedBox(height: 8),
        Text(
          content.description,
          style: theme.textTheme.headline5,
        ),
        const SizedBox(height: 64),
        Align(
          alignment: Alignment.center,
          child: content.isVector
              ? SvgPicture.asset(
                  content.image,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  content.image,
                  fit: BoxFit.cover,
                ),
        ),
      ],
    );
  }
}

import 'dart:developer';

import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingEntity {
  OnboardingEntity({
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final String image;
}

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late bool _isPageInit;
  @override
  void initState() {
    _isPageInit = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<OnboardingEntity> _onboardingContent = [];

    /// Контент страниц онбординга
    if (!_isPageInit) {
      _onboardingContent = [
        OnboardingEntity(
          title: AppLocalizations.of(context)!.onboarding_title1,
          description: AppLocalizations.of(context)!.onboarding_description1,
          image: 'assets/img/onboarding/1.svg',
        ),
        OnboardingEntity(
          title: AppLocalizations.of(context)!.onboarding_title2,
          description: AppLocalizations.of(context)!.onboarding_description2,
          image: 'assets/img/onboarding/2.svg',
        ),
        OnboardingEntity(
          title: AppLocalizations.of(context)!.onboarding_title3,
          description: AppLocalizations.of(context)!.onboarding_description3,
          image: 'assets/img/onboarding/3.svg',
        ),
        OnboardingEntity(
          title: AppLocalizations.of(context)!.onboarding_title4,
          description: AppLocalizations.of(context)!.onboarding_description4,
          image: 'assets/img/onboarding/4.svg',
        ),
        OnboardingEntity(
          title: AppLocalizations.of(context)!.onboarding_title5,
          description: AppLocalizations.of(context)!.onboarding_description5,
          image: 'assets/img/onboarding/5.svg',
        ),
        OnboardingEntity(
          title: AppLocalizations.of(context)!.onboarding_title6,
          description: AppLocalizations.of(context)!.onboarding_description6,
          image: 'assets/img/onboarding/6.svg',
        ),
        OnboardingEntity(
          title: AppLocalizations.of(context)!.onboarding_title7,
          description: AppLocalizations.of(context)!.onboarding_description7,
          image: 'assets/img/onboarding/7.svg',
        ),
      ];
      _isPageInit = false;
    }

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          /// Контент
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Виджет прокрутки
                  SafeArea(
                    child: Container(
                      height: 2.h,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                    ),
                  ),

                  /// Страница онбординга
                  SizedBox(
                    width: width,
                    height: height,
                    child: PageView(
                      children: [
                        /// Генерация страниц онбординга
                        ...List.generate(
                          _onboardingContent.length,
                          (index) => OnBoardingPage(
                            content: _onboardingContent[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Следующая страница
          Align(
            alignment: Alignment.centerRight,
            child: _nagigationButton(
              height,
              onTap: () => log('Next'),
            ),
          ),

          /// Предыдущая страница
          Align(
            alignment: Alignment.centerLeft,
            child: _nagigationButton(
              height,
              onTap: () => log('Back'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nagigationButton(
    double height, {
    Function()? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SizedBox(
        width: 164.w,
        height: height,
      ),
    );
  }
}

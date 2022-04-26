import 'package:cportal_flutter/feature/presentation/ui/finger_print/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartBoarding extends StatelessWidget {
  const StartBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0.w,
          ),
          child: Column(
            children: [
              SizedBox(height: 87.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: theme.textTheme.headline2,
                      ),
                      Text(
                        AppLocalizations.of(context)!.findImportantInformation,
                        style: theme.textTheme.headline5,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Button.factory(
            context,
            ButtonEnum.blue,
            AppLocalizations.of(context)!.forward,
            () {
              // TODO релизовать редирект на страницу с онбордингом
            },
            Size(double.infinity, 48.h),
          ),
        ),
      ],
    );
  }
}

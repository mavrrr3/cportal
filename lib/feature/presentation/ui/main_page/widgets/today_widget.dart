import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.today,
          style: theme.textTheme.headline3,
        ),
        const SizedBox(height: 12),
        ResponsiveRowColumn(
          layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          children: [
            const ResponsiveRowColumnItem(
              child: AvatarBox(
                size: 69,
                imgPath:
                    'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
              ),
            ),
            ResponsiveRowColumnItem(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.birthDay,
                      style: theme.textTheme.headline6,
                    ),
                    Text(
                      'Романова Алексея Игоревича',
                      softWrap: true,
                      style: theme.textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Охранник',
                          style: theme.textTheme.bodyText1!.copyWith(
                            color: theme.hoverColor.withOpacity(0.68),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.cardColor.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Text(
                                'Новосталь-М',
                                style: theme.textTheme.bodyText1!.copyWith(
                                  color: theme.hoverColor.withOpacity(0.68),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_right_search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.today,
          style: kMainTextRoboto.copyWith(fontSize: 22.sp),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Row(
            children: [
              const AvatarBox(size: 69),
              Padding(
                padding: const EdgeInsets.only(left: 15.5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 120.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.birthDay,
                        style: kMainTextRoboto.copyWith(fontSize: 14.sp),
                      ),
                      Text(
                        'Романова Алексея Игоревича',
                        softWrap: true,
                        style: kMainTextRoboto.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Охранник',
                            style: kMainTextRoboto.copyWith(fontSize: 12.sp),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                child: Text(
                                  'Новосталь-М',
                                  style:
                                      kMainTextRoboto.copyWith(fontSize: 12.sp),
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
        ),
      ],
    );
  }
}

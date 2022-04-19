import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/faq/widgets/faq_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqWidget extends StatelessWidget {
  const FaqWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.faq,
          style: kMainTextRoboto.copyWith(fontSize: 22.sp),
        ),
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: faqList.length,
          itemBuilder: (context, i) {
            return FaqRow(title: faqList[i]);
          },
        ),
      ],
    );
  }
}

final List<String> faqList = [
  'Компенсация занятий спортом',
  'Таким образом, глубокий уровень',
  'Приятно, граждане, наблюдать',
];

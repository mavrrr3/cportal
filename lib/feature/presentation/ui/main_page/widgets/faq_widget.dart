import 'package:cportal_flutter/feature/presentation/ui/faq/widgets/faq_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FaqWidget extends StatelessWidget {
  const FaqWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.faq,
          style: theme.textTheme.headline3,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: faqList.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: FaqRow(
                text: faqList[i],
                // OnTap: () {},.
              ),
            );
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
  'Приятно, граждане, наблюдать',
];

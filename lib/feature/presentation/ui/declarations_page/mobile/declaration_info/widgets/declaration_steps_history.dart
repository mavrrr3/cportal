import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_step_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeclarationStepsHistory extends StatelessWidget {
  final List<DeclarationStepEntity> steps;
  final bool isHistoryExpanded;
  final Function() onTap;
  const DeclarationStepsHistory({
    Key? key,
    required this.steps,
    required this.isHistoryExpanded,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.history,
                    color: theme.textLight,
                    width: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    AppLocalizations.of(context)!.history,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                isHistoryExpanded ? ImageAssets.arrowDown : ImageAssets.arrowUp,
                width: 24,
                color: theme.primary,
              ),
            ],
          ),
        ),
        if (isHistoryExpanded) const SizedBox(height: 17),
        if (isHistoryExpanded)
          ...List.generate(
            steps.length,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: DeclarationStep(item: steps[i]),
            ),
          ),
      ],
    );
  }
}

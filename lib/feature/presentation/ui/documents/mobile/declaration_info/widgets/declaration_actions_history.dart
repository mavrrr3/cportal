import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_step_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_expandble_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeclarationActionsHistory extends StatelessWidget {
  final List<DeclarationStepEntity> actions;
  const DeclarationActionsHistory({Key? key, required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeclarationExpandbleContent(
      title: AppLocalizations.of(context)!.stepsHistory,
      childTopPadding: 16,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: actions.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: DeclarationAction(item: actions[i]),
        ),
      ),
    );
  }
}

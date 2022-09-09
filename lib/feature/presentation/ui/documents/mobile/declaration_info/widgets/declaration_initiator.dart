import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_headline.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/user_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class DeclarationInitiator extends StatelessWidget {
  final String fullName;
  final String position;
  final String imgLing;
  const DeclarationInitiator({
    super.key,
    required this.fullName,
    required this.position,
    required this.imgLing,
  });

  @override
  Widget build(BuildContext context) {
    final localizedStrings = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeclarationHeadline(title: localizedStrings.initiator),
        const SizedBox(height: 8),
        UserCard(
          fullName: fullName,
          position: position,
          imgLink: imgLing,
          color: ColorService.randomColor,
        ),
      ],
    );
  }
}

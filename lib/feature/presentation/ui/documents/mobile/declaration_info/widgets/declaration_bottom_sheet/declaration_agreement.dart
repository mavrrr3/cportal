import 'dart:developer';

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/create_declaration/widgets/declaration_textfield.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_headline.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DeclarationAgreement extends StatefulWidget {
  final String description;
  final Function() onAgreed;

  const DeclarationAgreement({
    super.key,
    required this.description,
    required this.onAgreed,
  });

  @override
  State<DeclarationAgreement> createState() => _DeclarationAgreementState();
}

class _DeclarationAgreementState extends State<DeclarationAgreement> {
  late GlobalKey key1;
  late GlobalKey key2;
  late GlobalKey key3;
  late GlobalKey key4;

  @override
  void initState() {
    key1 = GlobalKey();
    key2 = GlobalKey();
    key3 = GlobalKey();
    key4 = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeclarationHeadline(
          key: key1,
          title: localizedStrings.agreementNeeds,
        ),
        const SizedBox(height: 4),
        Text(
          key: key2,
          widget.description,
          style: theme.textTheme.px12.copyWith(
            color: theme.textLight,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        const SizedBox(height: 24),
        DeclarationTextField(
          key: key3,
          controller: TextEditingController(),
          title: localizedStrings.comment,
        ),
        const SizedBox(height: 32),
        Column(
          key: key4,
          mainAxisSize: MainAxisSize.min,
          children: [
            Button.factory(
              context,
              type: ButtonEnum.filled,
              text: localizedStrings.notAgreed,
              onTap: () {
                double count = key1.currentContext!.size!.height;
                count += key2.currentContext!.size!.height;
                count += key3.currentContext!.size!.height;
                count += key4.currentContext!.size!.height;
                count += 68;
                log('GGGG $count ');
                widget.onAgreed();
              },
              color: theme.red,
            ),
            const SizedBox(height: 8),
            Button.factory(
              context,
              type: ButtonEnum.filled,
              text: localizedStrings.agreed,
              onTap: widget.onAgreed,
            ),
          ],
        ),
      ],
    );
  }

  // double getButtonsPosition() {
  //   // Если клавиатура активна.
  //   if (MediaQuery.of(context).viewInsets.bottom > 0) {
  //     if (MediaQuery.of(context).viewInsets.bottom > 32) {
  //       return MediaQuery.of(context).viewInsets.bottom - 30;
  //     }
  //     // Если клавиатура скрыта, то прижимаем кнопки к низу
  //     // развернутой части Draggable Scrollable Sheet
  //   } else {

  //     if (widget.draggableScrollableController.size > 0.37 &&
  //         widget.draggableScrollableController.size < 0.985) {
  //       return widget.draggableScrollableController
  //           .sizeToPixels(0.985 - widget.draggableScrollableController.size);
  //     }
  //   }

  //   return 0;
  // }
}

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/empty_declarations_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class NewDeclarations extends StatelessWidget {
  const NewDeclarations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final halfWidth = MediaQuery.of(context).size.width / 2 - 24;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            // ! Отображать если нет заявлений.
            const EmptyDeclarationsTitle(),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DeclarationCard(
                        width: halfWidth,
                        svgPath: ImageAssets.calendar,
                        text: AppLocalizations.of(context)!
                            .buisenesTripDeclaration,
                      ),
                      DeclarationCard(
                        width: halfWidth,
                        svgPath: ImageAssets.flyVocation,
                        text: AppLocalizations.of(context)!.vocationDeclaration,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DeclarationCard(
                        width: halfWidth,
                        svgPath: ImageAssets.lock,
                        text: AppLocalizations.of(context)!.passDeclaration,
                      ),
                      DeclarationCard(
                        width: halfWidth,
                        svgPath: ImageAssets.payList,
                        text: AppLocalizations.of(context)!.payListDeclaration,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DeclarationCard(
                    width: double.infinity,
                    svgPath: ImageAssets.support,
                    text: AppLocalizations.of(context)!.supportDeclaration,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

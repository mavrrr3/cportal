import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_document_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_headline.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeclarationDocuments extends StatelessWidget {
  final List<DeclarationDocumentEntity> items;
  final Function(int) onTap;
  const DeclarationDocuments({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeclarationHeadline(title: localizedStrings.docs),
        const SizedBox(height: 16),
        ...List.generate(
          items.length,
          (i) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => onTap(i),
            child: Row(
              children: [
                SvgPicture.asset(
                  _getIconByFileType(items[i].file),
                  width: 24,
                  color: theme.textLight,
                ),
                const SizedBox(width: 8),
                Text(
                  items[i].title,
                  style:
                      theme.textTheme.px14Bold.copyWith(color: theme.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getIconByFileType(String path) {
    final splitted = path.split('.');
    switch (splitted[1]) {
      case 'pdf':
        return ImageAssets.pdfFile;
      default:
        return ImageAssets.docFile;
    }
  }
}

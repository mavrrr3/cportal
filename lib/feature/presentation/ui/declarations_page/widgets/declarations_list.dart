import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/archive_declaration_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card_with_status.dart';
import 'package:flutter/material.dart';

class DeclarationsList extends StatelessWidget {
  final List<DeclarationEntity> items;
  final Function(int) onTap;
  const DeclarationsList({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return ListView.builder(
      itemCount: items.length + 1,
      itemBuilder: (context, i) {
        return i != items.length
            ? DeclarationCardWithStatus(
                item: items[i],
                onTap: () => onTap(i),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ArchiveDeclarationButton(
                  theme: theme,
                  onTap: () {},
                ),
              );
      },
    );
  }
}

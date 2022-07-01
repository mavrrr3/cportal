import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declaration_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/archive_declaration_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card_with_status.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/in_process_title.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/status_badge.dart';
import 'package:flutter/material.dart';


class AllDeclarations extends StatelessWidget {
  const AllDeclarations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
                        final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;


    Widget drawBadgeByStatus(String status) {
      switch (status) {
        case 'одобрено':
          return StatusBadge(
            status,
            theme.green,
          );
        case 'отклонено':
          return StatusBadge(
            status,
            theme.red,
          );
        default:
          return StatusBadge(
            status,
            theme.yellow,
          );
      }
    }

    List<Widget> drawDeclarationCards(List<DeclarationEntity> declarations) {
      final List<Widget> list = [];
      int count = 0;
      while (count < declarations.length) {
        list.add(
          DeclarationCardWithStatus(
            status: drawBadgeByStatus(declarations[count].status),
            title: declarations[count].title,
            svgPath: declarations[count].svgPath,
            date: declarations[count].date,
            number: declarations[count].number,
          ),
        );
        count++;
      }

      return list;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (doneDeclorations.isNotEmpty)
          ...drawDeclarationCards(doneDeclorations),
        if (inProgressDeclorations.isNotEmpty) InProcessTitle(theme: theme),
        ...drawDeclarationCards(inProgressDeclorations),
        ArchiveDeclarationButton(theme: theme, onTap: (){},),
      ],
    );
  }
}

final List<DeclarationEntity> doneDeclorations = mockDeclarations
    .where((declaration) => declaration.status != 'обработка')
    .toList();

final List<DeclarationEntity> inProgressDeclorations = mockDeclarations
    .where((declaration) => declaration.status == 'обработка')
    .toList();

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
    final ThemeData theme = Theme.of(context);

    Widget drawBadgeByStatus(String status) {
      switch (status) {
        case 'одобрено':
          return StatusBadge(
            status,
            theme.focusColor,
          );
        case 'отклонено':
          return StatusBadge(
            status,
            theme.errorColor,
          );
        default:
          return StatusBadge(
            status,
            theme.indicatorColor,
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
        ArchiveDeclarationButton(theme: theme),
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

final List<DeclarationEntity> mockDeclarations = [
  const DeclarationEntity(
    title: 'Заявление на отпуск',
    svgPath: 'assets/icons/fly_vocation.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'обработка',
  ),
  const DeclarationEntity(
    title: 'Заявление на командировку',
    svgPath: 'assets/icons/calendar.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'одобрено',
  ),
  const DeclarationEntity(
    title: 'Заявление на пропуск',
    svgPath: 'assets/icons/lock.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'обработка',
  ),
  const DeclarationEntity(
    title: 'Заявление на расчетный листок',
    svgPath: 'assets/icons/pay_list.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'одобрено',
  ),
  const DeclarationEntity(
    title: 'Заявление на тех. поддержку/IT',
    svgPath: 'assets/icons/support.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'отклонено',
  ),
  const DeclarationEntity(
    title: 'Заявление на тех. поддержку/IT',
    svgPath: 'assets/icons/support.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'одобрено',
  ),
];

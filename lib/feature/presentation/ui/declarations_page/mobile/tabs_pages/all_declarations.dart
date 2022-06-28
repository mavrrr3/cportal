import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declaration_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/archive_declaration_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card_with_status.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/in_process_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDeclarations extends StatelessWidget {
  const AllDeclarations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    List<Widget> drawDeclarationCards(List<DeclarationEntity> declarations) {
      final List<Widget> list = [];
      int count = 0;
      while (count < declarations.length) {
        list.add(
          DeclarationCardWithStatus(
            item: declarations[count],
          ),
        );
        count++;
      }

      return list;
    }

    return BlocBuilder<DeclarationsBloc, DeclarationsState>(
      builder: (context, state) {
        if (state is DeclarationsLoadingState) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is DeclarationsLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.doneDeclarations.isNotEmpty) ...drawDeclarationCards(state.doneDeclarations),
              if (state.inProgressDeclarations.isNotEmpty) const InProcessTitle(bottomPadding: 16),
              ...drawDeclarationCards(state.inProgressDeclarations),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ArchiveDeclarationButton(
                  theme: theme,
                  onTap: () {},
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}

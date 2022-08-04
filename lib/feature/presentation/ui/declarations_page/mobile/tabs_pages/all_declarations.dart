import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/archive_declaration_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card_with_status.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/in_process_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AllDeclarations extends StatelessWidget {
  const AllDeclarations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<DeclarationsBloc, DeclarationsState>(
      builder: (context, state) {
        if (state is DeclarationsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DeclarationsLoadedState) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.doneDeclarations.isNotEmpty)
                    ..._drawDeclarationCards(context, state.doneDeclarations),
                  if (state.inProgressDeclarations.isNotEmpty)
                    const InProcessTitle(bottomPadding: 16),
                  ..._drawDeclarationCards(
                    context,
                    state.inProgressDeclarations,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ArchiveDeclarationButton(
                      theme: theme,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

List<Widget> _drawDeclarationCards(
  BuildContext context,
  List<DeclarationEntity> declarations,
) {
  final List<Widget> list = [];
  int count = 0;
  while (count < declarations.length) {
    list.add(
      DeclarationCardWithStatus(
        item: declarations[count],
        onTap: () {
          context.pushNamed(NavigationRouteNames.declarationInfo);
        },
      ),
    );
    count++;
  }

  return list;
}

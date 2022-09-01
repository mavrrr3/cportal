import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/custom_padding.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_card_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/declarations_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDeclarationsTab extends StatelessWidget {
  const MyDeclarationsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizedStrings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;

    // Список заявлений.
    return BlocBuilder<DeclarationsBloc, DeclarationsState>(
      builder: (context, state) {
        List<DeclarationCardEntity> declarations = [];

        if (state is DeclarationsLoadingState && state.isFirstFetch) {
          return const Expanded(
            child: Center(
              child: PlatformProgressIndicator(),
            ),
          );
        } else if (state is DeclarationsLoadingState) {
          declarations = state.oldDeclarations;
        }

        if (state is DeclarationsLoadedState) {
          declarations = state.declarations;
        }

        return declarations.isNotEmpty
            ? CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                  ),
                  SliverPadding(
                    padding: getHorizontalPadding(context),
                    sliver: SliverToBoxAdapter(
                      child: DeclarationsList(
                        items: declarations,
                      ),
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(top: 128),
                child: Text(
                  localizedStrings.emptyDeclarations,
                  style: theme.textTheme.px22.copyWith(color: theme.textLight),
                  textAlign: TextAlign.center,
                ),
              );
      },
    );
  }
}

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declarations_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDeclarationsTab extends StatelessWidget {
  final ScrollController scrollController;
  const MyDeclarationsTab({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;

    // Список заявлений.
    return BlocBuilder<DeclarationsBloc, DeclarationsState>(
      builder: (context, state) {
        if (state is DeclarationsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DeclarationsLoadedState) {
          return state.declarations.isNotEmpty
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
                          items: state.declarations,
                          scrollController: scrollController,
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 128),
                  child: Text(
                    strings.emptyDeclarations,
                    style:
                        theme.textTheme.px22.copyWith(color: theme.textLight),
                    textAlign: TextAlign.center,
                  ),
                );
        }

        return const SizedBox();
      },
    );
  }
}

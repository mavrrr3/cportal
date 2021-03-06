import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/create_declaration_card.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/archive_declaration_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card_with_status.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/in_process_title.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/selected_filters_view.dart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeclarationsContentWeb extends StatelessWidget {
  final TextEditingController searchController;
  final Function() onFilterTap;

  const DeclarationsContentWeb({
    Key? key,
    required this.searchController,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final List<Widget> newDeclaration = [
      DeclarationCard(
        svgPath: ImageAssets.calendar,
        text: AppLocalizations.of(context)!.buisenesTripDeclaration,
      ),
      DeclarationCard(
        svgPath: ImageAssets.flyVocation,
        text: AppLocalizations.of(context)!.vocationDeclaration,
      ),
      DeclarationCard(
        svgPath: ImageAssets.lock,
        text: AppLocalizations.of(context)!.passDeclaration,
      ),
      DeclarationCard(
        svgPath: ImageAssets.payList,
        text: AppLocalizations.of(context)!.payListDeclaration,
      ),
      DeclarationCard(
        svgPath: ImageAssets.support,
        text: AppLocalizations.of(context)!.supportDeclaration,
      ),
    ];

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
          return Expanded(
            child: SafeArea(
              child: Padding(
                padding: getHorizontalPadding(context),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),

                      // ???????????? ?? ??????????????.
                      SearchWithFilter(
                        searchController: searchController,
                        onSearch: (text) {},
                        onFilterTap: onFilterTap,
                        padding: EdgeInsets.zero,
                      ),

                      // ?????????????????? ??????????????.
                      BlocBuilder<FilterDeclarationsBloc, FilterState>(
                        builder: (context, state) {
                          if (state is FilterLoadedState) {
                            return SelectedFiltersView(
                              filters: state.declarationsFilters,
                              onRemove: (item, i) {
                                BlocProvider.of<FilterDeclarationsBloc>(
                                  context,
                                ).add(
                                  FilterRemoveItemEvent(
                                    filterIndex: i,
                                    item: item,
                                  ),
                                );
                              },
                              padding: EdgeInsets.zero,
                            );
                          }

                          // TODO: ???????????????????? ???????????? ????????????.
                          return const SizedBox();
                        },
                      ),

                      // ?????????????? ??????????????????.
                      CreateDeclarationCard(
                        items: newDeclaration,
                        onTap: (i) {},
                      ),

                      // ?????????????? ?????????????????????? ??????????????????.
                      const SizedBox(height: 55),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: List.generate(
                          state.doneDeclarations.length,
                          (index) => DeclarationCardWithStatus(
                            item: state.doneDeclarations[index],
                            width: 328,
                            onTap: () {},
                          ),
                        ),
                      ),

                      // ??????????????????, ?????????????? ?? ????????????????.
                      const SizedBox(height: 32),
                      const InProcessTitle(bottomPadding: 24),

                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: List.generate(
                          state.inProgressDeclarations.length,
                          (index) => DeclarationCardWithStatus(
                            item: state.inProgressDeclarations[index],
                            width: 328,
                            onTap: () {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ArchiveDeclarationButton(
                        theme: theme,
                        onTap: () {},
                        width: 169,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        // TODO: ???????????????????? ???????????? ????????????.

        return const SizedBox();
      },
    );
  }
}

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_state.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_visibility_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/archive_declaration_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/create_declarations.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/in_process_title.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/card_with_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/selected_filters_view.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeclarationsContentWeb extends StatefulWidget {
  final TextEditingController searchController;
  final FocusNode searchFocus;

  final Function() onFilterTap;

  const DeclarationsContentWeb({
    Key? key,
    required this.searchController,
    required this.searchFocus,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  State<DeclarationsContentWeb> createState() => _DeclarationsContentWebState();
}

class _DeclarationsContentWebState extends State<DeclarationsContentWeb> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final locolizedStrings = AppLocalizations.of(context)!;
    final List<CardWithIcon> newDeclaration = [
      CardWithIcon(
        svgPath: ImageAssets.calendar,
        text: locolizedStrings.buisenesTripDeclaration,
        onTap: () {},
      ),
      CardWithIcon(
        svgPath: ImageAssets.flyVocation,
        text: locolizedStrings.vocationDeclaration,
        onTap: () {},
      ),
      CardWithIcon(
        svgPath: ImageAssets.lock,
        text: locolizedStrings.passDeclaration,
        onTap: () {},
      ),
      CardWithIcon(
        svgPath: ImageAssets.payList,
        text: locolizedStrings.payListDeclaration,
        onTap: () {},
      ),
      CardWithIcon(
        svgPath: ImageAssets.support,
        text: locolizedStrings.supportDeclaration,
        onTap: () {},
      ),
    ];

    return BlocBuilder<DeclarationsBloc, DeclarationsState>(
      builder: (context, state) {
        if (state is DeclarationsLoadingState) {
          return const Expanded(
            child: Center(
              child: PlatformProgressIndicator(),
            ),
          );
        }

        if (state is DeclarationsLoadedState) {
          return Stack(
            children: [
              SafeArea(
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

                        // Строка с поиском.
                        SearchWithFilter(
                          searchController: widget.searchController,
                          currentMenuIndex: 3,
                          onSearch: (text) {},
                          onSearchClear: () {},
                          onFilterTap: widget.onFilterTap,
                        ),

                        // Выбранные фильтры.
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

                            // TODO: отработать другие стейты.
                            return const SizedBox();
                          },
                        ),

                        // Создать заявление.
                        CreateDeclarations(
                          items: newDeclaration,
                          onTap: (i) {},
                        ),

                        // История завершенных заявлений.
                        // const SizedBox(height: 55),
                        // Wrap(
                        //   spacing: 16,
                        //   runSpacing: 8,
                        //   children: List.generate(
                        //     state.doneDeclarations.length,
                        //     (index) => DeclarationCardWithStatus(
                        //       item: state.doneDeclarations[index],
                        //       width: 328,
                        //       onTap: () {},
                        //     ),
                        //   ),
                        // ),

                        // Заявления, которые в процессе.
                        const SizedBox(height: 32),
                        const InProcessTitle(bottomPadding: 24),

                        // Wrap(
                        //   spacing: 16,
                        //   runSpacing: 8,
                        //   children: List.generate(
                        //     state.inProgressDeclarations.length,
                        //     (index) => DeclarationCardWithStatus(
                        //       item: state.inProgressDeclarations[index],
                        //       width: 328,
                        //       onTap: () {},
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 32),
                        ArchiveDeclarationButton(
                          onTap: () {},
                          width: 169,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<FilterVisibilityBloc, FilterVisibilityState>(
                builder: (_, state) {
                  return state.isActive
                      ? GestureDetector(
                          onTap: () => context
                              .read<FilterVisibilityBloc>()
                              .add(const FilterChangeVisibilityEvent(
                                isActive: false,
                              )),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: theme.barrierColor,
                          ),
                        )
                      : const SizedBox();
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FilterWeb(
                  type: FilterType.declarations,
                  onApply: _onApplyFilter,
                  onClear: _onClearFilter,
                ),
              ),
            ],
          );
        }

        // TODO: отработать другие стейты.

        return const SizedBox();
      },
    );
  }

  void _onApplyFilter() {
    context
        .read<FilterVisibilityBloc>()
        .add(const FilterChangeVisibilityEvent(isActive: false));
  }

  void _onClearFilter() {
    context.read<FilterDeclarationsBloc>().add(FilterRemoveAllEvent());
    context
        .read<FilterVisibilityBloc>()
        .add(const FilterChangeVisibilityEvent(isActive: false));
  }
}

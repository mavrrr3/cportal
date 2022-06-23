import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/tag_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedFiltersView extends StatelessWidget {
  final Function(FilterItemEntity, int) onRemove;
  const SelectedFiltersView({
    Key? key,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getHorizontalPadding(context),
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          if (state is FilterLoadedState) {
            return Column(
              children: [
                SizedBox(
                  height: _isAnyFilterSelected(state.filters) ? 19 : 31,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filters.length,
                  itemBuilder: (context, index) {
                    // Выбран ли хоть один пункт в текущем разделе фильтра.
                    final bool isActive = state.filters[index].items
                        .any((element) => element.isActive);

                    // Если isActive - создаем список только с выбранными пунктами в текущем разделе.
                    final List<FilterItemEntity> selectedItems = [];
                    if (isActive) {
                      for (final item in state.filters[index].items) {
                        if (item.isActive) {
                          selectedItems.add(item);
                        }
                      }
                    }

                    return isActive
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: FilterViewRow(
                              headline: state.filters[index].headline,
                              selectedItems: selectedItems,
                              onClose: onRemove,
                            ),
                          )
                        : const SizedBox();
                  },
                ),
                SizedBox(
                  height: _isAnyFilterSelected(state.filters) ? 8 : 0,
                ),
              ],
            );
          }

          // TODO: Обработать другие стейты.
          return const SizedBox();
        },
      ),
    );
  }

  bool _isAnyFilterSelected(List<FilterEntity> filters) {
    bool isActive = false;
    // ignore: avoid_function_literals_in_foreach_calls
    filters.forEach((filter) {
      // ignore: avoid_function_literals_in_foreach_calls
      filter.items.forEach((item) {
        if (item.isActive) {
          isActive = true;
        }
      });
    });

    return isActive;
  }
}

class FilterViewRow extends StatelessWidget {
  final String headline;
  final List<FilterItemEntity> selectedItems;
  final Function(FilterItemEntity, int) onClose;

  const FilterViewRow({
    Key? key,
    required this.headline,
    required this.selectedItems,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            headline,
            style: theme.textTheme.px12.copyWith(
              color: theme.textLight,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: List.generate(
              selectedItems.length,
              (index) => TagContainer(
                text: selectedItems[index].name,
                isCloseAction: true,
                onTap: () {
                  onClose(selectedItems[index], index);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

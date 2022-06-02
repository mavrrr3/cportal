import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/tag_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedFiltersView extends StatelessWidget {
  final FilterLoadedState state;
  final Function(FilterItemEntity, int) onClose;
  const SelectedFiltersView({
    Key? key,
    required this.state,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.filters.length,
      itemBuilder: (context, index) {
        // Выбран ли хоть один пункт в текущем разделе фильтра.
        final bool isActive =
            state.filters[index].items.any((element) => element.isActive);

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
                child: FilterViewSelectedRow(
                  headline: state.filters[index].headline,
                  selectedItems: selectedItems,
                  onClose: (item, i) {
                    BlocProvider.of<FilterBloc>(
                      context,
                    ).add(
                      FilterRemoveItemEvent(
                        filterIndex: index,
                        item: item,
                      ),
                    );
                  },
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class FilterViewSelectedRow extends StatelessWidget {
  final String headline;
  final List<FilterItemEntity> selectedItems;
  final Function(FilterItemEntity, int) onClose;

  const FilterViewSelectedRow({
    Key? key,
    required this.headline,
    required this.selectedItems,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            headline,
            style: theme.textTheme.bodyText1!.copyWith(
              color: theme.cardColor.withOpacity(0.68),
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

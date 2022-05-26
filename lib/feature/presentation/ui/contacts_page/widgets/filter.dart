import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Filter extends StatefulWidget {
  const Filter({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              controller: widget.scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: state.filters.length,
              itemBuilder: (context, index) => _FilterSectionItem(
                item: state.filters[index],
                onExpand: () {
                  BlocProvider.of<FilterBloc>(context)
                      .add(FilterExpandSectionEvent(index: index));
                },
                onSelect: (i) {
                  BlocProvider.of<FilterBloc>(context).add(
                    FilterSelectItemEvent(
                      filterIndex: index,
                      itemIndex: i,
                    ),
                  );
                },
              ),
            ),
          );
        }

        // TODO: Обработать другие стейты
        return const SizedBox();
      },
    );
  }
}

class _FilterSectionItem extends StatefulWidget {
  /// Блок отдельного раздела фильтра
  const _FilterSectionItem({
    Key? key,
    required this.item,
    required this.onExpand,
    required this.onSelect,
  }) : super(key: key);

  final FilterEntity item;
  final Function() onExpand;
  final Function(int) onSelect;

  @override
  State<_FilterSectionItem> createState() => _FilterSectionItemState();
}

class _FilterSectionItemState extends State<_FilterSectionItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.onExpand,
            // Разделы фильтра
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.light
                        ? theme.scaffoldBackgroundColor
                        : theme.scaffoldBackgroundColor.withOpacity(0.34),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      bottom: 9,
                      top: 11,
                    ),
                    child: Text(
                      widget.item.headline,
                      style: theme.textTheme.headline6!.copyWith(
                        color: theme.hoverColor.withOpacity(0.68),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                SvgPicture.asset(
                  widget.item.isActive
                      ? 'assets/icons/arrow_up.svg'
                      : 'assets/icons/arrow_down.svg',
                  width: 24,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (widget.item.isActive)
            // Пункты фильтра
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.item.items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    bottom: 12.0,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.onSelect(index);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomCheckBox(
                          onTap: () {
                            widget.onSelect(index);
                          },
                          isActive: widget.item.items[index].isActive,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.item.items[index].name,
                          style: theme.textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          // ...List.generate(, ),
        ],
      ),
    );
  }
}
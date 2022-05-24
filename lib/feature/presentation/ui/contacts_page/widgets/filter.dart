import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterModel {
  final String headline;
  final List<FilterItemModel> items;
  bool isActive;

  FilterModel({
    required this.headline,
    required this.items,
    this.isActive = false,
  });
}

class FilterItemModel {
  final String name;
  bool isActive;

  FilterItemModel({
    required this.name,
    this.isActive = false,
  });
}

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
  void initState() {
    BlocProvider.of<FilterBloc>(context, listen: false).add(FilterInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterStateImpl>(
      builder: (context, state) {
        return state.filters != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  controller: widget.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.filters!.length,
                  itemBuilder: (context, index) => _FilterItem(
                    item: state.filters![index],
                    onExpand: () {
                      setState(() {
                        BlocProvider.of<FilterBloc>(context, listen: false)
                            .add(FilterExpandSectionEvent(index: index));
                      });
                    },
                    onSelect: (i) {
                      setState(() {
                        BlocProvider.of<FilterBloc>(context, listen: false).add(
                          FilterSelectItemEvent(
                            filterIndex: index,
                            itemIndex: i,
                          ),
                        );
                      });
                    },
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class _FilterItem extends StatefulWidget {
  /// Блок отдельного фильтра
  const _FilterItem({
    Key? key,
    required this.item,
    required this.onExpand,
    required this.onSelect,
  }) : super(key: key);

  final FilterModel item;
  final Function() onExpand;
  final Function(int) onSelect;

  @override
  State<_FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<_FilterItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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

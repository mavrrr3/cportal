import 'package:cportal_flutter/feature/presentation/ui/contacts/widgets/check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterModel {
  final String headline;
  final List<String> items;
  bool isActive;

  FilterModel({
    required this.headline,
    required this.items,
    this.isActive = false,
  });
}

List<FilterModel> _filters = [
  FilterModel(
    headline: 'Компания',
    items: [
      'АЭМ3',
      'Новосталь-М',
      'Демедия',
    ],
  ),
  FilterModel(
    headline: 'Компания',
    items: [
      'АЭМ3',
      'Новосталь-М',
      'Демедия',
    ],
  ),
  FilterModel(
    headline: 'Компания',
    items: [
      'АЭМ3',
      'Новосталь-М',
      'Демедия',
    ],
  ),
];

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 396,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  _filters.length,
                  (index) => _FilterItem(
                    item: _filters[index],
                    onTap: () {
                      setState(() {
                        _filters[index].isActive = !_filters[index].isActive;
                      });
                    },
                    onSelect: (i) {},
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class _FilterItem extends StatefulWidget {
  /// Блок отдельного фильтра
  const _FilterItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onSelect,
  }) : super(key: key);

  final FilterModel item;
  final Function() onTap;
  final Function(int) onSelect;

  @override
  State<_FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<_FilterItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            const SizedBox(height: 16),
            if (widget.item.isActive)
              ...List.generate(widget.item.items.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    bottom: 12.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomCheckBox(
                        onTap: () {
                          widget.onSelect(index);
                        },
                        isActive: true,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.item.items[index],
                        style: theme.textTheme.headline6,
                      )
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

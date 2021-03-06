import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterSection extends StatefulWidget {
  final FilterEntity item;
  final TextEditingController controller;
  final Function() onExpand;
  final Function(int) onSelect;
  final Function(String) onSearch;
  final double? sectionWidth;

  /// Блок отдельного раздела фильтра.
  const FilterSection({
    Key? key,
    required this.item,
    required this.controller,
    required this.onExpand,
    required this.onSelect,
    required this.onSearch,
    this.sectionWidth,
  }) : super(key: key);

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.onExpand,

            /// Разделы фильтра.
            child: Row(
              children: [
                Container(
                  width: widget.sectionWidth ?? (MediaQuery.of(context).size.width - 80),
                  decoration: BoxDecoration(
                    color:
                        theme.brightness == Brightness.light ? theme.background : theme.background!.withOpacity(0.34),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: widget.item.isActive
                      ? TextField(
                          controller: widget.controller,
                          onChanged: (text) {
                            setState(() {});
                            widget.onSearch(text);
                          },
                          decoration: InputDecoration(
                            hintText: widget.item.headline,
                            hintStyle: theme.textTheme.px14.copyWith(
                              color: theme.textLight,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          style: theme.textTheme.px14.copyWith(
                            color: theme.textLight,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          child: Text(
                            widget.item.headline,
                            style: theme.textTheme.px14.copyWith(
                              color: theme.textLight,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 24),
                SvgPicture.asset(
                  widget.item.isActive ? ImageAssets.arrowUp : ImageAssets.arrowDown,
                  width: 24,
                  color: theme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (widget.item.isActive && widget.controller.text.isEmpty)
            // Пункты фильтра.
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.item.items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    bottom: 12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.onSelect(index);
                        },
                        child: CustomCheckBox(
                          isActive: widget.item.items[index].isActive,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          widget.onSelect(index);
                        },
                        child: Text(
                          widget.item.items[index].name,
                          style: theme.textTheme.px14,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          if (widget.item.isActive && widget.controller.text.isNotEmpty)
            // Пункты фильтра.
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: getSortedFilters(controller: widget.controller, items: widget.item.items).length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    bottom: 12,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // ignore: prefer-correct-identifier-length
                      final i = widget.item.items
                          .indexOf(getSortedFilters(controller: widget.controller, items: widget.item.items)[index]);
                      widget.onSelect(i);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomCheckBox(
                          isActive:
                              getSortedFilters(controller: widget.controller, items: widget.item.items)[index].isActive,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            getSortedFilters(controller: widget.controller, items: widget.item.items)[index].name,
                            style: theme.textTheme.px14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

List<FilterItemEntity> getSortedFilters({
  required TextEditingController controller,
  required List<FilterItemEntity> items,
}) {
  final List<FilterItemEntity> findedFilters = [];
  for (final element in items) {
    if (element.name.toLowerCase().contains(controller.text.toLowerCase())) {
      findedFilters.add(element);
    }
  }

  return findedFilters;
}

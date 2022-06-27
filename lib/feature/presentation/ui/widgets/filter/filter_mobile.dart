import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_contacts_bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/custom_check_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Filter Bottom Sheet Mobile.
Future<void> showFilterMobile(
  BuildContext context, {
  required Function() onApply,
  required Function() onClear,
}) async {
  final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: theme.cardColor,
    barrierColor: theme.barrierColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      snap: true,
      initialChildSize: 0.57,
      minChildSize: 0.57,
      maxChildSize: 0.875,
      builder: (
        context,
        scrollController,
      ) =>
          FilterMobile(
        scrollController: scrollController,
        onApply: onApply,
        onClear: onClear,
      ),
    ),
  );
}

class FilterMobile extends StatefulWidget {
  final ScrollController scrollController;
  final Function() onApply;
  final Function() onClear;

  const FilterMobile({
    Key? key,
    required this.scrollController,
    required this.onApply,
    required this.onClear,
  }) : super(key: key);

  @override
  State<FilterMobile> createState() => _FilterMobileState();
}

class _FilterMobileState extends State<FilterMobile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterContactsBloc, FilterState>(
      builder: (context, state) {
        if (state is ContactsFiltersLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Контент фильтра.
                Expanded(
                  child: ListView.builder(
                    controller: widget.scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.filters.length,
                    itemBuilder: (context, index) => FilterSectionItem(
                      item: state.filters[index],
                      onExpand: () {
                        BlocProvider.of<FilterContactsBloc>(context).add(FilterExpandSectionEvent(index: index));
                      },
                      onSelect: (i) {
                        BlocProvider.of<FilterContactsBloc>(context).add(
                          FilterSelectItemEvent(
                            filterIndex: index,
                            itemIndex: i,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Кнопки фильтра.
                FilterActionButtons(
                  width: (MediaQuery.of(context).size.width - 44) / 2,
                  onApply: widget.onApply,
                  onClear: widget.onClear,
                ),
              ],
            ),
          );
        }

        // TODO: Обработать другие стейты.
        return const SizedBox();
      },
    );
  }
}

class FilterSectionItem extends StatefulWidget {
  final FilterEntity item;
  final Function() onExpand;
  final Function(int) onSelect;
  final double? sectionWidth;

  /// Блок отдельного раздела фильтра.
  const FilterSectionItem({
    Key? key,
    required this.item,
    required this.onExpand,
    required this.onSelect,
    this.sectionWidth,
  }) : super(key: key);

  @override
  State<FilterSectionItem> createState() => _FilterSectionItemState();
}

class _FilterSectionItemState extends State<FilterSectionItem> {
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
                  child: Padding(
                    padding: const EdgeInsets.all(12),
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
                  widget.item.isActive ? 'assets/icons/arrow_up.svg' : 'assets/icons/arrow_down.svg',
                  width: 24,
                  color: theme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (widget.item.isActive)
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
                        Expanded(
                          child: Text(
                            widget.item.items[index].name,
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

import 'dart:developer';

import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Filter Bottom Sheet Mobile.
Future<void> showFilterMobile(
  BuildContext context, {
  required Function() onApply,
  required Function() onClear,
  required FilterType type,
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
    builder: (context) => GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: DraggableScrollableSheet(
        expand: false,
        snap: true,
        initialChildSize: 0.875,
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
          type: type,
        ),
      ),
    ),
  ).whenComplete(() {
    log('post chosen filters request');
    switch (type) {
      case FilterType.contacts:

      default:
    }
  });
}

class FilterMobile extends StatefulWidget {
  final ScrollController scrollController;
  final Function() onApply;
  final Function() onClear;
  final FilterType type;

  const FilterMobile({
    Key? key,
    required this.scrollController,
    required this.onApply,
    required this.onClear,
    required this.type,
  }) : super(key: key);

  @override
  State<FilterMobile> createState() => _FilterMobileState();
}

class _FilterMobileState extends State<FilterMobile> {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      // Мобильная версия фильтра для раздела "Контакты".
      case FilterType.contacts:
        return BlocBuilder<FilterContactsBloc, FilterState>(
          builder: (context, state) {
            if (state is FilterLoadedState) {
              final List<TextEditingController> controllers = [];
              // ignore: prefer-correct-identifier-length
              for (int i = 0; i < state.contactsFilters.length; i++) {
                controllers.add(TextEditingController());
              }

              return BottomSheetContent(
                scrollController: widget.scrollController,
                filters: state.contactsFilters,
                controllers: controllers,
                onExpand: (i) {
                  BlocProvider.of<FilterContactsBloc>(context).add(FilterExpandSectionEvent(index: i));
                },
                onSelect: (filterIndex, itemIndex) {
                  BlocProvider.of<FilterContactsBloc>(context).add(
                    FilterSelectItemEvent(
                      filterIndex: filterIndex,
                      itemIndex: itemIndex,
                    ),
                  );
                },
                onSearch: (i, text) {
                  log(controllers[i].text);
                },
                onApply: widget.onApply,
                onClear: widget.onClear,
              );
            }

            // TODO: Обработать другие стейты.
            return const SizedBox();
          },
        );

      // Мобильная версия фильтра для раздела "Заявления".
      case FilterType.declarations:
        return BlocBuilder<FilterDeclarationsBloc, FilterState>(
          builder: (context, state) {
            if (state is FilterLoadedState) {
              final List<TextEditingController> controllers = [];
              // ignore: prefer-correct-identifier-length
              for (int i = 0; i < state.declarationsFilters.length; i++) {
                controllers.add(TextEditingController());
              }

              return BottomSheetContent(
                scrollController: widget.scrollController,
                filters: state.declarationsFilters,
                controllers: controllers,
                onExpand: (i) {
                  BlocProvider.of<FilterDeclarationsBloc>(context).add(FilterExpandSectionEvent(index: i));
                },
                onSelect: (filterIndex, itemIndex) {
                  BlocProvider.of<FilterDeclarationsBloc>(context).add(
                    FilterSelectItemEvent(
                      filterIndex: filterIndex,
                      itemIndex: itemIndex,
                    ),
                  );
                },
                onSearch: (i, text) {},
                onApply: widget.onApply,
                onClear: widget.onClear,
              );
            }

            // TODO: Обработать другие стейты.
            return const SizedBox();
          },
        );

      default:
        return const SizedBox();
    }
  }
}

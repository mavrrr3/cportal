import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_visibility_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_web_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterWeb extends StatefulWidget {
  final FilterType type;
  final Function() onApply;
  final Function() onClear;

  const FilterWeb({
    Key? key,
    required this.type,
    required this.onApply,
    required this.onClear,
  }) : super(key: key);

  @override
  State<FilterWeb> createState() => _FilterWebState();
}

class _FilterWebState extends State<FilterWeb> {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      // Web версия фильтра для раздела "Контакты".
      case FilterType.contacts:
        return BlocBuilder<FilterContactsBloc, FilterState>(
          builder: (context, state) {
            if (state is FilterLoadedState) {
              return BlocBuilder<FilterVisibilityBloc, FilterVisibilityState>(
                builder: (_, visibility) {
                  return FilterWebContent(
                    isActive: visibility.isActive,
                    filters: state.contactsFilters,
                    controllers: const [],
                    onApply: widget.onApply,
                    onClear: widget.onClear,
                    onExpand: (i) =>
                        BlocProvider.of<FilterContactsBloc>(context).add(
                      FilterExpandSectionEvent(index: i),
                    ),
                    onSelect: (filterIndex, itemIndex) =>
                        BlocProvider.of<FilterContactsBloc>(context).add(
                      FilterSelectItemEvent(
                        filterIndex: filterIndex,
                        itemIndex: itemIndex,
                      ),
                    ),
                    onSearch: (i, text) {},
                  );
                },
              );
            }

            // TODO: Обработать другие стейты.
            return const SizedBox();
          },
        );

      // Web версия фильтра для раздела "Заявления".
      case FilterType.declarations:
        return BlocBuilder<FilterDeclarationsBloc, FilterState>(
          builder: (context, state) {
            if (state is FilterLoadedState) {
              return BlocBuilder<FilterVisibilityBloc, FilterVisibilityState>(
                builder: (_, visibility) {
                  return FilterWebContent(
                    isActive: visibility.isActive,
                    filters: state.declarationsFilters,
                    controllers: const [],
                    onApply: widget.onApply,
                    onClear: widget.onClear,
                    onExpand: (i) =>
                        BlocProvider.of<FilterDeclarationsBloc>(context).add(
                      FilterExpandSectionEvent(index: i),
                    ),
                    onSelect: (filterIndex, itemIndex) =>
                        BlocProvider.of<FilterDeclarationsBloc>(context).add(
                      FilterSelectItemEvent(
                        filterIndex: filterIndex,
                        itemIndex: itemIndex,
                      ),
                    ),
                    onSearch: (i, text) {},
                  );
                },
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

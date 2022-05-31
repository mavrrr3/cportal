import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterWeb extends StatefulWidget {
  const FilterWeb({Key? key}) : super(key: key);

  @override
  State<FilterWeb> createState() => _FilterWebState();
}

class _FilterWebState extends State<FilterWeb> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoadedState) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(color: theme.backgroundColor),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.filters.length,
                        itemBuilder: (context, index) => FilterSectionItem(
                          sectionWidth:
                              MediaQuery.of(context).size.width * 0.25 - 80,
                          item: state.filters[index],
                          onExpand: () {
                            BlocProvider.of<FilterBloc>(context).add(
                              FilterExpandSectionEvent(index: index),
                            );
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Применить.
                          _ActionButton(
                            text: 'Применить',
                            onTap: () {},
                          ),

                          // Очистить.
                          _ActionButton(
                            text: 'Очистить',
                            onTap: () {},
                            isOutline: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // TODO: Обработать другие стейты.
        return const SizedBox();
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final bool isOutline;

  /// Кнопка фильтра [Применить, Очистить].
  const _ActionButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isOutline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width * 0.25 - 48) / 2,
        decoration: BoxDecoration(
          color: isOutline ? Colors.transparent : theme.primaryColor,
          border: isOutline
              ? Border.all(width: 2, color: theme.primaryColor)
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              text,
              style: theme.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w700,
                color: isOutline
                    ? theme.primaryColor
                    : theme.brightness == Brightness.light
                        ? Colors.white
                        : theme.hoverColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterWeb extends StatefulWidget {
  final Function() onApply;
  final Function() onClear;

  const FilterWeb({
    Key? key,
    required this.onApply,
    required this.onClear,
  }) : super(key: key);

  @override
  State<FilterWeb> createState() => _FilterWebState();
}

class _FilterWebState extends State<FilterWeb> {
  @override
  Widget build(BuildContext context) {
                                     final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;


    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoadedState) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(color: theme.cardColor),
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
                      child: FilterActionButtons(
                        width:
                            (MediaQuery.of(context).size.width * 0.25 - 48) / 2,
                        onApply: widget.onApply,
                        onClear: widget.onClear,
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

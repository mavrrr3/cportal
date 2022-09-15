import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';

import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/tasks_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/selected_filters_view.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final localizedStrings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final responsiveUtil = ResponsiveUtil(context);

    // Список задач.
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return const Center(child: PlatformProgressIndicator());
        }
        if (state is TasksLoadedState) {
          return state.tasks.isNotEmpty
              ? CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context,
                      ),
                    ),
                    SliverPadding(
                      padding: responsiveUtil.getHorizontalPadding(),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Выбранные фильтры.
                            BlocBuilder<FilterDeclarationsBloc, FilterState>(
                              builder: (context, state) {
                                if (state is FilterLoadedState) {
                                  return SelectedFiltersView(
                                    filters: state.declarationsFilters,
                                    padding: EdgeInsets.zero,
                                    onRemove: (item, i) async {
                                      context
                                          .read<FilterDeclarationsBloc>()
                                          .add(
                                            FilterRemoveItemEvent(
                                              filterIndex: i,
                                              item: item,
                                            ),
                                          );
                                      await Future<dynamic>.delayed(
                                        const Duration(milliseconds: 150),
                                      );
                                      // Widget.sendFilters();.
                                    },
                                  );
                                }

                                // TODO: отработать другие стейты.
                                return const SizedBox(height: 0);
                              },
                            ),
                            TasksList(items: state.tasks),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 128),
                  child: Text(
                    localizedStrings.emptyTasks,
                    style:
                        theme.textTheme.px22.copyWith(color: theme.textLight),
                    textAlign: TextAlign.center,
                  ),
                );
        }

        return const SizedBox();
      },
    );
  }
}

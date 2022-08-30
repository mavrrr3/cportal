import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/custom_padding.dart';
import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_bloc/tasks_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_bloc/tasks_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;

    // Список задач.
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return const Center(child: CircularProgressIndicator());
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
                      padding: getHorizontalPadding(context),
                      sliver: const SliverToBoxAdapter(
                        child: SizedBox(),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 128),
                  child: Text(
                    strings.emptyTasks,
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

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/custom_tab_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DeclarationsTabBar extends StatefulWidget {
  final TabController tabController;
  const DeclarationsTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<DeclarationsTabBar> createState() => _DeclarationsTabBarState();
}

class _DeclarationsTabBarState extends State<DeclarationsTabBar> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return CustomTabBar(
      isScrollable: false,
      tabs: [
        Tab(
          child: Text(
            AppLocalizations.of(context)!.myDeclarations,
            style: theme.textTheme.px16.copyWith(
              fontWeight: FontWeight.w700,
              leadingDistribution: TextLeadingDistribution.even,
              color:
                  widget.tabController.index == 0 ? theme.primary : theme.text,
            ),
          ),
        ),
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.tasks,
                style: theme.textTheme.px16.copyWith(
                  fontWeight: FontWeight.w700,
                  leadingDistribution: TextLeadingDistribution.even,
                  color: widget.tabController.index == 1
                      ? theme.primary
                      : theme.text,
                ),
              ),
              BlocBuilder<TasksBloc, TasksState>(
                builder: (context, state) {
                  if (state is TasksLoadedState) {
                    if (state.tasks.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Container(
                          width: 16,
                          height: 17,
                          decoration: BoxDecoration(
                            color: theme.red,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${state.tasks.length}',
                              style: theme.textTheme.px10
                                  .copyWith(color: theme.white),
                            ),
                          ),
                        ),
                      );
                    }
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ],
      tabController: widget.tabController,
    );
  }
}

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TasksList extends StatelessWidget {
  final List<TaskCardEntity> items;

  const TasksList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    DateTime startDate = DateTime(1111, 1, 1);

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, i) {
        if (startDate.day != items[i].date.day) {
          startDate = items[i].date;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: i == 0 ? 20 : 24),
              Text(
                FormatterUtil.dayWithFullMonth(
                  date: items[i].date,
                ),
                style: theme.textTheme.px12.copyWith(color: theme.textLight),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 18,
                  bottom: getBottomPadding(i),
                ),
                child: TaskCard(
                  item: items[i],
                  onTap: () => context.pushNamed(
                    NavigationRouteNames.taskInfo,
                    params: {
                      'fid': items[i].id,
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(
              top: 16,
              bottom: getBottomPadding(i),
            ),
            child: TaskCard(
              item: items[i],
              onTap: () => context.pushNamed(
                NavigationRouteNames.taskInfo,
                params: {
                  'fid': items[i].id,
                },
              ),
            ),
          );
        }
      },
    );
  }

  double getBottomPadding(int i) => i == items.length - 1 ? 32 : 0;
}

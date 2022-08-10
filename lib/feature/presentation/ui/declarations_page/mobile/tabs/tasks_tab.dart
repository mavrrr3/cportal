import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card_with_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TasksTab extends StatelessWidget {
  final ScrollController scrollController;
  const TasksTab({
    Key? key,
    required this.scrollController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Список задач.
    return BlocBuilder<DeclarationsBloc, DeclarationsState>(
      builder: (context, state) {
        if (state is DeclarationsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DeclarationsLoadedState) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: getHorizontalPadding(context),
                sliver: SliverToBoxAdapter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: state.tasks.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: DeclarationCardWithStatus(
                          item: state.tasks[i],
                          onTap: () => context.pushNamed(
                            NavigationRouteNames.declarationInfo,
                            params: {'fid': state.tasks[i].id},
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}

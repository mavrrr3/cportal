import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declarations_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDeclarationsTab extends StatelessWidget {
  final ScrollController scrollController;
  const MyDeclarationsTab({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Список заявлений.
    return BlocBuilder<DeclarationsBloc, DeclarationsState>(
      builder: (context, state) {
        if (state is DeclarationsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DeclarationsLoadedState) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: getHorizontalPadding(context),
                sliver: SliverToBoxAdapter(
                  child: DeclarationsList(
                    items: state.declarations,
                    scrollController: scrollController,
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

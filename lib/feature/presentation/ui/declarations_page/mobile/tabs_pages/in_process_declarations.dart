import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declarations_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InProcessDeclarations extends StatelessWidget {
  const InProcessDeclarations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeclarationsBloc, DeclarationsState>(
      builder: (context, state) {
        if (state is DeclarationsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DeclarationsLoadedState) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 16,
            ),
            child: DeclarationsList(
              items: state.inProgressDeclarations,
              onTap: (i) =>
                  context.pushNamed(NavigationRouteNames.declarationInfo),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

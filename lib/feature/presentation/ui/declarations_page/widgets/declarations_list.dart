import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';

import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card_with_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeclarationsList extends StatelessWidget {
  const DeclarationsList({
    Key? key,
  }) : super(key: key);

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
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.declarations.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: EdgeInsets.only(
                  top: i == 0 ? 9 : 0,
                  bottom: 16,
                ),
                child: DeclarationCardWithStatus(
                  item: state.declarations[i],
                  onTap: () => context.pushNamed(
                    NavigationRouteNames.declarationInfo,
                    params: {'fid': state.declarations[i].id},
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

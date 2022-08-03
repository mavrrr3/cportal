import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_visibility_bloc.dart';

class BarierContainerMenu extends StatelessWidget {
  const BarierContainerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<FilterVisibilityBloc, FilterVisibilityState>(
      builder: (_, state) {
        return state.isActive
            ? GestureDetector(
                onTap: () => context
                    .read<FilterVisibilityBloc>()
                    .add(const FilterChangeVisibilityEvent(isActive: false)),
                child: Container(
                  width: 256,
                  height: MediaQuery.of(context).size.height,
                  color: theme.barrierColor,
                ),
              )
            : const SizedBox();
      },
    );
  }
}

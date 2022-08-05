import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/barier_container_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_items_column_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesktopMenu extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;
  final Function()? onboarding;

  const DesktopMenu({
    Key? key,
    required this.currentIndex,
    required this.onChange,
    this.onboarding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              width: 256,
              height: MediaQuery.of(context).size.height,
              color: theme.cardColor,
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: MenuItemsColumnWeb(
                    menuItems: state.menuItems,
                    currentIndex: currentIndex,
                    onChange: onChange,
                  ),
                ),
              ),
            ),
            const BarierContainerMenu(),
          ],
        );
      },
    );
  }
}

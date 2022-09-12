import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_items_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BurgerMenu extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;
  final double menuWidth;
  final int duration;

  const BurgerMenu({
    Key? key,
    required this.currentIndex,
    required this.onChange,
    this.menuWidth = 256,
    this.duration = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, state) {
        return Row(
          children: [
            AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: duration),
              width: state.isActive ? menuWidth : 0,
              height: MediaQuery.of(context).size.height,
              color: theme.cardColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: AnimatedOpacity(
                  curve: Curves.easeInCubic,
                  opacity: state.isActive ? 1 : 0,
                  duration: Duration(milliseconds: (duration * 1.15).toInt()),
                  child: Material(
                    color: theme.cardColor,
                    child: SafeArea(
                      child: MenuItemsColumn(
                        menuItems: state.menuItems,
                        currentIndex: currentIndex,
                        onChange: onChange,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.read<NavigationBarBloc>().add(
                    NavBarVisibilityEvent(
                      index: currentIndex,
                      isActive: false,
                    ),
                  ),
              child: AnimatedOpacity(
                curve: Curves.easeInCubic,
                opacity: state.isActive ? 1 : 0,
                duration: Duration(milliseconds: (duration * 1.6).toInt()),
                child: state.isActive
                    ? Container(
                        width: MediaQuery.of(context).size.width - menuWidth,
                        height: MediaQuery.of(context).size.height,
                        color: theme.barrierColor,
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        );
      },
    );
  }
}

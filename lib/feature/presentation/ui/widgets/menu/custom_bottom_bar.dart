import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/menu_button_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatefulWidget {
  final bool isNestedNavigation;

  const CustomBottomBar({
    Key? key,
    this.isNestedNavigation = false,
  }) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: theme.cardColor,
              child: SafeArea(
                minimum: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    state.menuItems.length,
                    (index) => _MenuItem(
                      item: state.menuItems[index],
                      state: state,
                      index: index,
                      onTap: () {
                        if (widget.isNestedNavigation) {
                          context.pop();
                        }
                        setState(
                          () => BlocProvider.of<NavigationBarBloc>(context).add(NavBarChangePageEvent(index: index)),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MenuItem extends StatelessWidget {
  final NavigationBarState state;
  final MenuButtonEntity item;
  final Function() onTap;
  final int index;

  const _MenuItem({
    Key? key,
    required this.item,
    required this.state,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    final Color nonActiveColor = theme.text!.withOpacity(0.48);
    final Color activeColor = theme.primary!;

    Color textColor(int index, NavigationBarState state) {
      return theme.brightness == Brightness.light
          ? state.currentIndex == index
              ? activeColor
              : nonActiveColor
          : state.currentIndex == index
              ? activeColor
              : Colors.white;
    }

    Color iconColor(int index, NavigationBarState state) {
      return state.currentIndex == index ? activeColor : nonActiveColor;
    }

    return ExpandTapWidget(
      tapPadding: const EdgeInsets.symmetric(horizontal: 10),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          SvgPicture.asset(
            item.img,
            width: 24,
            color: iconColor(index, state),
          ),
          const SizedBox(height: 4),
          Text(
            item.text,
            style: theme.textTheme.bottomBar.copyWith(
              color: textColor(index, state),
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatefulWidget {
  final NavigationBarState state;
  final bool isNestedNavigation;

  const CustomBottomBar({
    Key? key,
    required this.state,
    this.isNestedNavigation = false,
  }) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color: theme.splashColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.state.menuItems.length,
          (index) => _MenuItem(
            item: widget.state.menuItems[index],
            state: widget.state,
            index: index,
            onTap: () {
              if (widget.isNestedNavigation) {
                context.pop();
              }
              setState(
                () => BlocProvider.of<NavigationBarBloc>(context)
                    .add(NavigationBarEventImpl(index: index)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final NavigationBarState state;
  final MenuButtonModel item;
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
    final ThemeData theme = Theme.of(context);
    final Color nonActiveColor = theme.brightness == Brightness.light
        ? theme.hoverColor.withOpacity(0.48)
        : theme.cardColor.withOpacity(0.48);
    final Color activeColor = theme.primaryColor;

    Color _textColor(int index, NavigationBarState state) {
      final ThemeData theme = Theme.of(context);

      return theme.brightness == Brightness.light
          ? state.currentIndex == index
              ? activeColor
              : nonActiveColor
          : state.currentIndex == index
              ? activeColor
              : Colors.white;
    }

    Color _iconColor(int index, NavigationBarState state) {
      return state.currentIndex == index ? activeColor : nonActiveColor;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          SvgPicture.asset(
            item.img,
            width: 24,
            color: _iconColor(index, state),
          ),
          const SizedBox(height: 4),
          Text(
            item.text,
            style: theme.textTheme.bodyText2!.copyWith(
              color: _textColor(index, state),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

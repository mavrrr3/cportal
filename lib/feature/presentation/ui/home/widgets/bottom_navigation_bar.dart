import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    Key? key,
    required this.state,
    this.isNestedNavigation = false,
  }) : super(key: key);
  final NavBarState state;
  final bool isNestedNavigation;
  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      height: 56,
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
                () => BlocProvider.of<NavBarBloc>(context)
                    .add(NavBarEventImpl(index: index)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    Key? key,
    required this.item,
    required this.state,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final NavBarState state;
  final MenuButtonModel item;
  final Function() onTap;
  final int index;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color _nonActiveColor = theme.brightness == Brightness.light
        ? theme.hoverColor.withOpacity(0.48)
        : theme.cardColor.withOpacity(0.48);
    final Color _activeColor = theme.primaryColor;

    Color _textColor(int index, NavBarState state) {
      final ThemeData theme = Theme.of(context);

      // ignore: prefer-conditional-expressions
      if (theme.brightness == Brightness.light) {
        return state.currentIndex == index ? _activeColor : _nonActiveColor;
      } else {
        return state.currentIndex == index ? _activeColor : Colors.white;
      }
    }

    Color _iconColor(int index, NavBarState state) {
      return state.currentIndex == index ? _activeColor : _nonActiveColor;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuButtonModel {
  final String img;
  final String text;

  MenuButtonModel({
    required this.img,
    required this.text,
  });
}

class DesktopMenu extends StatelessWidget {
  const DesktopMenu({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onChange,
  }) : super(key: key);

  final List<MenuButtonModel> items;
  final int currentIndex;
  final Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: 256,
      height: MediaQuery.of(context).size.height,
      color: theme.splashColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SvgPicture.asset(
                'assets/icons/logo_grey.svg',
                color: theme.brightness == Brightness.dark
                    ? theme.hoverColor
                    : null,
                width: 24.0,
              ),
            ),
            const SizedBox(height: 24),

            // Генерация навигационных элементов меню
            ...List.generate(
              items.length,
              (index) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  onChange(index);
                },
                child: _MenuItem(
                  item: items[index],
                  isActive: currentIndex == index,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    Key? key,
    required this.item,
    required this.isActive,
    this.duration = const Duration(milliseconds: 250),
  }) : super(key: key);

  final MenuButtonModel item;
  final Duration duration;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isActive
            ? theme.brightness == Brightness.light
                ? theme.scaffoldBackgroundColor
                : theme.scaffoldBackgroundColor.withOpacity(0.34)
            : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SvgPicture.asset(
              item.img,
              width: 24,
              color: isActive
                  ? theme.primaryColor
                  : theme.cardColor.withOpacity(0.48),
            ),
            const SizedBox(width: 16),
            Text(
              item.text,
              style: theme.textTheme.headline5!.copyWith(
                color: isActive
                    ? theme.primaryColor
                    : theme.cardColor.withOpacity(0.68),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

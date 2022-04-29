import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuButtonModel {
  final String img;
  final String text;
  bool isActive;

  MenuButtonModel({
    required this.img,
    required this.text,
    this.isActive = false,
  });
}

class DesktopMenu extends StatelessWidget {
  const DesktopMenu({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<MenuButtonModel> items;

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
            SvgIcon(
              theme.brightness == Brightness.dark ? theme.hoverColor : null,
              path: 'logo_grey.svg',
              width: 24.0,
            ),
            const SizedBox(height: 24),

            // Генерация навигационных элементов меню
            ...List.generate(
              items.length,
              (index) => _MenuItem(item: items[index]),
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
    this.duration = const Duration(milliseconds: 250),
  }) : super(key: key);

  final MenuButtonModel item;
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnimatedContainer(
      duration: duration,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: item.isActive
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
              color: item.isActive
                  ? theme.primaryColor
                  : theme.cardColor.withOpacity(0.48),
            ),
            const SizedBox(width: 16),
            Text(
              item.text,
              style: theme.textTheme.headline5!.copyWith(
                color: item.isActive
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

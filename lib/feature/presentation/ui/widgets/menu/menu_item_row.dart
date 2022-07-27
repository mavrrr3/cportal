import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/menu_button_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItemRow extends StatelessWidget {
  final MenuButtonEntity item;
  final Duration duration = const Duration(milliseconds: 250);
  final bool isActive;
  const MenuItemRow({
    Key? key,
    required this.item,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isActive
            ? theme.brightness == Brightness.light
                ? theme.background
                : theme.background?.withOpacity(0.34)
            : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: OnHover(builder: (isHovered) {
          return Row(
            children: [
              SvgPicture.asset(
                item.img,
                width: 24,
                color: isActive
                    ? theme.primary
                    : isHovered
                        ? theme.primary
                        : theme.text?.withOpacity(0.48),
              ),
              const SizedBox(width: 16),
              Text(
                item.text,
                style: theme.textTheme.px16.copyWith(
                  color: isActive
                      ? theme.primary
                      : isHovered
                          ? theme.primary
                          : theme.text,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

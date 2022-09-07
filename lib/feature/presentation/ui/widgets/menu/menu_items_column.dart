import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/menu_button_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItemsColumn extends StatelessWidget {
  final List<MenuButtonEntity> menuItems;
  final int currentIndex;
  final Function(int) onChange;
  const MenuItemsColumn({
    Key? key,
    required this.menuItems,
    required this.currentIndex,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          ImageAssets.logo,
          color: theme.text!.withOpacity(0.4),
          width: 24,
        ),
        const SizedBox(height: 24),
        // Генерация навигационных элементов меню.
        ...List.generate(
          menuItems.length,
          (i) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              onChange(i);
            },
            child: MenuItemRow(
              item: menuItems[i],
              isActive: currentIndex == i,
            ),
          ),
        ),
      ],
    );
  }
}

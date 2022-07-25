import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        return Container(
          width: 256,
          height: MediaQuery.of(context).size.height,
          color: theme.cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: GestureDetector(
                    onTap: onboarding,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SvgPicture.asset(
                        ImageAssets.logo,
                        color: theme.text!.withOpacity(0.4),
                        width: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Генерация навигационных элементов меню.
                ...List.generate(
                  state.menuItems.length,
                  (i) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      onChange(i);
                    },
                    child: MenuItemRow(
                      item: state.menuItems[i],
                      isActive: currentIndex == i,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

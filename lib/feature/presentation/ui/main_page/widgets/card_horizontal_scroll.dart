import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardHorizontalScroll extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const CardHorizontalScroll({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return OnHover(
      builder: (isHovered) {
        return GestureDetector(
          onTap: () => context.goNamed(NavigationRouteNames.onBoardingStart),
          child: Container(
            width: 148,
            height: 92,
            decoration: BoxDecoration(
              color: isHovered ? color?.withOpacity(0.6) : color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: theme.textLight,
                  ),
                  Text(
                    text,
                    style: theme.textTheme.px14.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

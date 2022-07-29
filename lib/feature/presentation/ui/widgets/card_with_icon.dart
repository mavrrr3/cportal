import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardWithIcon extends StatelessWidget {
  final String svgPath;
  final String text;
  final Function() onTap;
  final Color? color;
  final double? width;

  const CardWithIcon({
    Key? key,
    required this.svgPath,
    required this.text,
    required this.onTap,
    this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final defaultColor = color ?? theme.cardColor;

    return OnHover(
      builder: (isHovered) {
        return Opacity(
          opacity: isHovered ? 0.6 : 1,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: width ?? 156,
              height: 92,
              decoration: BoxDecoration(
                color: defaultColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      svgPath,
                      width: 24,
                      color: theme.textLight,
                    ),
                    Text(
                      text,
                      style: theme.textTheme.px14.copyWith(height: 1.5),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

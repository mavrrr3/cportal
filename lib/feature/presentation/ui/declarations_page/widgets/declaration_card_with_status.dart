import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeclarationCardWithStatus extends StatelessWidget {
  final Widget status;
  final String title;
  final String svgPath;
  final String date;
  final String number;

  const DeclarationCardWithStatus({
    Key? key,
    required this.status,
    required this.title,
    required this.svgPath,
    required this.date,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.px14.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SvgPicture.asset(
                        svgPath,
                        color: theme.textLight,
                        width: 20,
                      ),
                    ],
                  ),
                  Text(
                    date,
                    style: theme.textTheme.px12.copyWith(
                      color: theme.textLight,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    number,
                    style: theme.textTheme.px12.copyWith(
                      color: theme.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Бейдж со статусами "Одобрено, Отклонено, Обработка".
          Positioned(
            left: 12,
            top: -9,
            child: status,
          ),
        ],
      ),
    );
  }
}

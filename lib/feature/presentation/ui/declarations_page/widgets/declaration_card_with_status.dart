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
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: theme.backgroundColor,
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
                        style: theme.textTheme.headline6!.copyWith(
                          color: theme.cardColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SvgPicture.asset(
                        svgPath,
                        width: 20,
                      ),
                    ],
                  ),
                  Text(
                    date,
                    style: theme.textTheme.bodyText1!.copyWith(
                      color: theme.cardColor.withOpacity(0.68),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    number,
                    style: theme.textTheme.bodyText1!.copyWith(
                      color: theme.cardColor.withOpacity(0.68),
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

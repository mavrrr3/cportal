// ignore_for_file: prefer_int_literals

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeclarationHeadline extends StatefulWidget {
  final String title;
  final Function()? onTap;

  // Если передается, то стрелка рендерится в заголовке
  // bool отвечает за то развернут список или нет
  final bool? isArrow;
  // Передавать, если isArrow != null.
  final AnimationController? controller;

  /// Виджет заголовка на странице подробно открытого заявления/задачи.
  const DeclarationHeadline({
    super.key,
    required this.title,
    this.onTap,
    this.isArrow,
    this.controller,
  });

  @override
  State<DeclarationHeadline> createState() => _DeclarationHeadlineState();
}

class _DeclarationHeadlineState extends State<DeclarationHeadline> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: theme.textTheme.px16Bold,
          ),
          if (widget.isArrow != null)
            RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(widget.controller!),
              child: SvgPicture.asset(
                ImageAssets.arrowUp,
                width: 24,
                color: theme.primary,
              ),
            ),
        ],
      ),
    );
  }
}

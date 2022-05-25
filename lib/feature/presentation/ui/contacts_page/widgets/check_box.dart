import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    Key? key,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  final Function() onTap;
  final bool isActive;
  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: AnimatedContainer(
        width: 20,
        height: 20,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: widget.isActive
                ? theme.primaryColor
                : theme.hoverColor.withOpacity(0.34),
            width: 2,
          ),
          color: widget.isActive ? theme.primaryColor : Colors.transparent,
        ),
        child: widget.isActive
            ? SvgPicture.asset(
                'assets/icons/check_mark.svg',
                width: 12,
              )
            : const SizedBox(),
      ),
    );
  }
}

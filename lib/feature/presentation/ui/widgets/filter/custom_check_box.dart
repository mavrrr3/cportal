import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final Function()? onTap;
  final bool isActive;

  const CustomCheckBox({
    Key? key,
    this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

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
                ? theme.primary!
                : theme.text!.withOpacity(0.34),
            width: 2,
          ),
          color: widget.isActive ? theme.primary! : Colors.transparent,
        ),
        child: widget.isActive
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Image.asset(
                  ImageAssets.checkmark,
                  width: 12,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

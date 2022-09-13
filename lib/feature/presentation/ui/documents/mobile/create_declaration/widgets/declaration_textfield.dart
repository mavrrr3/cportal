import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class DeclarationTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String title;
  const DeclarationTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: theme.text!.withOpacity(0.08),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  child: Text(title),
                  style: theme.textTheme.px12.copyWith(
                    color: focusNode.hasFocus ? theme.primary : theme.textLight,
                  ),
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeInOut,
                ),
                SizedBox(
                  height: 24,
                  child: TextFormField(
                    autocorrect: false,
                    focusNode: focusNode,
                    controller: controller,
                    style: theme.textTheme.px16.copyWith(
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    cursorColor: theme.primary,
                    cursorWidth: 2,
                    cursorHeight: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: MediaQuery.of(context).size.width,
          height: focusNode.hasFocus ? 2 : 0,
          color: theme.primary,
        ),
      ],
    );
  }
}

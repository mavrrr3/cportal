import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class DeclarationTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  const DeclarationTextField({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);

  @override
  State<DeclarationTextField> createState() => _DeclarationTextFieldState();
}

class _DeclarationTextFieldState extends State<DeclarationTextField> {
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

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
          child: SizedBox(
            height: 48,
            child: TextFormField(
              autocorrect: false,
              focusNode: focusNode,
              controller: widget.controller,
              style: theme.textTheme.px16.copyWith(
                leadingDistribution: TextLeadingDistribution.even,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(16, 5, 16, 3),
                label: AnimatedDefaultTextStyle(
                  child: Text(widget.title),
                  style: theme.textTheme.px16.copyWith(
                    color: focusNode.hasFocus ? theme.primary : theme.textLight,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeInOut,
                ),
              ),
              cursorColor: theme.primary,
              cursorWidth: 2,
              cursorHeight: 17,
              maxLines: 1,
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

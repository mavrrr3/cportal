import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class DeclarationTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final MaskType maskType;
  const DeclarationTextField({
    Key? key,
    required this.controller,
    required this.title,
    this.maskType = MaskType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: theme.textLight,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        child: TextField(
          controller: controller,
        ),
      ),
    );
  }
}

enum MaskType { text, date, phone, passportData }

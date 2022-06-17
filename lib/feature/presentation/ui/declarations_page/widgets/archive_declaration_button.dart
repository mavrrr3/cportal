import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';

class ArchiveDeclarationButton extends StatelessWidget {
  final CustomTheme theme;

  const ArchiveDeclarationButton({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 2, color: theme.primary!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              'Архив заявлений',
              style: theme.textTheme.px16.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

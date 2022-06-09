import 'package:flutter/material.dart';

class ArchiveDeclarationButton extends StatelessWidget {
  final ThemeData theme;

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
          border: Border.all(width: 2, color: theme.primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              'Архив заявлений',
              style: theme.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

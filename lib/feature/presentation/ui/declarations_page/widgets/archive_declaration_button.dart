import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ArchiveDeclarationButton extends StatelessWidget {
  final CustomTheme theme;
  final Function() onTap;
  final double? width;

  const ArchiveDeclarationButton({
    Key? key,
    required this.theme,
    required this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnHover(
      builder: (isHovered) {
        return Opacity(
          opacity: isHovered ? 0.8 : 1,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: width ?? double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 2,
                  color: theme.primary!,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.declarationsArchive,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.focusNode,
    required this.animationDuration,
    this.isAnimation = false,
  }) : super(key: key);
  final Function(String) onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Duration animationDuration;
  final bool isAnimation;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnimatedContainer(
      duration:
          isAnimation ? animationDuration : const Duration(milliseconds: 100),
      width: _getContainerWidth(context),
      height: 40,
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        color: theme.splashColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgIcon(
              theme.brightness == Brightness.dark ? theme.hoverColor : null,
              path: 'search.svg',
              width: 20,
            ),
          ),
          SizedBox(
            width:
                ResponsiveWrapper.of(context).isLargerThan(TABLET) ? 510 : 200,
            child: TextField(
              showCursor: true,
              controller: controller,
              focusNode: focusNode,
              textInputAction: TextInputAction.search,
              onChanged: (text) {
                onChanged(text);
              },
              style: theme.textTheme.headline6!.copyWith(
                color: theme.hoverColor.withOpacity(0.68),
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 8),
                hintText: AppLocalizations.of(context)!.enterRequest,
                hintStyle: theme.textTheme.headline6!.copyWith(
                  color: theme.hoverColor.withOpacity(0.68),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getContainerWidth(
    BuildContext context,
  ) {
    final double width = MediaQuery.of(context).size.width;

    // ignore: prefer-conditional-expressions
    if (!ResponsiveWrapper.of(context).isLargerThan(TABLET)) {
      return isAnimation ? width - 32 : width - 84;
    } else {
      return 584;
    }
  }
}

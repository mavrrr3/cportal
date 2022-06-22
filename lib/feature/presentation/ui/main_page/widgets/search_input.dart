import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SearchInput extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Duration animationDuration;
  final bool isAnimation;

  const SearchInput({
    Key? key,
    required this.controller,
    this.onChanged,
    this.focusNode,
    this.animationDuration = const Duration(milliseconds: 300),
    this.isAnimation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: getSearchContainerWidth(context),
      height: 40,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SvgIcon(
              theme.brightness == Brightness.dark ? theme.white : null,
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
              onChanged: onChanged,
              style: theme.textTheme.px14.copyWith(
                color: theme.textLight,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 8),
                hintText: AppLocalizations.of(context)!.enterRequest,
                hintStyle: theme.textTheme.px14.copyWith(
                  color: theme.textLight,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

double getSearchContainerWidth(
  BuildContext context,
) {
  final double width = MediaQuery.of(context).size.width;

  return ResponsiveWrapper.of(context).isSmallerThan(TABLET) ? width - 84 : 584;
}

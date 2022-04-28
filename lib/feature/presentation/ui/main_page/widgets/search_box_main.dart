import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBoxMain extends StatelessWidget {
  const SearchBoxMain({
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

    final double width = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration:
          isAnimation ? animationDuration : const Duration(milliseconds: 100),
      // width: 276.w,
      width: isAnimation ? width - 32.w : 276.w,
      height: 40.h,
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        color: theme.splashColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgIcon(
              theme.brightness == Brightness.dark ? theme.hoverColor : null,
              path: 'search.svg',
              width: 20.w,
            ),
          ),
          SizedBox(
            width: 200.w,
            child: TextField(
              showCursor: true,
              controller: controller,
              focusNode: focusNode,
              textInputAction: TextInputAction.search,
              onChanged: (text) {
                onChanged(text);
              },
              decoration: InputDecoration(
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
}

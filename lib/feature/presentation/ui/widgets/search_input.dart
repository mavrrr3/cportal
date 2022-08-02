import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:cportal_flutter/common/util/is_larger_then.dart';

class SearchInput extends StatefulWidget {
  final Function(String)? onChanged;
  final Function onTap;
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
    required this.onTap,
  }) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return OnHover(
      builder: (isHovered) {
        return Container(
          width: getSearchContainerWidth(context),
          height: 40,
          decoration: BoxDecoration(
            color:
                isHovered ? theme.cardColor?.withOpacity(0.6) : theme.cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  ImageAssets.search,
                  color:
                      theme.brightness == Brightness.dark ? theme.white : null,
                  width: 20,
                ),
              ),
              SizedBox(
                width: ResponsiveWrapper.of(context).isLargerThan(TABLET)
                    ? 510
                    : 200,
                child: TextField(
                  showCursor: true,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  textInputAction: TextInputAction.search,
                  autocorrect: false,
                  onChanged: widget.onChanged,
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
              const Expanded(child: SizedBox()),
              if (widget.controller.text.isNotEmpty)
                GestureDetector(
                  onTap: () => widget.onTap(),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.close,
                      color: theme.brightness == Brightness.dark
                          ? theme.white
                          : theme.text?.withOpacity(0.65),
                    ),
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}

double getSearchContainerWidth(
  BuildContext context,
) {
  final double width = MediaQuery.of(context).size.width;

  return !isLargerThenTablet(context)
      ? kIsWeb
          ? width - 136
          : width - 84
      : 584;
}

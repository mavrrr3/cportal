// ignore_for_file: unnecessary_lambdas

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';

class SearchInput extends StatefulWidget {
  final Function(String) onChanged;
  final Function onTap;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const SearchInput({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onTap,
    this.focusNode,
  }) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

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
                width: widget.controller.text.isNotEmpty
                    ? getSearchContainerWidth(context) - 76
                    : getSearchContainerWidth(context) - 40,
                child: TextField(
                  showCursor: true,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  textInputAction: TextInputAction.search,
                  autocorrect: false,
                  onChanged: (text) {
                    setState(() {});
                    widget.onChanged(text);
                  },
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
              const Spacer(),
              if (widget.controller.text.isNotEmpty)
                GestureDetector(
                  onTap: () => widget.onTap(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    child: Icon(
                      Icons.close,
                      color: theme.brightness == Brightness.dark
                          ? theme.white
                          : theme.text?.withOpacity(0.65),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

double getSearchContainerWidth(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  //
  // double searchWidth = 0;

  if (isMobile(context) || width < 514) {
    return width - 84;
  }
  if (width < 834) {
    return width - 184;
  }

  // if (width < 1000) {
  //   searchWidth = width - 240;
  // } else if (isMobile(context)) {
  //   width - 84;
  // } else {
  //   searchWidth = 584;
  // }

  return 584;
}

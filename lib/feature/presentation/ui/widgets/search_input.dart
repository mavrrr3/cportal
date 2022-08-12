// ignore_for_file: unnecessary_lambdas

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function onClear;

  const SearchInput({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.focusNode,
  }) : super(key: key);

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
                width: isLargerThenTablet(context) ? 510 : 200,
                child: TextField(
                  showCursor: true,
                  controller: controller,
                  focusNode: focusNode,
                  textInputAction: TextInputAction.search,
                  autocorrect: false,
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
              const Spacer(),
              if (focusNode.hasFocus)
                GestureDetector(
                  onTap: () => onClear(),
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

double getSearchContainerWidth(
  BuildContext context,
) {
  final double width = MediaQuery.of(context).size.width;

  return isLargerThenTablet(context)
      ? 584
      : kIsWeb
          ? width - 136
          : width - 84;
}

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DeclarationsTabBar extends StatelessWidget {
  final TabController tabController;
  const DeclarationsTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TabBar(
              overlayColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
              labelStyle: theme.textTheme.px22.copyWith(
                fontWeight: FontWeight.w700,
              ),
              labelColor: theme.primary,
              unselectedLabelColor: theme.cardColor,
              indicatorColor: theme.primary,
              controller: tabController,
              tabs: [
                Tab(
                  child: Text(
                    AppLocalizations.of(context)!.declarations,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    AppLocalizations.of(context)!.newDeclarations,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          color: theme.divider,
        ),
      ],
    );
  }
}

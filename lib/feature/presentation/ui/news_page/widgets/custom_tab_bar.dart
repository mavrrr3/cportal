import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/rounded_tab_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<Tab> _tabs;
  final TabController _tabController;

  const CustomTabBar({
    Key? key,
    required List<Tab> tabs,
    required TabController tabController,
  })  : _tabController = tabController,
        _tabs = tabs,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final roundedIndicator = RoundedTabIndicator(color: theme.primary!);
    final labelStyle =
        theme.textTheme.px16.copyWith(fontWeight: FontWeight.w700);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kIsWeb ? 24 : 8),
            child: TabBar(
              labelPadding: const EdgeInsets.only(right: 8, left: 8),
              isScrollable: true,
              indicatorWeight: 2.5,
              indicatorColor: theme.primary,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: roundedIndicator,
              controller: _tabController,
              labelStyle: labelStyle,
              unselectedLabelStyle: labelStyle,
              unselectedLabelColor: theme.text,
              labelColor: theme.primary,
              overlayColor: kIsWeb
                  ? MaterialStateProperty.all(Colors.transparent)
                  : MaterialStateProperty.all(theme.black!.withOpacity(0.04)),
              tabs: _tabs,
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

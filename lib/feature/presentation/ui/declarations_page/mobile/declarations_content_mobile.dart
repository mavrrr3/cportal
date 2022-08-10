import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/tabs/my_declarations_tab.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/tabs/tasks_tab.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declarations_tab_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:flutter/material.dart';

class DeclarationsContentMobile extends StatefulWidget {
  final TextEditingController searchController;
  final TabController tabController;
  final Function() onFilterTap;

  const DeclarationsContentMobile({
    Key? key,
    required this.searchController,
    required this.tabController,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  State<DeclarationsContentMobile> createState() =>
      _DeclarationsContentMobileState();
}

class _DeclarationsContentMobileState extends State<DeclarationsContentMobile> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return SafeArea(
      child: NestedScrollView(
        floatHeaderSlivers: true,
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                backgroundColor: theme.background,
                collapsedHeight: 108,
                expandedHeight: 108,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      const SizedBox(height: 11),
                      Padding(
                        padding: getHorizontalPadding(context),
                        child: SearchWithFilter(
                          searchController: widget.searchController,
                          onSearch: (text) {},
                          onFilterTap: widget.onFilterTap,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Заголовки вкладок.
                      DeclarationsTabBar(tabController: widget.tabController),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: widget.tabController,
          children: [
            MyDeclarationsTab(scrollController: _scrollController),
            TasksTab(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}

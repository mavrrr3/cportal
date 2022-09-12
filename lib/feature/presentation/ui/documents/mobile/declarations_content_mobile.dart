import 'dart:developer';

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_event.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/tabs/my_declarations_tab.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/tabs/tasks_tab.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/declarations_tab_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeclarationsContentMobile extends StatefulWidget {
  final TextEditingController searchController;
  final FocusNode searchFocus;

  final TabController tabController;
  final Function() onFilterTap;

  const DeclarationsContentMobile({
    Key? key,
    required this.searchController,
    required this.searchFocus,
    required this.tabController,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  State<DeclarationsContentMobile> createState() => _DeclarationsContentMobileState();
}

class _DeclarationsContentMobileState extends State<DeclarationsContentMobile> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _setupScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return SafeArea(
      child: NestedScrollView(
        floatHeaderSlivers: true,
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                backgroundColor: theme.background,
                collapsedHeight: 108.5,
                expandedHeight: 108.5,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 11),
                      Padding(
                        padding: getHorizontalPadding(context),
                        child: SearchWithFilter(
                          searchController: widget.searchController,
                          currentMenuIndex: 3,
                          onSearch: (text) {},
                          onSearchClear: () {},
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
          children: const [
            MyDeclarationsTab(),
            TasksTab(),
          ],
        ),
      ),
    );
  }

  // Пагинация.
  void _setupScrollController() {
    _scrollController.addListener(() {
      if (widget.searchController.text.isEmpty) {
        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels != 0) {
            if (widget.tabController.index == 0) {
              context.read<DeclarationsBloc>().add(const FetchDeclarationsEvent());
            } else {
              log('request Tasks');
            }
          }
        }
      }
    });
  }
}

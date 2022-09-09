import 'dart:developer';

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/all_news_list/scrollable_news_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/custom_tab_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/loader.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/burger_menu_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';

class NewsPageWebTablet extends StatefulWidget {
  final List<String> categories;
  const NewsPageWebTablet({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  State<NewsPageWebTablet> createState() => _NewsPageWebTabletState();
}

class _NewsPageWebTabletState extends State<NewsPageWebTablet> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: widget.categories.length,
      vsync: this,
    );
    log(widget.categories.toString());
    tabController.addListener(_fetchNewsByTabs);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _fetchNewsByTabs() {
    final fetchNewsBloc = context.read<FetchNewsBloc>();

    if (tabController.index == 0) {
      fetchNewsBloc.add(const FetchAllNewsEvent());
    } else {
      fetchNewsBloc.add(FetchNewsEventBy(widget.categories[tabController.index]));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final double width = MediaQuery.of(context).size.width;
    final customPadding = ResponsiveUtil(context);

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        List<ArticleEntity> articles = [];

        if (state is NewsLoading) {
          articles = state.oldArticles;
        } else if (state is NewsLoaded) {
          articles = state.articles;
        }

        return SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: width < 514
                        ? const EdgeInsets.only(left: 16)
                        : zeroWidthCondition(context)
                            ? const EdgeInsets.only(left: 40)
                            : customPadding.webTabletPadding(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (zeroWidthCondition(context) && width > 514)
                          BurgerMenuButton(onTap: () {
                            context.read<NavigationBarBloc>().add(
                                  const NavBarVisibilityEvent(index: 1, isActive: true),
                                );
                          }),
                        Text(
                          AppLocalizations.of(context)!.news,
                          style: theme.textTheme.header,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: widget.categories.length == 1
                        ? const Center(child: PlatformProgressIndicator())
                        : Padding(
                            padding: customPadding.webTabletPadding(),
                            child: SizedBox(
                              width: customPadding.widthContent(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTabBar(
                                    tabs: getTabs(),
                                    tabController: tabController,
                                  ),
                                  ScrollableNewsList(
                                    articles: articles,
                                    tabController: tabController,
                                    categories: widget.categories,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              if (state is NewsLoading && !kIsWeb) const Loader(),
            ],
          ),
        );
      },
    );
  }

  List<Tab> getTabs() {
    return widget.categories.map((tabTitle) => Tab(text: tabTitle)).toList();
  }
}

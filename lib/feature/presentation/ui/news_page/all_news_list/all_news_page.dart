import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/all_news_list/scrollable_news_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/custom_tab_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/loader.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/burger_menu_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';

class AllNewsPage extends StatefulWidget {
  final List<String> _categories;
  const AllNewsPage({
    Key? key,
    required List<String> categories,
  })  : _categories = categories,
        super(key: key);

  @override
  State<AllNewsPage> createState() => _AllNewsPageState();
}

class _AllNewsPageState extends State<AllNewsPage>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final TabController _tabController;

  @override
  void initState() {
    _pageController = PageController();
    _tabController = TabController(
      length: widget._categories.length,
      vsync: this,
    );

    _tabController.addListener(() {
      _fetchNewsByTabs(context, widget._categories);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _fetchNewsByTabs(
    BuildContext context,
    List<String> categories,
  ) {
    final fetchNewsBloc = context.read<FetchNewsBloc>();

    if (_tabController.index == 0) {
      fetchNewsBloc.add(const FetchAllNewsEvent());
    } else {
      fetchNewsBloc.add(FetchNewsEventBy(categories[_tabController.index]));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: getHorizontalPadding(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BurgerMenuButton(onTap: () {
                          context.read<NavigationBarBloc>().add(
                                const NavBarVisibilityEvent(isActive: true),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTabBar(
                          tabs: getTabs(widget._categories),
                          tabController: _tabController,
                        ),
                        ScrollableNewsList(
                          articles: articles,
                          tabController: _tabController,
                          categories: widget._categories,
                        ),
                      ],
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

  List<Tab> getTabs(List<String> tabs) {
    return tabs.map((tabTitle) => Tab(text: tabTitle)).toList();
  }
}

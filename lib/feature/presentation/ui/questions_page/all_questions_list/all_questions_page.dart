import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/custom_padding.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/custom_tab_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/all_questions_list/scrollable_questions_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/loader.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/burger_menu_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/size_padding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllQuestionsPage extends StatefulWidget {
  final List<String> categories;
  const AllQuestionsPage({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  State<AllQuestionsPage> createState() => _AllQuestionsPageState();
}

class _AllQuestionsPageState extends State<AllQuestionsPage> with TickerProviderStateMixin {
  late PageController _pageController;
  late final TabController _tabController;

  @override
  void initState() {
    _pageController = PageController();
    _tabController = TabController(
      length: widget.categories.length,
      vsync: this,
    );

    _tabController.addListener(() {
      _fetchQuestionsByTabs(widget.categories);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController
      ..removeListener(() {
        _fetchQuestionsByTabs(widget.categories);
      })
      ..dispose();

    super.dispose();
  }

  void _fetchQuestionsByTabs(
    List<String> categories,
  ) {
    final fetchQuestionsBloc = context.read<FetchQuestionsBloc>();

    if (_tabController.index == 0) {
      fetchQuestionsBloc.add(const FetchQaustionsEvent());
    } else {
      fetchQuestionsBloc.add(FetchQaustionsEventBy(categories[_tabController.index]));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<FetchQuestionsBloc, FetchQuestionsState>(
      builder: (context, state) {
        List<ArticleEntity> questions = [];

        if (state is QuestionsLoading) {
          questions = state.oldArticles;
        } else if (state is QuestionsLoaded) {
          questions = state.articles;
        }

        return SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizePadding.height12px,
                  Padding(
                    padding: getHorizontalPadding(context),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!isMobile(context) && !isDesktop(context)) ...[
                          BurgerMenuButton(onTap: () {
                            context.read<NavigationBarBloc>().add(
                                  const NavBarVisibilityEvent(isActive: true),
                                );
                          }),
                        ],
                        Text(
                          AppLocalizations.of(context)!.questions,
                          style: theme.textTheme.header,
                        ),
                      ],
                    ),
                  ),
                  CustomTabBar(
                    tabs: getTabs(),
                    tabController: _tabController,
                  ),
                  ScrollableQuestionsList(
                    articles: questions,
                    tabController: _tabController,
                    categories: widget.categories,
                  ),
                ],
              ),
              if (state is QuestionsLoading && !kIsWeb) const Loader(),
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

import 'dart:developer';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/faq_widget.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/horizontal_listview_main.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_horizontal_scroll.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_input.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/today_widget.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/profile_popup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController _searchController;
  late FocusNode _searchFocus;
  late Duration _animationDuration;
  late bool _isSearchActive;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocus = FocusNode();
    _animationDuration = const Duration(milliseconds: 300);
    _isSearchActive = false;
    _searchFocus.addListener(_onFocusChange);

    BlocProvider.of<FetchNewsBloc>(context, listen: false)
        .add(const FetchNewsEventImpl(newsCodeEnum: NewsCodeEnum.news));
  }

  @override
  void dispose() {
    _searchFocus.removeListener(_onFocusChange);
    super.dispose();
  }

  /// Анимация при нажатии на поиск.
  void _onFocusChange() {
    if (_searchFocus.hasFocus) {
      setState(() {
        _isSearchActive = true;
      });
    } else {
      setState(() {
        _isSearchActive = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                    ? 16
                    : 13,
              ),
              child: ResponsiveConstraints(
                constraint: kIsWeb ? const BoxConstraints(maxWidth: 704) : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: getHorizontalPadding(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SearchInput(
                            controller: _searchController,
                            focusNode: _searchFocus,
                            onChanged: (text) {
                              log('[Search text] $text');
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              ResponsiveWrapper.of(context).isLargerThan(TABLET)
                                  ? showProfile(context)
                                  : context.pushNamed(
                                      NavigationRouteNames.profile,
                                    );
                            },
                            child: const AvatarBox(
                              size: 40,
                              imgPath: '2.jpg',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            HorizontalListViewMain(
                              color: _isSearchActive
                                  ? theme.brightness == Brightness.light
                                      ? theme.splashColor.withOpacity(0.3)
                                      : theme.splashColor
                                  : theme.splashColor,
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: getHorizontalPadding(context),
                              child: TodayWidget(
                                onTap: (i) {},
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: getHorizontalPadding(context),
                              child: Text(
                                AppLocalizations.of(context)!.news,
                                style: theme.textTheme.headline3,
                              ),
                            ),
                            BlocBuilder<FetchNewsBloc, FetchNewsState>(
                              builder: (context, state) {
                                if (state is FetchNewsLoadingState) {
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (state is FetchNewsLoadedState) {
                                  return !kIsWeb
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                            left: getSingleHorizontalPadding(
                                              context,
                                            ),
                                          ),
                                          child: NewsHorizontalScroll(
                                            onTap: (i) => _onArticleSelected(
                                              state
                                                  .news.response.articles[i].id,
                                            ),
                                            items: state.news.response.articles,
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              getHorizontalPadding(context),
                                          child: Wrap(
                                            spacing: 16,
                                            runSpacing: 20,
                                            children: List.generate(
                                              state.news.response.articles
                                                  .length,
                                              (i) => NewsCardItem(
                                                onTap: () => _onArticleSelected(
                                                  state.news.response
                                                      .articles[i].id,
                                                ),
                                                width: 312,
                                                height: 152,
                                                item: state
                                                    .news.response.articles[i],
                                              ),
                                            ),
                                          ),
                                        );
                                }

                                return const SizedBox();
                              },
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: getHorizontalPadding(context),
                              child: const FaqWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ResponsiveConstraints(
            constraint: ResponsiveWrapper.of(context).isLargerThan(TABLET)
                ? const BoxConstraints(maxWidth: 640)
                : null,
            child: SearchBox(
              isAnimation: _isSearchActive,
              animationDuration: _animationDuration,
            ),
          ),
        ],
      ),
    );
  }

  void _onArticleSelected(String id) {
    GoRouter.of(context).pushNamed(
      NavigationRouteNames.newsArticlePage,
      params: {'fid': id},
    );
  }
}

Future<void> showProfile(BuildContext context) {
  return showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true,
    builder: (context) {
      final ThemeData theme = Theme.of(context);

      // final double width = MediaQuery.of(context).size.width;
      // var horizontalPading = width * 0.28;
      // log(horizontalPading.toString());

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 100,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: theme.splashColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 32,
                  right: 32,
                  bottom: 32,
                  top: 32,
                ),
                child: ProfilePopUp(),
              ),
            ),
          );
        },
      );
    },
  );
}

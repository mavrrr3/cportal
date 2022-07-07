import 'dart:developer';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/common/util/random_color_service.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_image.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_main_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/question_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/horizontal_listview_main.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/news_main_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_input.dart';
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
  late ScrollController _questionController;
  late FocusNode _searchFocus;
  late Duration _animationDuration;
  late bool _isSearchActive;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _questionController = ScrollController();
    _searchFocus = FocusNode();
    _animationDuration = const Duration(milliseconds: 300);
    _isSearchActive = false;
    _searchFocus.addListener(_onFocusChange);

    BlocProvider.of<FetchNewsBloc>(context, listen: false).add(
      const FetchAllNewsEvent(),
    );
    BlocProvider.of<FetchQuestionsBloc>(context, listen: false)
        .add(const FetchQaustionsEvent());
  }

  @override
  void dispose() {
    _searchFocus.removeListener(_onFocusChange);
    _searchController.dispose();
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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    List<ArticleEntity> articles;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: isLargerThenMobile(context) ? 10 : 13,
              ),
              child: ResponsiveConstraints(
                constraint:
                    kIsWeb ? const BoxConstraints(maxWidth: 1046) : null,
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
                              isLargerThenTablet(context)
                                  ? showProfile(context)
                                  : context.pushNamed(
                                      NavigationRouteNames.profile,
                                    );
                            },
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is Authenticated) {
                                  final user = state.user;

                                  return ProfileImage(
                                    fullName: user.name,
                                    imgLink: user.photoUrl,
                                    color: RandomColorService.color,
                                    size: 40,
                                    borderRadius: 12,
                                  );
                                }

                                return const PlatformProgressIndicator();
                              },
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
                                      ? theme.cardColor!.withOpacity(0.3)
                                      : theme.cardColor!
                                  : theme.cardColor!,
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
                                style: theme.textTheme.px22,
                              ),
                            ),
                            BlocBuilder<FetchNewsBloc, FetchNewsState>(
                              builder: (context, state) {
                                if (state is NewsLoading) {
                                  const Center(
                                    child: PlatformProgressIndicator(),
                                  );
                                }

                                if (state is NewsLoaded) {
                                  final articles = state.articles;

                                  return kIsWeb
                                      ? NewsMainWeb(articles: articles)
                                      : NewsMainMobile(articles: articles);
                                }

                                return const SizedBox();
                              },
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: getHorizontalPadding(context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.faq,
                                    style: theme.textTheme.px22,
                                  ),
                                  const SizedBox(height: 16),
                                  BlocBuilder<FetchQuestionsBloc,
                                      FetchQuestionsState>(
                                    builder: (context, state) {
                                      if (state is QuestionsLoading &&
                                          state.isFirstFetch) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 60,
                                          ),
                                          child: Center(
                                            child: PlatformProgressIndicator(),
                                          ),
                                        );
                                      } else if (state is QuestionsLoading) {
                                        articles = state.oldArticles;
                                        log(articles.toString());
                                      } else if (state is QuestionsLoaded) {
                                        final articles = state.articles;

                                        return ListView.builder(
                                          controller: _questionController,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: AppConfig
                                              .numberNewsArticlesOnMain,
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 24,
                                              ),
                                              child: QuestionRow(
                                                text: articles[i].header,
                                                onTap: () {
                                                  GoRouter.of(context)
                                                      .pushNamed(
                                                    NavigationRouteNames
                                                        .questionArticlePage,
                                                    params: {
                                                      'fid': articles[i].id,
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      }

                                      return const SizedBox();
                                    },
                                  ),
                                ],
                              ),
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
            constraint: isLargerThenTablet(context)
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
}

Future<void> showProfile(BuildContext context) {
  return showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true,
    builder: (context) {
      final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
      final double width = MediaQuery.of(context).size.width;
      final double horizontalPadding =
          isLargerThenMobile(context) ? width * 0.25 : width * 0.15;

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: horizontalPadding,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
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

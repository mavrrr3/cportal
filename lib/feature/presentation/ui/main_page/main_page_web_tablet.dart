// ignore_for_file: avoid_types_on_closure_parameters, prefer_int_literals

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:cportal_flutter/common/util/delayer.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/new_employee_bloc/fetch_new_employee_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_event.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_image.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/horizontal_listview_main.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_main_web_tablet.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/questions_main.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/today_widget.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/profile_popup.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/loader.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/burger_menu_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_input.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/web_copy_right.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPageWebTablet extends StatefulWidget {
  const MainPageWebTablet({
    Key? key,
  }) : super(key: key);
  @override
  State<MainPageWebTablet> createState() => _MainPageWebTabletState();
}

class _MainPageWebTabletState extends State<MainPageWebTablet> {
  late CustomTheme theme;
  late TextEditingController _searchController;
  late ScrollController _questionController;
  late FocusNode _searchFocus;
  late Duration _animationDuration;
  late bool _isSearchActive;
  final _delayer = Delayer(milliseconds: 500);

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _questionController = ScrollController();
    _searchFocus = FocusNode();
    _animationDuration = const Duration(milliseconds: 300);
    _isSearchActive = false;
    _searchFocus.addListener(_onFocusChange);

    _fetchContent(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context).extension<CustomTheme>()!;
  }

  @override
  void dispose() {
    _searchFocus
      ..removeListener(_onFocusChange)
      ..dispose();
    _searchController.dispose();
    _questionController.dispose();
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

  void _fetchContent(BuildContext context) {
    context
      ..read<FetchNewsBloc>().add(const FetchAllNewsEvent())
      ..read<FetchQuestionsBloc>().add(const FetchQuestionsEvent())
      ..read<ContactsBloc>().add(const FetchContactsEvent(isFirstFetch: true))
      ..read<FilterContactsBloc>().add(FetchFiltersEvent())
       ..read<DeclarationsBloc>()
          .add(const FetchDeclarationsEvent(isFirstFetch: true))
      ..read<TasksBloc>().add(const FetchTasksEvent(isFirstFetch: true))
      ..read<FetchNewEmployeeBloc>().add(const FetchNewEmployeeEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((FetchNewsBloc bloc) => bloc.state is NewsLoading) ||
            context.select(
              (FetchQuestionsBloc bloc) => bloc.state is QuestionsLoading,
            );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                _appBar(),
                _mainPageBody(),
              ],
            ),
            if (isLoading && !kIsWeb) ...[
              const Loader(),
            ],
          ],
        ),
      ),
    );
  }

  SliverAppBar _appBar() {
    final double width = MediaQuery.of(context).size.width;
    final customPadding = ResponsiveUtil(context);

    return SliverAppBar(
      toolbarHeight: 60,
      floating: true,
      elevation: 0,
      backgroundColor: theme.background,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: width < 514
                        ? const EdgeInsets.only(left: 16)
                        : zeroWidthCondition(context)
                            ? const EdgeInsets.only(left: 40)
                            : EdgeInsets.only(
                                left: customPadding
                                        .webTabletPaddingWithRightBloc()
                                        .horizontal /
                                    2,
                              ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (zeroWidthCondition(context) && width > 514) ...[
                          BurgerMenuButton(onTap: () {
                            context.read<NavigationBarBloc>().add(
                                  const NavBarVisibilityEvent(
                                    index: 0,
                                    isActive: true,
                                  ),
                                );
                          }),
                        ],
                        SizedBox(
                          width: customPadding.searchLineWidth(),
                          child: Row(
                            children: [
                              SearchInput(
                                controller: _searchController,
                                focusNode: _searchFocus,
                                onChanged: (query) {
                                  _delayer.run(
                                    () => _onSearchInput(query),
                                  );

                                  if (_searchController.text.isEmpty) {
                                    setState(() {
                                      _isSearchActive = false;
                                    });
                                  } else {
                                    setState(() {
                                      _isSearchActive = true;
                                    });
                                  }
                                },
                                onTap: () => setState(() {
                                  _searchController.clear();
                                  _isSearchActive = false;
                                }),
                              ),
                              if (width > 1010) const Spacer(),
                              if (width <= 1010) const SizedBox(width: 16),
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
                                    if (state is! Authenticated) {
                                      return const PlatformProgressIndicator();
                                    } else {
                                      final user = state.user;

                                      return OnHover(
                                        builder: (isHovered) {
                                          return ProfileImage(
                                            fullName: user.name,
                                            imgLink: user.photoUrl,
                                            color: ColorService.randomColor,
                                            size: isHovered ? 48 : 40,
                                            borderRadius: 12,
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _mainPageBody() {
    final customPadding = ResponsiveUtil(context);

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: customPadding.webTabletPaddingWithRightBloc(),
                      child: SizedBox(
                        width: customPadding.widthContentWithRightBloc(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            HorizontalListViewMain(
                              color: theme.cardColor!,
                            ),

                            if (zeroWidthCondition(context)) ...[
                              TodayWidget(
                                onTap: (i) {},
                              ),
                            ],
                            const SizedBox(height: 24),
                            Text(
                              AppLocalizations.of(context)!.news,
                              style: theme.textTheme.px22,
                            ),
                            const SizedBox(height: 12),
                            BlocBuilder<FetchNewsBloc, FetchNewsState>(
                              builder: (context, state) {
                                if (state is NewsLoaded) {
                                  final articles = state.articles;

                                  return NewsMainWebTablet(articles: articles);
                                }

                                return const SizedBox();
                              },
                            ),
                            const SizedBox(height: 24),
                            QuestionsMain(
                              questionController: _questionController,
                            ),
                            // Padding to bottom navigation bar.
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    if (!zeroWidthCondition(context)) ...[
                      Padding(
                        padding: const EdgeInsets.only(right: 32),
                        child: TodayWidget(
                          onTap: (i) {},
                        ),
                      ),
                    ],
                  ],
                ),
                const WebCopyRight(),
              ],
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

  Future<void> showProfile(BuildContext context) {
    return showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      builder: (context) {
        final theme = Theme.of(context).extension<CustomTheme>()!;
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

  void _onSearchInput(String query) {
    context.read<MainSearchBloc>().add(MainSearch(query));
  }
}

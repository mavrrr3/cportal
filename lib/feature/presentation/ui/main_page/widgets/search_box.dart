import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_box/search_box_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchBox extends StatefulWidget {
  final bool isAnimation;
  final Duration animationDuration;

  const SearchBox({
    Key? key,
    required this.isAnimation,
    required this.animationDuration,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<MainSearchBloc, MainSearchState>(
      builder: (context, state) {
        List<MainSearchEntity> searchList = [];

        if (state is MainSearchLoaded) searchList = state.searchList;

        double getHeightSearchBox() {
          double height = 0;
          if (searchList.isNotEmpty) {
            height = (searchList.length * 54) + 16;
          }

          return height;
        }

        return SafeArea(
          child: Padding(
            padding: isLargerThenTablet(context)
                ? const EdgeInsets.only(left: 32)
                : getHorizontalPadding(context),
            child: AnimatedOpacity(
              duration: widget.animationDuration,
              opacity: widget.isAnimation ? 1 : 0,
              curve: Curves.easeIn,
              child: Padding(
                padding: EdgeInsets.only(
                  top: isLargerThenTablet(context) ? 60 : 56,
                ),
                child: AnimatedContainer(
                  duration: widget.animationDuration,
                  curve: Curves.easeIn,
                  width: isLargerThenTablet(context)
                      ? 584
                      : MediaQuery.of(context).size.width,
                  height: widget.isAnimation ? getHeightSearchBox() : 0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: theme.cardColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          BlocBuilder<MainSearchBloc, MainSearchState>(
                            builder: (context, state) {
                              return state is! MainSearchLoaded
                                  ? const PlatformProgressIndicator()
                                  : SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: searchList.length,
                                            itemBuilder: (context, index) {
                                              return _SearchBoxItem(
                                                () => goToPage(
                                                  searchList[index].category,
                                                  searchList[index].id,
                                                  context,
                                                ),
                                                category:
                                                    searchList[index].category,
                                                text: searchList[index].title,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void goToPage(String category, String id, BuildContext context) {
  switch (category) {
    case 'Новости':
      BlocProvider.of<GetSingleNewsBloc>(context, listen: false)
          .add(GetSingleNewsEventImpl(id));
      return context.pushNamed(
        NavigationRouteNames.newsArticlePage,
        params: {'fid': id},
      );
    case 'Вопросы':
      BlocProvider.of<GetSingleQuestionBloc>(context, listen: false)
          .add(GetSingleQuestionEventImpl(id));
      return context.pushNamed(
        NavigationRouteNames.questionArticlePage,
        params: {'fid': id},
      );
    case 'Контакты':
      return context.pushNamed(
        NavigationRouteNames.contactProfile,
        params: {'fid': id},
      );
    default:
  }
}

class _SearchBoxItem extends StatelessWidget {
  final String category;
  final String text;
  final Function()? onTap;

  const _SearchBoxItem(
    this.onTap, {
    Key? key,
    required this.category,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 8),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: theme.textTheme.px12.copyWith(color: theme.textLight),
            ),
            const SizedBox(height: 4),
            SearchBoxRow(text: text),
          ],
        ),
      ),
    );
  }
}

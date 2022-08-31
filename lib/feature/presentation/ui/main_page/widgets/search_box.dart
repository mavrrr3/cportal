import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/custom_padding.dart';
import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_box_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchBox extends StatelessWidget {
  final bool isAnimation;
  final Duration animationDuration;

  const SearchBox({
    Key? key,
    required this.isAnimation,
    required this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    const scrollPhysics = BouncingScrollPhysics();
    const curves = Curves.easeIn;

    return BlocBuilder<MainSearchBloc, MainSearchState>(
      builder: (context, state) {
        List<MainSearchEntity> searchList = [];

        if (state is MainSearchLoaded) searchList = state.searchList;

        double getHeightSearchBox() {
          double height = 0;
          if (searchList.isNotEmpty) {
            height = (searchList.length * 56) + 16;
          }

          return height;
        }

        return SafeArea(
          child: Padding(
            padding: isLargerThenTablet(context) ? const EdgeInsets.only(left: 32) : getHorizontalPadding(context),
            child: AnimatedOpacity(
              duration: animationDuration,
              opacity: isAnimation ? 1 : 0,
              curve: curves,
              child: Padding(
                padding: EdgeInsets.only(
                  top: isLargerThenTablet(context) ? 2 : 3,
                ),
                child: AnimatedContainer(
                  duration: animationDuration,
                  curve: curves,
                  //
                  //TODO: сделать корректную ширину и расположение выпадающего списка
                  width: isLargerThenTablet(context) ? 584 : MediaQuery.of(context).size.width,
                  height: isAnimation ? getHeightSearchBox() : 0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: theme.cardColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      physics: scrollPhysics,
                      child: Column(
                        children: [
                          BlocBuilder<MainSearchBloc, MainSearchState>(
                            builder: (context, state) {
                              return state is! MainSearchLoaded
                                  ? const PlatformProgressIndicator()
                                  : SingleChildScrollView(
                                      physics: scrollPhysics,
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: searchList.length,
                                            itemBuilder: (context, index) {
                                              return SearchBoxItem(
                                                () => goToPage(
                                                  searchList[index].category,
                                                  searchList[index].id,
                                                  context,
                                                ),
                                                category: searchList[index].category,
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
      context.read<GetSingleNewsBloc>().add(GetSingleNewsEventImpl(id));
      return context.pushNamed(
        NavigationRouteNames.newsArticlePage,
        params: {'fid': id},
      );
    case 'Вопросы':
      context.read<GetSingleQuestionBloc>().add(GetSingleQuestionEventImpl(id));
      return context.pushNamed(
        NavigationRouteNames.question,
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

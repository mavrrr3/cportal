import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_template.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/burger_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/burger_menu_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_service.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/news/news_card_similar_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/size_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleNewsArticleWebTablet extends StatefulWidget {
  final ArticleEntity article;
  final List<ArticleEntity>? articles;

  const SingleNewsArticleWebTablet({
    Key? key,
    required this.article,
    this.articles,
  }) : super(key: key);

  @override
  State<SingleNewsArticleWebTablet> createState() =>
      _SingleNewsArticleWebTabletState();
}

class _SingleNewsArticleWebTabletState
    extends State<SingleNewsArticleWebTablet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    final double width = MediaQuery.of(context).size.width;
    final customPadding = ResponsiveUtil(context);

    return SafeArea(
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!zeroWidthCondition(context)) ...[
                DesktopMenu(
                  currentIndex: 1,
                  onChange: (index) {
                    MenuService.changePage(context, index);
                  },
                ),
              ],
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: width < 514
                          ? const EdgeInsets.only(left: 16, top: 20)
                          : zeroWidthCondition(context)
                              ? const EdgeInsets.only(left: 40, top: 20)
                              : EdgeInsets.only(
                                  left: customPadding
                                          .webTabletPaddingWithRightBloc()
                                          .horizontal /
                                      2,
                                  top: 20,
                                ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              context.pop();
                            },
                            child: Row(
                              children: [
                                if (zeroWidthCondition(context) &&
                                    width > 514) ...[
                                  BurgerMenuButton(onTap: () {
                                    context
                                        .read<NavigationBarBloc>()
                                        .add(const NavBarVisibilityEvent(
                                          index: 1,
                                          isActive: true,
                                        ));
                                  }),
                                ],
                                SvgPicture.asset(
                                  ImageAssets.backArrow,
                                  color: theme.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  AppLocalizations.of(context)!.news,
                                  style: theme.textTheme.px14.copyWith(
                                    color: theme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: customPadding
                                    .webTabletPaddingWithRightBloc()
                                    .horizontal /
                                2,
                            right: customPadding
                                    .webTabletPaddingWithRightBloc()
                                    .horizontal /
                                2,
                          ),
                          child: SizedBox(
                            width: customPadding.widthContentWithRightBloc(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width,
                                  height: 310,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      '${AppConfig.imagesUrl}/${widget.article.image}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizePadding.height24px,
                                Text(
                                  widget.article.header,
                                  style: theme.textTheme.px22,
                                ),
                                SizePadding.height12px,
                                Text(
                                  FormatterUtil.fullDateWithoutSeconds(
                                      date: widget.article.date),
                                  style: theme.textTheme.px12,
                                ),
                                SizePadding.height24px,
                                NewsTemplate.factory(
                                  context,
                                  widget.article.content.first,
                                ),
                                const SizedBox(height: 40),
                                if (widget.articles != null &&
                                    zeroWidthCondition(context))
                                  Wrap(
                                    runSpacing: 16,
                                    spacing: 16,
                                    children: List.generate(
                                      AppConfig.numberRecomendedArticlesWeb,
                                      (i) {
                                        return GestureDetector(
                                          onTap: () =>
                                              GoRouter.of(context).pushNamed(
                                            NavigationRouteNames
                                                .newsArticlePage,
                                            params: {
                                              'fid': articlesToRecomendations(
                                                widget.article.id,
                                              )[i]
                                                  .id,
                                            },
                                          ),
                                          child: NewsCardSimilarItem(
                                            width: 312,
                                            height: 152,
                                            item: articlesToRecomendations(
                                              widget.article.id,
                                            )[i],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                else
                                  const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        if (!zeroWidthCondition(context)) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...List.generate(
                                AppConfig.numberRecomendedArticlesWeb,
                                (i) {
                                  return GestureDetector(
                                    onTap: () => GoRouter.of(context).pushNamed(
                                      NavigationRouteNames.newsArticlePage,
                                      params: {
                                        'fid': articlesToRecomendations(
                                          widget.article.id,
                                        )[i]
                                            .id,
                                      },
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20, right: 32),
                                      child: NewsCardSimilarItem(
                                        width: 312,
                                        height: 152,
                                        item: articlesToRecomendations(
                                          widget.article.id,
                                        )[i],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          BurgerMenu(
            currentIndex: 1,
            onChange: (i) => MenuService.changePage(context, i),
          ),
        ],
      ),
    );
  }

  List<ArticleEntity> articlesToRecomendations(String id) {
    return widget.articles!.where((element) => element.id != id).toList();
  }
}

import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';

class QuestionArticlePage extends StatelessWidget {
  const QuestionArticlePage({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Swipe(
      onSwipeRight: () => _onBack(context),
      child: BlocBuilder<FetchNewsBloc, FetchNewsState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 19.h),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => _onBack(context),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 26.w,
                              height: 24.h,
                            ),
                            SvgPicture.asset(
                              'assets/icons/back_arrow.svg',
                              width: 16.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 19.h),
                      if (state is FetchNewsLoadedState)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.news.article[currentIndex].header,
                              style: kMainTextRoboto.copyWith(fontSize: 32.sp),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              state.news.article[currentIndex].description,
                              style: kMainTextRoboto,
                            ),
                            SizedBox(height: 24.h),
                            if (state.news.article.length - 1 != currentIndex)
                              Column(
                                children: [
                                  QuestionWidget(
                                    text: state
                                        .news.article[currentIndex + 1].header,
                                    onTap: () {
                                      GoRouter.of(context).pop();
                                      GoRouter.of(context).pushNamed(
                                        NavigationRouteNames
                                            .questionArticlePage,
                                        extra: currentIndex + 1,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 32.h),
                                ],
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onBack(BuildContext context) => GoRouter.of(context).pop();
}

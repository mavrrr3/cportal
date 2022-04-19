import 'dart:developer';

import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Во время билда запускается эвент и подгружаются новости
    BlocProvider.of<FetchNewsBloc>(context, listen: false)
        .add(const FetchNewsEventImpl(newsCodeEnum: NewsCodeEnum.news));

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        log(state.toString());

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.w,
              ),
              child: Column(
                children: [
                  SizedBox(height: 37.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.news,
                            style: kMainTextRusso.copyWith(
                              fontSize: 28.sp,
                            ),
                          ),
                          if (state is FetchNewsLoadingState) ...[
                            const CircularProgressIndicator(),
                          ],
                          if (state is FetchNewsLoadedState)
                            // Это просто вывод чтобы понять, что
                            // бизнес логика работает
                            ...state.news.article
                                .map((article) => Text(
                                      article.header,
                                      style: kMainTextRusso.copyWith(
                                        fontSize: 28.sp,
                                      ),
                                    ))
                                .toList(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(height: 27.h),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
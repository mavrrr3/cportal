import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import 'package:swipe/swipe.dart';

class NewsArticlePage extends StatelessWidget {
  const NewsArticlePage({
    Key? key,
    required this.article,
  }) : super(key: key);
  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    final DateFormat outputFormat = DateFormat('d MMMM y, H:m', 'ru');

    return Swipe(
      onSwipeRight: () => _onBack(context),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                expandedHeight: 176.h,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  enableFeedback: false,
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 24.w,
                  onPressed: () => _onBack(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    article.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Колонка с контентом статьи
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0.h,
                    horizontal: 20.0.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.header,
                        style: kMainTextRoboto.copyWith(fontSize: 22.sp),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        outputFormat.format(article.dateShow),
                        style: kMainTextRoboto.copyWith(fontSize: 12.sp),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        article.description,
                        style: kMainTextRoboto.copyWith(fontSize: 14.sp),
                      ),
                      SizedBox(height: 600.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBack(BuildContext context) => GoRouter.of(context).pop();
}

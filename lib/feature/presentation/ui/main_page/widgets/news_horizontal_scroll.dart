import 'dart:developer';

import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NewsHorizontalScroll extends StatelessWidget {
  const NewsHorizontalScroll({
    Key? key,
    this.items,
    this.currentArticle,
    this.isTextVisible = true,
    this.onTap,
  }) : super(key: key);

  final List<ArticleEntity>? items;
  final bool isTextVisible;
  final Function(int)? onTap;
  final ArticleEntity? currentArticle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTextVisible)
          Text(
            AppLocalizations.of(context)!.news,
            style: kMainTextRoboto.copyWith(fontSize: 22.sp),
          ),
        SizedBox(
          height: 200.h,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: items?.length ?? listViewMap.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    if (items != null)

                      ///Условие, чтобы не отрисовывалась новость, которая сейчас открыта
                      if (items![i] != currentArticle)
                        _buildCard(
                          item: items![i],
                          onTap: () {
                            if (onTap != null) {
                              onTap!(i);
                            }
                          },
                        ),
                    if (items == null)
                      NewsCardItem(
                        imgPath: listViewMap[i]['imgPath'] as String,
                        title: listViewMap[i]['title'] as String,
                        dateTime: listViewMap[i]['dateTime'] as String,
                      ),
                    SizedBox(width: 8.w),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required ArticleEntity item,
    Function()? onTap,
  }) {
    final DateFormat outputFormat = DateFormat('d MMMM y, H:m', 'ru');

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: NewsCardItem(
        imgPath: item.image,
        title: item.header,
        dateTime: outputFormat.format(item.dateShow),
      ),
    );
  }
}

final List<Map<String, dynamic>> listViewMap = [
  <String, String>{
    'imgPath': 'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
    'title': 'Новосталь-М успешно дебютировал на выставке «Металл-Экспо 2020»',
    'dateTime': '9 апреля 2022, 13:00',
  },
  <String, String>{
    'imgPath': 'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
    'title': 'АЭМЗ ведёт активную работу в области импортозамещения',
    'dateTime': '9 апреля 2022, 13:00',
  },
  <String, String>{
    'imgPath': 'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
    'title': 'Новосталь-М успешно дебютировал на выставке «Металл-Экспо 2020»',
    'dateTime': '9 апреля 2022, 13:00',
  },
  <String, String>{
    'imgPath': 'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
    'title': 'АЭМЗ ведёт активную работу в области импортозамещения',
    'dateTime': '9 апреля 2022, 13:00',
  },
  <String, String>{
    'imgPath': 'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
    'title': 'Новосталь-М успешно дебютировал на выставке «Металл-Экспо 2020»',
    'dateTime': '9 апреля 2022, 13:00',
  },
];

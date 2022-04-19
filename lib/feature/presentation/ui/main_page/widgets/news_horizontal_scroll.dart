import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_right_search_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsHorizontalScroll extends StatelessWidget {
  const NewsHorizontalScroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.news,
          style: kMainTextRoboto.copyWith(fontSize: 22.sp),
        ),
        SizedBox(
          height: 185.h,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: listViewMap.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
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

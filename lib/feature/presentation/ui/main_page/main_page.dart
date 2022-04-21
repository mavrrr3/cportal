import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/faq_widget.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/horizontal_listview.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_horizontal_scroll.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_box_main.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/today_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 36.h),
            Row(
              children: [
                const SearchBoxMain(),
                SizedBox(width: 12.w),
                const AvatarBox(
                  size: 40,
                  imgPath:
                      'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
                ),
              ],
            ),
            SizedBox(height: 16.h),
            const HorizontalListViewMain(),
            SizedBox(height: 24.h),
            const TodayWidget(),
            SizedBox(height: 24.h),
            const NewsHorizontalScroll(),
            SizedBox(height: 24.h),
            const FaqWidget(),
          ],
        ),
      ),
    );
  }
}

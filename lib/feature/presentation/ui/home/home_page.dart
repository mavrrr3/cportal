import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

int _selectedItemIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    List<Widget> listPages = <Widget>[
      const MainPage(),
    ];

    return Scaffold(
      body: listPages[_selectedItemIndex],
      bottomNavigationBar: Container(
        color: AppColors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavBarItem(
              index: 0,
              width: width,
              iconWidget: SvgIcon(null, path: 'navbar/main.svg', width: 24.w),
              text: 'Главная',
            ),
            NavBarItem(
              index: 1,
              width: width,
              iconWidget: SvgIcon(null, path: 'navbar/news.svg', width: 20.w),
              text: 'Новости',
            ),
            NavBarItem(
              index: 2,
              width: width,
              iconWidget:
                  SvgIcon(null, path: 'navbar/questions.svg', width: 22.w),
              text: 'Вопросы',
            ),
            NavBarItem(
              index: 3,
              width: width,
              iconWidget:
                  SvgIcon(null, path: 'navbar/declaration.svg', width: 22.0.w),
              text: 'Заявки',
            ),
            NavBarItem(
              index: 4,
              width: width,
              iconWidget:
                  SvgIcon(null, path: 'navbar/contacts.svg', width: 20.0.w),
              text: 'Контакты',
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final int index;
  final Widget iconWidget;
  final double width;

  final String text;
  const NavBarItem({
    Key? key,
    required this.index,
    required this.width,
    required this.iconWidget,
    required this.text,
  }) : super(key: key);

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = widget.index;
        });
      },
      child: Container(
        height: 56.h,
        width: widget.width / 5,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5.h),
            widget.iconWidget,
            SizedBox(height: 5.h),
            Text(
              widget.text,
              style: kMainTextInter.copyWith(fontSize: 9.sp),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}

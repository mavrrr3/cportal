import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_right_search_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_box_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ProfileEntity profile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 36.h),
          Row(
            children: [
              const SearchBoxMain(),
              SizedBox(width: 12.w),
              const AvatarRightSearchBox(),
            ],
          ),
        ],
      ),
    );
  }
}

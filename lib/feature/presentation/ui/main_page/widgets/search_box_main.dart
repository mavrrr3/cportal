import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBoxMain extends StatelessWidget {
  const SearchBoxMain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 276.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgIcon(null, path: 'search.svg', width: 20.w),
          ),
          SizedBox(
            width: 200.w,
            child: TextField(
              showCursor: false,
              decoration: InputDecoration(
                labelText: 'Введите запрос',
                labelStyle: kMainTextRoboto.copyWith(
                  fontSize: 14,
                  color: AppColors.kLightTextColor.withOpacity(0.68),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

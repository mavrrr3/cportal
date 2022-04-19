import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsCardItem extends StatelessWidget {
  final String imgPath;
  final String title;
  final String dateTime;
  const NewsCardItem({
    Key? key,
    required this.imgPath,
    required this.title,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 220.w,
          height: 106.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: FractionalOffset.topCenter,
              image: NetworkImage(
                imgPath,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 220.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                softWrap: true,
                style: kMainTextRoboto.copyWith(
                  fontSize: 14.w,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    dateTime,
                    style: kMainTextRoboto.copyWith(fontSize: 12.w),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

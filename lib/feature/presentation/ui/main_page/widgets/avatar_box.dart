import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarBox extends StatelessWidget {
  final double size;
  final String imgPath;
  const AvatarBox({
    Key? key,
    required this.size,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.h,
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
    );
  }
}

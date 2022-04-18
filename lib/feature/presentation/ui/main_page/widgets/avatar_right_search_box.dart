import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarRightSearchBox extends StatelessWidget {
  const AvatarRightSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
          image: NetworkImage(
            'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
          ),
        ),
      ),
    );
  }
}

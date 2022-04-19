import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarBox extends StatelessWidget {
  final double size;
  const AvatarBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.h,
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
